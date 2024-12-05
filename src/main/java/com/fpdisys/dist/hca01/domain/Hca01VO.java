package com.fpdisys.dist.hca01.domain;

import lombok.Getter;
import lombok.Setter;


@Setter
@Getter
public class Hca01VO {
	
	private static final long serialVersionUID = 1L;
	
	private String REG_DATE;
	private String CMP_CD;
	private String MARKET_NAME;
	private String QTY;
	private String DAY_GUBN;
	
	
	private String QTY_1 = "";
	private String QTY_2 = "";
	private String QTY_3 = "";
	private String TOT_QTY = "";
}
