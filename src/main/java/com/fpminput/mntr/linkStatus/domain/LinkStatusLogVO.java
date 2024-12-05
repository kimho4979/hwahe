package com.fpminput.mntr.linkStatus.domain;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class LinkStatusLogVO {
	private String jobId		="";
	private String jobNm		="";
	private String jobDetil		="";
	private String jobCycle		="";
	private String jobYype		="";
	private String agency		="";
	private String useTbNm		="";
	private String uptStat		="";
	private String uptDtFormat	="";
	private String uptDt		="";
	
	private String startDate = "";
	private String sysGp = "";
	private String sysGpNm = "";
	private String rsltGp = "";
	private String rsltGpNm = "";
	private String endDate = "";
	private String procMsg = "";
	private String cdId = "";
	private String cdNm = "";
	private String searchDateF = "";
	private String searchDateT = "";
}				 
