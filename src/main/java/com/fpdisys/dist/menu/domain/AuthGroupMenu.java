package com.fpdisys.dist.menu.domain;

import lombok.Getter;
import lombok.Setter;

import com.fpdisys.base.mvc.BaseVo;
import com.fpdisys.dist.login.domain.AuthGroup;

@Setter
@Getter
public class AuthGroupMenu extends BaseVo{
	 
		private String grpAuthCd;
		
		private String grpAuthNm;

	  
		private String mnuCd;
		
		private String mnuNm;

		
		private AuthGroup authGroup;

		
		private Menu menu;

		
		private String schAh;

		
		private String savAh;

		
		private String exlAh;

		
		private String fn1Ah;

		
		private String fn2Ah;

		
		private String fn3Ah;

		
		private String fn4Ah;

		
		private String fn5Ah;
}
