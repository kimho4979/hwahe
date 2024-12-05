package com.fpdisys.dist.hab02.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.hab02.domain.Hab02VO;
import com.fpdisys.dist.hab02.mapper.Hab02Mapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class Hab02Service extends BaseService {
	
	@Autowired
	Hab02Mapper hab02Mapper;
	
	/**
	 * 품종별 종합 경매정보
	 * @param pRequestParamMap
	 * @return
	 */
	public List<EgovMap> selectHab02(Map<String, Object> pRequestParamMap) {
		return hab02Mapper.selectHab02(pRequestParamMap);
	}
	
	/**
	 * 등급정보 리스트 
	 * @param pRequestParamMap
	 * @return
	 */
	public List<EgovMap> selectHabLv02(Map<String, Object> pRequestParamMap) {
		// TODO Auto-generated method stub
		return hab02Mapper.selectHabLv02(pRequestParamMap);
	}
	
	/**
	 * 월별 경매분석 차트 
	 * @param pRequestParamMap
	 * @return
	 */	
	public List<Hab02VO>selectHabChart02(Map<String, Object> pRequestParamMap){
		return hab02Mapper.selectHabChart02(pRequestParamMap);
	}
	
	// 월별 경매정보 :: Excel
	public List<Hab02VO>selectHab02Excel(Map<String, Object> pRequestParamMap){
		return hab02Mapper.selectHab02Excel(pRequestParamMap);
	}
	
}
