package com.fpminput.mntr.mab02.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;


@Setter
@Getter
public class Mab02VO {

	//private static final long serialVersionUID = 1L;
	// T_CROP_REPORT_DETAIL
	private String seqNo;
	private String regDate;
	private String pumName;
	private String goodName;
	private String chulNo ;
	private String uniqueColor ;
	private String status ;	
	private String statSun;
	private String statSize;
	private String statClimate;
	private String statDefinition;
	private String statTemper;
	private String statColor;
	private String statLength;
	private String statThick;
	private String statInsectYn;
	private String statInsectKind;
	private String bigo	;
	private String useYn  ;
	private String sanCd  ;
	private String regDt  ;
	private String uptDt  ;
	
	//T_CROP_DETAIL_FILE
	private int fileSeq;
	private int cropReportSeq;
	private String originalFileName;
	private String storedFileName;
	private int fileSize;
	private Date creaDtm;
	private String creaId;
	private String delGb;	
	private String fileName;
	private String statusName;
	
	private String ORIGINAL_FILE_NAME;
	private String STORED_FILE_NAME;
	private String FILE_SIZE;
	
}
