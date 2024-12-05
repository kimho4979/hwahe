package com.execute;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.springframework.security.crypto.codec.Base64;

public class Execute {

	public static void main(String[] args) throws NoSuchAlgorithmException, UnsupportedEncodingException {
		// TODO Auto-generated method stub
		String base = "740830"; // 입력받은 pwd를 암호화 시키기 위해 base 에 넣음
		
		MessageDigest digest = MessageDigest.getInstance("SHA-256");
		byte[] hash = digest.digest(base.getBytes("UTF-8"));
		//byte[] base64Encoded = Base64.encode(hash);
		String base64Encoded = com.fpditrans.base.cipher.base64.Base64.toString(hash);
		
		StringBuilder hexString = new StringBuilder();
		StringBuilder hexString2 = new StringBuilder();
		for (int i = 0; i < hash.length; i++) {
			String hex = Integer.toHexString(0xff & hash[i]);
			if (hex.length() == 1)
				hexString.append('0');
			hexString.append(hex);
		}
		
		String pwd = hexString.toString();
		String base64pwd = hexString2.toString();
		System.out.println("pwd=" + pwd);
		System.out.println("pwd=" + pwd.length());
		System.out.println("base64=" + base64Encoded);
		System.out.println("base64=" + base64Encoded.length());
	}

	public static void mainyy(String[] args) {
		Class<?> cls = Execute.class;
		
		System.out.println(cls.getPackage().getSpecificationVersion());
	}
}