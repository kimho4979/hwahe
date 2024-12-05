package com.fpdisys.dist.api.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.api.domain.ApiViewVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("apiViewMapper")
public interface ApiViewMapper {
	
	int insertApiUser(Map<String, Object> pRequestParamMap);
	
	List<ApiViewVO>selectSettingList(Map<String, Object> pRequestParamMap);
	
	List<EgovMap>selectDetailFunctionList(Map<String, Object> pRequestParamMap);
	
	int insertApiData(Map<String, Object> pRequestParamMap);
	
	List<EgovMap>selectMemberList(Map<String, Object> pRequestParamMap);
	
	List<EgovMap>selectExsistList(Map<String, Object> pRequestParamMap);
	
	int updateApiData(Map<String, Object> pRequestParamMap);
	
	int updateApiDataInUser(Map<String, Object> pRequestParamMap);
	
}
