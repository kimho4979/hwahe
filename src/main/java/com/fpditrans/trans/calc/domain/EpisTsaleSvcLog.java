package com.fpditrans.trans.calc.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

import com.fpditrans.base.mvc.BaseVo;
/**
 * @Class Name : TsaleVO.java
 * @Description : TsaleVO Class
 *	 
 * @ 전송시스템로그  도메인 클래스 
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
public class EpisTsaleSvcLog extends BaseVo{
	
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
		
		private String midName;
		/** 대분류+중분류 */
		private String midCode;
		
		
		/** 품목코드 (소분류)  */
		private String small;
		
		private String smallName;
		
		/**  코드합친것 **/
		private String stdCode;
		
		private String stdName;
		
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
	  
		/** 총물량 **/
		private double totQty;
		
		/** 총 가격 **/
		private double totAmt;
		
		/**입력시간 **/
		private Date  inDate;
		
		/** 성공여부*/
		private String successYn;
	  
		/** 성공에부 */
		private String successYn2;
		
		/** 실패사유*/ 
		private String failMessage;
		
		/** 실패사유2  */
		private String failMessage2;
		
		/**  파일명*/
		private String fileName;
		
		/**  레코드내용 */
		private String recordText;
	  
	 
	  
	
}
