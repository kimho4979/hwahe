package com.kati.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("katiDataMapper")
public interface KatiDataMapper {
	
	List<?> selectImportList(Map<String, Object> pRequestParamMap);
	
	List<?> selectImportPumList(Map<String, Object> pRequestParamMap);

	List<?> selectImportNatList(Map<String, Object> pRequestParamMap);
}
