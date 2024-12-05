package com.fpdisys.dist.hab07.domain;


import lombok.Getter;
import lombok.Setter;


@Setter
@Getter
public class Hab07VO extends Hab07DefaultVO{

	private static final long serialVersionUID = 1L;
	
	private String cmpCd;
	private String cmpCdNm;
	private String saleMonth;
	private String flowerGubn;
	private String flowerGubnNm;
	private String pumName;
	private String goodName;
	private String mmCd;
	private String mmCdNm;
	private String danCd;
	private String danCdNm;
	private String pojCd;
	private String pojCdNm;
	private String lvCd;
	private String lvCdNm;
	private double danQ;	
	private int maxAmt;
	private int minAmt;
	private int avgAmt;
	private String sizeCd;
	private String sizeCdNm;
	private String sanCd;
	private String sanCdNm;
	private double totAmt;
	private double totQty;
	private String chartX;

}
