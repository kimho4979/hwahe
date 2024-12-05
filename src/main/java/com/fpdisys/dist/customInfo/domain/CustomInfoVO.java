package com.fpdisys.dist.customInfo.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;


@Setter
@Getter
public class CustomInfoVO {
	
	// T_CUSTOMINFO
	private String userId;
	private String passwd;
	private String userGubun;
	private String useYn;		
	private Date regDate;
	private String regId;
	private String initYn;
	private String acsYn;

	// T_CUSTOMINFO_DTL
	private String report1Yn ="";
	private String report2Yn ="";
	private String saleYn	="";
	private String salePum	="";
	private String realYn	="";
	private String realTime  ="";
	
	// T_CUSTOMINFO_REAL
	private String seq		="";
	private String sidoCode ="";
	private String itemCd	="";
	private String itemCd1	="";
	private String flowerCd	="";
	
}
