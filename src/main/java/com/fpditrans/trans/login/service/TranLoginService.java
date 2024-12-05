package com.fpditrans.trans.login.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpditrans.base.mvc.BaseService;
import com.fpditrans.trans.login.mapper.TranLoginMapper;

/**
 * @Class Name : LoginService.java
 * @Description : LoginService Class
 *	 
 * @ 로그인  서비스 테이블 
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
public class TranLoginService extends BaseService{
	
	@Autowired
	TranLoginMapper loginMapper;
	
	/**
	 * 로그인정보 조회
	 * @param pReqParamMap
	 * @return
	 */
	public List<?> selectLogin (Map<String, Object> pReqParamMap){
		return (List<?>)loginMapper.selectLogin(pReqParamMap); 
	}

}
