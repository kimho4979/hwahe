package com.fpminput.mntr.codeManage.domain;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonAutoDetect.Visibility;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@JsonAutoDetect(fieldVisibility=Visibility.ANY)
public class CodeManageVO {
	
	private String cmpCd			="";
	private String flowerGubn	  ="";
	private String flowerCode ="";
	private String pumNm			="";
	private String jongNm		  ="";
	private String cmpCdMap		="";
	private String cmpCdMapNm		="";
	private String flowerGubnMap	="";
	private String pumNmMap		="";
	private String jongNmMap		="";
	private String regDt			="";
	private String regId			="";
	private String updDt			="";
	private String uptId			="";
	
	private String userIp;
	private String userId;
	
	private String itemNm;
	private String kindNm;
	private String itemCd;
	private String kindCd;
	private String marketCd;
	private String mCmpGood;//이것은 매핑 테이블에 있는 cmpGood 값
	private String cmpGood;
	
	private String txtSale;
	
	private String searchMejang;

}
