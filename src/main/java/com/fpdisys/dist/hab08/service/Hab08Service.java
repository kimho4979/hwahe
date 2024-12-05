package com.fpdisys.dist.hab08.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.hab08.mapper.Hab08Mapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class Hab08Service extends BaseService {
	
	@Autowired
	Hab08Mapper hab08Mapper;
	
	/**
	 * 등급정보 리스트 카운트
	 * @param pRequestParamMap
	 * @return
	 */
	public List<EgovMap> hab08Chart1(Map<String, Object> pRequestParamMap) {
		return hab08Mapper.hab08Chart1(pRequestParamMap);
	}
	
	/**
	 * 등급정보 리스트 카운트
	 * @param pRequestParamMap
	 * @return
	 */
	public List<EgovMap> hab08Chart2(Map<String, Object> pRequestParamMap) {
		return hab08Mapper.hab08Chart2(pRequestParamMap);
	}
	
	/**
	 * 등급정보 리스트 카운트
	 * @param pRequestParamMap
	 * @return
	 */
	public List<EgovMap> hab08Button(Map<String, Object> pRequestParamMap) {
		return hab08Mapper.hab08Button(pRequestParamMap);
	}
	
}
