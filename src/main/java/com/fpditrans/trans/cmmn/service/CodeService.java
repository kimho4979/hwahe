package com.fpditrans.trans.cmmn.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpditrans.base.mvc.BaseService;
import com.fpditrans.trans.cmmn.mapper.CodeMapper;



/**
 * @Class Name : CodeService.java
 * @Description : CodeService Class
 *	 
 * @ 코드 (포장, 크기, 등급 단위) 서비스 테이블 
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
public class CodeService extends BaseService{
	
	@Autowired
	CodeMapper codeMapper;
	
	
	
	/**
	 * 단위코드 전체조회
	 * @param pReqParamMap
	 * @return
	 */
	public List<?> selectDanListAll(Map<String, Object> pReqParamMap){
		
		return codeMapper.selectDanListAll(pReqParamMap);
	}
	
	/**
	 * 단위코드 검색조회
	 * @param pReqParamMap
	 * @return
	 */
	public List<?> selectDanListSearch(Map<String, Object> pReqParamMap){
		return codeMapper.selectDanListSearch(pReqParamMap);
	}
	
	/**
	 * 단위코드 검색조회 페이징 처리 
	 * @param pReqParamMap
	 * @return
	 */
	public List<?> selectDanListSearchPageAble(Map<String, Object> pReqParamMap){
		return codeMapper.selectDanListSearchPageAble(pReqParamMap);
	}
	
	/**
	 * 등급코드 전체 조회
	 * @param pReqParamMap
	 * @return
	 */
	public List<?> selectLevelListAll(Map<String, Object> pReqParamMap){
		return codeMapper.selectLevelListAll(pReqParamMap);
	}
	
	/**
	 * 등급코드 검색조회
	 * @param pReqParamMap
	 * @return
	 */
	public List<?> selectLevelListSearch(Map<String, Object> pReqParamMap){
		return codeMapper.selectLevelListSearch(pReqParamMap);
	}
	
	/**
	 * 등급코드 검색조회 페이징 처리 
	 * @param pReqParamMap
	 * @return
	 */
	public List<?> selectLevelListSearchPageAble(Map<String, Object> pReqParamMap){
		return codeMapper.selectLevelListSearchPageAble(pReqParamMap);
	}
	
	/**
	 * 포장코드 전체 조회
	 * @param pReqParamMap
	 * @return
	 */
	public List<?> selectPojoListAll(Map<String, Object> pReqParamMap){
		return codeMapper.selectPojoListAll(pReqParamMap);
	}
	
	/**
	 * 포장코드 검색조회
	 * @param pReqParamMap
	 * @return
	 */
	public List<?> selectPojoListSearch(Map<String, Object> pReqParamMap){
		return codeMapper.selectPojoListSearch(pReqParamMap);
	}
	
	/**
	 * 포장코드 검색조회 페이징처리 
	 * @param pReqParamMap
	 * @return
	 */
	public List<?> selectPojoListSearchPageAble(Map<String, Object> pReqParamMap){
		return codeMapper.selectPojoListSearchPageAble(pReqParamMap);
	}
	
	/**
	 * 크기코드 전체 조회
	 * @param pReqParamMap
	 * @return
	 */
	public List<?> selectSizeListAll(Map<String, Object> pReqParamMap){
		return codeMapper.selectSizeListAll(pReqParamMap);
	}
	
	/**
	 * 크기코드 검색조회
	 * @param pReqParamMap
	 * @return
	 */
	public List<?> selectSizeListSearch(Map<String, Object> pReqParamMap){
		return codeMapper.selectSizeListSearch(pReqParamMap);
	}
	
	/**
	 * 크기 코드 검색조회 페이징 처리 
	 * @param pReqParamMap
	 * @return
	 */
	public List<?> selectSizeListSearchPageAble(Map<String, Object> pReqParamMap){
		return codeMapper.selectSizeListSearchPageAble(pReqParamMap);
	}
	
	
	public List<?> selectCodeListSearch(Map<String, Object> pReqParamMap){
		
	
		List<?> resultList =null;
		String searcgCodeType = pReqParamMap.get("searcgCodeType").toString();
		if(searcgCodeType.equals("dan")){
			resultList = this.selectDanListSearch(pReqParamMap);
		}else if(searcgCodeType.equals("lev")){
			resultList = this.selectLevelListSearch(pReqParamMap);
		}else if(searcgCodeType.equals("size")){
			
			resultList = this.selectSizeListSearch(pReqParamMap);
			
		}else if(searcgCodeType.equals("poj")){
			resultList = this.selectPojoListSearch(pReqParamMap);
		}else{
			resultList = this.selectDanListSearch(pReqParamMap);
		}
		
		
		return resultList;
	}

}
