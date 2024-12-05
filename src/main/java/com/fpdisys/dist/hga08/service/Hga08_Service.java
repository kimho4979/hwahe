package com.fpdisys.dist.hga08.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.hga08.mapper.Hga08_Mapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class Hga08_Service extends BaseService {
	
	@Autowired
	Hga08_Mapper hga08_Mapper;
	
	public List<EgovMap> selectHga08ChartJson1(Map<String, Object> pRequestParamMap) {
		return hga08_Mapper.selectHga08ChartJson1(pRequestParamMap);
	}
	public List<EgovMap> selectHga08ChartJson2(Map<String, Object> pRequestParamMap) {
		return hga08_Mapper.selectHga08ChartJson2(pRequestParamMap);
	}
}
