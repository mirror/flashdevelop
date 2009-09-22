using System;
using System.Collections.Generic;

namespace CodeRefactor.Exceptions
{
    public abstract class RefactorException : Exception
    {
        public RefactorException()
            : base()
        {
        }
        public RefactorException(String message)
            : base(message)
        {
        }
        public RefactorException(String message, Exception innerException)
            : base(message, innerException)
        {
        }
    }
}
