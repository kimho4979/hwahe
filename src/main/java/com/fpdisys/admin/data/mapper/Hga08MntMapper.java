package com.fpdisys.admin.data.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("Hga08MntMapper")
public interface Hga08MntMapper {
	void deleteAll(Map<String, Object> pRequestParamMap);
	void insertList(Map<String, Object> pRequestParamMap);
	void updateList(Map<String, Object> pRequestParamMap);
	void deleteList(Map<String, Object> pRequestParamMap);
	List<Map> selectCultivationStatus(Map<String, Object> pRequestParamMap);
}
