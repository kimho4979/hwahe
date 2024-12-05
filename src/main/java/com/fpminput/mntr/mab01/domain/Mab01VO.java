package com.fpminput.mntr.mab01.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;


@Setter
@Getter
public class Mab01VO {

	//private static final long serialVersionUID = 1L;
	// T_CROP_REPORT
	private String seqNo	="";
	private String regDate ="";
	private String pumName ="";
	private String goodName="";
	private String chulNo  ="";
	private String status  ="";
	private String bigo	="";
	private String useYn	="";
	private String sanCd	="";
	private String regDt	="";
	private String uptDt	="";
	 
	//T_CROP_FILE
	private int fileSeq =0;
	private int cropReportSeq =0;
	private String originalFileName ="";
	private String storedFileName	="";
	private int fileSize;
	private Date creaDtm;
	private String creaId			="";
	private String delGb			 ="";
	
	private String fileName = "";
	private String statusName ="";
	
}
