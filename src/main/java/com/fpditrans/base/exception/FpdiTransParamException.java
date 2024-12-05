package com.fpditrans.base.exception;

/**
 * @Class Name : FpdiTransParamException.java
 * @Description : FpdiTransParamException Class
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

public class FpdiTransParamException extends RuntimeException 
{
	private static final long serialVersionUID = 1L;

	private int 	errCode;
	private String	errMsg;

	public FpdiTransParamException(int errcode, String errmsg) 
	{
		this.errCode = errcode;
		this.errMsg = errmsg;
	}

	@Override
	public String getMessage() 
	{
		return String.format("파라미터 오류-%s", this.errMsg);
	}
}