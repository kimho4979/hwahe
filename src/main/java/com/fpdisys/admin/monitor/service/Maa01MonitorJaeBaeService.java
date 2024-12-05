package com.fpdisys.admin.monitor.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.admin.monitor.mapper.Maa01MonitorJaeBaeMapper;
import com.fpdisys.admin.monitor.mapper.Maa01MonitorJakHwangMapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;


@Service
public class Maa01MonitorJaeBaeService {
protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired
	Maa01MonitorJaeBaeMapper maa01MonitorJaeBaeMapper;

	public List<EgovMap> maa01MonitorJaeBae(Map<String, Object> pRequestParamMap) {
		// TODO Auto-generated method stub
		return maa01MonitorJaeBaeMapper.maa01MonitorJaeBae(pRequestParamMap);	
	}

	public List<EgovMap> maa01MonitorJaeBaeList(
			Map<String, Object> pRequestParamMap) {
		// TODO Auto-generated method stub
		return maa01MonitorJaeBaeMapper.maa01MonitorJaeBaeList(pRequestParamMap);
	}

	public List<EgovMap> maa01MonitorJaeBaeDetail(
			Map<String, Object> pRequestParamMap) {
		// TODO Auto-generated method stub
		return maa01MonitorJaeBaeMapper.maa01MonitorJaeBaeDetail(pRequestParamMap);
	}

	public int updateMaa01MonitorJaeBaePopup(
			Map<String, Object> pRequestParamMap) {
		return maa01MonitorJaeBaeMapper.updateMaa01MonitorJaeBaePopup(pRequestParamMap);
		
	}

	public List<EgovMap> maa01MonitorJaeBaegDate(
			Map<String, Object> pRequestParamMap) {
		// TODO Auto-generated method stub
		return maa01MonitorJaeBaeMapper.maa01MonitorJaeBaegDate(pRequestParamMap);
	}

	public int deleteMonitorJaeBaetDetail(Map<String, Object> pRequestParamMap) {
		return maa01MonitorJaeBaeMapper.deleteMonitorJaeBaetDetail(pRequestParamMap);
		
	}

	public List<EgovMap> maa01MonitorJaeBae_Date(
			Map<String, Object> pRequestParamMap) {
		// TODO Auto-generated method stub
		return maa01MonitorJaeBaeMapper.maa01MonitorJaeBae_Date(pRequestParamMap);
	}

	public int Maa01MonitorJaeBaePopupInsert(
			Map<String, Object> pRequestParamMap) {
		return maa01MonitorJaeBaeMapper.Maa01MonitorJaeBaePopupInsert(pRequestParamMap);
		
	}
}