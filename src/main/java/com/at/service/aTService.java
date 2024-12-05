package com.at.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.at.domain.AtMarketVO;
import com.at.domain.AtMntVO;
import com.at.domain.SituationVO;
import com.at.mapper.aTMapper;
import com.fpdisys.base.mvc.BaseService1;
/**
 * @Class Name : TsaleService.java
 * @Description : TsaleService Class
 * 
 *			  @ 정산자료 서비스 테이블 @ 수정일 수정자 수정내용 @ --------- ---------
 *			  ------------------------------- @ 2016.07.28 최초생성
 *
 * @author 우림인포텍
 * @version 1.0
 * @see Copyright (C) by woorim All right reserved.
 */

@Service
public class aTService extends BaseService1 {

	@Autowired
	aTMapper aTMapper;
	
	protected Log log = LogFactory.getLog(this.getClass());

	
	
	public List<AtMarketVO> atMarketData(Map<String, Object> pReqParamMap) throws SQLException{

		return (List<AtMarketVO>) aTMapper.atMarketData(pReqParamMap);

	}
	
	public List<AtMarketVO> atMarketDataManual(Map<String, Object> pReqParamMap) throws SQLException{

		return (List<AtMarketVO>) aTMapper.atMarketDataManual(pReqParamMap);

	}
	
	public List<AtMarketVO> atMarketRealData(Map<String, Object> pReqParamMap) throws SQLException{

		return (List<AtMarketVO>) aTMapper.atMarketRealData(pReqParamMap);

	}
	
	public List<AtMarketVO> atMarketRealData2(Map<String, Object> pReqParamMap) throws SQLException{

		return (List<AtMarketVO>) aTMapper.atMarketRealData2(pReqParamMap);

	}
	
	public List<AtMarketVO> atMarketRealDataDate(Map<String, Object> pReqParamMap) throws SQLException{

		return (List<AtMarketVO>) aTMapper.atMarketRealDataDate(pReqParamMap);

	}
	
	public List<AtMntVO> atMntData(Map<String, Object> pReqParamMap) throws SQLException{

		return (List<AtMntVO>) aTMapper.atMntData(pReqParamMap);

	}
	
	public List<AtMarketVO> atMarketYuchalData(Map<String, Object> pReqParamMap) throws SQLException{

		return (List<AtMarketVO>) aTMapper.atMarketYuchalData(pReqParamMap);

	}
	
	public int atMarketTotCnt(Map<String, Object> pReqParamMap) throws SQLException{

		return (int) aTMapper.atMarketTotCnt(pReqParamMap);

	}
	
	/**
	 * 현황판시작
	 */
	
	public List<SituationVO> selectSituation(Map<String, Object> pRequestParamMap) {
		return aTMapper.selectSituation(pRequestParamMap);
	}

	public List<SituationVO> selectSituation1(Map<String, Object> pRequestParamMap) {
		return aTMapper.selectSituation1(pRequestParamMap);
	}
	
	public List<SituationVO> selectSituation2(Map<String, Object> pRequestParamMap) {
		return aTMapper.selectSituation2(pRequestParamMap);
	}

	public List<Map<String, Object>> selectAuctionAPumMok() {
		// TODO Auto-generated method stub
		return aTMapper.selectAuctionAPumMok();
	}

	public List<Map<String, Object>> selectAuctionAPumJong() {
		// TODO Auto-generated method stub
		return aTMapper.selectAuctionAPumJong();
	}
	
}
