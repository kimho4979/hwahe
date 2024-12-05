package com.fpdisys.dist.kind.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.kind.domain.AuctionKindVO;
import com.fpdisys.dist.kind.mapper.AuctionKindMapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class AuctionKindService extends BaseService{
	@Autowired
	AuctionKindMapper auctionKindMapper;
	
	// 일자별 품종 경매정보 기본 목록
	public List<EgovMap> selectKindDaily(Map<String, Object> pRequestParamMap){
		return auctionKindMapper.selectKindDaily(pRequestParamMap);
	}
	
	// 일자별 품종 경매정보 목록 2Depth 월별 거래량 정보
	public List<EgovMap> selectKindDailyDate(Map<String, Object> pRequestParamMap){
		return auctionKindMapper.selectKindDailyDate(pRequestParamMap);
	}
	
	// 일자별 품종 경매정보 목록 3Depth 월별 레벨별 거래량 정보
	public List<EgovMap> selectKindDailyDateLevel(Map<String, Object> pRequestParamMap){
		return auctionKindMapper.selectKindDailyDateLevel(pRequestParamMap);
	}
	
	// 월별 품종 경매정보 기본 목록
	public List<EgovMap> selectKindMonthly(Map<String, Object> pRequestParamMap){
		return auctionKindMapper.selectKindMonthly(pRequestParamMap);
	}
	
	// 월별 품종 경매정보 목록 2Depth 월별 거래량 정보
	public List<EgovMap> selectKindMonthlyMonth(Map<String, Object> pRequestParamMap){
		return auctionKindMapper.selectKindMonthlyMonth(pRequestParamMap);
	}
	
	// 월별 품종 경매정보 목록 3Depth 월별 레벨별 거래량 정보
	public List<EgovMap> selectKindMonthlyMonthLevel(Map<String, Object> pRequestParamMap){
		return auctionKindMapper.selectKindMonthlyMonthLevel(pRequestParamMap);
	}
	//Excel
	public List<AuctionKindVO> selectDailyKindExcel(Map<String, Object> pRequestParamMap){
		return auctionKindMapper.selectDailyKindExcel(pRequestParamMap);
	}

	public List<AuctionKindVO> selectMonthlyKindExcel(Map<String, Object> pRequestParamMap) {
		return auctionKindMapper.selectMonthlyKindExcel(pRequestParamMap);
	}
}