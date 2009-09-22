using System;
using System.Collections.Generic;

namespace CodeRefactor.Commands
{

    /// <summary>
    /// Event arguments provided when a refactoring command completes.
    /// </summary>
    /// <typeparam name="RefactorResultType">The type of the results</typeparam>
    public class RefactorCompleteEventArgs<RefactorResultType> : EventArgs
    {
        private RefactorResultType m_Results;
        public virtual RefactorResultType Results
        {
            get
            {
                return m_Results;
            }
        }

        public RefactorCompleteEventArgs(RefactorResultType results)
        {
            m_Results = results;
        }
    }
}
