package com.fpdisys.admin.data.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("ConfigMapper")
public interface ConfigMapper {
	List<Map<String, Object>> selectDailyConfig(Map<String, Object> pRequestParamMap);
	void insertList(Map<String, Object> pRequestParamMap);
	void updateList(Map<String, Object> pRequestParamMap);
	void deleteList(Map<String, Object> pRequestParamMap);
	List<Map<String, Object>> selectPumJongInfo(Map<String, Object> pRequestParamMap);
	String selectNeisKey(@Param("type")String type);
	void authKeyUpdate(HashMap<String, String> requestMap);
	void updateCompCode(@Param("userId")String value);
	void removeCompCode(@Param("userId")String value);
	List<Map<String, Object>> selectConfig(Map<String, Object> pRequestParamMap);
	void deleteIpData(Map<String, Object> map);
	void updateIpData(Map<String, Object> map);
	void insertIpData(Map<String, Object> map);
	List<Map<String, Object>> authKeySelect();
}
