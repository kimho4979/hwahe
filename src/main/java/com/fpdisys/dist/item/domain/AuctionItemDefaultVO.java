package com.fpdisys.dist.item.domain;

import com.fpdisys.base.mvc.BaseVo;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class AuctionItemDefaultVO extends BaseVo{
	/**
	 * 
	 */
	private static final long serialVersionUID = -2463191003136337431L;

	/** 검색조건 */
	private String searchCondition = "";
	
	/** 검색Keyword */
	private String searchKeyword = "";
	
	/** 검색사용여부 */
	private String searchUseYn = "";
	
	/** 현재페이지 */
	private int pageIndex = 1;
	
	/** 페이지갯수 */
	private int pageUnit = 10;
	
	/** 페이지사이즈 */
	private int pageSize = 10;

	/** firstIndex */
	private int firstIndex = 1;

	/** lastIndex */
	private int lastIndex = 1;

	/** recordCountPerPage */
	private int recordCountPerPage = 10;
}