using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text;
using BopsDataAccess;
using BopsUtilities;

namespace Driver_Event_Scrubber
{
    class LocationClientDetector
    {
        private const double _ApproachThreshold = 0.25;
        private const double _DepartThreshold = 0.25;
        private const double _NoMovementThreshold = 0.01;
        private const int _MinimumApproachPoints = 3;

        private PlanSummary _Plan;
        private List<PlanSummary.Visit> _DetectedVisits;

        public PlanSummary Plan
        {
            get { return _Plan; }
        }

        public List<PlanSummary.Visit> DetectedVisits
        {
            get { return _DetectedVisits; }
        }

        public LocationClientDetector(PlanSummary Plan)
        {
            _Plan = Plan;
        }

        List<BopsDestination> GetDetectableClients()
        {
            Dictionary<int, BopsDestination> Clients = new Dictionary<int, BopsDestination>();
            foreach (KeyValuePair<int, BopsDestination> Pair in _Plan.Origins)
            {
                if (Pair.Value.Latitude == 0.0 || Pair.Value.Longitude == 0.0) continue;
                if (Clients.ContainsKey(Pair.Key)) continue;

                Clients.Add(Pair.Key, Pair.Value);
            }

            foreach (KeyValuePair<int, BopsDestination> Pair in _Plan.Destinations)
            {
                if (Pair.Value.Latitude == 0.0 || Pair.Value.Longitude == 0.0) continue;
                if (Clients.ContainsKey(Pair.Key)) continue;

                Clients.Add(Pair.Key, Pair.Value);
            }

            return new List<BopsDestination>(Clients.Values);
        }

        private static double[] ComputeDistances(double Latitude, double Longitude, IList<BopsDestination> Clients)
        {
            double[] ReturnValue = new double[Clients.Count];

            for (int Index = 0; Index < Clients.Count; Index++)
            {
                ReturnValue[Index] = GeocodingUtilities.ComputeSphericalDistance(Latitude, Longitude, Clients[Index].Latitude, Clients[Index].Longitude);
            }

            return ReturnValue;
        }

        private bool IsRealVisit(int FirstIndex, double InitialDistance, BopsDestination Client)
        {
            double LastDistance = InitialDistance;
            int DecreasingDistancePoints = 0, PointsBelowThreshold = 0;

            for (int Index = 0; Index < _MinimumApproachPoints; Index++)
            {
                int LocationIndex = FirstIndex + 1 + Index;

                double Distance = GeocodingUtilities.ComputeSphericalDistance(_Plan.Positions[LocationIndex].Latitude,
                    _Plan.Positions[LocationIndex].Longitude, Client.Latitude, Client.Longitude);

                if (Distance < _ApproachThreshold)
                    PointsBelowThreshold++;
                if (Distance < LastDistance || (Distance - LastDistance) < _NoMovementThreshold)
                    DecreasingDistancePoints++;

                LastDistance = Distance;
            }

            // The confidence value is calculated on the basis of the number of points with decreasing distance
            // and the number of points below the threshold. In an optimal case, confidence would be 2.0 so we
            // use that for the final return value determination.

            double Confidence = (double)DecreasingDistancePoints / _MinimumApproachPoints + (double)PointsBelowThreshold / _MinimumApproachPoints;
            return Confidence >= 1.0;
        }

        private int DetectVisitLastIndex(int FirstIndex, double InitialDistance, BopsDestination Client)
        {
            bool MayHaveLeft = false;
            int LastIndexBelowThreshold = -1;

            for (int Index = FirstIndex + 1; Index < _Plan.Positions.Count; Index++)
            {
                double Distance = GeocodingUtilities.ComputeSphericalDistance(_Plan.Positions[Index].Latitude,
                    _Plan.Positions[Index].Longitude, Client.Latitude, Client.Longitude);

                if (Distance < _DepartThreshold)
                    LastIndexBelowThreshold = Index;

                if (Distance <= _DepartThreshold * 2) continue;

                if (MayHaveLeft)
                    return LastIndexBelowThreshold;

                MayHaveLeft = true;
            }

            // If we've arrived here, it's because we didn't find a clear ending index up above,
            // in which case we return the last index in the list of positions. It's something of a
            // cop-out, but it's the best we can do.

            return _Plan.Positions.Count - 1;
        }

        public StringBuilder DetectClientLocations()
        {
            _DetectedVisits = new List<PlanSummary.Visit>();
            StringBuilder Sb = new StringBuilder();

            // First, build a unified list of clients.

            List<BopsDestination> Clients = GetDetectableClients();

            for (int Index = 0; Index < _Plan.Positions.Count; Index++)
            {
                double[] Distances = ComputeDistances(_Plan.Positions[Index].Latitude, _Plan.Positions[Index].Longitude, Clients);

                // Run through the clients looking for a possible arrival.

                for (int ClientIndex = 0; ClientIndex < Clients.Count; ClientIndex++)
                {
                    if (Distances[ClientIndex] >= _ApproachThreshold) continue;
                    if (!IsRealVisit(Index, Distances[ClientIndex], Clients[ClientIndex])) continue;

                    Sb.AppendLine(string.Format("Arrived at {0} at {1}", Clients[ClientIndex], _Plan.Positions[Index].Timestamp.ToShortTimeString()));

                    int LastIndex = DetectVisitLastIndex(Index, Distances[ClientIndex], Clients[ClientIndex]);
                    Debug.Assert(Index < LastIndex && LastIndex < _Plan.Positions.Count);
                    Sb.AppendLine(string.Format("Departed {0} at {1}", Clients[ClientIndex], _Plan.Positions[LastIndex].Timestamp.ToShortTimeString()));

                    PlanSummary.Visit NewVisit = new PlanSummary.Visit(Clients[ClientIndex].DestinationId, Index, _Plan.Positions[Index], 
                        LastIndex, _Plan.Positions[LastIndex]);
                    _DetectedVisits.Add(NewVisit);

                    // Manually update the loop variable to skip the positions during the visit.

                    Index = LastIndex;
                }
            }

            return Sb;
        }

        public void UpdatePlanSummaryWithDetectedVisits()
        {
            if (_DetectedVisits == null)
                throw new InvalidOperationException("Client locations must first be detected");

            List<PlanSummary.DetailVisits> Visits = new List<PlanSummary.DetailVisits>();

            foreach (BopsDriverPlanDetail Detail in _Plan.Details)
            {
                PlanSummary.DetailVisits NewItem = new PlanSummary.DetailVisits();

                foreach (PlanSummary.Visit Visit in _DetectedVisits)
                {
                    if (Visit.ClientId == Detail.OriginRef)
                        NewItem.OriginVisits.Add(Visit);
                    if (Visit.ClientId == Detail.DestinationRef)
                        NewItem.DestinationVisits.Add(Visit);
                }
                
                Visits.Add(NewItem);
            }

            _Plan.DetectedVisits = Visits;
        }
    }
}
