package com.fpdisys.dist.saleprice.domain;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class BizMsgVO {

	private static final long serialVersionUID = 1L;
	
	String CMID;
	
	String UMID;
	
	String MSG_TYPE;
	
	String DEST_PHONE;
	
	String SEND_PHONE;		
	
	String SUBJECT;
	
	String MSG_BODY;
	
	String NATION_CODE;
	
	String SENDER_KEY;
	
	String TEMPLATE_CODE;
	
	String RE_TYPE;
	
	String RE_BODY;
}