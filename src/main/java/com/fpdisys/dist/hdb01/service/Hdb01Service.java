package com.fpdisys.dist.hdb01.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.hdb01.domain.Hdb01VO;
import com.fpdisys.dist.hdb01.mapper.Hdb01Mapper;

@Service
public class Hdb01Service extends BaseService {
	
	@Autowired
	Hdb01Mapper hdb01Mapper;

	public List<?> selectChartList(Map<String, Object> pRequestParamMap){
		return hdb01Mapper.selectChartList(pRequestParamMap);		
	}

	public String selectFastDay() {
		// TODO Auto-generated method stub
		return hdb01Mapper.selectFastDay();
	}
	
	public List<Hdb01VO> selectChartListExcel(Map<String, Object> pRequestParamMap){
		return hdb01Mapper.selectChartListExcel(pRequestParamMap);		
	}
	
}