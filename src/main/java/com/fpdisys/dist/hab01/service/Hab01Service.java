package com.fpdisys.dist.hab01.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.hab01.domain.Hab01VO;
import com.fpdisys.dist.hab01.mapper.Hab01Mapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class Hab01Service extends BaseService {
	
	@Autowired
	Hab01Mapper hab01Mapper;
	
	public List<EgovMap> selectHab01(Map<String, Object> pRequestParamMap){
		return hab01Mapper.selectHab01(pRequestParamMap);
	}
	
	/**
	 * 등급정보 리스트 카운트
	 * @param pRequestParamMap
	 * @return
	 */
	public String selectHabLv01Cnt(Map<String, Object> pRequestParamMap){
		return hab01Mapper.selectHabLv01Cnt(pRequestParamMap);
	}
	
	/**
	 * 등급정보 리스트 
	 * @param pRequestParamMap
	 * @return
	 */
	public List<EgovMap>selectHabLv01(Map<String, Object> pRequestParamMap){
		return hab01Mapper.selectHabLv01(pRequestParamMap);
	}
	/**
	 * 경매정보 분석  리스트 		
	 * @param pRequestParamMap
	 * @return
	 */
	public List<?> selectHabInfo01(Map<String, Object> pRequestParamMap){
		return hab01Mapper.selectHabInfo01(pRequestParamMap);
	}
	/**
	 * 월별 경매분석 차트 
	 * @param pRequestParamMap
	 * @return
	 */
	public List<?>selectHabChart01(Map<String, Object> pRequestParamMap){
		return hab01Mapper.selectHabChart01(pRequestParamMap);
	}
	
	public List<Hab01VO>selectGetSaleDate(Map<String, Object> pRequestParamMap){
		return hab01Mapper.selectGetSaleDate(pRequestParamMap);
	}
	/**
	 * 명매날짜 가져오기 
	 * @param pRequestParamMap
	 * @return
	 */
	public List<?> selectTestData(Map<String, Object> pRequestParamMap){
		return hab01Mapper.selectTestData(pRequestParamMap);
	}

	// 일자별 경매정보 :: excel
	public List<Hab01VO>selectHab01Excel(Map<String, Object> pRequestParamMap){
		return hab01Mapper.selectHab01Excel(pRequestParamMap);
	}
	
}
