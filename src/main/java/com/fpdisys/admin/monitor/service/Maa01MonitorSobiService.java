package com.fpdisys.admin.monitor.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.admin.monitor.mapper.Maa01MonitorJakHwangMapper;
import com.fpdisys.admin.monitor.mapper.Maa01MonitorSobiMapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;




@Service
public class Maa01MonitorSobiService {
protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired
	Maa01MonitorSobiMapper maa01MonitorSobiMapper;

	public List<EgovMap> maa01MonitorSobi(Map<String, Object> pRequestParamMap) {
		// TODO Auto-generated method stub
		return maa01MonitorSobiMapper.maa01MonitorSobi(pRequestParamMap);	
	}

	public List<EgovMap> maa01MonitorSobiDetail(
			Map<String, Object> pRequestParamMap) {
		// TODO Auto-generated method stub
		return maa01MonitorSobiMapper.maa01MonitorSobiDetail(pRequestParamMap);	
	}

	public int Maa01MonitorSobiPopupUpdate(Map<String, Object> pRequestParamMap) {
		// TODO Auto-generated method stub
		return maa01MonitorSobiMapper.Maa01MonitorSobiPopupUpdate(pRequestParamMap);
	}

	public int deleteMonitorSobitDetail(Map<String, Object> pRequestParamMap) {
		// TODO Auto-generated method stub
		return maa01MonitorSobiMapper.deleteMonitorSobitDetail(pRequestParamMap);
		
	}

	public List<EgovMap> maa01MonitorSobi_Date(
			Map<String, Object> pRequestParamMap) {
		// TODO Auto-generated method stub
		return maa01MonitorSobiMapper.maa01MonitorSobi_Date(pRequestParamMap);
	}

	public int Maa01MonitorSobiPopupInsert(Map<String, Object> pRequestParamMap) {
		return maa01MonitorSobiMapper.Maa01MonitorSobiPopupInsert(pRequestParamMap);
		
	}

	
}