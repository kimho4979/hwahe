package com.fpditrans.base.mvc;

import lombok.Data;
import lombok.NoArgsConstructor;


/**
 * @Class Name : PageableTO.java
 * @Description : PageableTO Class
 * @Modification Information
 * @
 * @  수정일	  수정자			  수정내용
 * @ ---------	---------	-------------------------------
 * @ 2016.08.16			최초생성
 *
 * @author 우림인포텍
 * @since 2016. 03.16
 * @version 1.0
 * @see
 *
 *  Copyright (C) by WOORIM All right reserved.
 */

@Data
@NoArgsConstructor
public class PageableTO {
	
	//총페이지
	private Integer totalPages;
	//전체 갯수
	private Long totalElements;
	
	//현재페이지 
	private Integer currentPage;
	
	// 페이지당 개체수
	private Integer pageSize;

}
