package com.fpminput.base.exception;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class FpminputRunException extends RuntimeException {
	private static final long serialVersionUID = 1L;
	private final Logger logger = LogManager.getLogger(getClass());

	private final int errCode;
	private final String errMsg;
 
	//getter and setter methods
 
	public FpminputRunException(int errCode, String errMsg) {
		this.errCode = errCode;
		this.errMsg = errMsg;
	}
	
	@Override
	public String getMessage() 
	{
		logger.debug(this.errCode);
		
//		return String.format("MVNO Server - %d: %s", this.errCode, this.errMsg);
		return String.format("%s", this.errMsg);
	}		
}
