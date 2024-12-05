package com.fpdisys.base.exception;
import egovframework.rte.fdl.cmmn.exception.BaseException;

public class FpdisysServiceException extends BaseException{
	
	private static final long serialVersionUID = -2870585054772220895L;

	  public FpdisysServiceException(String messageKey, Throwable causeThrowable)
	  {
		super(messageKey, causeThrowable);
	  }

	  public FpdisysServiceException(String messageKey)
	  {
		super(messageKey);
	  }

	  public FpdisysServiceException(String messageKey, Object[] args, Throwable causeThrowable)
	  {
		super(messageKey, args, causeThrowable);
	  }

}
