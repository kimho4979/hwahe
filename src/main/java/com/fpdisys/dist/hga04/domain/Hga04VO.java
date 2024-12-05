package com.fpdisys.dist.hga04.domain;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class Hga04VO {
	// 조회조건
	private String searchStrDate = "";
	private String searchEndDate = "";
	private String cmpCd = "";
	private String cmpNm = "";
	private String dateType = "";
	private String searchStrYear = "";
	private String cmpCd2 = "";
	private String cmpNm2 = "";
	private String flowerCd = "";
	private String flowerNm = "";
	private String type2 = "";
	
	// 조회조건 품목
	private String itemCd	="";
	private String itemNm	="";
	
	// 조회조건 품목
	private String kindCd	="";
	private String kindNm	="";
	
	// 우측상단 산지별집계
	private String sanName = "";
	private String av1 = "";
	private String av2 = "";
	
	private String sidoCode = "";
	private String label = "";
	private String code = "";
	private String rank = "";
	
	// 우측하단 유통현황
	private String mth = "";
	private String qty = "";
	
	private String flowerGubun = "";
	private String flowerCode = "";
	
	// 엑셀다운
	private String pumName = "";
	private String goodName = "";
	private String marketName = "";
	private String marketCd = "";
	private String sanBigo = "";
	private String totQty = "";
	private String totAmt = "";	
	private String amt = "";
	
	private String sanBigoSi = "";
	private String sanBigoGun = "";
	
	private String saleDate = "";
}
