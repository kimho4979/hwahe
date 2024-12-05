package com.fpdisys.admin.monitor.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;


@Mapper("maa01MonitorSobiMapper")
public interface Maa01MonitorSobiMapper {

	List<EgovMap> maa01MonitorSobi(Map<String, Object> pRequestParamMap);

	List<EgovMap> maa01MonitorSobiDetail(Map<String, Object> pRequestParamMap);

	int Maa01MonitorSobiPopupUpdate(Map<String, Object> pRequestParamMap);

	int deleteMonitorSobitDetail(Map<String, Object> pRequestParamMap);

	List<EgovMap> maa01MonitorSobi_Date(Map<String, Object> pRequestParamMap);

	int Maa01MonitorSobiPopupInsert(Map<String, Object> pRequestParamMap);

}