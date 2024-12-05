package com.fpdisys.dist.saleprice.domain;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class BizMailVO {

	private static final long serialVersionUID = 1L;
	
	String SEQ;
	
	String USER_ID;
	
	String SUBJECT;
	
	String MSG_BODY;
	
	String BIZ_MAIL;
}