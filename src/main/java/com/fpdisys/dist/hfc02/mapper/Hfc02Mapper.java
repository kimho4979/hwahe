package com.fpdisys.dist.hfc02.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("hfc02Mapper")
public interface Hfc02Mapper {

	List<Map<String, String>> selectEventCalendarList(	Map<String, Object> pRequestParamMap);

	List<Map<String, String>> selectEventList(	Map<String, Object> pRequestParamMap);

}
