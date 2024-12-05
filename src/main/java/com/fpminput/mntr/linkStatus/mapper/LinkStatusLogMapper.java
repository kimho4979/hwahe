package com.fpminput.mntr.linkStatus.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("linkStatusLogMapper")
public interface LinkStatusLogMapper {

	List<EgovMap> selectRunManualBatchList(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectCheckList(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectCheckListDetailLog(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectFailList(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectSysGp(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectLogList(Map<String, Object> pRequestParamMap);
	
	EgovMap selectLog(Map<String, Object> pRequestParamMap);
}
