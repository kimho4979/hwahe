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
public class ApiCallYuchalVO {

	 @JsonProperty("flowerGubn")
	private String flowerGubn	 ="";
	 @JsonProperty("saleDate")
	private String saleDate  ="";
	@JsonProperty("pumName")
	private String pumName	="";
	@JsonProperty("goodName")
	private String goodName  ="";
	@JsonProperty("totCnt")
	private String totCnt	="";
	@JsonProperty("yuchalCnt")
	private String yuchalCnt ="";
}
