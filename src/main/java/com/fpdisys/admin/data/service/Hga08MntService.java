package com.fpdisys.admin.data.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.admin.data.mapper.Hga08MntMapper;

@Service
public class Hga08MntService {
	
	@Autowired
	Hga08MntMapper hga08MntMapper;

	public void uploadExcel(List<Map<String, Object>> result) {
		hga08MntMapper.deleteAll(result.get(0));
		for(Map e : result){
			hga08MntMapper.insertList(e);
		}
	}
	
	public void saveExcel(Map<String, List<Map<String, Object>>> pRequestParamMap) {

		for(Map e : pRequestParamMap.get("insertList")){
			hga08MntMapper.insertList(e);
		}
		for(Map e : pRequestParamMap.get("updateList")){
			hga08MntMapper.updateList(e);
		}
		for(Map e : pRequestParamMap.get("deleteList")){
			hga08MntMapper.deleteList(e);
		}
	}
	public List<Map> selectCultivationStatus(Map<String, Object> pRequestParamMap) {
		return hga08MntMapper.selectCultivationStatus(pRequestParamMap);
	}


}
