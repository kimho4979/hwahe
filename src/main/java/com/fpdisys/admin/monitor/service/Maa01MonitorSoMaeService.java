package com.fpdisys.admin.monitor.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.admin.monitor.mapper.Maa01MonitorSoMaeMapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;


@Service
public class Maa01MonitorSoMaeService {
protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired
	Maa01MonitorSoMaeMapper maa01MonitorSoMaeMapper;

	public List<EgovMap> maa01MonitorSoMae(Map<String, Object> pRequestParamMap) {
		// TODO Auto-generated method stub
		return maa01MonitorSoMaeMapper.selectMonitorSoMaeJson(pRequestParamMap);	
	}

	public List<EgovMap> maa01MonitorSoMaeDetail(
			Map<String, Object> pRequestParamMap) {
		// TODO Auto-generated method stub
		return maa01MonitorSoMaeMapper.maa01MonitorSoMaeDetail(pRequestParamMap);	
	}

	public int Maa01MonitorSoMaePopupUpdate(
			Map<String, Object> pRequestParamMap) {
		return maa01MonitorSoMaeMapper.Maa01MonitorSoMaePopupUpdate(pRequestParamMap);	
		
	}

	public int deleteMonitorSoMaeDetail(Map<String, Object> pRequestParamMap) {
		return maa01MonitorSoMaeMapper.deleteMonitorSoMaeDetail(pRequestParamMap);	
		
	}

	public List<EgovMap> maa01MonitorSoMae_Date(
			Map<String, Object> pRequestParamMap) {
		// TODO Auto-generated method stub
		return maa01MonitorSoMaeMapper.maa01MonitorSoMae_Date(pRequestParamMap);	
	}

	public int Maa01MonitorSoMaePopupInsert(Map<String, Object> pRequestParamMap) {
		return maa01MonitorSoMaeMapper.Maa01MonitorSoMaePopupInsert(pRequestParamMap);	
		
	}
}