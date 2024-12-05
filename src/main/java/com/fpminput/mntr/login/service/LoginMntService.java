package com.fpminput.mntr.login.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpminput.mntr.login.domain.UserVO;
import com.fpminput.mntr.login.mapper.LoginMapper;

@Service
public class LoginMntService extends BaseService {

	@Autowired
	LoginMapper loginMapper;
	
	/**
	 * 로그인정보 조회
	 * @param pReqParamMap
	 * @return
	 */
	public UserVO selectLogin (Map<String, Object> pReqParamMap){
		return loginMapper.selectLogin(pReqParamMap); 
	}
	
	/**
	 * 비밀번호 틀림 
	 * count 증가
	 * @param pReqParamMap
	 * @return
	 */
	public void wrongPasswd (Map<String, Object> pReqParamMap){
		loginMapper.wrongPasswd(pReqParamMap); 
	}
	
	/**
	 * 최종 로그인 시간 수정
	 * @param pReqParamMap
	 * @return
	 */
	public void updateLastDate (Map<String, Object> pReqParamMap){
		loginMapper.updateLastDate(pReqParamMap); 
	}
	
	/**
	 * sso insert
	 * @return
	 */
	public void insertSso (Map<String, Object> pReqParamMap){
		loginMapper.insertSso(pReqParamMap); 
	}

	/**
	 * sso insert
	 * @return
	 */
	public void deleteSso (Map<String, Object> pReqParamMap){
		loginMapper.deleteSso(pReqParamMap); 
	}

	/**
	 * sso select
	 * @return
	 */
	public List selectSso (Map<String, Object> pReqParamMap){
		return loginMapper.selectSso(pReqParamMap); 
	}
	
	/**
	 * sso select
	 * @return
	 */
	public UserVO selectSsoLogin (Map<String, Object> pReqParamMap){
		return loginMapper.selectSsoLogin(pReqParamMap); 
	}

	public void updateLimitLogin(Map<String, Object> pRequestParamMap) {
		loginMapper.updateLimitLogin(pRequestParamMap); 
	}

	public int checkLimitDate(Map<String, Object> pRequestParamMap) {
		// TODO Auto-generated method stub
		return loginMapper.checkLimitDate(pRequestParamMap); 
	}

	public List<UserVO> selectIpList() {
		// TODO Auto-generated method stub
		return loginMapper.selectIpList();
	}
	
	
}
