package com.egovapi.mapper;

import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface DataGoCustMapper {
	
	void dataType1BeforeDelete(Map<String, String> map);

	void dataType1Insert(Map<String, String> map);
	
}
