package com.fpdisys.dist.hga03.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.hga03.domain.Hga03VO;
import com.fpdisys.dist.hga03.mapper.Hga03Mapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class Hga03Service extends BaseService{

	@Autowired
	Hga03Mapper hga03Mapper;

	public String selectGetDate(Map<String, Object> pRequestParamMap) {
		return hga03Mapper.selectGetDate(pRequestParamMap);
	}

	public List<EgovMap> selectGetItemList(Map<String, Object> pRequestParamMap) {
		return hga03Mapper.selectGetItemList(pRequestParamMap);
	}

	public List<EgovMap> selectPlntList1(Map<String, Object> pRequestParamMap) {
		return hga03Mapper.selectPlntList1(pRequestParamMap);
	}
	
	public List<EgovMap> selectPlntList2(Map<String, Object> pRequestParamMap) {
		return hga03Mapper.selectPlntList2(pRequestParamMap);
	}
	
	// 수출현황 :: Excel
	public List<Hga03VO> selectPlntList1Excel(Map<String, Object> pRequestParamMap) {
		return hga03Mapper.selectPlntList1Excel(pRequestParamMap);
	}
	
	// 수입황 :: Excel
	public List<Hga03VO> selectPlntList2Excel(Map<String, Object> pRequestParamMap) {
		return hga03Mapper.selectPlntList2Excel(pRequestParamMap);
	}
	
}
