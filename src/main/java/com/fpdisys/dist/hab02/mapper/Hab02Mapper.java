package com.fpdisys.dist.hab02.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.hab02.domain.Hab02VO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("hab02Mapper")
public interface Hab02Mapper {
	/**
	 * 품종별 종합 경매정보
	 * @param pRequestParamMap
	 * @return
	 */
	List<EgovMap> selectHab02(Map<String, Object> pRequestParamMap);
	/**
	 * 등급정보 리스트 
	 * @param pRequestParamMap
	 * @return
	 */
	List<EgovMap>selectHabLv02(Map<String, Object> pRequestParamMap);
	
	/**
	 * 월별 경매분석 차트 
	 * @param pRequestParamMap
	 * @return
	 */	
	List<Hab02VO>selectHabChart02(Map<String, Object> pRequestParamMap);
	
	// 월별 경매정보 :: Excel
	List<Hab02VO>selectHab02Excel(Map<String, Object> pRequestParamMap);
		
}
