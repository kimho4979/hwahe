package com.fpdisys.dist.hfc01.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("hfc01Mapper")
public interface Hfc01Mapper {

	List<Map<String, String>> selectEventCalendarList(	Map<String, Object> pRequestParamMap);

	List<Map<String, String>> selectYearEventCnt(Map<String, Object> pRequestParamMap);

	List<Map<String, String>> selectYearEventOfType(Map<String, Object> pRequestParamMap);

	List<Map<String, String>> flowerMainBackUpSchedule(Map<String, Object> pRequestParamMap);
	
}
