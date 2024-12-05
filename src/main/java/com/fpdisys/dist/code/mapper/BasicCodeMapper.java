package com.fpdisys.dist.code.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("BasicCodeMapper")
public interface BasicCodeMapper {

List<?> findByBasicCd(Map<String, Object> pReqParamMap);
	
	List<?> findByBasicCdOrderBySortAsc(Map<String, Object> pReqParamMap);
	
	List<?> findByPosUseYn(Map<String, Object> pReqParamMap);
	
	
	List<?> findByBasicCdContainingOrBasicNmContaining(Map<String, Object> pReqParamMap);
	 
	List<?> findByBasicCdContainingOrBasicNmContainingPageAble(Map<String, Object> pReqParamMap);
	
	List<?> findAll(Map<String, Object> pReqParamMap);
	
	List<?> findAllPageAble(Map<String, Object> pReqParamMap);
	
	int insertBasicCode(Map<String, Object> pReqParamMap);
	
	int updateBasicCode(Map<String, Object> pReqParamMap);
	
	int mergeBasicCode(Map<String, Object> pReqParamMap);
	
	List<?> getBasicCodeList(Map<String, Object> pReqParamMap);
	
}
