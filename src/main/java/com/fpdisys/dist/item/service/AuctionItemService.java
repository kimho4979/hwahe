package com.fpdisys.dist.item.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.item.domain.AuctionItemVO;
import com.fpdisys.dist.item.mapper.AuctionItemMapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class AuctionItemService extends BaseService{
	@Autowired
	AuctionItemMapper auctionItemMapper;

	// 일자별 품목 경매정보 기본 목록
	public List<EgovMap> selectItemDaily(Map<String, Object> pRequestParamMap){
		return auctionItemMapper.selectItemDaily(pRequestParamMap);
	}

	// 일자별 품목 경매정보 목록 2Depth 일자별 거래량 정보
	public List<EgovMap> selectItemDailyDate(Map<String, Object> pRequestParamMap){
		return auctionItemMapper.selectItemDailyDate(pRequestParamMap);
	}

	// 일자별 품목 경매정보 목록 3Depth 일자별 레벨별 거래량 정보
	public List<EgovMap> selectItemDailyDateLevel(Map<String, Object> pRequestParamMap){
		return auctionItemMapper.selectItemDailyDateLevel(pRequestParamMap);
	}

	// 월별 품목 경매정보 기본 목록
	public List<EgovMap> selectItemMonthly(Map<String, Object> pRequestParamMap){
		return auctionItemMapper.selectItemMonthly(pRequestParamMap);
	}

	// 월별 품목 경매정보 목록 2Depth 일자별 거래량 정보
	public List<EgovMap> selectItemMonthlyMonth(Map<String, Object> pRequestParamMap){
		return auctionItemMapper.selectItemMonthlyMonth(pRequestParamMap);
	}

	// 월별 품목 경매정보 목록 3Depth 일자별 레벨별 거래량 정보
	public List<EgovMap> selectItemMonthlyMonthLevel(Map<String, Object> pRequestParamMap){
		return auctionItemMapper.selectItemMonthlyMonthLevel(pRequestParamMap);
	}

	// 금주(월)의 인기품목 List
	public List<EgovMap> selectItemPopularList(Map<String, Object> pRequestParamMap){
		return auctionItemMapper.selectItemPopularList(pRequestParamMap);
	}

	// 금주(월)의 인기품목 CHART
	public List<EgovMap> selectItemPopularChart(Map<String, Object> pRequestParamMap){
		return auctionItemMapper.selectItemPopularChart(pRequestParamMap);
	}

	//Excel
	public List<AuctionItemVO> selectDailyItemExcel(Map<String, Object> pRequestParamMap){
		return auctionItemMapper.selectDailyItemExcel(pRequestParamMap);
	}

	public List<AuctionItemVO> selectMonthlyItemExcel(Map<String, Object> pRequestParamMap) {
		return auctionItemMapper.selectMonthlyItemExcel(pRequestParamMap);
	}
}