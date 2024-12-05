package com.fpdisys.dist.hga04.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.hga04.domain.Hga04VO;
import com.fpdisys.dist.hga04.mapper.Hga04Mapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class Hga04Service extends BaseService{

	@Autowired
	Hga04Mapper hga04Mapper;

	
	// 조회조건 품목
/*	public List<EgovMap> selectGetItem(	Map<String, Object> pRequestParamMap) {
		return hga04Mapper.selectGetItem(pRequestParamMap);
	}*/
	
	// 조회조건 개별 품목
	public List<EgovMap> selectGetItemEach(	Map<String, Object> pRequestParamMap) {
		return hga04Mapper.selectGetItemEach(pRequestParamMap);
	}
	
	// 조회조건 통합 품목
	public List<EgovMap> selectGetItemTotal(Map<String, Object> pRequestParamMap) {
		return hga04Mapper.selectGetItemTotal(pRequestParamMap);
	}
		
	// 조회조건 품종
	/*public List<EgovMap> selectGetItem2(Map<String, Object> pRequestParamMap) {
		return hga04Mapper.selectGetItem2(pRequestParamMap);
	}*/
	
	// 조회조건 개별 품종
	public List<EgovMap> selectGetItem2Each(Map<String, Object> pRequestParamMap) {
		return hga04Mapper.selectGetItem2Each(pRequestParamMap);
	}
	
	// 조회조건 통합 품종
	public List<EgovMap> selectGetItem2Total(Map<String, Object> pRequestParamMap) {
		return hga04Mapper.selectGetItem2Total(pRequestParamMap);
	}	
	
	// 우측상단 산지별집계(통합)
	public List<EgovMap> selectProdSearchTot(Map<String, Object> pRequestParamMap) {
		return hga04Mapper.selectProdSearchTot(pRequestParamMap);
	}
	
	// 우측상단 산지별 집계(개별)
	public List<EgovMap> selectProdSearchEach(Map<String, Object> pRequestParamMap) {
		return hga04Mapper.selectProdSearchEach(pRequestParamMap);
	}
	
	// 좌측 지도(통합)
	public List<EgovMap> selectMapSearchListTot(Map<String, Object> pRequestParamMap) {
		return hga04Mapper.selectMapSearchListTot(pRequestParamMap);
	}
	
	// 좌측 지도(개별)
	public List<EgovMap> selectMapSearchListEach(Map<String, Object> pRequestParamMap) {
		return hga04Mapper.selectMapSearchListEach(pRequestParamMap);
	}
	
	// 우측하단 유통현황(통합)
	public List<EgovMap> selectDistSearchTot(Map<String, Object> pRequestParamMap) {
		return hga04Mapper.selectDistSearchTot(pRequestParamMap);
	}
	
	// 우측하단 유통현황(개별)
	public List<EgovMap> selectDistSearchEach(Map<String, Object> pRequestParamMap) {
		return hga04Mapper.selectDistSearchEach(pRequestParamMap);
	}
	
	// 엑셀다운 (개별)
	public List<EgovMap> selectExcelSearchEach(Map<String, Object> pRequestParamMap) {
		return hga04Mapper.selectExcelSearchEach(pRequestParamMap);
	}
	
	// 엑셀다운 (통합)
	public List<EgovMap> selectExcelSearchTot(Map<String, Object> pRequestParamMap) {
		return hga04Mapper.selectExcelSearchTot(pRequestParamMap);
	}
	
	
	
}
