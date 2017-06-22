using System;
using Ninject.Extensions.Logging;

namespace Scm.OpsCore.Bootstrap
{
    /// <summary>
    /// A wrapper class to provide logging via a bootstrap-level ILog interface.
    /// </summary>
    class NinjectLog4Net : ILog
    {
        private readonly ILogger _logger;

        public NinjectLog4Net(ILogger logger)
        {
            _logger = logger;
        }

        /// <inheritdoc/>
        public Type Type
        {
            get { return _logger.Type; }
        }

        /// <inheritdoc/>
        public bool IsDebugEnabled
        {
            get { return _logger.IsDebugEnabled; }
        }

        /// <inheritdoc/>
        public bool IsInfoEnabled
        {
            get { return _logger.IsInfoEnabled; }
        }

        /// <inheritdoc/>
        public bool IsTraceEnabled
        {
            get { return _logger.IsTraceEnabled; }
        }

        /// <inheritdoc/>
        public bool IsWarnEnabled
        {
            get { return _logger.IsWarnEnabled; }
        }

        /// <inheritdoc/>
        public bool IsErrorEnabled
        {
            get { return _logger.IsErrorEnabled; }
        }

        /// <inheritdoc/>
        public bool IsFatalEnabled
        {
            get { return _logger.IsFatalEnabled; }
        }

        /// <inheritdoc/>
        public void Debug(string message)
        {
            _logger.Debug(message);
        }

        /// <inheritdoc/>
        public void Debug(string format, params object[] args)
        {
            _logger.Debug(format, args);
        }

        /// <inheritdoc/>
        public void Debug(Exception exception, string format, params object[] args)
        {
            _logger.Debug(exception, format, args);
        }

        /// <inheritdoc/>
        public void Info(string message)
        {
            _logger.Info(message);
        }

        /// <inheritdoc/>
        public void Info(string format, params object[] args)
        {
            _logger.Info(format, args);
        }

        /// <inheritdoc/>
        public void Info(Exception exception, string format, params object[] args)
        {
            _logger.Info(exception, format, args);
        }

        /// <inheritdoc/>
        public void Trace(string message)
        {
            _logger.Info(message);
        }

        /// <inheritdoc/>
        public void Trace(string format, params object[] args)
        {
            _logger.Trace(format, args);
        }

        /// <inheritdoc/>
        public void Trace(Exception exception, string format, params object[] args)
        {
            _logger.Trace(exception, format, args);
        }

        /// <inheritdoc/>
        public void Warn(string message)
        {
            _logger.Warn(message);
        }

        /// <inheritdoc/>
        public void Warn(string format, params object[] args)
        {
            _logger.Warn(format, args);
        }

        /// <inheritdoc/>
        public void Warn(Exception exception, string format, params object[] args)
        {
            _logger.Warn(exception, format, args);
        }

        /// <inheritdoc/>
        public void Error(string message)
        {
            _logger.Error(message);
        }

        /// <inheritdoc/>
        public void Error(string format, params object[] args)
        {
            _logger.Error(format, args);
        }

        /// <inheritdoc/>
        public void Error(Exception exception, string format, params object[] args)
        {
            _logger.Error(exception, format, args);
        }

        /// <inheritdoc/>
        public void Fatal(string message)
        {
            _logger.Fatal(message);
        }

        /// <inheritdoc/>
        public void Fatal(string format, params object[] args)
        {
            _logger.Fatal(format, args);
        }

        /// <inheritdoc/>
        public void Fatal(Exception exception, string format, params object[] args)
        {
            _logger.Fatal(exception, format, args);
        }
    }
}
