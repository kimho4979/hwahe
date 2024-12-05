package com.fpdisys.dist.apiCall.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.apiCall.domain.ApiCallSaleDateVO;
import com.fpdisys.dist.apiCall.domain.ApiCallVO;
import com.fpdisys.dist.apiCall.domain.ApiCallYuchalVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("apiCallMapper")
public interface ApiCallMapper {
	
	List<ApiCallVO> selectCheckList(Map<String, Object> pRequestParamMap);
	
	List<ApiCallSaleDateVO> selectSaleDateList(Map<String, Object> pRequestParamMap);
	
	List<ApiCallYuchalVO> selectPassedInList(Map<String, Object> pRequestParamMap);
	
	int insertLogList(Map<String, Object> pRequestParamMap);
	
	int updateLogList(Map<String, Object> pRequestParamMap);
	
}