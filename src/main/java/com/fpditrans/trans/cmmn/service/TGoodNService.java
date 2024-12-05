package com.fpditrans.trans.cmmn.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpditrans.base.mvc.BaseService;

import com.fpditrans.trans.cmmn.mapper.TGoodNMapper;

/**
 * @Class Name : TransTsaleService.java
 * @Description : TransTsaleService Class
 *	 
 * @ 품목코드  서비스 테이블 
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

@Service
public class TGoodNService extends BaseService{
	
	@Autowired
	TGoodNMapper tGoodNMapper;
	
	
	
	/**
	 * 폼목 소분류 전체검색
	 * @param pReqParamMap
	 * @return
	 */
	public List<?> selectGoodNListAll(Map<String, Object> pReqParamMap){
		return tGoodNMapper.selectGoodNListAll(pReqParamMap);
	}
	
	/**
	 * 검색한 데이터만 가져오기 
	 * @param pReqParamMap
	 * @return
	 */
	public List<?> selectGoodNListSearch(Map<String, Object> pReqParamMap){
		return tGoodNMapper.selectGoodNListSearch(pReqParamMap);
	}
	
	/**
	 * 페이징 처리 
	 * @param pReqParamMap
	 * @return
	 */
	List<?> selectGoodNListSearchPageAble(Map<String, Object> pReqParamMap){
		return tGoodNMapper.selectGoodNListSearchPageAble(pReqParamMap);
	}

}
