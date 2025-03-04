package com.fpminput.mntr.dailyRptSend.domain;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class DailyRptSendVO {

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
	
	private String emailAdrs = "";
	private String sndDeptNm = "";
	private String sndOthNm = ""; 
	private String sndTel = "";
	private String endSndDt = "";
	private String useYn = "";
	private String userNm = "";
	private String searchNm = "";
	
	private String idx = "";

	public String getEmailAdrs() {
		// TODO Auto-generated method stub
		return null;
	}
}
