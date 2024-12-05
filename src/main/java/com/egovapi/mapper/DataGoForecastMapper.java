package com.egovapi.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper
public interface DataGoForecastMapper {
	
	void dataType2BeforeDelete(Map<String, String> map);

	void dataType2Insert(Map<String, String> map);
	
	List<EgovMap> ForecastList(Map<String, Object> pRequestParamMap);

	void execForecast(Map<String, Object> pRequestParamMap);
	
}
