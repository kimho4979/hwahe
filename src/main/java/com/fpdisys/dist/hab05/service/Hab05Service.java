package com.fpdisys.dist.hab05.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.hab05.domain.Hab05VO;
import com.fpdisys.dist.hab05.mapper.Hab05Mapper;

@Service
public class Hab05Service extends BaseService {
	
	@Autowired
	Hab05Mapper hab05Mapper;
	
	public List<Hab05VO> selectHab05(Map<String, Object> pRequestParamMap){
		return hab05Mapper.selectHab05(pRequestParamMap);
	}
	
	public List<Hab05VO> selectHab05Excel(Map<String, Object> pRequestParamMap){
		return hab05Mapper.selectHab05Excel(pRequestParamMap);
	}
	
}
