package com.fpdisys.dist.cmmn.integrated.domain;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class KindVO implements Serializable {
	private static final long serialVersionUID = -8145203853089837634L;

	private String flowerGubn;
	private String flowerCode;
	private String itemCd;
	private String kindCd;
	private String itemNm;
	private String kindNm;
	private String useYn;
	
	private String saleDate;
	private String totQty;
	private String minAmt;
	private String maxAmt;
	private String avgAmt;
	private String marketCd;
	
}
