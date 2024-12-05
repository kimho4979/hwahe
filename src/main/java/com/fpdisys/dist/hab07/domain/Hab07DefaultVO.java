package com.fpdisys.dist.hab07.domain;

import lombok.Getter;
import lombok.Setter;

import com.fpdisys.base.mvc.BaseVo;

@Setter
@Getter
public class Hab07DefaultVO extends BaseVo {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1742517028675316738L;

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
	
	private String regDate;
	
	private String updDate;
}
