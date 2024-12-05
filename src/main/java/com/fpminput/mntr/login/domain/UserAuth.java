package com.fpminput.mntr.login.domain;

import lombok.Getter;
import lombok.Setter;

import com.fpdisys.base.mvc.BaseVo;

@Setter
@Getter
public class UserAuth extends BaseVo {

	  private String userCd;

		
		private String grpAuthCd;

		
		private User user;

	  
		private AuthGroup authGroup;

		
		private String remark;

		
		private String useYn;
	
}
