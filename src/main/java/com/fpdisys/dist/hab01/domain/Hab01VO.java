package com.fpdisys.dist.hab01.domain;


import lombok.Getter;
import lombok.Setter;


@Setter
@Getter
public class Hab01VO extends Hab01DefaultVO{

	private static final long serialVersionUID = 1L;
	
	private String cmpCd;
	private String saleMonth;
	private String saleDate;
	private String flowerGubn;
	private String pumName;
	private String goodName;
	private String maxAmt;
	private String minAmt;
	private String avgAmt;
	private String totQty;
	private String totAmt;
	private String lvName;
	private String lvCd;
	private String lvEtcNm;
	private String cost;
	
	private String perTotQty;
	private String perTotAmt;
	private String perQtyCol;
	private String perAmtCol;
	private String perYearTotQty;
	private String perYearTotAmt;
	private String perYearQtyCol;
	private String perYearAmtCol;
	private String perOldTotQty;
	private String perOldTotAmt;
	private String perOldQtyCol;
	private String perOldAmtCol;
}
