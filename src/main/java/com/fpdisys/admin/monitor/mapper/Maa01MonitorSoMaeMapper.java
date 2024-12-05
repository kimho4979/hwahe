package com.fpdisys.admin.monitor.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("maa01MonitorSoMaeMapper")
public interface Maa01MonitorSoMaeMapper {

	List<EgovMap> selectMonitorSoMaeJson(Map<String, Object> pRequestParamMap);

	List<EgovMap> maa01MonitorSoMaeDetail(Map<String, Object> pRequestParamMap);

	int Maa01MonitorSoMaePopupUpdate(Map<String, Object> pRequestParamMap);

	int deleteMonitorSoMaeDetail(Map<String, Object> pRequestParamMap);

	List<EgovMap> maa01MonitorSoMae_Date(Map<String, Object> pRequestParamMap);

	int Maa01MonitorSoMaePopupInsert(Map<String, Object> pRequestParamMap);

}
