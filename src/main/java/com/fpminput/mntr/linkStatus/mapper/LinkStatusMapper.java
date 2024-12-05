package com.fpminput.mntr.linkStatus.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("linkStatusMapper")
public interface LinkStatusMapper {

	List<EgovMap> selectRunManualBatchList(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectCheckList(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectCheckListDetailLog(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectFailList(Map<String, Object> pRequestParamMap);
	
}
