package com.fpdisys.admin.group.domain;

import lombok.Getter;
import lombok.Setter;

import com.fpdisys.base.mvc.BaseVo;

@Setter
@Getter
public class AdminAuthGrpVO extends BaseVo {
	
	private static final long serialVersionUID = 3681993006264972616L;
	
	private String grpAuthCd;
	
	private String grpAuthNm;
	
	private String remark;
	
	private String useYn;
	
	private String regDt;
	
	private String uptSDt;
	

}
