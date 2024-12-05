package com.fpdisys.dist.search.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.search.mapper.SearchMapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class SearchService extends BaseService {

	@Autowired
	SearchMapper searchMapper;


	public List<EgovMap> selectSaleDate(Map<String, Object> pRequestParamMap) {
		return searchMapper.selectSaleDate(pRequestParamMap);
	}

	public List<EgovMap> selectSaleMonth(Map<String, Object> pRequestParamMap){
		return searchMapper.selectSaleMonth(pRequestParamMap);
	}

	public List<EgovMap> selectSaleYear(Map<String, Object> pRequestParamMap){
		return searchMapper.selectSaleYear(pRequestParamMap);
	}

	public List<EgovMap> selectSaleDateReal(Map<String, Object> pRequestParamMap) {
		return searchMapper.selectSaleDateReal(pRequestParamMap);
	}

	public List<EgovMap> selectSaleDateYuchal(Map<String, Object> pRequestParamMap) {
		return searchMapper.selectSaleDateYuchal(pRequestParamMap);
	}

	public List<EgovMap> selectPumNameDate(Map<String, Object> pRequestParamMap) {
		return searchMapper.selectPumNameDate(pRequestParamMap);
	}

	public List<EgovMap> selectGoodNameDate(Map<String, Object> pRequestParamMap) {
		return searchMapper.selectGoodNameDate(pRequestParamMap);
	}

	public List<EgovMap> selectPumNameMonth(Map<String, Object> pRequestParamMap) {
		return searchMapper.selectPumNameMonth(pRequestParamMap);
	}

	public List<EgovMap> selectGoodNameMonth(Map<String, Object> pRequestParamMap) {
		return searchMapper.selectGoodNameMonth(pRequestParamMap);
	}

	public List<EgovMap> selectPumNameReal(Map<String, Object> pRequestParamMap) {
		return searchMapper.selectPumNameReal(pRequestParamMap);
	}

	public List<EgovMap> selectGoodNameReal(Map<String, Object> pRequestParamMap) {
		return searchMapper.selectGoodNameReal(pRequestParamMap);
	}

	public List<EgovMap> selectPumNameYuchal(Map<String, Object> pRequestParamMap) {
		return searchMapper.selectPumNameYuchal(pRequestParamMap);
	}

	public List<EgovMap> selectGoodNameYuchal(Map<String, Object> pRequestParamMap) {
		return searchMapper.selectGoodNameYuchal(pRequestParamMap);
	}

	public List<EgovMap> selectSaleDateWeekday(Map<String, Object> pRequestParamMap) {
		return searchMapper.selectSaleDateWeekday(pRequestParamMap);
	}

	public List<EgovMap> selectPumNameCmpDate(Map<String, Object> pRequestParamMap) {
		return searchMapper.selectPumNameCmpDate(pRequestParamMap);
	}

	public List<EgovMap> selectPumNameCmpMonth(Map<String, Object> pRequestParamMap) {
		return searchMapper.selectPumNameCmpMonth(pRequestParamMap);
	}

	public List<EgovMap> selectPumNameCmpYear(Map<String, Object> pRequestParamMap) {
		return searchMapper.selectPumNameCmpYear(pRequestParamMap);
	}

	public List<EgovMap> selectGoodNameCmpDate(Map<String, Object> pRequestParamMap) {
		return searchMapper.selectGoodNameCmpDate(pRequestParamMap);
	}

	public List<EgovMap> selectGoodNameCmpMonth(Map<String, Object> pRequestParamMap) {
		return searchMapper.selectGoodNameCmpMonth(pRequestParamMap);
	}

	public List<EgovMap> selectGoodNameCmpYear(Map<String, Object> pRequestParamMap) {
		return searchMapper.selectGoodNameCmpYear(pRequestParamMap);
	}

	public List<EgovMap> selectPumNameCmpTotal(Map<String, Object> pRequestParamMap) {
		return searchMapper.selectPumNameCmpTotal(pRequestParamMap);
	}

	public List<EgovMap> selectGoodNameCmpTotal(Map<String, Object> pRequestParamMap) {
		return searchMapper.selectGoodNameCmpTotal(pRequestParamMap);
	}

	/*public List<Hab07VO> getPumName(Map<String, Object> pRequestParamMap){
		return searchMapper.getPumName(pRequestParamMap);
	}*/
}
