package com.fpditrans.trans.main.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpditrans.base.mvc.BaseService;
import com.fpditrans.trans.main.mapper.TranMainMapper;



/**
 * @Class Name : MainService.java
 * @Description : MainService Class
 *	 
 * @ 메인 서비스 테이블 
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
@Service
public class TranMainService extends BaseService{
	
	
	@Autowired
	TranMainMapper mainMapper;
	
	/**
	 * 정산 자료 등록 프로시저 호출 서비브 
	 * @param reqMap
	 * @return
	 */
	public Map<String, Object> marketJungInsert(Map<String, Object> reqMap){
		
		  reqMap.put("oRetMessage", "");
		  reqMap.put("intProCessCnt", "");
		  mainMapper.marketJungInsert(reqMap);
		  
		  return reqMap;
		
	}
	
	/**
	 * 실시간 정산 자료 등록 프로시저 호출  서비스 
	 * @param reqMap
	 * @return
	 */
	public Map<String, Object> marketJungPrepare(Map<String, Object> reqMap){
		  reqMap.put("oRetMessage", "");
		  reqMap.put("intProCessCnt", "");
		  mainMapper.marketJungPrepare(reqMap);
		  
		return reqMap;
	}
	
	
	/**
	 * 화훼공판장 자료전송 테스트 메소드	(완료후 삭제 예정)
	 * @param reqMap
	 * @return
	 */
	public Map<String ,Object>  insertTest(Map<String, Object> reqMap){
		 
		mainMapper.insertTest(reqMap);
			
		  reqMap.put("oRetMessage", "OK");
		 return reqMap;
	}
	
	/**
	 * 화훼공판장 마감처리 프로시저 호출 
	 * @param reqMap
	 * @return
	 */
	public Map<String, Object> marketJungMagam(Map<String, Object> reqMap){
		  reqMap.put("oRetMessage", "");
		  reqMap.put("intProCessCnt", "");
		  mainMapper.marketJungMagam(reqMap);
		  
		return reqMap;
	}
	
	

}
