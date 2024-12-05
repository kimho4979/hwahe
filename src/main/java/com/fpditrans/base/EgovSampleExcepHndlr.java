package com.fpditrans.base;

import egovframework.rte.fdl.cmmn.exception.handler.ExceptionHandler;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @Class Name : EgovSampleExcepHndlr.java
 * @Description : EgovSampleExcepHndlr Class
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
public class EgovSampleExcepHndlr implements ExceptionHandler {

	private static final Logger LOGGER = LoggerFactory.getLogger(EgovSampleExcepHndlr.class);

	/**
	* @param ex
	* @param packageName
	* @see 개발프레임웍크 실행환경 개발팀
	*/
	@Override
	public void occur(Exception ex, String packageName) {
		LOGGER.debug(" EgovServiceExceptionHandler run...............");
	}
}

