package com.fpdisys.dist.hga02.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.hga02.domain.Hga02VO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("hga02Mapper")
public interface Hga02Mapper {

	List<EgovMap> selectGetSido(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectGetGugun(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectGetItem(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectTrendAnalysisList(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectGetItemList(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectGetItemListBefore(Map<String, Object> pRequestParamMap);
	
	List<Hga02VO> selectGetItemListExcel(Map<String, Object> pRequestParamMap);
	
}
