package com.at.mapper;

import java.util.List;
import java.util.Map;

import com.at.domain.AtMarketVO;
import com.at.domain.AtMntVO;
import com.at.domain.SituationVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
/**
 * @Class Name : TsaleMapper.java
 * @Description : TsaleMapper Class
 *	 
 * @
 * @  수정일	  수정자			  수정내용
 * @ ---------	---------	-------------------------------
 * @ 2016.07.28			최초생성
 *
 * @author 우림인포텍
 * @version 1.0
 * @see
 *
 *  Copyright (C) by woorim All right reserved.
 */

@Mapper("aTMapper")
public interface aTMapper {

	List<?> atMarketData(Map<String, Object> pReqParamMap);

	List<AtMarketVO> atMarketRealData(Map<String, Object> pReqParamMap);
	
	List<AtMarketVO> atMarketRealData2(Map<String, Object> pReqParamMap);

	List<AtMarketVO> atMarketRealDataDate(Map<String, Object> pReqParamMap);

	List<AtMntVO> atMntData(Map<String, Object> pReqParamMap);
	
	List<SituationVO> selectSituation(Map<String, Object> pRequestParamMap);

	List<SituationVO> selectSituation1(Map<String, Object> pRequestParamMap);

	List<SituationVO> selectSituation2(Map<String, Object> pRequestParamMap);

	List<AtMarketVO> atMarketDataManual(Map<String, Object> pReqParamMap);

	List<AtMarketVO> atMarketYuchalData(Map<String, Object> pReqParamMap);
	
	int atMarketTotCnt(Map<String, Object> pReqParamMap);
	
	List<Map<String,Object>> selectAuctionAPumJong();
	List<Map<String,Object>> selectAuctionAPumMok();

}
