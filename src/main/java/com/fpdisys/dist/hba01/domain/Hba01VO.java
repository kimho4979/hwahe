package com.fpdisys.dist.hba01.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Hba01VO {
	
	private static final long serialVersionUID = 1L;
	
	private String TOTAL_COUNT;
	private String RNUM;
	private String ANUM;
	private String REG_MONTH;
	private String TITLE;
	private String WRITE_NAME;
	private String INS_DT;	
	private String CONTENT;
	private String ORIGINAL_FILE_NAME;
	private String STORED_FILE_NAME;
	private String SEQ_NO;
	private String CLICK_CNT;
	
	private String seqNo			="";
	private String regMonth	 	="";
	private String title1			="";
	private String writeName		="";
	private String insDt				="";
	private String gubn				="";
	private String useYn			="";
	private String content1			="";
	private String originalFileName	="";
	private String storedFileName  	="";
	
	private String startPageNo 	= "";
	private String endPageNo 	= "";
	
}