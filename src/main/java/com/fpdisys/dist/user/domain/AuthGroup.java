package com.fpdisys.dist.user.domain;

import java.util.List;

import com.fpdisys.base.mvc.BaseVo;
import com.fpdisys.dist.menu.domain.AuthGroupMenu;



import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class AuthGroup extends BaseVo{
	
		private String grpAuthCd;

		
		private List<AuthGroupMenu> authGroupMenus;

		
		private String grpAuthNm;

		
		private String remark;

		
		private String grpFg;
		
		private String useYn;

}
