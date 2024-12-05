package com.fpdisys.admin.monitor.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;
@Mapper("maa01MonitorMapper")
public interface Maa01MonitorMapper {

	List<?> selectShipmntPrearngeVolm(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectMonitorPredictJson(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectMonitorPredictList(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectMonitorPredictDetail(
			Map<String, Object> pRequestParamMap);

	List<EgovMap> selectMonitorDetail(Map<String, Object> pRequestParamMap);

	int deleteMonitorPredictDetail(Map<String, Object> pRequestParamMap);

	int deleteMonitortDetail(Map<String, Object> pRequestParamMap);

	int updateMonitorPredictDetail_Popup(Map<String, Object> pRequestParamMap);

	int updateMonitorDetail_Popup(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectmaa01Monitor_Date(Map<String, Object> pRequestParamMap);

	int insertMonitorDetail_Popup(Map<String, Object> pRequestParamMap);

	int insertMonitorPredictDetail_Popup(Map<String, Object> pRequestParamMap);	


}
