package com.fpdisys.dist.hab07.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.hab07.domain.Hab07VO;
import com.fpdisys.dist.hab07.mapper.Hab07Mapper;

@Service
public class Hab07Service extends BaseService {
	
	@Autowired
	Hab07Mapper hab07Mapper;
	
	public List<Hab07VO> selectHab07(Map<String, Object> pRequestParamMap){
		return hab07Mapper.selectHab07(pRequestParamMap);
	}
	
	// 지역별 월별출하실적 :: Excel
	public List<Hab07VO> selectHab07Excel(Map<String, Object> pRequestParamMap){
		return hab07Mapper.selectHab07Excel(pRequestParamMap);
	}
	
}
