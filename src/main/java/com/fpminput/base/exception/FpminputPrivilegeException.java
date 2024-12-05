package com.fpminput.base.exception;

public class FpminputPrivilegeException extends Exception 
{

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 4829160259452949227L;
	
	private int errCode;
	private String errMsg;
 
	//getter and setter methods
 
	public FpminputPrivilegeException(int errCode, String errMsg) {
		this.errCode = errCode;
		this.errMsg = errMsg;
	}
	
	@Override
	public String getMessage() 
	{
		return String.format("fpminput Server - %d: %s", this.errCode, this.errMsg);
	}	

}
