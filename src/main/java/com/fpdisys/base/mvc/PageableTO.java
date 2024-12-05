package com.fpdisys.base.mvc;

import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
public class PageableTO {
	

	private Integer totalPages;
	
	private Long totalElements;
	
	 private Integer currentPage;
	
	 private Integer pageSize;

}
