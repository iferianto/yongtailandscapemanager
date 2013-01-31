package com.ecko.core.util;


import it.sauronsoftware.base64.Base64;

import java.security.MessageDigest;


public class MD5 {

    public final static String toMD5(String s) {
        /*char hexDigits[] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};
        try {
            byte[] strTemp = s.getBytes();
            MessageDigest mdTemp = MessageDigest.getInstance("MD5");
            mdTemp.update(strTemp);
            byte[] md = mdTemp.digest();
            int j = md.length;
            char str[] = new char[j * 2];
            int k = 0;
            for (int i = 0; i < j; i++) {
                byte byte0 = md[i];
                str[k++] = hexDigits[byte0 >>> 4 & 0xf];
                str[k++] = hexDigits[byte0 & 0xf];
            }
            return new String(str);
        }
        catch (Exception e) {
            return null;
        }*/
    	return new String(Base64.encode(s.getBytes()));
    }

    public static void main(String[] args) {
        // MD5_Test aa = new MD5_Test();

        System.out.println(MD5.toMD5("1"));
        System.out.println(MD5.toMD5("rainworm"));
        System.out.println(Base64.decode("MQ=="));
        System.out.println(Base64.decode("cmFpbndvcm0="));
    }
}
