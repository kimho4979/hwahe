package com.fpditrans.trans.cmmn.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpditrans.base.mvc.BaseService;
import com.fpditrans.trans.cmmn.mapper.TLocalMapper;


/**
 * @Class Name : TLocalService.java
 * @Description : TLocalService Class
 *	 
 * @ 산지코드  서비스 테이블 
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
public class TLocalService extends BaseService{
	
	@Autowired
	TLocalMapper tLocalMapper;
	
	
	/**
	 * 산지코드 전체 조회
	 * @param pReqParamMap
	 * @return
	 */
	public List<?> selectSANListAll(Map<String, Object> pReqParamMap){
		return tLocalMapper.selectSANListAll(pReqParamMap);
	}
	
	/**
	 * 검색한 데이터만 가져오기 
	 * @param pReqParamMap
	 * @return
	 */
	public List<?> selectSanListSearch(Map<String, Object> pReqParamMap){
		return tLocalMapper.selectSanListSearch(pReqParamMap);
	}
	
	/**
	 * 검색한 데이터만 가져오기 페이징 처리 
	 * @param pReqParamMap
	 * @return
	 */
	public List<?> selectSanListSearchPageAble(Map<String, Object> pReqParamMap){
	  return tLocalMapper.selectSanListSearchPageAble(pReqParamMap);	
	}

}
