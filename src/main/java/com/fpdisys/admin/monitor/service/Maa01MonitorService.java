package com.fpdisys.admin.monitor.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.admin.monitor.mapper.Maa01MonitorMapper;
import com.fpdisys.base.mvc.BaseService;

import egovframework.rte.psl.dataaccess.util.EgovMap;
@Service
public class Maa01MonitorService extends BaseService {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired
	Maa01MonitorMapper maa01MonitorMapper;
	
	public List<?> selectShipmntPrearngeVolm(Map<String, Object> pRequestParamMap){
		return maa01MonitorMapper.selectShipmntPrearngeVolm(pRequestParamMap);		
	}

	public List<EgovMap> selectMonitorPredictJson(
			Map<String, Object> pRequestParamMap) {
		// TODO Auto-generated method stub
		return maa01MonitorMapper.selectMonitorPredictJson(pRequestParamMap);	
	}
	
	public List<EgovMap> selectMonitorPredictList(
			Map<String, Object> pRequestParamMap) {
		// TODO Auto-generated method stub
		return maa01MonitorMapper.selectMonitorPredictList(pRequestParamMap);
	}


	public List<EgovMap> selectMonitorPredictDetail(
			Map<String, Object> pRequestParamMap) {
		// TODO Auto-generated method stub
		return maa01MonitorMapper.selectMonitorPredictDetail(pRequestParamMap);
	}

	public List<EgovMap> selectMonitorDetail(
			Map<String, Object> pRequestParamMap) {
		// TODO Auto-generated method stub
		return maa01MonitorMapper.selectMonitorDetail(pRequestParamMap);
	}

	public int deleteMonitorPredictDetail(Map<String, Object> pRequestParamMap) {
		return maa01MonitorMapper.deleteMonitorPredictDetail(pRequestParamMap);
		
	}

	public int deleteMonitortDetail(Map<String, Object> pRequestParamMap) {
		return maa01MonitorMapper.deleteMonitortDetail(pRequestParamMap);
		
	}


	public int updateMonitorPredictDetail_Popup(
			Map<String, Object> pRequestParamMap) {
		return maa01MonitorMapper.updateMonitorPredictDetail_Popup(pRequestParamMap);
		
	}

	public int updateMonitorDetail_Popup(Map<String, Object> pRequestParamMap) {
		return maa01MonitorMapper.updateMonitorDetail_Popup(pRequestParamMap);
		
	}

	public List<EgovMap> selectmaa01Monitor_Date(
			Map<String, Object> pRequestParamMap) {
		// TODO Auto-generated method stubselectShipmntPrearngeVolm
		return maa01MonitorMapper.selectmaa01Monitor_Date(pRequestParamMap);
	}


	public int insertMonitorPredictDetail_Popup(
			Map<String, Object> pRequestParamMap) {
		return maa01MonitorMapper.insertMonitorPredictDetail_Popup(pRequestParamMap);
		
	}

	public int insertMonitorDetail_Popup(Map<String, Object> pRequestParamMap) {
		return maa01MonitorMapper.insertMonitorDetail_Popup(pRequestParamMap);
		
	}	
}
