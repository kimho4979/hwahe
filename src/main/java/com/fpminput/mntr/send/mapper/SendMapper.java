package com.fpminput.mntr.send.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("sendMapper")
public interface SendMapper {
	
	int insertSmsTranfer(Map<String, Object> pReqParamMap);
	
	int insertSmsTranferLog(Map<String, Object> pReqParamMap);
	
	int insertEmailTranfer(Map<String, Object> pReqParamMap);
	
	int insertEmailTranferLog(Map<String, Object> pReqParamMap);

}