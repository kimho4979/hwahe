package com.fpditrans.base.exception;

/**
 * @Class Name : FpdiTransPrivilegeException.java
 * @Description : FpdiTransPrivilegeException Class
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

public class FpdiTransPrivilegeException extends Exception 
{

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 4829160259452949227L;
	
	private int errCode;
	private String errMsg;
 
	//getter and setter methods
 
	public FpdiTransPrivilegeException(int errCode, String errMsg) {
		this.errCode = errCode;
		this.errMsg = errMsg;
	}
	
	@Override
	public String getMessage() 
	{
		return String.format("fpdisys Server - %d: %s", this.errCode, this.errMsg);
	}	

}