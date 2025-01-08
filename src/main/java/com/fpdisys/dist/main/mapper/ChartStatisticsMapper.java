package com.fpdisys.dist.main.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("chartStatisticsMapper")
public interface ChartStatisticsMapper {
	
	// 품목별차트 날짜 조회
	List<EgovMap> selectPumMokSaledate();
	
	// 메인조회 날짜(품목)
	List<EgovMap> selectSearchPumMokSaleDate(Map<String, Object> pRequestParamMap);
	// 메인조회 날짜(지역)
	List<EgovMap> selectSearchAreaSaleDate(Map<String, Object> pRequestParamMap);
	
	// FlowerGubun 찾기
	List<EgovMap> selectSearchFlowerGubun(Map<String, Object> pRequestParamMap);
	
	// 품목별거래현황차트전체 스케쥴러 조회
	List<EgovMap> selectPumStatsTotList(Map<String, Object> searchDateMap);
	
	// 품목별거래현황차트전체 조회(메인)
	List<EgovMap> selectPumStatsTot(Map<String, Object> searchDateMap);
	
	// 품목별거래현황차트전체 스케쥴러 등록
	int insertPumStatsTot(Map<String, Object> paramMap);
	
	// 품목별거래현황차트전체 스케쥴러 삭제
	int deletePumStatsTot(Map<String, Object> paramMap);
	
	// 품목별거래현황차트 스케쥴러 조회
	List<EgovMap> selectPumStatsList(Map<String, Object> searchDateMap);
	
	// 품목별거래현황차트 조회(메인)
	List<EgovMap> selectPumStats(Map<String, Object> searchDateMap);
	
	// 품목별거래현황차트 스케쥴러 등록
	int insertPumStats(Map<String, Object> paramMap);
	
	// 품목별거래현황차트 스케쥴러 삭제
	int deletePumStats(Map<String, Object> paramMap);
	
	// 스케쥴러 날짜 조회
	List<EgovMap> selectAreaSaleDate();
	
	// 지역별거래현황 스케쥴러 조회
	List<EgovMap> selectChartAreaMapList(Map<String, Object> searchDateMap);
	
	// 지역별거래현황 스케쥴러 등록
	int insertChartAreaMap(Map<String, Object> paramMap);
	
	// 지역별거래현황 스케쥴러 삭제
	int deleteChartAreaMap(Map<String, Object> paramMap);
	
	// 지역별거래현황 지도 조회(메인)
	List<EgovMap> selectChartAreaMap(Map<String, Object> searchDateMap);
	
	// 지역별거래현황 스케쥴러 조회
	List<EgovMap> selectChartAreaList(Map<String, Object> searchDateMap);
	
	// 지역별거래현황 스케쥴러 등록
	int insertChartArea(Map<String, Object> paramMap);
	
	// 지역별거래현황 스케쥴러 삭제
	int deleteChartArea(Map<String, Object> paramMap);

	// 지역별거래현황 조회(메인)
	List<EgovMap> selectChartArea(Map<String, Object> searchDateMap);
	
}
