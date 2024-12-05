package com.fpditrans.trans.cmmn.mapper;



import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
/**
 * @Class Name : TGoodNMapper.java
 * @Description : TGoodNMapper Class
 *	 
 * @  품목코드(소분류) Mapper class;
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

@Mapper("tGoodNMapper")
public interface TGoodNMapper {
	/**
	 * 폼목 소분류 전체검색
	 * @param pReqParamMap
	 * @return
	 */
	List<?> selectGoodNListAll(Map<String, Object> pReqParamMap);
	
	/**
	 * 검색한 데이터만 가져오기 
	 * @param pReqParamMap
	 * @return
	 */
	List<?> selectGoodNListSearch(Map<String, Object> pReqParamMap);
	
	/**
	 * 페이징 처리 
	 * @param pReqParamMap
	 * @return
	 */
	List<?> selectGoodNListSearchPageAble(Map<String, Object> pReqParamMap);

}
