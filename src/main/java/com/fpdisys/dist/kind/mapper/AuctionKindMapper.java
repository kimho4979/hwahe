package com.fpdisys.dist.kind.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.kind.domain.AuctionKindVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("auctionKindMapper")
public interface AuctionKindMapper{
	// 일자별 품종 경매정보 기본 목록
	List<EgovMap> selectKindDaily(Map<String, Object> pRequestParamMap);
	
	// 일자별 품종 경매정보 목록 2Depth 월별 거래량 정보
	List<EgovMap> selectKindDailyDate(Map<String, Object> pRequestParamMap);
	
	// 일자별 품종 경매정보 목록 3Depth 월별 레벨별 거래량 정보
	List<EgovMap> selectKindDailyDateLevel(Map<String, Object> pRequestParamMap);

	// 월별 품종 경매정보 기본 목록
	List<EgovMap> selectKindMonthly(Map<String, Object> pRequestParamMap);
	
	// 월별 품종 경매정보 목록 2Depth 월별 거래량 정보
	List<EgovMap> selectKindMonthlyMonth(Map<String, Object> pRequestParamMap);
	
	// 월별 품종 경매정보 목록 3Depth 월별 레벨별 거래량 정보
	List<EgovMap> selectKindMonthlyMonthLevel(Map<String, Object> pRequestParamMap);

	List<AuctionKindVO> selectDailyKindExcel(Map<String, Object> pRequestParamMap);

	List<AuctionKindVO> selectMonthlyKindExcel(Map<String, Object> pRequestParamMap);
}