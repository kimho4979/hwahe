package com.fpdisys.dist.hca03.domain;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class Hca03VO {
	
	private static final long serialVersionUID = 1L;
	private String TOTAL_COUNT;
	private String RNUM;
	private String REG_DATE;
	private String PUM_NAME;
	private String GOOD_NAME;
	private String CHUL_NO;
	private String STATUS;
	private String BIGO;		
	private String FILE_PATH;
	private String SIDO;
	private String FILE_NAME;
	private String UNIQUE_COLOR;
	private String STAT_SUN;
	private String STAT_SIZE;
	private String STAT_CLIMATE;
	private String STAT_DEFINITION;
	private String STAT_TEMPER;
	private String STAT_COLOR;
	private String STAT_LENGTH;
	private String STAT_THICK;
	private String STAT_INSECT_YN;
	private String STAT_INSECT_KIND;
	private String FILE_SEQ;
	private String ORIGINAL_FILE_NAME;
	private String STORED_FILE_NAME;
	private String REG_DT;
	
	private String seqNo				="";
	private String regDate	 		="";
	private String pumName	 		="";
	private String goodName			="";
	private String chulNo	  		="";
	private String status1	 		="";
	private String bigo1				="";
	private String useYn				="";
	private String sanCd				="";
	private String regDt				="";
	private String uptDt				="";
	
	private String fileSeq			="";
	private String cropReportSeq	="";
	private String originalFileName ="";
	private String storedFileName	="";
	
	private String startPageNo ="";
	private String endPageNo	="";
	
	private String statusCnt	="";
}
