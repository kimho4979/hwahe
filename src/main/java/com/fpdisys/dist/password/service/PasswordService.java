package com.fpdisys.dist.password.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.password.domain.PasswordVO;
import com.fpdisys.dist.password.mapper.PasswordMapper;

@Service
public class PasswordService extends BaseService {

	@Autowired
	PasswordMapper passwordMapper;
	
	public List<PasswordVO> passwordMailInfo(Map<String, Object> pRequestParamMap){
		return passwordMapper.passwordMailInfo(pRequestParamMap);		
	}
	
	public int updatePasswordInitYn(String userId){
		return passwordMapper.updatePasswordInitYn(userId);
	}
	
	public int updateChangePassword(Map<String, Object> pRequestParamMap){
		return passwordMapper.updateChangePassword(pRequestParamMap);
	}
}
