import javax.crypto.Cipher;

/**
 * Quick test class to check if the Java JCE library is installed.
 */
class TestForJCE
{
	public static void main(String[] args)
	{
		try
		{
			System.out.println("JCE is installed. Maximum key length for AES is: "
					.concat(String.valueOf(Cipher.getMaxAllowedKeyLength("AES"))));
		}
		catch (Exception e)
		{
			System.out.println("JCE is NOT available for this Java installation.");
		}
	}
}
