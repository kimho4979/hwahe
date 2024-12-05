package com.fpdisys.dist.batch.domain;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class CategoryLargeVO implements Serializable {
	private static final long serialVersionUID = -5444785376577358028L;
	
	private String large;
	private String largeName;

}
