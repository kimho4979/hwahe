package com.fpditrans.base;

import egovframework.rte.fdl.cmmn.exception.handler.ExceptionHandler;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @Class Name : EgovSampleOthersExcepHndlr.java
 * @Description : EgovSampleOthersExcepHndlr Class
 * @Modification Information
 * @
 * @  수정일	  수정자			  수정내용
 * @ ---------	---------	-------------------------------
 * @ 2009.03.16			최초생성
 *
 * @author 우림인포텍
 * @since 2009. 03.16
 * @version 1.0
 * @see
 *
 *  Copyright (C) by WOORIM All right reserved.
 */
public class EgovSampleOthersExcepHndlr implements ExceptionHandler {

	private static final Logger LOGGER = LoggerFactory.getLogger(EgovSampleOthersExcepHndlr.class);

	/**
	* @param exception
	* @param packageName
	* @see 우림인포텍
	*/
	@Override
	public void occur(Exception exception, String packageName) {
		LOGGER.debug(" EgovServiceExceptionHandler run...............");
	}

}

