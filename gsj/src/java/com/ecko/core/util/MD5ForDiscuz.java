package com.ecko.core.util;
import java.security.MessageDigest;

public class MD5ForDiscuz
{

	private String inStr;

	private MessageDigest md5;

	/**
	 * Constructs the MD5 object and sets the string whose MD5 is to be
	 * computed.
	 * 
	 * @param inStr
	 *            the <code>String</code> whose MD5 is to be computed
	 */
	public MD5ForDiscuz(String inStr)
	{
		this.inStr = inStr;
		try
		{
			this.md5 = MessageDigest.getInstance("MD5");
		}
		catch (Exception e)
		{
			System.out.println(e.toString());
			e.printStackTrace();
		}
	}

	/**
	 * Computes the MD5 fingerprint of a string.
	 * 
	 * @return the MD5 digest of the input <code>String</code>
	 */
	public String compute()
	{
		// convert input String to a char[]
		// convert that char[] to byte[]
		// get the md5 digest as byte[]
		// bit-wise AND that byte[] with 0xff
		// prepend "0" to the output StringBuffer to make sure that we don't
		// end up with
		// something like "e21ff" instead of "e201ff"

		char[] charArray = this.inStr.toCharArray();

		byte[] byteArray = new byte[charArray.length];

		for (int i = 0; i < charArray.length; i++)
			byteArray[i] = (byte) charArray[i];

		byte[] md5Bytes = this.md5.digest(byteArray);

		StringBuffer hexValue = new StringBuffer();

		for (int i = 0; i < md5Bytes.length; i++)
		{
			int val = ((int) md5Bytes[i]) & 0xff;
			if (val < 16)
				hexValue.append("0");
			hexValue.append(Integer.toHexString(val));
		}

		return hexValue.toString();
	}

	/**
	 * 该测试在Discuz 7.2版本上
	 * @param args
	 */
	public static void main(String[] args)
	{
		//admin为dz_uc_members表的password字段未加密前的明文
		MD5ForDiscuz md5 = new MD5ForDiscuz("admin");
		
		//用MD5第一次加密
		String pwd = md5.compute();
		
		//将加密后的密文加上dz_uc_members表的salt字段
		//因为DZ加密是使用MD5加密后加上随机码再次加密，所以需要还原加密
		pwd = pwd + "2632ef";
		
		//再次用MD5加密
		MD5ForDiscuz m = new MD5ForDiscuz(pwd);
		
		//得到最终密文
		String npwd = m.compute();
		System.out.println(npwd);
		
		
		//6f96f727c37cacbd4578ab4a6ea3d97c	//数据库的密文
		//6f96f727c37cacbd4578ab4a6ea3d97c	//控件台输出的密文
	}

}
