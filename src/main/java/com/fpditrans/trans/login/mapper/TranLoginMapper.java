package com.fpditrans.trans.login.mapper;



import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


/**
 * @Class Name : LoginMapper.java
 * @Description : LoginMapper Class
 *	 로그인 맵퍼 클래스
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

@Mapper("tranLoginMapper")
public interface TranLoginMapper {
	
	/**
	 * 로그인 정보 조회
	 * @param pReqParamMap
	 * @return
	 */
	List<?> selectLogin (Map<String, Object> pReqParamMap);

}
