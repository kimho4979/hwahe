package com.fpdisys.admin.monitor.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.fpdisys.admin.monitor.mapper.Maa01MonitorJaeBaeMapper;
import com.fpdisys.admin.monitor.mapper.Maa01MonitorReportMapper;
import com.fpdisys.dist.hba01.domain.Hba01VO;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Service
public class Maa01MonitorResportService {
protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired
	Maa01MonitorReportMapper maa01MonitorReportMapper;

	public List<?> selectHba01(Map<String, Object> pRequestParamMap) {
		// TODO Auto-generated method stub
		return maa01MonitorReportMapper.selectHba01(pRequestParamMap);
	}

	public int Maa01MonitorReportInsert(Map<String, Object> pRequestParamMap) {
		return maa01MonitorReportMapper.Maa01MonitorReportInsert(pRequestParamMap);
		
	}

	public int Maa01MonitorReportFileInsert(
			Map<String, Object> pRequestParamMap) {
		return maa01MonitorReportMapper.Maa01MonitorReportFileInsert(pRequestParamMap);
		
	}

	public int deleteMonitorReport(Map<String, Object> pRequestParamMap) {
		return maa01MonitorReportMapper.deleteMonitorReport(pRequestParamMap);
		
	}

	public int Maa01MonitorSugeupUpdate_Popup(Map<String, Object> pRequestParamMap) {
		return maa01MonitorReportMapper.Maa01MonitorSugeupUpdate_Popup(pRequestParamMap);
		
	}
		
}
