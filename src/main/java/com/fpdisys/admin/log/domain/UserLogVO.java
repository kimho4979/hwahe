package com.fpdisys.admin.log.domain;

import lombok.Getter;
import lombok.Setter;

import com.fpdisys.base.mvc.BaseVo;
@Setter
@Getter
public class UserLogVO extends BaseVo {
	private static final long serialVersionUID = 3681993006264972616L;
	
	private String USER_IP;
	
	private String MENU_ID;
	
	private String INS_DT;
	
	private String INS_ID;
	
	private String UPT_DT;
	
	private String UPT_ID;
	
	private String TOTAL_COUNT;
	

}
