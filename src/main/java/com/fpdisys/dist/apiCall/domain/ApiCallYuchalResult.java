package com.fpdisys.dist.apiCall.domain;

import java.util.List;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;

import org.codehaus.jackson.annotate.JsonProperty;
import org.springframework.stereotype.Component;

@XmlRootElement(name="response")
@XmlAccessorType(XmlAccessType.FIELD)
@Component
public class ApiCallYuchalResult {
	
	@XmlElement(name="resultCd")
	@JsonProperty("resultCd")
	private String resultCd;
	@XmlElement(name="resultMsg")
	@JsonProperty("resultMsg")
	private String resultMsg;
	@XmlElement(name="numOfRows")
	@JsonProperty("numOfRows")
	private String numOfRows;
	
	@XmlElementWrapper(name="items")
	 @XmlElement(name="item")		
	 @JsonProperty("item")
	private List<ApiCallYuchalVO> items;
	
	
	public List<ApiCallYuchalVO> getItems() {
		return items;
	}
	public void setItems(List<ApiCallYuchalVO> items) {
		this.items = items;
	}
	public String getResultCd() {
		return resultCd;
	}
	public void setResultCd(String resultCd) {
		this.resultCd = resultCd;
	}
	public String getResultMsg() {
		return resultMsg;
	}
	public void setResultMsg(String resultMsg) {
		this.resultMsg = resultMsg;
	}
	public String getNumOfRows() {
		return numOfRows;
	}
	public void setNumOfRows(String numOfRows) {
		this.numOfRows = numOfRows;
	}
}
