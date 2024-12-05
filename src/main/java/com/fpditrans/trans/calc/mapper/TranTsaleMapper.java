package com.fpditrans.trans.calc.mapper;

import java.util.List;
import java.util.Map;

import com.fpditrans.trans.calc.domain.CSVBean;
import com.fpditrans.trans.calc.domain.TsaleVO;








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

@Mapper("tranTsaleMapper")
public interface TranTsaleMapper {
	
	/**
	 * 목록데이터 전제 검색
	 * @param pReqParamMap
	 * @return
	 */
	List<?>  selectTsaleListAll(Map<String, Object> pReqParamMap);
	
	/**
	 * 검색한 데이터만 가져오기 
	 * @param pReqParamMap
	 * @return
	 */
	List<?>  selectSearchTsaleList(Map<String, Object> pReqParamMap);
	/**
	 * 검색한 데이터 페이징 처리해서 목록가져오기 
	 * @param pReqParamMap
	 * @return
	 */
	List<?>  selectSearchTsaleListPageAble(Map<String, Object> pReqParamMap);
	
	/**
	 * 개별데에터 검색
	 * 
	 * @param pReqParamMap
	 * @return
	 */
	TsaleVO  selectTsaleOne(Map<String, Object> pReqParamMap);
	
	
	/**
	 * 로그초기등록
	 * @param pReqParamMap
	 * @return
	 */
	
	int  insertTsaleLogFirst(Map<String, Object> pReqParamMap) ;
	
	/**
	 * 로그 수정  
	 * @param pReqParamMap
	 * @return
	 */
	int  updateTsaleLogFirst(Map<String, Object> pReqParamMap) ;
	/**
	 * 로그 갯수 카운트
	 * @param pReqParamMap
	 * @return
	 */
	int selectTsaleCnt(Map<String, Object> pReqParamMap) ;
	/**
	 * 정산 삭제 처리 
	 * @param pReqParamMap
	 * @return
	 */
	int  deleteTsaleLogFirst(Map<String, Object> pReqParamMap) ;
	/**
	 * 정산 등록
	 * @param data
	 * @return
	 */
	int  insertTsaleFirst(CSVBean  data) ;
	/**
	 * 최종 로그 수정 
	 * @param data
	 * @return
	 */
	int  updateTsaleLogLast(CSVBean  data) ;
	
	/**
	 * 정산 로그 전체 검색
	 * @param pReqParamMap
	 * @return
	 */
	List<?> selectEpisTsaleSvcLogAll(Map<String, Object> pReqParamMap);
	
	/**
	 * 정산 로그 검색 조회 
	 * @param pReqParamMap
	 * @return
	 */
	List<?> selectEpisTsaleSvcLogSearch(Map<String, Object> pReqParamMap);
	
	/**
	 * 정산 로그 검색조회 페이징 처리 
	 * @param pReqParamMap
	 * @return
	 */
	List<?> selectEpisTsaleSvcLogSearchPageAble(Map<String, Object> pReqParamMap);
	
	/**
	 * 등록 결과 조회 (성공건수, 실패건수, 물량 등)
	 * @param pReqParamMap
	 * @return
	 */
	Map<String, Object>  selectEpisTsaleSvcLogResult(Map<String, Object> pReqParamMap);	
	
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
	 * 주별 정산 삭제 처리 
	 * @param pReqParamMap
	 */
	void deleteSaleWeek(Map<String, Object> pReqParamMap);
	/**
	 * 주별 정산 등록 처리 
	 * @param pReqParamMap
	 */
	void insertSaleWeek(Map<String, Object> pReqParamMap);
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
	 * 결과 검색 조회  
	 * @param pReqParamMap
	 * @return
	 */
	List<?> selectEpisTsaleSvcLogResultListSearch(Map<String, Object> pReqParamMap);
	
	/**
	 * 결과 검색 조회 페이징 처리 
	 * @param pReqParamMap
	 * @return
	 */
	List<?> selectEpisTsaleSvcLogResultListSearchPageAble(Map<String, Object> pReqParamMap);
	
	/**
	 * 삭제처리 등록
	 * @param pReqParamMap
	 * @return
	 */
	int insertTsaleDelLog(Map<String, Object> pReqParamMap);
	
	/**
	 * 정산로그 삭제 처리 조건 (saledate, cmp_cd, seq,no1, no2)
	 * @param pReqParamMap
	 * @return
	 */
	int  deleteTsaleLog(Map<String, Object> pReqParamMap);
	
	/**
	 * 품종코드로 화훼 구분(농협) 가져온다. 
	 * @param cmpGood
	 * @return
	 */
	String  selectFlowerGubn(String cmpGood);
	
	/**
	 * 한국화훼 등급코드로 표준등급코드를 가져온다. 
	 * @param lvCd
	 * @return
	 */
	String selectKoreaLvCdChage(String lvCd);
	
	/**
	 * 품종코드로 화훼 구분(AT) 가져온다. 
	 * @param cmpGood
	 * @return
	 */
	String  selectFlowerGubnAt(String cmpGood);
	
	/**
	 * 품종코드로 화훼 구분(농협) 가져온다. 
	 * @param pReqParamMap
	 * @return
	 */
	String selectFlowerGubnNong(Map<String, Object> pReqParamMap);
	/**
	 * 날자 TSALE 삭제 처리 
	 * @param pReqParamMap
	 */
	 int deleteTsaleAllByDate(Map<String, Object> pReqParamMap);

	void insertTsaleAt(Map<String, Object> paramMap);

	int deleteTsaleAt(Map<String, Object> pReqParamMap);

	void insertMagam(Map<String, Object> reqMap);


}
