package com.fpdisys.admin.monitor.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("maa01MonitorJaeBaeMapper")
public interface Maa01MonitorJaeBaeMapper {

	List<EgovMap> maa01MonitorJaeBae(Map<String, Object> pRequestParamMap);

	List<EgovMap> maa01MonitorJaeBaeList(Map<String, Object> pRequestParamMap);

	List<EgovMap> maa01MonitorJaeBaeDetail(Map<String, Object> pRequestParamMap);

	int updateMaa01MonitorJaeBaePopup(Map<String, Object> pRequestParamMap);

	List<EgovMap> maa01MonitorJaeBaegDate(Map<String, Object> pRequestParamMap);

	int deleteMonitorJaeBaetDetail(Map<String, Object> pRequestParamMap);

	List<EgovMap> maa01MonitorJaeBae_Date(Map<String, Object> pRequestParamMap);

	int Maa01MonitorJaeBaePopupInsert(Map<String, Object> pRequestParamMap);

}
