package com.fpdisys.dist.hab08.domain;


import lombok.Getter;
import lombok.Setter;


@Setter
@Getter
public class Hab08VO extends Hab08DefaultVO{

	private static final long serialVersionUID = 1L;
	
	private String cmpCd;
	private String saleDate;
	private String pumCode;
	private String pumName;
	private String weeklyNm;
	private String marketName;	
	private String per;
	private String totQty;
	
	private String col0000000001;
	private String col1288202296;
	private String col1508500020;
	private String col3848200087;
	private String col4108212335;
	private String col6068207466;
	private String col6158209828;
}
