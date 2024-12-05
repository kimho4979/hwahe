package com.fpditrans.base.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
/**
 * @Class Name : HashUtils.java
 * @Description : HashUtils Class
 *	 
 * 암호화 유틸 클래스
 * @  수정일	  수정자			  수정내용
 * @ ---------	---------	-------------------------------
 * @ 2016.07.28			최초생성
 *
 * @author 우림인포텍
 * @version 1.0
 * @see
 *
 *  Copyright (C) by woorim All right reserved.
 */
public class HashUtils {
	 public static String MD5(String str) {
			String MD5 = "";

			try {
				MessageDigest md = MessageDigest.getInstance("MD5");
				md.update(str.getBytes());
				byte byteData[] = md.digest();
				StringBuffer sb = new StringBuffer();
				for (int i = 0; i < byteData.length; i++) {
					sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
				}
				MD5 = sb.toString();

			} catch (NoSuchAlgorithmException e) {
				e.printStackTrace();
				MD5 = null;
			}
			return MD5;
		}

		public static String SHA256(String str) {
			String SHA = "";

			try {
				MessageDigest sh = MessageDigest.getInstance("SHA-256");
				sh.update(str.getBytes());
				byte byteData[] = sh.digest();
				StringBuffer sb = new StringBuffer();
				for (int i = 0; i < byteData.length; i++) {
					sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
				}
				SHA = sb.toString();

			} catch (NoSuchAlgorithmException e) {
				e.printStackTrace();
				SHA = null;
			}
			return SHA;
		}

		public static String SHA512(String str) {
			MessageDigest md;
			String SHA = "";

			try {
				md = MessageDigest.getInstance("SHA-512");

				md.update(str.getBytes());
				byte[] mb = md.digest();
				for (int i = 0; i < mb.length; i++) {
					byte temp = mb[i];
					String s = Integer.toHexString(new Byte(temp));
					while (s.length() < 2) {
						s = "0" + s;
					}
					s = s.substring(s.length() - 2);
					SHA += s;
				}
			} catch (NoSuchAlgorithmException e) {
			}

			return SHA;
		}

		public static String SHA1(String str) {
			try {
				MessageDigest mDigest = MessageDigest.getInstance("SHA1");
				byte[] result = mDigest.digest(str.getBytes());
				StringBuffer sb = new StringBuffer();
				for (int i = 0; i < result.length; i++) {
					sb.append(Integer.toString((result[i] & 0xff) + 0x100, 16).substring(1));
				}
				return sb.toString();
			} catch (Exception e) {

			}

			return "";
		}
}
