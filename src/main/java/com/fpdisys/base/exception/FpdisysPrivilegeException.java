package com.fpdisys.base.exception;

public class FpdisysPrivilegeException extends Exception 
{

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 4829160259452949227L;
	
	private int errCode;
	private String errMsg;
 
	//getter and setter methods
 
	public FpdisysPrivilegeException(int errCode, String errMsg) {
		this.errCode = errCode;
		this.errMsg = errMsg;
	}
	
	@Override
	public String getMessage() 
	{
		return String.format("fpdisys Server - %d: %s", this.errCode, this.errMsg);
	}	

}
