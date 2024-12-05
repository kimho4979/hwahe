package com.fpminput.mntr.login.domain;

import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

import com.fpdisys.base.mvc.BaseVo;

@Getter
@Setter
public class User extends BaseVo {

	private String userCd;

		
	private String userNm;

	
	private String userPs;

	
	private String compCd;

	
	private String email;

	
	private String hpNo;

	
	private String userType;

  
	private String remark;

	
	private String useYn;

	
	private Date lastLoginDate;

	
	private Date passwordUpdateDate;

	
	private String apiKey;

	
	private List<UserAuth> userAuthList;
	
}
