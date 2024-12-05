package com.fpdisys.dist.real.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.real.domain.RealVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("realMapper")
public interface RealMapper {
	int deleteRealData(RealVO realVo);
	
	int saveRealData(RealVO realVo);
	
	int deleteSaleData(RealVO realVo);
	
	int saveSaleData(RealVO realVo);


	int saveErrLog(Map<String, String> hashMap);

	List<RealVO> getRealData(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> getRealData1(Map<String, Object> pRequestParamMap);
	
	List<RealVO> getRealMainData(Map<String, Object> pRequestParamMap);
	
	List<RealVO> getRealSaleData(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> getRealPumNameData(Map<String, Object> pRequestParamMap);
	
	List<RealVO> getRealSilData(Map<String, Object> pRequestParamMap);
	
	List<RealVO> getRealLvData(Map<String, Object> pRequestParamMap);
	
	List<RealVO> getRealInforData(Map<String, Object> pRequestParamMap);
	
	List<RealVO> getRealchartData(Map<String, Object> pRequestParamMap);
	
	/**
	 * 품종코드로 화훼 구분(농협) 가져온다. 
	 * @param pReqParamMap
	 * @return
	 */
	String selectFlowerGubnNong(Map<String, Object> pReqParamMap);
	/**
	 * 한국화훼 등급코드로 표준등급코드를 가져온다. 
	 * @param lvCd
	 * @return
	 */
	String selectKoreaLvCdChage(String lvCd);
	
	/**
	 * 일자별 정산 삭제 처리 
	 * @param pReqParamMap
	 */
	void deleteSaleDate(Map<String, Object> pReqParamMap);
	
	/**
	 * 일자별 정산 등록처리 
	 * @param pReqParamMap
	 */
	void insertSaleDate(Map<String, Object> pReqParamMap);
	/**
	 * 월별 정산 삭제 처리 
	 * @param pReqParamMap
	 */
	void deleteSaleMonth(Map<String, Object> pReqParamMap);
	/**
	 * 월별 정산 등록처리 
	 * @param pReqParamMap
	 */
	void insertSaleMonth(Map<String, Object> pReqParamMap);
	
	/**
	 * 일자별 정산 삭제 처리 
	 * @param pReqParamMap
	 */
	void deleteSale(Map<String, Object> pReqParamMap);
	
	List<RealVO> selectPumAvg(Map<String, Object> pRequestParamMap);

	List<RealVO> selectLvCdAvg(Map<String, Object> pRequestParamMap);
	
	List<RealVO> getRealDataExcel(Map<String, Object> pRequestParamMap);
	
	int atMarketRealTotCnt(Map<String, Object> pRequestParamMap);
	
	void deleteAtRealData(Map<String, Object> pRequestParamMap);
}
