package com.fpdisys.admin.monitor.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.hba01.domain.Hba01VO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("maa01MonitorReportMapper")
public interface Maa01MonitorReportMapper {


	List<?> selectHba01(Map<String, Object> pRequestParamMap);

	int Maa01MonitorReportInsert(Map<String, Object> pRequestParamMap);

	int Maa01MonitorReportFileInsert(Map<String, Object> pRequestParamMap);

	int deleteMonitorReport(Map<String, Object> pRequestParamMap);

	int Maa01MonitorSugeupUpdate_Popup(Map<String, Object> pRequestParamMap);

}
