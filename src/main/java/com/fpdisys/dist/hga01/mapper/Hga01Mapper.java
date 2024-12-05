package com.fpdisys.dist.hga01.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.hga01.domain.Hga01VO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("hga01Mapper")
public interface Hga01Mapper {

	List<EgovMap> selectGetDate(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectGetItem(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectTrendAnalysisList(Map<String, Object> pRequestParamMap);
	
	List<Hga01VO> selectTrendAnalysisListExcel(Map<String, Object> pRequestParamMap);
	
}
