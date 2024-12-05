package com.egovapi.mapper;

import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("commonApiLogMapper")
public interface CommonApiLogMapper {

	void startJobLog(Map<String, String> map);

	void insertFailLog(Map<String, String> map2);

	void updateLog(Map<String, String> map);
	
	void updateJobList(Map<String, String> map);
}
