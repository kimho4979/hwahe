package com.fpdisys.dist.haa00.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.haa00.mapper.Haa00Mapper;
import com.fpdisys.dist.haa01.domain.Haa01VO;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class Haa00Service extends BaseService {
	
	@Autowired
	Haa00Mapper haa00Mapper;
	//경매리스트
	public List<EgovMap> selectAuctionDayList(Map<String, Object> pRequestParamMap) {
		return haa00Mapper.selectAuctionDayList(pRequestParamMap);
	}
	
	public List<EgovMap> selectAuctionMonthList(Map<String, Object> pRequestParamMap) {
		return haa00Mapper.selectAuctionMonthList(pRequestParamMap);
	}
	
	public List<EgovMap> selectAuctionYearList(Map<String, Object> pRequestParamMap) {
		return haa00Mapper.selectAuctionYearList(pRequestParamMap);
	}
	
	public List<EgovMap> selectAuctionListTotal(Map<String, Object> pRequestParamMap) {
		return haa00Mapper.selectAuctionListTotal(pRequestParamMap);
	}
	
	
	//등급정보 리스트
	public List<EgovMap> selectHaaLvDate00(Map<String, Object> pRequestParamMap) {
		return haa00Mapper.selectHaaLvDate00(pRequestParamMap);
	}
	
	public List<EgovMap> selectHaaLvMonth00(Map<String, Object> pRequestParamMap) {
		return haa00Mapper.selectHaaLvMonth00(pRequestParamMap);
	}
	
	public List<EgovMap> selectHaaLvYear00(Map<String, Object> pRequestParamMap) {
		return haa00Mapper.selectHaaLvYear00(pRequestParamMap);
	}
	
	public List<EgovMap> selectHaa00LvTotal(Map<String, Object> pRequestParamMap) {
		return haa00Mapper.selectHaa00LvTotal(pRequestParamMap);
	}

	
	//거래금액분포도 리스트
	public List<EgovMap> selectHaaInfoDate00(Map<String, Object> pRequestParamMap) {
		return haa00Mapper.selectHaaInfoDate00(pRequestParamMap);
	}
	
	public List<EgovMap> selectHaaInfoMonth00(Map<String, Object> pRequestParamMap) {
		return haa00Mapper.selectHaaInfoMonth00(pRequestParamMap);
	}
	
	public List<EgovMap> selectHaaInfoYear00(Map<String, Object> pRequestParamMap) {
		return haa00Mapper.selectHaaInfoYear00(pRequestParamMap);
	}
	
	public List<EgovMap> selectHaaInfoTotal00(Map<String, Object> pRequestParamMap) {
		return haa00Mapper.selectHaaInfoTotal00(pRequestParamMap);
	}
	
	
	//거래동향리스트
	public List<EgovMap> selectHaaChartDate00(Map<String, Object> pRequestParamMap) {
		return haa00Mapper.selectHaaChartDate00(pRequestParamMap);
	}
	
	public List<EgovMap> selectHaaChartMonth00(Map<String, Object> pRequestParamMap) {
		return haa00Mapper.selectHaaChartMonth00(pRequestParamMap);
	}
	
	public List<EgovMap> selectHaaChartYear00(Map<String, Object> pRequestParamMap) {
		return haa00Mapper.selectHaaChartYear00(pRequestParamMap);
	}
	
	public List<EgovMap> selectHaaChartTotal00(Map<String, Object> pRequestParamMap) {
		return haa00Mapper.selectHaaChartTotal00(pRequestParamMap);
	}

	//공판장비중리스트
	public List<EgovMap> selectHaa00QtyPerJson(Map<String, Object> pRequestParamMap) {
		return haa00Mapper.selectHaa00QtyPerJson(pRequestParamMap);
	}
	
	public List<EgovMap> selectHaa00QtyPerJsonTotal(Map<String, Object> pRequestParamMap) {
		return haa00Mapper.selectHaa00QtyPerJsonTotal(pRequestParamMap);
	}

}
