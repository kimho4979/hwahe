package com.fpminput.mntr.mcd02.domain;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class Mcd02VO {

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
	
	private String eventGp ="";
	private String eventGpNm ="";
	private String eventNm ="";
	private String eventYmd ="";
	private String eventTim ="";
	private String siNm ="";
	private String addr ="";
	private String eventPls ="";
	private String searchDate ="";
	private String cdId = "";
	private String cdNm = "";
}
