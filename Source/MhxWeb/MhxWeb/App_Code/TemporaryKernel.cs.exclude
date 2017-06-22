using Scm.OpsCore.Legacy.DataLayer;
using Scm.OpsCore.Legacy.NHibernate;

namespace Web_App
{
    // TODO: Replace this with a real dependency injection kernel when time permits.

    /// <summary>
    /// A quick, temporary kernel to hide the details of interface binding until a real 
    /// dependency injection kernel is available for old-style WebForms apps.
    /// </summary>
    public class TemporaryKernel
    {
        public static IRfsDataContext GetRfsDataContext()
        {
            return new RfsDataContext();
        }
    }
}