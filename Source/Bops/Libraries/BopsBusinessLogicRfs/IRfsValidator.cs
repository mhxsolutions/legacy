using System.Collections.Generic;

namespace BopsBusinessLogicRfs
{
    /// <summary>
    /// Defines the details of a particular RFS validation error.
    /// </summary>
    public class RfsValidationError
    {
        /// <summary>
        /// Defines the different sorts of RFS errors.
        /// </summary>
        public enum ErrorType
        {
            /// <summary>
            /// No error detected.
            /// </summary>
            None,

            /// <summary>
            /// The RFS number does not exist.
            /// </summary>
            RfsDoesNotExist,

            /// <summary>
            /// The referenced shipper client does not exist.
            /// </summary>
            ShipperClientDoesNotExist,

            /// <summary>
            /// The RFS does not have a corresponding shipper stakeholder.
            /// </summary>
            ShipperStakeholderDoesNotExist,

            /// <summary>
            /// The RFS has more than one corresponding shipper stakeholder.
            /// </summary>
            ShipperStakeholderCountIsNotOne,

            /// <summary>
            /// The client referenced by a stakeholder does not exist.
            /// </summary>
            StakeholderClientDoesNotExist,

            /// <summary>
            /// The referenced stakeholder does not exist.
            /// </summary>
            StakeholderDoesNotExist,

            /// <summary>
            /// A stakeholder referenced by a particular RFS has an RFS reference value which does not match.
            /// </summary>
            StakeholderRfsMismatch,

            /// <summary>
            /// A stakeholder referenced in a particular role does not match said role.
            /// </summary>
            StakeholderRoleMismatch,

            /// <summary>
            /// The referenced service offered does not exist.
            /// </summary>
            ServiceOfferedDoesNotExist
        }

        private int _RfsId;
        private ErrorType _Error;
        private int _RelevantId;

        /// <summary>
        /// The RFS ID against which the error was logged.
        /// </summary>
        public int RfsId
        {
            get { return _RfsId; }
            set { _RfsId = value; }
        }

        /// <summary>
        /// The type of error logged.
        /// </summary>
        public ErrorType Error
        {
            get { return _Error; }
            set { _Error = value; }
        }

        /// <summary>
        /// The ID relevant to the error.
        /// </summary>
        public int RelevantId
        {
            get { return _RelevantId; }
            set { _RelevantId = value; }
        }

        /// <summary>
        /// Constructs the object from the specified values.
        /// </summary>
        /// <param name="_RfsId">The RFS ID against which the error was logged.</param>
        /// <param name="_Error">The type of error logged.</param>
        /// <param name="_RelevantId">The ID relevant to the error.</param>
        public RfsValidationError(int _RfsId, ErrorType _Error, int _RelevantId)
        {
            this._RfsId = _RfsId;
            this._Error = _Error;
            this._RelevantId = _RelevantId;
        }

        ///<summary>
        ///Returns a <see cref="T:System.String"></see> that represents the current <see cref="T:System.Object"></see>.
        ///</summary>
        ///
        ///<returns>
        ///A <see cref="T:System.String"></see> that represents the current <see cref="T:System.Object"></see>.
        ///</returns>
        ///<filterpriority>2</filterpriority>
        public override string ToString()
        {
            return string.Format("RFS ID {0}: Error {1}, ID {2}", _RfsId, _Error, _RelevantId);
        }

        /// <summary>
        /// Provides a means for the user to retrieve a textual description of the error.
        /// </summary>
        /// <returns>A textual description of the error condition if successful or "(unknown)" if the error type is unknown.</returns>
        public string GetErrorTypeStringDescription()
        {
            string ReturnValue;

            switch (_Error)
            {
                case ErrorType.None:
                    ReturnValue = "None";
                    break;
                case ErrorType.RfsDoesNotExist:
                    ReturnValue = string.Format("RFS {0} does not exist.", _RfsId);
                    break;
                case ErrorType.ShipperClientDoesNotExist:
                    ReturnValue = string.Format("Shipper client {0}, referenced by the top-level RFS record, does not exist.", _RelevantId);
                    break;
                case ErrorType.ShipperStakeholderDoesNotExist:
                    ReturnValue = "No shipper exists within the stakeholder list.";
                    break;
                case ErrorType.ShipperStakeholderCountIsNotOne:
                    ReturnValue = "More than one shipper within the stakeholder list.";
                    break;
                case ErrorType.StakeholderClientDoesNotExist:
                    ReturnValue = string.Format("The client, referenced by stakeholder {0}, does not exist.", _RelevantId);
                    break;
                case ErrorType.StakeholderDoesNotExist:
                    ReturnValue = string.Format("A stakeholder, referenced by requested service {0}, does not exist.", _RelevantId);
                    break;
                case ErrorType.StakeholderRfsMismatch:
                    ReturnValue = string.Format("Stakeholder {0} has an RFS value which does not match the top-level RFS record.", _RelevantId);
                    break;
                case ErrorType.StakeholderRoleMismatch:
                    ReturnValue = string.Format("Stakeholder {0} has a role which does not match the requested service.", _RelevantId);
                    break;
                case ErrorType.ServiceOfferedDoesNotExist:
                    ReturnValue = string.Format("Requested service {0} references an offered service that does not exist.", _RelevantId);
                    break;

                default:
                    ReturnValue = "(unknown)";
                    break;
            }

            return ReturnValue;
        }
    }

    public interface IRfsValidator
    {
        /// <summary>
        ///  Checks a single RFS for issues and returns a list of errors or null if there are none.
        /// </summary>
        /// <param name="rfsId">The RFS ID to be checked.</param>
        /// <returns>A list of validation errors.</returns>
        List<RfsValidationError> ValidateSingleRfs(int rfsId);
    }
}
