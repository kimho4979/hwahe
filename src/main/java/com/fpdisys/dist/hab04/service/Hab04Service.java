package com.fpdisys.dist.hab04.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.hab04.domain.Hab04VO;
import com.fpdisys.dist.hab04.mapper.Hab04Mapper;


@Service
public class Hab04Service extends BaseService {
	
	@Autowired
	Hab04Mapper hab04Mapper;
	
	public List<Hab04VO> selectHab04(Map<String, Object> pRequestParamMap){
		return hab04Mapper.selectHab04(pRequestParamMap);
	}
	
	// 품목별 총 거래정보 :: Excel
	public List<Hab04VO> selectHab04Excel(Map<String, Object> pRequestParamMap){
		return hab04Mapper.selectHab04Excel(pRequestParamMap);
	}
}
