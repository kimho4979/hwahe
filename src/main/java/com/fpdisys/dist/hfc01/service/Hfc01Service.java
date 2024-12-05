package com.fpdisys.dist.hfc01.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.hfc01.mapper.Hfc01Mapper;

@Service
public class Hfc01Service extends BaseService{

	@Autowired
	Hfc01Mapper hfc01Mapper;

	
	// 게시판관리 행상일정관리 행사달력 데이터 조회
	public List<Map<String, String>> selectEventCalendarList(	Map<String, Object> pRequestParamMap) {
		return hfc01Mapper.selectEventCalendarList(pRequestParamMap);
	}


	// 연별행사 rowspan 용 월별 타입별 행사 개수 조회
	public List<Map<String, String>> selectYearEventCnt(Map<String, Object> pRequestParamMap) {
		return hfc01Mapper.selectYearEventCnt(pRequestParamMap);
	}

	// 특정행사의 월별 데이터 조회
	public List<Map<String, String>> selectYearEventOfType(Map<String, Object> pRequestParamMap) {
		return hfc01Mapper.selectYearEventOfType(pRequestParamMap);
	}


	public List<Map<String, String>> flowerMainBackUpSchedule(
			Map<String, Object> pRequestParamMap) {
		return hfc01Mapper.flowerMainBackUpSchedule(pRequestParamMap);
	}
}
