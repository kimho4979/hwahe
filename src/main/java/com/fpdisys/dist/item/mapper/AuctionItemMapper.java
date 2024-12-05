package com.fpdisys.dist.item.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.item.domain.AuctionItemVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("auctionItemMapper")
public interface AuctionItemMapper{
	// 일자별 품목 경매정보 기본 목록
	List<EgovMap> selectItemDaily(Map<String, Object> pRequestParamMap);

	// 일자별 품목 경매정보 목록 2Depth 일자별 거래량 정보
	List<EgovMap> selectItemDailyDate(Map<String, Object> pRequestParamMap);

	// 일자별 품목 경매정보 목록 3Depth 일자별 레벨별 거래량 정보
	List<EgovMap> selectItemDailyDateLevel(Map<String, Object> pRequestParamMap);

	// 월별 품목 경매정보 기본 목록
	List<EgovMap> selectItemMonthly(Map<String, Object> pRequestParamMap);

	// 월별 품목 경매정보 목록 2Depth 일자별 거래량 정보
	List<EgovMap> selectItemMonthlyMonth(Map<String, Object> pRequestParamMap);

	// 월별 품목 경매정보 목록 3Depth 일자별 레벨별 거래량 정보
	List<EgovMap> selectItemMonthlyMonthLevel(Map<String, Object> pRequestParamMap);

	// 금주(월)의 인기품목 List
	List<EgovMap> selectItemPopularList(Map<String, Object> pRequestParamMap);

	// 금주(월)의 인기품목 CHART
	List<EgovMap> selectItemPopularChart(Map<String, Object> pRequestParamMap);

	List<AuctionItemVO> selectDailyItemExcel(Map<String, Object> pRequestParamMap);

	List<AuctionItemVO> selectMonthlyItemExcel(Map<String, Object> pRequestParamMap);
}