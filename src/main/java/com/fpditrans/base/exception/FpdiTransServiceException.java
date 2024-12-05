package com.fpditrans.base.exception;

import egovframework.rte.fdl.cmmn.exception.BaseException;

/**
 * @Class Name : FpdiTransServiceException.java
 * @Description : FpdiTransServiceException Class
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

public class FpdiTransServiceException extends BaseException{
	
	private static final long serialVersionUID = -2870585054772220895L;

	  public FpdiTransServiceException(String messageKey, Throwable causeThrowable)
	  {
		super(messageKey, causeThrowable);
	  }

	  public FpdiTransServiceException(String messageKey)
	  {
		super(messageKey);
	  }

	  public FpdiTransServiceException(String messageKey, Object[] args, Throwable causeThrowable)
	  {
		super(messageKey, args, causeThrowable);
	  }

}