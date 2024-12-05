package com.fpdisys.dist.user.domain;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

import com.fpdisys.base.mvc.BaseVo;

@Setter
@Getter
public class User extends BaseVo{

	private String userCd;
	
	private String userId;
	
	private String compCode;
	
	private String compCodeNm;
	
	private String userNm;
	
	private String email;
	
	private String hpNo;
	
	private String lastLoginDate;
	
	private String userPs;
	
	private String userType;
	
	private String userTypeNm;
	
	private String useYn;
	
	private int passErrNum;

	private String remark;
	
	private String passwordUpdateDate;
}
