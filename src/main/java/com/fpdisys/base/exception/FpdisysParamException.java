package com.fpdisys.base.exception;

public class FpdisysParamException extends RuntimeException 
{
	private static final long serialVersionUID = 1L;

	private int 	errCode;
	private String	errMsg;

	public FpdisysParamException(int errcode, String errmsg) 
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


