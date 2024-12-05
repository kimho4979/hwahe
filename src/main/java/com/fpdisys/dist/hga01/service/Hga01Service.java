package com.fpdisys.dist.hga01.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.hga01.domain.Hga01VO;
import com.fpdisys.dist.hga01.mapper.Hga01Mapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class Hga01Service extends BaseService{

	@Autowired
	Hga01Mapper hga01Mapper;

	
	// 화훼 수출입 동향분석 :: MAX 일자 가져오기
	public List<EgovMap> selectGetDate(	Map<String, Object> pRequestParamMap) {
		return hga01Mapper.selectGetDate(pRequestParamMap);
	}
	
	// 화훼 수출입 동향분석 :: 품목 List
	public List<EgovMap> selectGetItem(	Map<String, Object> pRequestParamMap) {
		return hga01Mapper.selectGetItem(pRequestParamMap);
	}
	
	// 화훼 수출입 동향분석 List
	public List<EgovMap> selectTrendAnalysisList(	Map<String, Object> pRequestParamMap) {
		return hga01Mapper.selectTrendAnalysisList(pRequestParamMap);
	}
	
	// 화훼 수출입 동향분석 List :: Excel
	public List<Hga01VO> selectTrendAnalysisListExcel(	Map<String, Object> pRequestParamMap) {
		return hga01Mapper.selectTrendAnalysisListExcel(pRequestParamMap);
	}
	
}
