package com.fpminput.mntr.mba01.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpminput.mntr.mba01.domain.Mba01VO;
import com.fpminput.mntr.mba01.mapper.Mba01Mapper;

@Service
public class Mba01Service extends BaseService {
	
	@Autowired
	Mba01Mapper mba01Mapper;

	public List<?> selectCnsmpTrendInput(Map<String, Object> pRequestParamMap){
		return mba01Mapper.selectCnsmpTrendInput(pRequestParamMap);		
	}
	
	public List<?> selectCnsmpTrendInputAll(Map<String, Object> pRequestParamMap){
		return mba01Mapper.selectCnsmpTrendInputAll(pRequestParamMap);		
	}
	
	public Mba01VO selectCnsmpTrendInputSeq(Mba01VO mba01vo){
		return mba01Mapper.selectCnsmpTrendInputSeq(mba01vo);		
	}
	
	public int insertCnsmpTrendInput(Map<String, Object> pReqParamMap){
		return mba01Mapper.insertCnsmpTrendInput(pReqParamMap);
	}
	
	public int updateCnsmpTrendInput(Map<String, Object> pReqParamMap){
		return mba01Mapper.updateCnsmpTrendInput(pReqParamMap);
	}
	
	public int deleteCnsmpTrendInput(Map<String, Object> pReqParamMap){
		return mba01Mapper.deleteCnsmpTrendInput(pReqParamMap);
	}
	
}
