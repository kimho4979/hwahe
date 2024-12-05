package com.fpminput.mntr.dailyRptMgt.domain;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class DailyRptMgtVO {

	private static final long serialVersionUID = 1L;
	
	private String seq		="";
	private String bbsGubn  ="";
	private String title	="";
	private String content  ="";
	private String dispYn	="";
	private String compCode ="";
	private String insDt	="";
	private String insId	="";
	private String uptDt	="";
	private String uptId	="";
	
	private String fileSeq			="";
	private String originFileName	="";
	private String storedFileName	="";
	private String filePath		 ="";
	private String fileSize		 ="";
	private String fileExt		  ="";
	
	private String startDate = "";
	private String rsltGp = "";
	private String rsltGpNm = "";
	private String endDate = "";
	private String procMsg = "";
	private String searchDate = "";
	private String searchNm = "";
	
	private int logSeq;
	private String sysGp = "";
	private String userNm = "";
	private String pgmId = "";
	private String pgmNm = "";
}
