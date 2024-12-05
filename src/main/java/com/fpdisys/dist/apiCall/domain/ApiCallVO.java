package com.fpdisys.dist.apiCall.domain;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class ApiCallVO {
	private String serviceKey = "";
	private String reqDataCd  = "";
	private String openStrDt  = "";
	private String openEndDt  = "";
	private String useYn	  = "";
	private String regDt	  = "";
	private String sysFmt	 = "";
	private String useInfo	= "";
	private String delYn	  = "";
	
	private String resultDt = "";
	
	private String callDt	="";
	private String callCnt	="";
	private String ip		="";
	private String dataType  ="";
	private String parameter ="";
	private String callTime  ="";
	private String resultCnt ="";
	private String resultCallDt ="";
}
