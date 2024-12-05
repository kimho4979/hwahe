package com.fpditrans.trans.cmmn.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * @Class Name : TLocalMapper.java
 * @Description : TLocalMapper Class
 *	 
 * @  산지코드  Mapper class;
 * @  수정일	  수정자			  수정내용
 * @ ---------	---------	-------------------------------
 * @ 2016.07.28			최초생성
 *
 * @author 우림인포텍
 * @version 1.0
 * @see
 *
 *  Copyright (C) by woorim All right reserved.
 */

@Mapper("tLocalMapper")
public interface TLocalMapper {
	
	/**
	 * 산지코드 전체 조회
	 * @param pReqParamMap
	 * @return
	 */
	List<?> selectSANListAll(Map<String, Object> pReqParamMap);
	
	/**
	 * 검색한 데이터만 가져오기 
	 * @param pReqParamMap
	 * @return
	 */
	List<?> selectSanListSearch(Map<String, Object> pReqParamMap);
	
	/**
	 * 검색한 데이터만 가져오기 페이징 처리 
	 * @param pReqParamMap
	 * @return
	 */
	List<?> selectSanListSearchPageAble(Map<String, Object> pReqParamMap);

}
