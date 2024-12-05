package com.fpdisys.admin.monitor.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.admin.monitor.mapper.Maa01MonitorJakHwangMapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class Maa01MonitorJakHwangService {
protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired
	Maa01MonitorJakHwangMapper maa01MonitorJakHwangMapper;
	
	public List<EgovMap> maa01MonitorJakHwang(
			Map<String, Object> pRequestParamMap) {
		// TODO Auto-generated method stub
		return maa01MonitorJakHwangMapper.maa01MonitorJakHwang(pRequestParamMap);		
	}

	public List<EgovMap> maa01MonitorJakHwangDetail(
			Map<String, Object> pRequestParamMap) {
		// TODO Auto-generated method stub
		return maa01MonitorJakHwangMapper.maa01MonitorJakHwangDetail(pRequestParamMap);	
	}

	public List<EgovMap> maa01MonitorJakHwangDate(
			Map<String, Object> pRequestParamMap) {
		// TODO Auto-generated method stub
		return maa01MonitorJakHwangMapper.maa01MonitorJakHwangDate(pRequestParamMap);
	}

	public int Maa01MonitorJakHwangPopupUpdate(Map<String, Object> pRequestParamMap) {
		return maa01MonitorJakHwangMapper.Maa01MonitorJakHwangPopupUpdate(pRequestParamMap);
	}

	public List<EgovMap> maa01MonitorJakHwangReLoad(
			Map<String, Object> pRequestParamMap) {
		// TODO Auto-generated method stub
		return maa01MonitorJakHwangMapper.maa01MonitorJakHwangReLoad(pRequestParamMap);
	}

	public int deleteMonitorJakHwangtDetail(
			Map<String, Object> pRequestParamMap) {
		return maa01MonitorJakHwangMapper.deleteMonitorJakHwangtDetail(pRequestParamMap);
		
	}

	public List<EgovMap> maa01MonitorJakHwang_Date(
			Map<String, Object> pRequestParamMap) {
		// TODO Auto-generated method stub
		return maa01MonitorJakHwangMapper.maa01MonitorJakHwang_Date(pRequestParamMap);
	}

	public int Maa01MonitorJakHwangPopupInsert(
			Map<String, Object> pRequestParamMap) {
		return maa01MonitorJakHwangMapper.Maa01MonitorJakHwangPopupInsert(pRequestParamMap);
		
	}

	public int Maa01MonitorJakHwangFileInsert(
			Map<String, Object> pRequestParamMap) {
		return maa01MonitorJakHwangMapper.Maa01MonitorJakHwangFileInsert(pRequestParamMap);
		
	}

}
