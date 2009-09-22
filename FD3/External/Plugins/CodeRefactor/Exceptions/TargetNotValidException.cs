using System;
using System.Collections.Generic;

namespace CodeRefactor.Exceptions
{
    public class TargetNotValidException : RefactorException
    {
        public TargetNotValidException()
            : base()
        {
        }
        public TargetNotValidException(String message)
            : base(message)
        {
        }
        public TargetNotValidException(String message, Exception innerException)
            : base(message, innerException)
        {
        }
    }
}
