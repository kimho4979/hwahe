package com.fpdisys.dist.haa00_new.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("haa00_newMapper")
public interface Haa00_newMapper {
	List<EgovMap> selectAuctionDayList(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectAuctionMonthList(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectAuctionYearList(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectAuctionListTotal(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectHaaLvDate00(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectHaaLvMonth00(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectHaaLvYear00(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectHaa00LvTotal(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectHaaInfoDate00(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectHaaInfoMonth00(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectHaaInfoYear00(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectHaaInfoTotal00(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectHaaChartDate00(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectHaaChartMonth00(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectHaaChartYear00(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectHaaChartTotal00(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectHaa00QtyPerJson(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectHaa00QtyPerJsonTotal(Map<String, Object> pRequestParamMap);
	
}
