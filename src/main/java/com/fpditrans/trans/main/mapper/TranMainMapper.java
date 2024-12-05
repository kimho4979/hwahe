package com.fpditrans.trans.main.mapper;



import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


/**
 * @Class Name : MainMapper.java
 * @Description : MainMapper Class
 *	 메인 맵퍼 클래스
 * @
 * @  수정일	  수정자			  수정내용
 * @ ---------	---------	-------------------------------
 * @ 2016.08.10			최초생성
 *
 * @author 우림인포텍
 * @version 1.0
 * @see
 *
 *  Copyright (C) by woorim All right reserved.
 */

@Mapper("tranMainMapper")
public interface TranMainMapper {
	
	/**
	 * 정산자료  등록	프로시저 호출	메소드 
	 * @param reqMap
	 * @return
	 */
	
	Map<String, Object> marketJungInsert(Map<String, Object> reqMap);
	
	/**
	 * 실시간 자료 등록 프로시저 호출 메소드 
	 * @param reqMap
	 * @return
	 */
	Map<String, Object> marketJungPrepare(Map<String, Object> reqMap);
	
	
	/**
	 * 화훼 공판장 자료전송 테스트 메소드 (완료후 삭제 예정
	 * @param reqMap
	 */
	void insertTest(Map<String, Object> reqMap);
	
	
	/**
	 * 정산 마감 처리 호출 메소드 
	 * @param reqMap
	 * @return
	 */
	Map<String , Object>marketJungMagam(Map<String, Object> reqMap); 
	
}
