package com.fpdisys.dist.hfc02.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.hfc02.mapper.Hfc02Mapper;

@Service
public class Hfc02Service extends BaseService{

	@Autowired
	Hfc02Mapper hfc02Mapper;

	// 주요행사일정 calendar
	public List<Map<String, String>> selectEventCalendarList(	Map<String, Object> pRequestParamMap) {
		return hfc02Mapper.selectEventCalendarList(pRequestParamMap);
	}

	// 주요행사일정 event
	public List<Map<String, String>> selectEventList(	Map<String, Object> pRequestParamMap) {
		return hfc02Mapper.selectEventList(pRequestParamMap);
	}
}
