package com.fpditrans.base.cipher.sha;

import java.security.NoSuchAlgorithmException;


/**
 * @Class Name : Sha256Cipher.java
 * @Description : Sha256Cipher Class
 * @Modification Information
 * @
 * @  수정일	  수정자			  수정내용
 * @ ---------	---------	-------------------------------
 * @ 2016.08.16			최초생성
 *
 * @author 우림인포텍
 * @since 2016. 03.16
 * @version 1.0
 * @see
 *
 *  Copyright (C) by WOORIM All right reserved.
 */

/**
 * SHA-256 algorithm to encrypt or decrypt the data is the class that provides the ability to.
 * @author devhome.tistory.com
 *
 */
public class Sha256Cipher {

	/**
	 * SHA-256 algorithm to encrypt the data.
	 * @param data Target Data
	 * @param salt Masterkey
	 * @return Encrypted data
	 */
	public static String encrypt(String data, String salt) {
		try {
			
			byte[] bSalt = null;
			if( salt != null ) {
				bSalt = salt.getBytes();
			}
			
			byte[] encrypt = MessageDigestEx.encrypt(data.getBytes(), bSalt, "SHA-256");
			
			StringBuffer buff = new StringBuffer();
			for( int i = 0; i < encrypt.length; i++ ) {
				String hex = Integer.toHexString( encrypt[i] & 0xFF ).toUpperCase();
				if( hex.length() == 1 ) {
					buff.append("0");
				}
				buff.append(hex);
			}
			return buff.toString();
			
		} catch(NoSuchAlgorithmException e) {
			// Never
			return null;
		}
	}
	
	public static void main(String args[]) {
		
		System.out.println( Sha256Cipher.encrypt("2323e2dferg3w4klmf434o", null) );
		System.out.println( Sha256Cipher.encrypt("2323e2dferg3w4klmf434o", "12345678") );
	}
}
