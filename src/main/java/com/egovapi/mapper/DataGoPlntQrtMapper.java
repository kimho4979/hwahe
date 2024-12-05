package com.egovapi.mapper;

import java.util.List;
import java.util.Map;
import java.lang.String;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("dataGoPlntQrtMapper")
public interface DataGoPlntQrtMapper {
	
	void dataType3ImpBeforeDelete(Map<String, String> map);

	void dataType3ImpInsert(Map<String, String> map);

	void dataType3ExpBeforeDelete(Map<String, String> map);
	
	void dataType3ExpInsert(Map<String, String> map);
	
	List<String> selectNatCdList();
	
	List<String> selectHsCdList();
	
	void logInsertCall(Map<String, String> map);
	
	List<Map<String, Object>> chkEventList(Map<String, String> map);
}
