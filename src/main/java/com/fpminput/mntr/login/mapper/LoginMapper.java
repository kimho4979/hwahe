package com.fpminput.mntr.login.mapper;

import java.util.List;
import java.util.Map;

import com.fpminput.mntr.login.domain.UserVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("loginMapper")
public interface LoginMapper {
	
	/**
	 * 로그인 정보 조회
	 * @param pReqParamMap
	 * @return
	 */
	UserVO selectLogin (Map<String, Object> pReqParamMap);

	/**
	 * 비밀번호 틀림 
	 * count 증가
	 * @param pReqParamMap
	 * @return
	 */
	void wrongPasswd(Map<String, Object> pReqParamMap);

	/**
	 * 최종 로그인 시간 수정
	 * @param pReqParamMap
	 * @return
	 */
	void updateLastDate(Map<String, Object> pReqParamMap);

	/**
	 * sso insert
	 * @return
	 */
	void insertSso(Map<String, Object> pReqParamMap);
	
	/**
	 * sso insert
	 * @return
	 */
	void deleteSso(Map<String, Object> pReqParamMap);

	/**
	 * sso
	 * @param pReqParamMap
	 * @return
	 */
	List selectSso (Map<String, Object> pReqParamMap);

	UserVO selectSsoLogin(Map<String, Object> pReqParamMap);

	int updateLimitLogin(Map<String, Object> pRequestParamMap);

	int checkLimitDate(Map<String, Object> pRequestParamMap2);

	List<UserVO> selectIpList();
}
