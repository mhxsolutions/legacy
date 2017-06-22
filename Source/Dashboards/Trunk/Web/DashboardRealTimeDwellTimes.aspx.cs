using System;
using System.Data;
using System.Drawing;
using System.Web.UI;

public partial class DashboardRealTimeDwellTimes : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        /*
         * Dan wanted the marker colors to change for the different dwell times based upon different
         * ranges. As of my Budway visit of 11/16/07, the desired values are:
         * 
         *              Green       Yellow      Red
         *  Pit         < 17        < 22        >= 22
         *  Track 5     < 25        < 30        >= 30
         *  Yard        < 30        < 35        >= 35
         *  Composite   < 20        < 25        >= 25
         */

        Color PitColor, TrackColor, YardColor, CompositeColor;
        double PitValue = 0, TrackValue = 0, YardValue = 0, CompositeValue = 0;

        DataSourceSelectArguments args = new DataSourceSelectArguments();
        DataView view = BudwayTruckingDwell.Select(args) as DataView;
        if (view.Count > 0)
            PitValue = Convert.ToInt32(view[0].Row["Dwell"]);

        view = BudwayYardDwell.Select(args) as DataView;
        if (view.Count > 0)
            YardValue = Convert.ToInt32(view[0].Row["Dwell"]);

        view = BudwayTrackFiveDwell.Select(args) as DataView;
        if (view.Count > 0)
            TrackValue = Convert.ToInt32(view[0].Row["Dwell"]);

        view = BudwayCompositeDwell.Select(args) as DataView;
        if (view.Count > 0)
            CompositeValue = Convert.ToInt32(view[0].Row["Dwell"]);

        if (PitValue < 17)
            PitColor = Color.Green;
        else if (PitValue < 22)
            PitColor = Color.Yellow;
        else
            PitColor = Color.Red;

        if (YardValue < 30)
            YardColor = Color.Green;
        else if (YardValue < 35)
            YardColor = Color.Yellow;
        else
            YardColor = Color.Red;

        if (TrackValue < 25)
            TrackColor = Color.Green;
        else if (TrackValue < 30)
            TrackColor = Color.Yellow;
        else
            TrackColor = Color.Red;

        if (CompositeValue < 20)
            CompositeColor = Color.Green;
        else if (CompositeValue < 25)
            CompositeColor = Color.Yellow;
        else
            CompositeColor = Color.Red;

        //PitGauge.LinearGauges["Default"].Pointers["Default"].FillGradientEndColor = PitColor;
        //YardGauge.LinearGauges["Default"].Pointers["Default"].FillGradientEndColor = YardColor;
        //TrackFiveGauge.LinearGauges["Default"].Pointers["Default"].FillGradientEndColor = TrackColor;
        //CompositeGauge.LinearGauges["Default"].Pointers["Default"].FillGradientEndColor = CompositeColor;
    }
}
