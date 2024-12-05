package com.fpdisys.dist.hab01.mapper;

import java.util.List;
import java.util.Map;








import com.fpdisys.dist.hab01.domain.Hab01VO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("hab01Mapper")
public interface Hab01Mapper {
	
	List<EgovMap> selectHab01(Map<String, Object> pRequestParamMap);
	/**
	 * 등급정보 카운트
	 * @param pRequestParamMap
	 * @return
	 */
	String selectHabLv01Cnt(Map<String, Object> pRequestParamMap);
	/**
	 * 등급정보 리스트 
	 * @param pRequestParamMap
	 * @return
	 */
	List<EgovMap> selectHabLv01(Map<String, Object> pRequestParamMap);
	/**
	 * 경매정보 분석  리스트 		
	 * @param pRequestParamMap
	 * @return
	 */
	List<?> selectHabInfo01(Map<String, Object> pRequestParamMap);	
	/**
	 * 월별 경매분석 차트 
	 * @param pRequestParamMap
	 * @return
	 */
	List<?> selectHabChart01(Map<String, Object> pRequestParamMap);	
	/**
	 * 경매날짜 가져오기 
	 * @param pRequestParamMap
	 * @return
	 */	
	List<Hab01VO>selectGetSaleDate(Map<String, Object> pRequestParamMap);

	List<?> selectTestData(Map<String, Object> pRequestParamMap);
	
	// 일자별 경매정보 :: excel
	List<Hab01VO>selectHab01Excel(Map<String, Object> pRequestParamMap);

}
