package com.fpdisys.admin.data.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.admin.data.mapper.ConfigMapper;
import com.fpdisys.admin.data.mapper.Hga08MntMapper;


@Service
public class ConfigService {
	@Autowired
	ConfigMapper configMapper;


	public List<Map<String, Object>> selectDailyConfig(Map<String, Object> pRequestParamMap) {
		return configMapper.selectDailyConfig(pRequestParamMap);
	}

	public void saveDailyConfig(Map<String, List<Map<String, Object>>> pRequestParamMap) {

		for(Map e : pRequestParamMap.get("insertList")){
			configMapper.insertList(e);
		}
		for(Map e : pRequestParamMap.get("updateList")){
			configMapper.updateList(e);
		}
		for(Map e : pRequestParamMap.get("deleteList")){
			configMapper.deleteList(e);
		}
	}
	
	public List<Map<String, Object>> selectPumJongInfo(Map<String, Object> pRequestParamMap) {
		return configMapper.selectPumJongInfo(pRequestParamMap);
	}

	public String getNeisKey(String type) {
		// TODO Auto-generated method stub
		return configMapper.selectNeisKey(type);
	}

//	public void authKeyUpdate(HashMap<String, String> requestMap) {
//		// TODO Auto-generated method stub
//		System.out.println("SERVICE :   " + requestMap.get("key"));
//		System.out.println("SERVICE :   " + requestMap.get("configCode"));
//		configMapper.authKeyUpdate(requestMap);
//	}

	public void authKeyUpdate(HashMap<String, String> requestMap) {
		// TODO Auto-generated method stub
		configMapper.authKeyUpdate(requestMap);
	}

	public void updateCompCode(String value) {
		// TODO Auto-generated method stub
		configMapper.updateCompCode(value);
		
	}

	public void removeCompCode(String value) {
		// TODO Auto-generated method stub
		configMapper.removeCompCode(value);
	}

	public List<Map<String, Object>> selectConfig(Map<String, Object> pRequestParamMap) {
		// TODO Auto-generated method stub
		return configMapper.selectConfig(pRequestParamMap);
	}

	public void insertIpData(Map<String, Object> map) {
		// TODO Auto-generated method stub
		configMapper.insertIpData(map);
		
	}

	public void updateIpData(Map<String, Object> map) {
		// TODO Auto-generated method stub
		configMapper.updateIpData(map);
	}

	public void deleteIpData(Map<String, Object> map) {
		// TODO Auto-generated method stub
		configMapper.deleteIpData(map);
	}

	public List<Map<String, Object>> authKeySelect() {
		return configMapper.authKeySelect();
	}
}
