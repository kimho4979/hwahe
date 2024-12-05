package com.at.domain;

import lombok.Getter;
import lombok.Setter;

import com.fpdisys.base.mvc.BaseVo;
/**
 * @Class Name : TsaleVO.java
 * @Description : TsaleVO Class
 *	 
 * @ 정산자료 도메인 클래스 
 * @  수정일	  수정자			  수정내용
 * @ ---------	---------	-------------------------------
 * @ 2016.07.28			최초생성
 *
 * @author 우림인포텍
 * @version 1.0
 * @see
 * 
 * Copyright (C) by woorim All right reserved.
 */
@Setter
@Getter
public class AtMntVO  extends BaseVo{
	private static final long serialVersionUID = 1L;
 
	private String PAN_DAY;
	private String PAN_NO;
	private String PAN_SERIAL;
	private String PUM_CODE;
	private String MOK_NAME;
	private String JONG_NAME;
	private String LEVEL_CODE;
	private String LEVEL_NAME;
	private String BOX_CNT;
	private String SOK_CNT;
	private String KM_P_NEW;
	private String PAN_PRICE;
	private String KM_LIST;
	private String DOME_CODE;
	private String BUN_CHK;
	private String CHUL_CODE;
	private String FIRST_IN_DATE;
	private String LAST_UPDATED;
	private String MEJANG;
}
