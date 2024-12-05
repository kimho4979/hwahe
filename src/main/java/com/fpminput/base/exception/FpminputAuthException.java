package com.fpminput.base.exception;

public class FpminputAuthException  extends Exception {
	private static final long serialVersionUID = 1L;

	private int errCode;
	private String errMsg;
 
	//getter and setter methods
 
	public FpminputAuthException(int errCode, String errMsg) {
		this.errCode = errCode;
		this.errMsg = errMsg;
	}
	
	@Override
	public String getMessage() 
	{
		return String.format("fpinput Server - %d: %s", this.errCode, this.errMsg);
	}	
}
