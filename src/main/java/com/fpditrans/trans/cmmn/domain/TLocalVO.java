package com.fpditrans.trans.cmmn.domain;

import com.fpditrans.base.mvc.BaseVo;

import lombok.Getter;
import lombok.Setter;

/**
 * @Class Name : TGoodNVO.java
 * @Description : TGoodNVO Class
 *	 
 * @  산지코드	도메인 클래스 
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
public class TLocalVO  extends BaseVo{
	
	private static final long serialVersionUID = 1L;
	
	
	  /** 현재페이지 */
	  private int pageIndex = 1;
	  
	  /** 페이지갯수 */
	  private int pageUnit = 10;
	  
	  /** 페이지사이즈 */
	  private int pageSize = 10;
	
	  /** firstIndex */
	  private int firstIndex = 1;
	
	  /** lastIndex */
	  private int lastIndex = 1;
	
	  /** recordCountPerPage */
	  private int recordCountPerPage = 10;
	  
	  /** 산지코드 */ 
	  private String sanCd;
	  
	  /** 산지명 */
	  private String sanName;
	  
	  /** 비고 */
	  private String SanBigo;
	  
	  /** 사용여부 */
	  private String gubn;
	  
	  private int rowNum;
	  
	  

}
