using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.IO;
using System.Resources;
using System.Text;

namespace prop2res
{
    public class Properties : System.Collections.Hashtable
    {
        protected Properties defaults;

        // Creates an empty property list with no default values.
        public Properties()
        {
            defaults = null;
        }

        // Creates an empty property list with the specified defaults.
        public Properties(Properties defaults)
        {
            this.defaults = defaults;
        }

        // Searches for the property with the specified key in this property 
        // list.
        public String getProperty(String key)
        {
            return getProperty(key, null);
        }

        // Searches for the property with the specified key in this property 
        // list.
        public String getProperty(String key, String defaultValue) 
        {
            if (this.ContainsKey(key))
            {
                return (String)this[key];
            }

            if (defaults != null)
            {
                return (String)defaults.getProperty(key);
            }

            return defaultValue;
        }

        // Prints this property list out to the specified output stream.
        public void list(Stream outStream)
        {
        }
          
        // Prints this property list out to the specified output stream. 
        public void list(TextWriter outStream)
        {
        }

        // Reads a property list (key and element pairs) from the input byte 
        // stream. 
        public void load(Stream inStream)
        {
            load(new StreamReader(inStream));
        }

        enum ParseState
        {
            BEFORE_KEY,
            INSIDE_KEY,
            AFTER_KEY,
            BEFORE_VALUE,
            INSIDE_VALUE
        };

        private Boolean IsHexDigit(char ch)
        {
            return ('0' <= ch && ch <= '9') || ('a' <= ch && ch <= 'f') || ('A' <= ch && ch <= 'F');
        }

        private int HexCharToInt(char ch)
        {
            if ('0' <= ch && ch <= '9')
            {
                return ch - '0';
            }
            else if ('a' <= ch && ch <= 'f')
            {
                return ch - 'a' + 10;
            }
            else
            {
                return ch - 'A' + 10;
            }
        }

        // Reads a property list (key and element pairs) from the input 
        // character stream in a simple line-oriented format. 
        public void load(TextReader reader)
        {
            StringBuilder logicalLine = new StringBuilder();

            StringBuilder key = new StringBuilder();
            StringBuilder value = new StringBuilder();

            Boolean escapeNext = false;
            Boolean skipWhiteSpace = true;
            int unicodeEscapeCount = 0;
            int unicodeChar = '\0';

            ParseState state = ParseState.BEFORE_KEY;

            String line;

            try
            {
                while ((line = reader.ReadLine()) != null)
                {
                    for (int index = 0; index < line.Length; index++)
                    {
                        char ch = line[index];

                        if (unicodeEscapeCount > 0)
                        {
                            if (IsHexDigit(ch))
                            {
                                unicodeChar *= 16;
                                unicodeChar += HexCharToInt(ch);
                                unicodeEscapeCount--;
                            }
                                
                            if (unicodeEscapeCount == 0 || !IsHexDigit(ch) || (index + 1) == line.Length)
                            {
                                ch = (char)unicodeChar;
                            }
                            else
                            {
                                continue;
                            }
                        }

                        if (escapeNext)
                        {
                            switch (ch)
                            {
                                case 'f':   // Formfeed
                                    ch = '\f';
                                    break;

                                case 'n':   // Newline
                                    ch = '\n';
                                    break;

                                case 'r':   // Return
                                    ch = '\r';
                                    break;

                                case 't':   // Tab
                                    ch = '\t';
                                    break;

                                case 'u':   // Unicode escape
                                    unicodeEscapeCount = 4;
                                    unicodeChar = 0;
                                    continue;
                            }

                            if (state == ParseState.INSIDE_KEY)
                            {
                                key.Append(ch);
                            }
                            else if (state == ParseState.INSIDE_VALUE)
                            {
                                value.Append(ch);
                            }
                            escapeNext = false;
                            continue;
                        }

                        switch (ch)
                        {
                            case '\\':
                                if (state == ParseState.BEFORE_KEY && (index + 1) < line.Length)
                                {
                                    state = ParseState.INSIDE_KEY;
                                }
                                if ((state == ParseState.AFTER_KEY || state == ParseState.BEFORE_VALUE) && 
                                    (index + 1) < line.Length)
                                {
                                    state = ParseState.INSIDE_VALUE;
                                }
                                escapeNext = true;
                                skipWhiteSpace = false;
                                break;

                            case ' ':
                            case '\t':
                            case '\f':
                                if (!skipWhiteSpace)
                                {
                                    if (state == ParseState.INSIDE_KEY)
                                    {
                                        state = ParseState.AFTER_KEY;
                                        skipWhiteSpace = true;
                                    }
                                    else if (state == ParseState.INSIDE_VALUE)
                                    {
                                        value.Append(ch);
                                    }
                                }
                                break;

                            case '\r':
                            case '\n':
                                break;

                            case '#':
                            case '!':
                                if (state == ParseState.BEFORE_KEY)
                                {
                                    index = line.Length - 1;
                                    continue;
                                }

                                if (state == ParseState.AFTER_KEY ||
                                    state == ParseState.BEFORE_VALUE)
                                {
                                    state = ParseState.INSIDE_VALUE;
                                }

                                if (state == ParseState.INSIDE_KEY)
                                {
                                    key.Append(ch);
                                }
                                else if (state == ParseState.INSIDE_VALUE)
                                {
                                    value.Append(ch);
                                }
                                skipWhiteSpace = false;
                                break;

                            case '=':
                            case ':':
                                if (state == ParseState.INSIDE_KEY ||
                                    state == ParseState.AFTER_KEY)
                                {
                                    state = ParseState.BEFORE_VALUE;
                                    skipWhiteSpace = true;
                                    continue;
                                }

                                if (state == ParseState.BEFORE_VALUE)
                                {
                                    state = ParseState.INSIDE_VALUE;
                                }

                                if (state == ParseState.INSIDE_VALUE)
                                {
                                    value.Append(ch);
                                }
                                break;

                            default:
                                if (state == ParseState.BEFORE_KEY)
                                {
                                    state = ParseState.INSIDE_KEY;
                                }
                                else 
                                if (state == ParseState.AFTER_KEY ||
                                    state == ParseState.BEFORE_VALUE)
                                {
                                    state = ParseState.INSIDE_VALUE;
                                }

                                if (state == ParseState.INSIDE_KEY)
                                {
                                    key.Append(ch);
                                }
                                else if (state == ParseState.INSIDE_VALUE)
                                {
                                    value.Append(ch);
                                }
                                skipWhiteSpace = false;
                                break;
                        }
                    }

                    if (!escapeNext)
                    {
                        if (key.Length > 0)
                        {
                            this[key.ToString()] = value.ToString();
                            key.Length = 0;
                            value.Length = 0;
                            state = ParseState.BEFORE_KEY;
                        }
                    }
                    else
                    {
                        escapeNext = false;
                    }
                }
            }
            catch (SystemException)
            {
            }
        }

        // Loads all of the properties represented by the XML document on the 
        // specified input stream into this properties table. 
        public void loadFromXML(Stream inStream)
        {
        }
        // Returns an enumeration of all the keys in this property list, 
        // including distinct keys in the default property list if a key of 
        // the same name has not already been found from the main properties 
        // list. 
        public IEnumerator propertyNames()
        {
            return Keys.GetEnumerator();
        }

        // Deprecated. This method does not throw an IOException if an I/O 
        // error occurs while saving the property list. The preferred way to 
        // save a properties list is via the store(OutputStream out, String 
        // comments) method or the storeToXML(OutputStream os, String comment) 
        // method. 
        public void save(Stream outStream, String comments)
        {
        }

        // Calls the Hashtable method put. 
        public Object setProperty(String key, String value)
        {
            Object previous = null;

            if (Contains(key))
            {
                previous = this[key];
            }

            this[key] = value;

            return previous;
        }

        // Writes this property list (key and element pairs) in this Properties 
        // table to the output stream in a format suitable for loading into a 
        // Properties table using the load(InputStream) method. 
        public void store(Stream outStream, String comments)
        {
        }

        // Writes this property list (key and element pairs) in this Properties 
        // table to the output character stream in a format suitable for using 
        // the load(Reader) method. 
        public void store(TextWriter writer, String comments)
        {
        }

        // Emits an XML document representing all of the properties contained 
        // in this table. 
        public void storeToXML(Stream os, String comment)
        {
        }

        // Emits an XML document representing all of the properties contained 
        // in this table, using the specified encoding. 
        public void storeToXML(Stream os, String comment, String encoding)
        {
        }

        // Returns a set of keys in this property list where the key and its 
        // corresponding value are strings, including distinct keys in the 
        // default property list if a key of the same name has not already 
        // been found from the main properties list. 
        public ICollection<String> stringPropertyNames()
        {
            return (ICollection<String>)Keys;
        }
    }

    public class PropertyResourceReader : IResourceReader
    {
        private Properties m_Properties;

        public PropertyResourceReader(Properties properties)
        {
            m_Properties = properties;
        }

        #region IResourceReader Members

        public void Close()
        {
            throw new Exception("The method or operation is not implemented.");
        }

        public IDictionaryEnumerator GetEnumerator()
        {
            return m_Properties.GetEnumerator();
        }

        #endregion

        #region IEnumerable Members

        IEnumerator IEnumerable.GetEnumerator()
        {
            return m_Properties.GetEnumerator();
        }

        #endregion

        #region IDisposable Members

        public void Dispose()
        {
            throw new Exception("The method or operation is not implemented.");
        }

        #endregion
    }
}
