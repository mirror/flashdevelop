using System;
using System.Text;
using System.Security.Cryptography;
using System.Collections;

namespace PluginCore.Utilities
{
    public class HashCalculator
    {
        /// <summary>
        /// Calculates the MD5 checksum
        /// </summary>
        public static String CalculateMD5(String input)
        {
            MD5 md5 = MD5.Create();
            Byte[] inputBytes = Encoding.ASCII.GetBytes(input);
            Byte[] hash = md5.ComputeHash(inputBytes);
            StringBuilder builder = new StringBuilder();
            for (Int32 i = 0; i < hash.Length; i++)
            {
                builder.Append(hash[i].ToString("X2"));
            }
            return builder.ToString();
        }

        /// <summary>
        /// Calculates the SHA-1 checksum
        /// </summary>
        public static String CalculateSHA1(String input)
        {
            SHA1 sha1 = SHA1.Create();
            Byte[] inputBytes = Encoding.ASCII.GetBytes(input);
            Byte[] hash = sha1.ComputeHash(inputBytes);
            StringBuilder builder = new StringBuilder();
            for (Int32 i = 0; i < hash.Length; i++)
            {
                builder.Append(hash[i].ToString("X2"));
            }
            return builder.ToString();
        }

    }

}
