package com.fpdisys.dist.auth.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("authGroupMapper")
public interface AuthGroupMapper {
	
	List<?> findAll(Map<String, Object> pReqParamMap);
	
	List<?> findByGrpAuthCd(Map<String, Object> pReqParamMap);
	
	int insertAuthGroup(Map<String, Object> pReqParamMap);
	
	int updateAuthGroup(Map<String, Object> pReqParamMap);
	
	int getMergeAuthGroup(Map<String, Object> pReqParamMap);
	
	int deleteAuthGroup(Map<String, Object> pReqParamMap);
	
	List<?> findByGrpUserId(Map<String, Object> pReqParamMap);
}
