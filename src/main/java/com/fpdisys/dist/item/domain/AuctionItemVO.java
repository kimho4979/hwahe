package com.fpdisys.dist.item.domain;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class AuctionItemVO extends AuctionItemDefaultVO{
	private static final long serialVersionUID = 1L;

	private String flowerGubn;

	private String marketCd;
	private String marketName;
	private String pumName;
	private String totQty;
	private String minAmt;
	private String maxAmt;
	private String avgAmt;
	private String itemNm;

	private String goodName;
	
	
}