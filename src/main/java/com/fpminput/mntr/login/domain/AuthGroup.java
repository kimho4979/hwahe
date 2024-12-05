package com.fpminput.mntr.login.domain;

import lombok.Getter;
import lombok.Setter;

import com.fpdisys.base.mvc.BaseVo;



@Getter
@Setter
public class AuthGroup extends BaseVo{

	 private String grpAuthCd;
		
	  /* private List<AuthGroupMenu> authGroupMenus;*/
		
		private String grpAuthNm;

		
		private String remark;

		
		private String grpFg;
		
		private String useYn;
	
}
