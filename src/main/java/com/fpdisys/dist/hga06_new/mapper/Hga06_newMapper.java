package com.fpdisys.dist.hga06_new.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.hga06_new.domain.Hga06_newVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("hga06_newMapper")
public interface Hga06_newMapper {

	List<EgovMap> selectGetDate(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectGetItem(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectTrendAnalysisList(Map<String, Object> pRequestParamMap);
	
	List<Hga06_newVO> selectTrendAnalysisListExcel(Map<String, Object> pRequestParamMap);

	// 수출 금액/물량
	List<EgovMap> selectExp(Map<String, Object> pRequestParamMap);
	
	// 수입 금액/물량
	List<EgovMap> selectImp(Map<String, Object> pRequestParamMap);
	
	// 수출 월별 국가 수
	List<EgovMap> selectExpNatCnt(Map<String, Object> pRequestParamMap);
		
	// 수입 월별 국가 수
	List<EgovMap> selectImpNatCnt(Map<String, Object> pRequestParamMap);	
	
	// 수출 차트 조회
	List<EgovMap> selectExpChart(Map<String, Object> pRequestParamMap);
	
	// 수입 차트 조회
	List<EgovMap> selectImpChart(Map<String, Object> pRequestParamMap);
}
