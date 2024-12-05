package com.fpminput.mntr.mcc02.domain;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class Mcc02VO {

	private static final long serialVersionUID = 1L;
	
	private String seqNo			="";
	private String regMonth		 ="";
	private String title			="";
	private String writeName		="";
	private String insDt			="";
	private String gubn			 ="";
	private String useYn			="";
	private String content		  ="";

	private String forecastSeq	  ="";
	private String originalFileName ="";
	private String storedFileName	="";
	private String fileSize		 ="";
	private String creaDtm		  ="";
	private String creaId			="";
	private String delGb			="";
}
