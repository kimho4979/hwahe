package com.fpdisys.base.exception;

public class FpdisysAuthException extends Exception 
{
	private static final long serialVersionUID = 1L;

	private int errCode;
	private String errMsg;
 
	//getter and setter methods
 
	public FpdisysAuthException(int errCode, String errMsg) {
		this.errCode = errCode;
		this.errMsg = errMsg;
	}
	
	@Override
	public String getMessage() 
	{
		return String.format("fpdisys Server - %d: %s", this.errCode, this.errMsg);
	}	
}
