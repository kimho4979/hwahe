package com.fpditrans.base.exception;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * @Class Name : FpdiTransRunException.java
 * @Description : FpdiTransRunException Class
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

public class FpdiTransRunException  extends RuntimeException {
	private static final long serialVersionUID = 1L;
	private final Logger logger = LogManager.getLogger(getClass());

	private final int errCode;
	private final String errMsg;
 
	//getter and setter methods
 
	public FpdiTransRunException(int errCode, String errMsg) {
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