package com.fpditrans.base.cipher.sha;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;



/**
 * @Class Name : MessageDigestEx.java
 * @Description : MessageDigestEx Class
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

public class MessageDigestEx {

	private static final int	ITERATION_CNT = 5;
	private static final String SALT		  = "24516422";
	
	public static byte[] getSalt() {
		return SALT.getBytes();
	}
	
	public static byte[] encrypt(byte[] data, byte[] salt, String algorithm) throws NoSuchAlgorithmException {
		
		MessageDigest digest = MessageDigest.getInstance(algorithm);
		digest.reset();
		if( salt == null ) {
			digest.update(getSalt());
		} else {
			digest.update(salt);
		}
		
		for( int i = 0; i < ITERATION_CNT; i++ ) {
			data = digest.digest(data);
		}
		
		return data;
	}
}

