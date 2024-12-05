package com.fpminput.mntr.cmmn.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class ItemVO {
	private String itemCd	="";
	private String gubnCd	="";
	private String gubnName ="";
	private String largeCd  ="";
	private String largeName="";
	private String smallCd  ="";
	private String smallName="";
	private String useYn	="";
	private Date regDate;
	private String regUser  ="";
}
