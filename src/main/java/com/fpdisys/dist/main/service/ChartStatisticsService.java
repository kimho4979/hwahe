package com.fpdisys.dist.main.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.main.mapper.ChartStatisticsMapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class ChartStatisticsService extends BaseService {

	@Autowired
	ChartStatisticsMapper chartStatisticsMapper;
	
	// 최신내역날짜조회
	public List<EgovMap> selectPumMokSaledate() {
		return chartStatisticsMapper.selectPumMokSaledate();
	}
	
	// 메인 조회 품목별 날짜
	public List<EgovMap> selectSearchPumMokSaleDate(Map<String, Object> pRequestParamMap) {
		return chartStatisticsMapper.selectSearchPumMokSaleDate(pRequestParamMap);
	}
	
	// 메인 조회 지역별 날짜
	public List<EgovMap> selectSearchAreaSaleDate(Map<String, Object> pRequestParamMap) {
		return chartStatisticsMapper.selectSearchAreaSaleDate(pRequestParamMap);
	}
	
	// 품목별거래현황 토탈 스케쥴러 조회
	public List<EgovMap> selectPumStatsTotList(Map<String, Object> searchDateMap) {
		return chartStatisticsMapper.selectPumStatsTotList(searchDateMap);
	}
	
	// 품목별거래현황토탈 스케쥴러 등록
	public int insertPumStatsTot(Map<String, Object> paramMap){
		return chartStatisticsMapper.insertPumStatsTot(paramMap);
	}
	
	// 품목별거래현황토탈 스케쥴러 삭제
	public int deletePumStatsTot(Map<String, Object> paramMap){
		return chartStatisticsMapper.deletePumStatsTot(paramMap);
	}
	
	// 품목별거래현황 토탈 조회(메인)
	public List<EgovMap> selectPumStatsTot(Map<String, Object> searchDateMap) {
		return chartStatisticsMapper.selectPumStatsTot(searchDateMap);
	}
	
	// 품목별거래현황 스케쥴러 조회
	public List<EgovMap> selectPumStatsList(Map<String, Object> searchDateMap) {
		return chartStatisticsMapper.selectPumStatsList(searchDateMap);
	}
	
	// 품목별거래현황 스케쥴러 등록
	public int insertPumStats(Map<String, Object> paramMap){
		return chartStatisticsMapper.insertPumStats(paramMap);
	}
	
	// 품목별거래현황 스케쥴러 삭제
	public int deletePumStats(Map<String, Object> paramMap){
		return chartStatisticsMapper.deletePumStats(paramMap);
	}
	
	// 품목별거래현황 조회(메인)
	public List<EgovMap> selectPumStats(Map<String, Object> searchDateMap) {
		return chartStatisticsMapper.selectPumStats(searchDateMap);
	}
	
	// 스케쥴러 날짜 조회
	public List<EgovMap> selectAreaSaleDate() {
		return chartStatisticsMapper.selectAreaSaleDate();
	}

	// 지역별차트 지도 스케쥴러 조회
	public List<EgovMap> selectChartAreaMapList(Map<String, Object> searchDateMap) {
		return chartStatisticsMapper.selectChartAreaMapList(searchDateMap);
	}
	
	// 지역별차트 지도 조회(메인)
	public List<EgovMap> selectChartAreaMap(Map<String, Object> searchDateMap) {
		return chartStatisticsMapper.selectChartAreaMap(searchDateMap);
	}
	
	// 지역별차트 지도 등록
	public int insertChartAreaMap(Map<String, Object> paramMap){
		return chartStatisticsMapper.insertChartAreaMap(paramMap);
	}
	
	// 지역별차트 지도 삭제
	public int deleteChartAreaMap(Map<String, Object> paramMap){
		return chartStatisticsMapper.deleteChartAreaMap(paramMap);
	}
	
	// 지역별차트 스케쥴러 조회
	public List<EgovMap> selectChartAreaList(Map<String, Object> searchDateMap) {
		return chartStatisticsMapper.selectChartAreaList(searchDateMap);
	}
	
	// 지역별차트 스케쥴러 등록
	public int insertChartArea(Map<String, Object> paramMap){
		return chartStatisticsMapper.insertChartArea(paramMap);
	}
	
	// 지역별차트 스케쥴러 삭제
	public int deleteChartArea(Map<String, Object> paramMap){
		return chartStatisticsMapper.deleteChartArea(paramMap);
	}
	
	// 지역별차트 조회(메인)
	public List<EgovMap> selectChartArea(Map<String, Object> searchDateMap) {
		return chartStatisticsMapper.selectChartArea(searchDateMap);
	}
}
