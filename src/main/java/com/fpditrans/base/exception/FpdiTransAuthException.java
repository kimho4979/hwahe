package com.fpditrans.base.exception;



/**
 * @Class Name : FpdiTransAuthException.java
 * @Description : FpdiTransAuthException Class
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

public class FpdiTransAuthException  extends Exception 
{
	private static final long serialVersionUID = 1L;

	private int errCode;
	private String errMsg;
 
	//getter and setter methods
 
	public FpdiTransAuthException(int errCode, String errMsg) {
		this.errCode = errCode;
		this.errMsg = errMsg;
	}
	
	@Override
	public String getMessage() 
	{
		return String.format("fpdisys Server - %d: %s", this.errCode, this.errMsg);
	}	
}