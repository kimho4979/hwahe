package com.fpdisys.dist.hab11.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.hab11.mapper.Hab11Mapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class Hab11Service extends BaseService {

	@Autowired
	Hab11Mapper hab11Mapper;

//	public List<EgovMap> selectHab01(Map<String, Object> pRequestParamMap){
//		return hab11Mapper.selectHab01(pRequestParamMap);
//	}

	/**
	 * 명매날짜 가져오기
	 * @param pRequestParamMap
	 * @return
	 */
//	public List<?> selectTestData(Map<String, Object> pRequestParamMap){
//		return hab01Mapper.selectTestData(pRequestParamMap);
//	}

	public List<EgovMap> selectList(Map<String, Object> pRequestParamMap) {
		return hab11Mapper.selectList(pRequestParamMap);
	}

}
