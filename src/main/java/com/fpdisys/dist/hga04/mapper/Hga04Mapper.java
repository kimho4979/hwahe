package com.fpdisys.dist.hga04.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.hga04.domain.Hga04VO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("hga04Mapper")
public interface Hga04Mapper {

	// 조회조건 품목
	/*List<EgovMap> selectGetItem(Map<String, Object> pRequestParamMap);*/
	
	// 조회조건 품종
	/*List<EgovMap> selectGetItem2(Map<String, Object> pRequestParamMap);*/
	
	// 조회조건 개별 품목
	List<EgovMap> selectGetItemEach(Map<String, Object> pRequestParamMap);
	
	// 조회조건 통합 품목
	List<EgovMap> selectGetItemTotal(Map<String, Object> pRequestParamMap);
	
	// 조회조건 개별 품종
	List<EgovMap> selectGetItem2Each(Map<String, Object> pRequestParamMap);
	
	// 조회조건 통합 품종
	List<EgovMap> selectGetItem2Total(Map<String, Object> pRequestParamMap);
	
	// 우측상단 산지별집계(통합)
	List<EgovMap> selectProdSearchTot(Map<String, Object> pRequestParamMap);
	
	// 우측상단 산지별 집계(개별)
	List<EgovMap> selectProdSearchEach(Map<String, Object> pRequestParamMap);

	// 좌측 지도(통합)
	List<EgovMap> selectMapSearchListTot(Map<String, Object> pRequestParamMap);
	
	// 좌측 지도(개별)
	List<EgovMap> selectMapSearchListEach(Map<String, Object> pRequestParamMap);
	
	// 우측 하단 유통현황(통합)
	List<EgovMap> selectDistSearchTot(Map<String, Object> pRequestParamMap);
	
	// 우측 하단 유통현황(통합)
	List<EgovMap> selectDistSearchEach(Map<String, Object> pRequestParamMap);
	
	// 엑셀다운 (개별)
	List<EgovMap> selectExcelSearchEach(Map<String, Object> pRequestParamMap);
	
	// 엑셀다운 (통합)
	List<EgovMap> selectExcelSearchTot(Map<String, Object> pRequestParamMap);

}
