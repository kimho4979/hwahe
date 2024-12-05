package com.fpdisys.dist.apiCall.domain;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlRootElement;

import lombok.Getter;
import lombok.Setter;

import org.codehaus.jackson.annotate.JsonProperty;
import org.springframework.stereotype.Component;


@Setter
@Getter
@XmlRootElement(name="item")
@XmlAccessorType(XmlAccessType.FIELD)
@Component
public class ApiCallSaleDateVO {

	@JsonProperty("saleDate")
	private String saleDate	 ="";
	@JsonProperty("flowerGubn")
	private String flowerGubn	="";
	@JsonProperty("pumName")
	private String pumName	  ="";
	@JsonProperty("goodName")
	private String goodName	 ="";
	@JsonProperty("lvNm")
	private String lvNm		 ="";
	@JsonProperty("maxAmt")
	private String maxAmt		="";
	@JsonProperty("minAmt")
	private String minAmt		="";
	@JsonProperty("avgAmt")
	private String avgAmt		="";
	@JsonProperty("totAmt")
	private String totAmt		="";
	@JsonProperty("totQty")
	private String totQty		="";
	
}
