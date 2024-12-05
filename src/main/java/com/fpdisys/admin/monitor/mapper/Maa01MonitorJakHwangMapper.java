package com.fpdisys.admin.monitor.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("maa01MonitorJakHwangMapper")
public interface Maa01MonitorJakHwangMapper {


	List<EgovMap> maa01MonitorJakHwang(Map<String, Object> pRequestParamMap);

	List<EgovMap> maa01MonitorJakHwangDetail(Map<String, Object> pRequestParamMap);

	List<EgovMap> maa01MonitorJakHwangDate(Map<String, Object> pRequestParamMap);

	int Maa01MonitorJakHwangPopupUpdate(Map<String, Object> pRequestParamMap);

	List<EgovMap> maa01MonitorJakHwangReLoad(Map<String, Object> pRequestParamMap);

	int deleteMonitorJakHwangtDetail(Map<String, Object> pRequestParamMap);

	List<EgovMap> maa01MonitorJakHwang_Date(Map<String, Object> pRequestParamMap);

	int Maa01MonitorJakHwangPopupInsert(Map<String, Object> pRequestParamMap);

	int Maa01MonitorJakHwangFileInsert(Map<String, Object> pRequestParamMap);

}
