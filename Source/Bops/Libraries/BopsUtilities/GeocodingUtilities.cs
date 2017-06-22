using System;

namespace BopsUtilities
{
    public class GeocodingUtilities
    {
        private static double DegreesToRadians(double Degrees)
        {
            return Degrees * Math.PI / 180;
        }

        private static double Square(double X)
        {
            return X * X;
        }

        public static double ComputeSphericalDistance(double Latitude1, double Longitude1, double Latitude2, double Longitude2)
        {
            const double EarthRadius = 3956.0;

            Latitude1 = DegreesToRadians(Latitude1);
            Longitude1 = DegreesToRadians(Longitude1);
            Latitude2 = DegreesToRadians(Latitude2);
            Longitude2 = DegreesToRadians(Longitude2);

            double LatDelta = Latitude2 - Latitude1;
            double LonDelta = Longitude2 - Longitude1;

            double Temp = Square(Math.Sin(LatDelta / 2)) + Math.Cos(Latitude1) * Math.Cos(Latitude2) * Square(Math.Sin(LonDelta / 2));
            double CentralAngle = 2 * Math.Atan2(Math.Sqrt(Temp), Math.Sqrt(1 - Temp));

            return EarthRadius * CentralAngle;
        }

    }
}
