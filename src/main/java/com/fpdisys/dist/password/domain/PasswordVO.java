package com.fpdisys.dist.password.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PasswordVO {

	private static final long serialVersionUID = 1L;
	
	String userId		="";
	String passwd		="";
	String userGubun		="";
	String useYn			="";
	String regDate	 	="";
	String regId			="";
	String initYn	  	="";
	
}
