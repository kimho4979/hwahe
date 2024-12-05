package com.fpdisys.admin.menu.domain;

import lombok.Getter;
import lombok.Setter;

import com.fpdisys.base.mvc.BaseVo;


@Setter
@Getter
public class AdminMenuVO extends BaseVo {
	
	private String sysCd;
	
	private String mnuCd;
	
	private String progCd;
	
	private String progNm;
	private String grpAuthCd;
	
	private String grpAuthCdNm;
	
	private String Icon;
	
	private String mnuIx;
	
	private String mnuLv;
	
	private String mnuNm;
	
	private String mnuUpCd;
	
	private String remark;
	
	private String useYn;
	
	private String regDt;
	
	private String sUptDt;

}
