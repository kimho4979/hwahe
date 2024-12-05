package com.fpminput.mntr.mce01.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("mce01Mapper")
public interface Mce01Mapper {

	void inputEventProc(Map<String, Object> pRequestParamMap);

	List<Map<String, String>> selectEventCalendarList(Map<String, Object> pRequestParamMap);

	Map<String, String> selectEventDetail(Map<String, Object> pRequestParamMap);

	void updateEventProc(Map<String, Object> pRequestParamMap);

	void deleteEventProc(Map<String, Object> pRequestParamMap);

}
