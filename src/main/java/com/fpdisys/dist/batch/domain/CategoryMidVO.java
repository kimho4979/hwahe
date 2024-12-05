package com.fpdisys.dist.batch.domain;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class CategoryMidVO implements Serializable {
	private static final long serialVersionUID = 9116588347646480835L;
	
	private String large;
	private String mid;
	private String midName;
	private String gubn;
	private String bigo;

}
