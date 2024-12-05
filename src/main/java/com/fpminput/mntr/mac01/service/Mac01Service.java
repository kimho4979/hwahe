package com.fpminput.mntr.mac01.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpminput.mntr.mac01.domain.Mac01VO;
import com.fpminput.mntr.mac01.mapper.Mac01Mapper;

@Service
public class Mac01Service extends BaseService {

	@Autowired
	Mac01Mapper mac01Mapper;
	
	public List<?> selectCtvtTrendInput(Map<String, Object> pRequestParamMap){
		return mac01Mapper.selectCtvtTrendInput(pRequestParamMap);		
	}
	
	public List<?> selectCtvtTrendInputAll(Map<String, Object> pRequestParamMap){
		return mac01Mapper.selectCtvtTrendInputAll(pRequestParamMap);		
	}
	
	public Mac01VO selectCtvtTrendInputSeq(Mac01VO mac01vo){
		return mac01Mapper.selectCtvtTrendInputSeq(mac01vo);		
	}
	
	public int insertCtvtTrendInput(Map<String, Object> pReqParamMap){
		return mac01Mapper.insertCtvtTrendInput(pReqParamMap);
	}
	
	public int updateCtvtTrendInput(Map<String, Object> pReqParamMap){
		return mac01Mapper.updateCtvtTrendInput(pReqParamMap);
	}
	
	public int deleteCtvtTrendInput(Map<String, Object> pReqParamMap){
		return mac01Mapper.deleteCtvtTrendInput(pReqParamMap);
	}
	
}
