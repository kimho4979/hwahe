package com.fpdisys.dist.haa01.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.haa01.domain.Haa01VO;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class Haa01Service extends BaseService {
	
	@Autowired
	com.fpdisys.dist.haa01.mapper.Haa01Mapper haa01Mapper;

	public List<EgovMap> selectListFlower(Map<String, Object> pRequestParamMap){
		return haa01Mapper.selectListFlower(pRequestParamMap);		
	}
	
	public List<EgovMap> selectListCombineGraph(Map<String, Object> pRequestParamMap){
		return haa01Mapper.selectListCombineGraph(pRequestParamMap);
	}
	
	// 경매기록부 :: Excel
	public List<Haa01VO> selectListFlowerExcel(Map<String, Object> pRequestParamMap){
		return haa01Mapper.selectListFlowerExcel(pRequestParamMap);		
	}
	
}
