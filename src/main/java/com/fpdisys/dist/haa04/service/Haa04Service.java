package com.fpdisys.dist.haa04.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.haa04.mapper.Haa04Mapper;


@Service
public class Haa04Service extends BaseService {

	@Autowired
	Haa04Mapper haa04Mapper;

	public List<?> selectMainList(Map<String, Object> pRequestParamMap){
		return haa04Mapper.selectMainList(pRequestParamMap);		
	}
	
	public List<?> graphMainAmtList(Map<String, Object> pRequestParamMap){
		return haa04Mapper.graphMainAmtList(pRequestParamMap);		
	}
}
