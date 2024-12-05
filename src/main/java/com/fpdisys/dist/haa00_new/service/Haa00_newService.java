package com.fpdisys.dist.haa00_new.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.haa00_new.mapper.Haa00_newMapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class Haa00_newService extends BaseService {
	
	@Autowired
	Haa00_newMapper haa00_newMapper;
	//경매리스트
	public List<EgovMap> selectAuctionDayList(Map<String, Object> pRequestParamMap) {
		return haa00_newMapper.selectAuctionDayList(pRequestParamMap);
	}
	
	public List<EgovMap> selectAuctionMonthList(Map<String, Object> pRequestParamMap) {
		return haa00_newMapper.selectAuctionMonthList(pRequestParamMap);
	}
	
	public List<EgovMap> selectAuctionYearList(Map<String, Object> pRequestParamMap) {
		return haa00_newMapper.selectAuctionYearList(pRequestParamMap);
	}
	
	public List<EgovMap> selectAuctionListTotal(Map<String, Object> pRequestParamMap) {
		return haa00_newMapper.selectAuctionListTotal(pRequestParamMap);
	}
	
	
	//등급정보 리스트
	public List<EgovMap> selectHaaLvDate00(Map<String, Object> pRequestParamMap) {
		return haa00_newMapper.selectHaaLvDate00(pRequestParamMap);
	}
	
	public List<EgovMap> selectHaaLvMonth00(Map<String, Object> pRequestParamMap) {
		return haa00_newMapper.selectHaaLvMonth00(pRequestParamMap);
	}
	
	public List<EgovMap> selectHaaLvYear00(Map<String, Object> pRequestParamMap) {
		return haa00_newMapper.selectHaaLvYear00(pRequestParamMap);
	}
	
	public List<EgovMap> selectHaa00LvTotal(Map<String, Object> pRequestParamMap) {
		return haa00_newMapper.selectHaa00LvTotal(pRequestParamMap);
	}

	
	//거래금액분포도 리스트
	public List<EgovMap> selectHaaInfoDate00(Map<String, Object> pRequestParamMap) {
		return haa00_newMapper.selectHaaInfoDate00(pRequestParamMap);
	}
	
	public List<EgovMap> selectHaaInfoMonth00(Map<String, Object> pRequestParamMap) {
		return haa00_newMapper.selectHaaInfoMonth00(pRequestParamMap);
	}
	
	public List<EgovMap> selectHaaInfoYear00(Map<String, Object> pRequestParamMap) {
		return haa00_newMapper.selectHaaInfoYear00(pRequestParamMap);
	}
	
	public List<EgovMap> selectHaaInfoTotal00(Map<String, Object> pRequestParamMap) {
		return haa00_newMapper.selectHaaInfoTotal00(pRequestParamMap);
	}
	
	
	//거래동향리스트
	public List<EgovMap> selectHaaChartDate00(Map<String, Object> pRequestParamMap) {
		return haa00_newMapper.selectHaaChartDate00(pRequestParamMap);
	}
	
	public List<EgovMap> selectHaaChartMonth00(Map<String, Object> pRequestParamMap) {
		return haa00_newMapper.selectHaaChartMonth00(pRequestParamMap);
	}
	
	public List<EgovMap> selectHaaChartYear00(Map<String, Object> pRequestParamMap) {
		return haa00_newMapper.selectHaaChartYear00(pRequestParamMap);
	}
	
	public List<EgovMap> selectHaaChartTotal00(Map<String, Object> pRequestParamMap) {
		return haa00_newMapper.selectHaaChartTotal00(pRequestParamMap);
	}

	//공판장비중리스트
	public List<EgovMap> selectHaa00QtyPerJson(Map<String, Object> pRequestParamMap) {
		return haa00_newMapper.selectHaa00QtyPerJson(pRequestParamMap);
	}
	
	public List<EgovMap> selectHaa00QtyPerJsonTotal(Map<String, Object> pRequestParamMap) {
		return haa00_newMapper.selectHaa00QtyPerJsonTotal(pRequestParamMap);
	}

}
