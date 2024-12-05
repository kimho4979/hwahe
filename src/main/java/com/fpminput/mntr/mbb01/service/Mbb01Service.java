package com.fpminput.mntr.mbb01.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpminput.mntr.mbb01.domain.Mbb01VO;
import com.fpminput.mntr.mbb01.mapper.Mbb01Mapper;

@Service
public class Mbb01Service extends BaseService {
	
	@Autowired
	Mbb01Mapper mbb01Mapper;

	public List<?> selectCnsmpPcInput(Map<String, Object> pRequestParamMap){
		return mbb01Mapper.selectCnsmpPcInput(pRequestParamMap);		
	}
	
	public List<?> selectCnsmpPcInputAll(Map<String, Object> pRequestParamMap){
		return mbb01Mapper.selectCnsmpPcInputAll(pRequestParamMap);		
	}
	
	public Mbb01VO selectCnsmpPcInputSeq(Mbb01VO mbb01vo){
		return mbb01Mapper.selectCnsmpPcInputSeq(mbb01vo);		
	}
	
	public int insertCnsmpPcInput(Map<String, Object> pReqParamMap){
		return mbb01Mapper.insertCnsmpPcInput(pReqParamMap);
	}
	
	public int updateCnsmpPcInput(Map<String, Object> pReqParamMap){
		return mbb01Mapper.updateCnsmpPcInput(pReqParamMap);
	}
	
	public int deleteCnsmpPcInput(Map<String, Object> pReqParamMap){
		return mbb01Mapper.deleteCnsmpPcInput(pReqParamMap);
	}
}
