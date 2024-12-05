package com.fpdisys.dist.haa06.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.haa06.mapper.Haa06_Mapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class Haa06_Service extends BaseService {
	
	@Autowired
	Haa06_Mapper haa06_Mapper;

	public List<Map> selectHaa06ChartJson1(Map<String, Object> pRequestParamMap) {
		return haa06_Mapper.selectHaa06ChartJson1(pRequestParamMap);
	}
	public List<Map> selectHaa06ChartJson2(Map<String, Object> pRequestParamMap) {
		return haa06_Mapper.selectHaa06ChartJson2(pRequestParamMap);
	}
	public List<Map> selectHaa06ChartJson3(Map<String, Object> pRequestParamMap) {
		return haa06_Mapper.selectHaa06ChartJson3(pRequestParamMap);
	}
	public List<Map> selectHaa06ChartJson4(Map<String, Object> pRequestParamMap) {
		return haa06_Mapper.selectHaa06ChartJson4(pRequestParamMap);
	}
	

}
