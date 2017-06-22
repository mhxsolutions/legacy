using System.Collections;
using System.ComponentModel;
using System.Configuration.Install;

namespace Bops_RFS_Operations
{
    [RunInstaller(true)]
    public partial class ProjectInstaller : Installer
    {
        public ProjectInstaller()
        {
            InitializeComponent();
        }

        protected override void OnAfterInstall(IDictionary savedState)
        {
            base.OnAfterInstall(savedState);
            serviceController1.Start();
        }
    }
}