package com.fpdisys.admin.log.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("userLogMapper")
public interface UserLogMapper {
	List<?> selectUserLogAll(Map<String, Object> pRequestParamMap);
	
	List<?> selectUserLogSearch(Map<String, Object> pRequestParamMap);
	
	List<?> selectUserLogSearchPageAble(Map<String, Object> pRequestParamMap);

	void InsertLog(HashMap<String, Object> map) throws Exception;

	List<?> userLogList(Map<String, Object> pRequestParamMap);

}
