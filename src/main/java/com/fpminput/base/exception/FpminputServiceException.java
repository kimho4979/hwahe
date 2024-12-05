package com.fpminput.base.exception;

import egovframework.rte.fdl.cmmn.exception.BaseException;

public class FpminputServiceException extends BaseException{
	
	private static final long serialVersionUID = -2870585054772220895L;

	  public FpminputServiceException(String messageKey, Throwable causeThrowable)
	  {
		super(messageKey, causeThrowable);
	  }

	  public FpminputServiceException(String messageKey)
	  {
		super(messageKey);
	  }

	  public FpminputServiceException(String messageKey, Object[] args, Throwable causeThrowable)
	  {
		super(messageKey, args, causeThrowable);
	  }

}
