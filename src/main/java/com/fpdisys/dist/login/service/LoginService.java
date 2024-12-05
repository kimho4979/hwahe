package com.fpdisys.dist.login.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.admin.log.mapper.UserLogMapper;
import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.login.mapper.LoginMapper;

@Service
public class LoginService extends BaseService{
	@Autowired
	private LoginMapper loginMapper;
	public List<?> selectLogin(Map<String, Object> pRequestParamMap) {
		// TODO Auto-generated method stub
		return loginMapper.selectLogin(pRequestParamMap);
	}

}
