package com.fpminput.mntr.apimgt.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("apiMgtMapper")
public interface ApiMgtMapper {
	
	List<EgovMap> selectApiSelectBoxList();
	
	List<EgovMap> selectApiMgtList();
	
	int updateApiMgtList(Map<String, Object> pReqParamMap);
	
	List<EgovMap> selectApiDegreeList(Map<String, Object> pReqParamMap);
	
	int updateApiDegreeList(Map<String, Object> pReqParamMap);
	
	List<EgovMap> selectApiLogList(Map<String, Object> pReqParamMap);
	
}