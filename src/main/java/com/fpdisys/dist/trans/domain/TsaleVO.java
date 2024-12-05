package com.fpdisys.dist.trans.domain;

import java.util.Date;

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
public class TsaleVO  extends BaseVo{
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
	
	  
	 /**정산일자*/
	private String saleDate;
	/**변경일자*/
	private String chDate;
	
	/**법인코드*/
	private String cmpCd;
	/**원표번호  */
	private String seq;
	/** 경매번호		*/
	private String no1;
	/** 경매구분		*/
	private int no2;
	/** 경매장구분		*/
	private String mejang;
	/** 품목코드 (대분류)  */
	private String large;
	
	private String largeName;
	
	/** 품목코드 (중분류)  */
	private String mid;
	
	private String midCode;
	
	private String midName;
	/** 품목코드 (소분류)  */
	private String small;
	
	private String smallName;
	
	private String stdCode;
	
	/** 법인사용품종코드  */
	private String cmpGood;
	
	/** 법인사용품목명  */
	private String pumName;
	
	/** 법인사용품종명  */
	private String goodName;
	
	/** 경매구분  */
	private String mmCd;
	
	/** 거래단량  */
	private double danq;
	
	/** 단위코드  */
	private String danCd;
	
	/** 포장코드  */
	private String pojCd;
	
	/** 크기코드  */
	private String sizeCd;
	
	/** 등급코드  */
	private String lvCd;
	
	/** 산지코드  */
	private String sanCd;
	
	/** 법인산지코드  */
	private String cmpSan;
	
	/** 법인산지명  */
	private String sanName;
	
	/** 거래량  */
	private int qty;
	
	/** 경락가  */
	private int cost;
	
	/** 중도매인코드  */
	private String amerCd;
	
	/** 출하구분  */
	private String chCd;
	
	 /** 수집상코드 **/
	private String smanCd;
	
	/** 출하자 등록번호**/
	private String chulNo;
	
	/** 출하처코드 */
	private String chulCd;
	/** 출하처명 **/
	private String chulName;
	
	/** 생산자명 **/
	private String farmName;
	
	/** 경락시간 */
	private String NakTime;
	
	/** 총물량 **/
	private double totQty;
	/** 총 가격 **/
	private double totAmt;
	/**입력시간 **/
	private Date  inTime;
	/** 자료구분 */
	private String gubn;
	
}
