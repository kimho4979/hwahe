package com.fpdisys.admin.user.domain;

import lombok.Getter;
import lombok.Setter;

import com.fpdisys.base.mvc.BaseVo;
@Setter
@Getter
public class AdminUserVO extends BaseVo {
	
	private static final long serialVersionUID = 3681993006264972619L;
	
	private String userId;
	
	private String compCode;
	
	private String compCodeNm;
	
	private String userType;
	
	private String userTypeNm;
	
	private String grpAuthCode;
	
	private String grpAuthCodeNm;
	
	private String LastLoginDate;
	
	private String remark;
	
	private String sanNm;
	
	private String useYn;
	
	private int passErrNum;
	
	private String regDt;

	private String sUptDt;
	
	private String SAN_BIGO;
	
	private String TOTAL_COUNT;
	
	

}
