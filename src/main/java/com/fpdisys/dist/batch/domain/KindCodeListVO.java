package com.fpdisys.dist.batch.domain;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class KindCodeListVO implements Serializable {
	private static final long serialVersionUID = -3826117926061216438L;
	
	private String queryType;
	private String flowerGubn;
	private String flowerCode;
	private String itemCd;
	private String kindCd;
	private String marketCd;
	private String cmpGood;
	private String cmpGood1;
	private String large;
	private String mid;
	private String small;
	private String lvCd;
	private String pumName;
	private String goodName;
	private String itemNm;
	private String kindNm;
}
