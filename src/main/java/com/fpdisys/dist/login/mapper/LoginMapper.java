package com.fpdisys.dist.login.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


/**
 * 
 * @author hongws
 *
 */
@Mapper("LoginMapper")
public interface LoginMapper {
	/**
	 * 로그인
	 * @param pReqParamMap
	 * @return
	 */
	List<?> selectLogin(Map<String, Object> pReqParamMap) ;
	
	/**
	 * 로그등록
	 * @param pReqParamMap
	 * @return
	 */
	int  insertLog(Map<String, Object> pReqParamMap) ;
	
	int  updateUserLastLoginDt(Map<String, Object> pReqParamMap) ;
	
	int  updateUserPassErrNum(Map<String, Object> pReqParamMap) ;
}
