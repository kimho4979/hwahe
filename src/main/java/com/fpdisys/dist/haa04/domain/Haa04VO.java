package com.fpdisys.dist.haa04.domain;

import lombok.Getter;
import lombok.Setter;

import com.fpdisys.dist.haa04.domain.Haa04DefaultVO;

@Setter
@Getter
public class Haa04VO extends Haa04DefaultVO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 905606821775569210L;
	
	private String SALE_MONTH;
	private String TOT_AMT;
	private String TOT_QTY;
	private String PER_TOT_AMT;
	private String PER_AMT_COL;
	private String PER_TOT_QTY;
	private String PER_QTY_COL;
	private String NU_TOT_AMT;
	private String NU_TOT_QTY;
	private String PER_NU_TOT_AMT;
	private String PER_NU_AMT_COL;
	private String PER_NU_TOT_QTY;
	private String PER_NU_QTY_COL;
	
}
