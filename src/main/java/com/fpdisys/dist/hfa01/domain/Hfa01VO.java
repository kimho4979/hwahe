package com.fpdisys.dist.hfa01.domain;

import lombok.Getter;
import lombok.Setter;




@Setter
@Getter
public class Hfa01VO {

	private static final long serialVersionUID = 1L;
	
	private String RNUM;
	private String SEQ;
	private String ENCRPT_SEQ;
	private String BBS_GUBN;
	private String TITLE;
	private String CONTENT;
	private String DISP_YN;
	private String COMP_CODE;
	private String INS_DT;
	private String INS_ID;
	private String UPT_DT;
	private String UPT_ID;
	private String TOTAL_COUNT;
	private String REG_DATE;
	private String ORIGIN_FILE_NAME;
	private String STORED_FILE_NAME;
	private String searchMonth;
	private String CLICK_CNT;	 	
	
	// 17.08.10 희준 :: VO 신규 생성
	private String seq1	 			="";
	private String bbsGubn			="";
	private String title1			="";
	private String content1  		="";
	private String dispYn		  	="";
	private String compCode			="";
	private String insDt				="";
	private String insDt1		  	="";
	private String insId				="";
	private String uptDt				="";
	private String uptId				="";
	private String originFileName 	="";
	private String storedFileName	="";
	
	private String startPageNo		="";
	private String endPageNo		="";
	
	// 20.02.20 :: 추가
	private String RNUM1;	
	
}
