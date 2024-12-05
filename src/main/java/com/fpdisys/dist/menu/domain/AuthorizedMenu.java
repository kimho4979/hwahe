package com.fpdisys.dist.menu.domain;

import org.apache.ibatis.type.Alias;

import com.fpdisys.base.mvc.BaseVo;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Alias("authorizedMenu")
@Data
@EqualsAndHashCode(callSuper=false)
public class AuthorizedMenu  extends BaseVo{
	private static final long serialVersionUID = -1168260908871731414L;

	private String searchAuth;

	private String saveAuth;

	private String excelAuth;

	private String function1Auth;

	private String function2Auth;

	private String function3Auth;

	private String function4Auth;

	private String function5Auth;

	private String menuCode;

	private String menuName;

	private String className;

	private Integer menuLevel;

	private Integer menuIndex;

	private String parentMenuCode;

	private String icon;

	private String programPath;

	private String programName;

	private String target;

	private String remark;

	
	private String menuNm;
	private String menuUrl;
	private Integer menuGubn;
	private Integer menuOrder;
	private String menuDetail;
	private Integer menuDepth;
}


