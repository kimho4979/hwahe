package com.fpdisys.dist.hab03.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.hab03.domain.Hab03VO;
import com.fpdisys.dist.hab03.mapper.Hab03Mapper;

@Service
public class Hab03Service extends BaseService {
	
	@Autowired
	Hab03Mapper hab03Mapper;

	public List<Hab03VO> selectHab03(Map<String, Object> pRequestParamMap) {
		// TODO Auto-generated method stub
		return hab03Mapper.selectHab03(pRequestParamMap);
	}
		
	public List<Hab03VO> selectPumJong(Map<String, Object> pRequestParamMap){
		return hab03Mapper.selectPumJong(pRequestParamMap);
	}
}
