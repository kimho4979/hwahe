package com.fpdisys.dist.cmmn.integrated.domain;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonAutoDetect.Visibility;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@JsonAutoDetect(fieldVisibility = Visibility.ANY)
public class ItemVO implements Serializable {
	private static final long serialVersionUID = 3846466937736097577L;

	private String flowerGubn;
	private String flowerCode;
	private String itemCd;
	private String itemNm;
	private String kindCd;
	private String kindNm;
	private String useYn;
	private String searchStrDate;
	private String searchEndDate;
	private String cmpCd;
	private String flowerCd;
	private String marketCd;
	
}
