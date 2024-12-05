package com.fpdisys.dist.user.domain;

import lombok.Getter;
import lombok.Setter;

import com.fpdisys.base.mvc.BaseVo;

@Setter
@Getter
public class UserAuth extends BaseVo{

	private String grpAuthCd;
	
	private String grpAuthNm;

	private String userCd;
	
	private String userNm;
	
	private String remark;
	
	private String useYn;
	
	private String userId;	
	
	private String compCode;

}