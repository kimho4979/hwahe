package com.fpditrans.trans.cmmn.mapper;


import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
/**
 * @Class Name : CodeMapper.java
 * @Description : CodeMapper Class
 *	 
 * @ 코드) Mapper class;
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

@Mapper("codeMapper")
public interface CodeMapper {
	/**
	 * 단위코드 전체조회
	 * @param pReqParamMap
	 * @return
	 */
	List<?> selectDanListAll(Map<String, Object> pReqParamMap);
	/**
	 * 단위코드 검색조회
	 * @param pReqParamMap
	 * @return
	 */
	List<?> selectDanListSearch(Map<String, Object> pReqParamMap);
	/**
	 * 단위코드 검색조회 페이징 처리 
	 * @param pReqParamMap
	 * @return
	 */
	List<?> selectDanListSearchPageAble(Map<String, Object> pReqParamMap);
	/**
	 * 등급코드 전체 조회
	 * @param pReqParamMap
	 * @return
	 */
	List<?> selectLevelListAll(Map<String, Object> pReqParamMap);
	/**
	 * 등급코드 검색조회
	 * @param pReqParamMap
	 * @return
	 */
	List<?> selectLevelListSearch(Map<String, Object> pReqParamMap);
	/**
	 * 등급코드 검색조회 페이징 처리 
	 * @param pReqParamMap
	 * @return
	 */
	List<?> selectLevelListSearchPageAble(Map<String, Object> pReqParamMap);
	/**
	 * 포장코드 전체 조회
	 * @param pReqParamMap
	 * @return
	 */
	List<?> selectPojoListAll(Map<String, Object> pReqParamMap);
	/**
	 * 포장코드 검색조회
	 * @param pReqParamMap
	 * @return
	 */
	List<?> selectPojoListSearch(Map<String, Object> pReqParamMap);
	/**
	 * 포장코드 검색조회 페이징처리 
	 * @param pReqParamMap
	 * @return
	 */
	List<?> selectPojoListSearchPageAble(Map<String, Object> pReqParamMap);
	
	/**
	 * 크기코드 전체 조회
	 * @param pReqParamMap
	 * @return
	 */
	List<?> selectSizeListAll(Map<String, Object> pReqParamMap);
	/**
	 * 크기코드 검색조회
	 * @param pReqParamMap
	 * @return
	 */
	List<?> selectSizeListSearch(Map<String, Object> pReqParamMap);
	/**
	 * 크기 코드 검색조회 페이징 처리 
	 * @param pReqParamMap
	 * @return
	 */
	List<?> selectSizeListSearchPageAble(Map<String, Object> pReqParamMap);
	

}
