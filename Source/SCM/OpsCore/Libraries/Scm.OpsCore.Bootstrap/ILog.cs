using System;

namespace Scm.OpsCore.Bootstrap
{
    /// <summary>
    /// Log interface, based initially on the Log4Net functionality.
    /// </summary>
    public interface ILog
    {
        /// <summary>
        /// Gets the type associated with the log interface.
        /// </summary>
        Type Type { get; }

        /// <summary>
        /// Should Debug severity be logged?
        /// </summary>
        bool IsDebugEnabled { get; }

        /// <summary>
        /// Should Info severity be logged?
        /// </summary>
        bool IsInfoEnabled { get; }

        /// <summary>
        /// Should Trace severity be logged?
        /// </summary>
        bool IsTraceEnabled { get; }

        /// <summary>
        /// Should Warn severity be logged?
        /// </summary>
        bool IsWarnEnabled { get; }

        /// <summary>
        /// Should Error severity be logged?
        /// </summary>
        bool IsErrorEnabled { get; }

        /// <summary>
        /// Should Fatal severity be logged?
        /// </summary>
        bool IsFatalEnabled { get; }

        /// <summary>
        /// Logs a message with Debug severity.
        /// </summary>
        /// <param name="message">Message.</param>
        void Debug(string message);

        /// <summary>
        /// Logs a message with Debug severity with formatting details.
        /// </summary>
        /// <param name="format">Message or format template.</param>
        /// <param name="args">Format template arguments (if any).</param>
        void Debug(string format, params object[] args);

        /// <summary>
        /// Logs an exception with Debug severity with formatting details.
        /// </summary>
        /// <param name="exception">Exception.</param>
        /// <param name="format">Format template.</param>
        /// <param name="args">Format template arguments (if any).</param>
        void Debug(Exception exception, string format, params object[] args);

        /// <summary>
        /// Logs a message with Info severity.
        /// </summary>
        /// <param name="message">Message.</param>
        void Info(string message);

        /// <summary>
        /// Logs a message with Info severity with formatting details.
        /// </summary>
        /// <param name="format">Message or format template.</param>
        /// <param name="args">Format template arguments (if any).</param>
        void Info(string format, params object[] args);
        // ReSharper restore MethodOverloadWithOptionalParameter

        /// <summary>
        /// Logs an exception with Info severity with formatting details.
        /// </summary>
        /// <param name="exception">Exception.</param>
        /// <param name="format">Format template.</param>
        /// <param name="args">Format template arguments (if any).</param>
        void Info(Exception exception, string format, params object[] args);

        /// <summary>
        /// Logs a message with Trace severity.
        /// </summary>
        /// <param name="message">Message.</param>
        void Trace(string message);

        /// <summary>
        /// Logs a message with Trace severity with formatting details.
        /// </summary>
        /// <param name="format">Message or format template.</param>
        /// <param name="args">Format template arguments (if any).</param>
        void Trace(string format, params object[] args);
        // ReSharper restore MethodOverloadWithOptionalParameter

        /// <summary>
        /// Logs an exception with Trace severity with formatting details.
        /// </summary>
        /// <param name="exception">Exception.</param>
        /// <param name="format">Format template.</param>
        /// <param name="args">Format template arguments (if any).</param>
        void Trace(Exception exception, string format, params object[] args);

        /// <summary>
        /// Logs a message with Warn severity.
        /// </summary>
        /// <param name="message">Message.</param>
        void Warn(string message);

        /// <summary>
        /// Logs a message with Warn severity with formatting details.
        /// </summary>
        /// <param name="format">Message or format template.</param>
        /// <param name="args">Format template arguments (if any).</param>
        void Warn(string format, params object[] args);
        // ReSharper restore MethodOverloadWithOptionalParameter

        /// <summary>
        /// Logs an exception with Warn severity with formatting details.
        /// </summary>
        /// <param name="exception">Exception.</param>
        /// <param name="format">Format template.</param>
        /// <param name="args">Format template arguments (if any).</param>
        void Warn(Exception exception, string format, params object[] args);

        /// <summary>
        /// Logs a message with Error severity.
        /// </summary>
        /// <param name="message">Message.</param>
        void Error(string message);

        /// <summary>
        /// Logs a message with Error severity with formatting details.
        /// </summary>
        /// <param name="format">Message or format template.</param>
        /// <param name="args">Format template arguments (if any).</param>
        void Error(string format, params object[] args);
        // ReSharper restore MethodOverloadWithOptionalParameter

        /// <summary>
        /// Logs an exception with Error severity with formatting details.
        /// </summary>
        /// <param name="exception">Exception.</param>
        /// <param name="format">Format template.</param>
        /// <param name="args">Format template arguments (if any).</param>
        void Error(Exception exception, string format, params object[] args);

        /// <summary>
        /// Logs a message with Fatal severity.
        /// </summary>
        /// <param name="message">Message.</param>
        void Fatal(string message);

        /// <summary>
        /// Logs a message with Fatal severity with formatting details.
        /// </summary>
        /// <param name="format">Message or format template.</param>
        /// <param name="args">Format template arguments (if any).</param>
        void Fatal(string format, params object[] args);
        // ReSharper restore MethodOverloadWithOptionalParameter

        /// <summary>
        /// Logs an exception with Fatal severity with formatting details.
        /// </summary>
        /// <param name="exception">Exception.</param>
        /// <param name="format">Format template.</param>
        /// <param name="args">Format template arguments (if any).</param>
        void Fatal(Exception exception, string format, params object[] args);
    }
}
