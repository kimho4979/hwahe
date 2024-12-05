package com.fpminput.mntr.codeMgt.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("codeMgtMapper")
public interface CodeMgtMapper {
	
	List<EgovMap> selectCodeMapList(Map<String, Object> pReqParamMap);
	
	int insertCodeMapList(Map<String, Object> pReqParamMap);
	
	int updateCodeMapList(Map<String, Object> pReqParamMap);
	
	int deleteCodeMapList(Map<String, Object> pReqParamMap);

}