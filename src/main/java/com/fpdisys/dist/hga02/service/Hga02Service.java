package com.fpdisys.dist.hga02.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.hga02.domain.Hga02VO;
import com.fpdisys.dist.hga02.mapper.Hga02Mapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class Hga02Service extends BaseService{

	@Autowired
	Hga02Mapper hga02Mapper;

	
	// 기상 동향분석 :: 시도명 가져오기
	public List<EgovMap> selectGetSido(	Map<String, Object> pRequestParamMap) {
		return hga02Mapper.selectGetSido(pRequestParamMap);
	}
	
	// 기상 동향분석 :: 시도명 가져오기
		public List<EgovMap> selectGetGugun(	Map<String, Object> pRequestParamMap) {
			return hga02Mapper.selectGetGugun(pRequestParamMap);
		}
	
	
	// 기상 동향분석 List
	public List<EgovMap> selectGetItemList(	Map<String, Object> pRequestParamMap) {
		return hga02Mapper.selectGetItemList(pRequestParamMap);
	}
	// 기상 동향분석 List
		public List<EgovMap> selectGetItemListBefore(	Map<String, Object> pRequestParamMap) {
			return hga02Mapper.selectGetItemListBefore(pRequestParamMap);
		}
	
	// 화훼 수출입 동향분석 :: 품목 List
	public List<EgovMap> selectGetItem(	Map<String, Object> pRequestParamMap) {
		return hga02Mapper.selectGetItem(pRequestParamMap);
	}
	
	// 화훼 수출입 동향분석 List
	public List<EgovMap> selectTrendAnalysisList(Map<String, Object> pRequestParamMap) {
		return hga02Mapper.selectTrendAnalysisList(pRequestParamMap);
	}
	
	// 화훼 수출입 동향분석 List :: Excel
	public List<Hga02VO> selectGetItemListExcel(Map<String, Object> pRequestParamMap) {
		return hga02Mapper.selectGetItemListExcel(pRequestParamMap);
	}
	
}
