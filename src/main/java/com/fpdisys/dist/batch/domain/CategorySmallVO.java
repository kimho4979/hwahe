package com.fpdisys.dist.batch.domain;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class CategorySmallVO implements Serializable {
	private static final long serialVersionUID = -2286266005247921828L;
	
	private String large;
	private String mid;
	private String small;
	private String goodName;
	private String manageCd;
	private String gubn;
	private String bigo;

}
