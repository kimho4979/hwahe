package com.fpdisys.dist.hga06_new.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.hga06_new.domain.Hga06_newVO;
import com.fpdisys.dist.hga06_new.mapper.Hga06_newMapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class Hga06_newService extends BaseService{

	@Autowired
	Hga06_newMapper hga06_newMapper;

	
	// 화훼 수출입 동향분석 :: MAX 일자 가져오기
	public List<EgovMap> selectGetDate(	Map<String, Object> pRequestParamMap) {
		return hga06_newMapper.selectGetDate(pRequestParamMap);
	}
	
	// 화훼 수출입 동향분석 :: 품목 List
	public List<EgovMap> selectGetItem(	Map<String, Object> pRequestParamMap) {
		return hga06_newMapper.selectGetItem(pRequestParamMap);
	}
	
	// 화훼 수출입 동향분석 List
	public List<EgovMap> selectTrendAnalysisList(	Map<String, Object> pRequestParamMap) {
		return hga06_newMapper.selectTrendAnalysisList(pRequestParamMap);
	}
	
	// 화훼 수출입 동향분석 List :: Excel
	public List<Hga06_newVO> selectTrendAnalysisListExcel(	Map<String, Object> pRequestParamMap) {
		return hga06_newMapper.selectTrendAnalysisListExcel(pRequestParamMap);
	}
	
	// 수출 금액/물량
	public List<EgovMap> selectExp(Map<String, Object> pRequestParamMap) {
		return hga06_newMapper.selectExp(pRequestParamMap);
	}
	
	// 수입 금액/물량
	public List<EgovMap> selectImp(Map<String, Object> pRequestParamMap) {
		return hga06_newMapper.selectImp(pRequestParamMap);
	}
	
	// 수입 월별 국가 수
	public List<EgovMap> selectImpNatCnt(Map<String, Object> pRequestParamMap) {
		return hga06_newMapper.selectImpNatCnt(pRequestParamMap);
	}
		
	// 수입 월별 국가 수
	public List<EgovMap> selectExpNatCnt(Map<String, Object> pRequestParamMap) {
		return hga06_newMapper.selectExpNatCnt(pRequestParamMap);
	}	
	
	// 수출 차트 조회
	public List<EgovMap> selectExpChart(Map<String, Object> pRequestParamMap) {
		return hga06_newMapper.selectExpChart(pRequestParamMap);
	}
	
	// 수입 차트 조회
	public List<EgovMap> selectImpChart(Map<String, Object> pRequestParamMap) {
		return hga06_newMapper.selectImpChart(pRequestParamMap);
	}
}
