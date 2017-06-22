using Scm.OpsCore.Bootstrap;

namespace ConsoleAppSample
{
    class Program
    {
        private class ConstructorInjectionHelper
        {
            public ILog Log { get; private set; }

            public ConstructorInjectionHelper(ILog log)
            {
                Log = log;
            }

            public void WriteLogEntry(string message)
            {
                Log.Info(message);
            }
        }

        static void Main()
        {
            Bootstrap.Startup();
            var log = Bootstrap.Kernel.Get<ILog>();
            log.Info("Console App Sample Startup");

            var helper = Bootstrap.Kernel.Get<ConstructorInjectionHelper>();
            helper.WriteLogEntry("Constructor injection helper message");

            log.Info("Console App Sample Shutdown");
        }
    }
}
