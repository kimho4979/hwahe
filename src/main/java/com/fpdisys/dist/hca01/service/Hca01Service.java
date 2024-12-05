package com.fpdisys.dist.hca01.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.hca01.domain.Hca01ExcelVO;
import com.fpdisys.dist.hca01.domain.Hca01VO;
import com.fpdisys.dist.hca01.mapper.Hca01Mapper;

@Service
public class Hca01Service extends BaseService {
	
	@Autowired
	Hca01Mapper hca01Mapper;

	public String selectFastDay(){
		return hca01Mapper.selectFastDay();		
	}
	
	public List<Hca01VO> selectTop(Map<String, Object> pRequestParamMap){
		return hca01Mapper.selectTop(pRequestParamMap);		
	}
	
	public List<Hca01VO> selectBottom(Map<String, Object> pRequestParamMap){
		return hca01Mapper.selectBottom(pRequestParamMap);		
	}

	public List<Hca01VO> selectMainChulChart(Map<String, Object> pRequestParamMap) {
		return hca01Mapper.selectMainChulChart(pRequestParamMap);
	}
	
	// 출하 및 예정물량 :: Excel
	public List<Hca01ExcelVO> selectTopExcel(Map<String, Object> pRequestParamMap) {
		return hca01Mapper.selectTopExcel(pRequestParamMap);
	}
		
}
	
