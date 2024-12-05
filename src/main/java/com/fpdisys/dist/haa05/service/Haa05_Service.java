package com.fpdisys.dist.haa05.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.haa05.mapper.Haa05_Mapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class Haa05_Service extends BaseService {
	
	@Autowired
	Haa05_Mapper haa05_Mapper;
	//경매리스트
	public List<EgovMap> selectAuctionDayList(Map<String, Object> pRequestParamMap) {
		return haa05_Mapper.selectAuctionDayList(pRequestParamMap);
	}
	
	public List<EgovMap> selectAuctionMonthList(Map<String, Object> pRequestParamMap) {
		return haa05_Mapper.selectAuctionMonthList(pRequestParamMap);
	}
	
	public List<EgovMap> selectAuctionYearList(Map<String, Object> pRequestParamMap) {
		return haa05_Mapper.selectAuctionYearList(pRequestParamMap);
	}
	
	public List<EgovMap> selectAuctionListTotal(Map<String, Object> pRequestParamMap) {
		return haa05_Mapper.selectAuctionListTotal(pRequestParamMap);
	}
	
	
	//등급정보 리스트
	public List<EgovMap> selectHaaLvDate00(Map<String, Object> pRequestParamMap) {
		return haa05_Mapper.selectHaaLvDate00(pRequestParamMap);
	}
	
	public List<EgovMap> selectHaaLvMonth00(Map<String, Object> pRequestParamMap) {
		return haa05_Mapper.selectHaaLvMonth00(pRequestParamMap);
	}
	
	public List<EgovMap> selectHaaLvYear00(Map<String, Object> pRequestParamMap) {
		return haa05_Mapper.selectHaaLvYear00(pRequestParamMap);
	}
	
	public List<EgovMap> selectHaa00LvTotal(Map<String, Object> pRequestParamMap) {
		return haa05_Mapper.selectHaa00LvTotal(pRequestParamMap);
	}

	
	//거래금액분포도 리스트
	public List<EgovMap> selectHaaInfoDate00(Map<String, Object> pRequestParamMap) {
		return haa05_Mapper.selectHaaInfoDate00(pRequestParamMap);
	}
	
	public List<EgovMap> selectHaaInfoMonth00(Map<String, Object> pRequestParamMap) {
		return haa05_Mapper.selectHaaInfoMonth00(pRequestParamMap);
	}
	
	public List<EgovMap> selectHaaInfoYear00(Map<String, Object> pRequestParamMap) {
		return haa05_Mapper.selectHaaInfoYear00(pRequestParamMap);
	}
	
	public List<EgovMap> selectHaaInfoTotal00(Map<String, Object> pRequestParamMap) {
		return haa05_Mapper.selectHaaInfoTotal00(pRequestParamMap);
	}
	
	
	//거래동향리스트
	public List<EgovMap> selectHaaChartDate00(Map<String, Object> pRequestParamMap) {
		return haa05_Mapper.selectHaaChartDate00(pRequestParamMap);
	}
	
	public List<EgovMap> selectHaaChartMonth00(Map<String, Object> pRequestParamMap) {
		return haa05_Mapper.selectHaaChartMonth00(pRequestParamMap);
	}
	
	public List<EgovMap> selectHaaChartYear00(Map<String, Object> pRequestParamMap) {
		return haa05_Mapper.selectHaaChartYear00(pRequestParamMap);
	}
	
	public List<EgovMap> selectHaaChartYear002(Map<String, Object> pRequestParamMap) {
		return haa05_Mapper.selectHaaChartYear002(pRequestParamMap);
	}
	
	public List<EgovMap> selectTop5(Map<String, Object> pRequestParamMap) {
		return haa05_Mapper.selectTop5(pRequestParamMap);
	}
	
	public List<EgovMap> selectHaaChartTotal00(Map<String, Object> pRequestParamMap) {
		return haa05_Mapper.selectHaaChartTotal00(pRequestParamMap);
	}

	//공판장비중리스트
	public List<EgovMap> selectHaa00QtyPerJson(Map<String, Object> pRequestParamMap) {
		return haa05_Mapper.selectHaa00QtyPerJson(pRequestParamMap);
	}
	
	public List<EgovMap> selectHaa00QtyPerJsonTotal(Map<String, Object> pRequestParamMap) {
		return haa05_Mapper.selectHaa00QtyPerJsonTotal(pRequestParamMap);
	}

}
