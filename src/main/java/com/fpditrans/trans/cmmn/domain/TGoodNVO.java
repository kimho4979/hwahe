package com.fpditrans.trans.cmmn.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

import com.fpditrans.base.mvc.BaseVo;

/**
 * @Class Name : TGoodNVO.java
 * @Description : TGoodNVO Class
 *	 
 * @ 품목 소분류  도메인 클래스 
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
public class TGoodNVO extends BaseVo{
	
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
	  
	  /** 대분류 */	 
	  private String large;
	 /** 대분류명 */
	  private String largeName;
	  
	  /** 중분류 */
	  private String mid;
	  
	  /** 대분류 +중분류 */
	  private String midCode;
	  
	  /** 중분류명 */
	  private String midName;
	  
	  /** 소분류 **/
	  private String small;
	  
	  /** 소분류명 **/
	  private String goodName;
	  
	  /** 표준코드	대분류+중분류+소분류*/
	  private String stdCode;
	  
	  /** 표준코드명*/
	  private String stdName;
	  
	  /** 종류 */
	  private String manageCd;
	  /** 구분*/
	  private String gubn;
	  
	  /** 비고 */
	  private String bigo;
	  
	  
	  private int rowNum; 
	  
	  
	  

}
