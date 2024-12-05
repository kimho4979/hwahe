package com.fpdisys.admin.log.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.admin.log.mapper.UserLogMapper;
import com.fpdisys.base.mvc.BaseService;

@Service
public class UserLogService extends BaseService {
	@Autowired
	private UserLogMapper userLogMapper;
	
	
	public List<?> selectUserLogAll(Map<String, Object> pRequestParamMap){
		return userLogMapper.selectUserLogAll(pRequestParamMap);
	}
	
	public List<?> selectUserLogSearch(Map<String, Object> pRequestParamMap){
		return userLogMapper.selectUserLogSearch(pRequestParamMap);
	}
	
	public List<?> selectUserLogSearchPageAble(Map<String, Object> pRequestParamMap){
		return userLogMapper.selectUserLogSearchPageAble(pRequestParamMap);
	}

	public void InsertLog(HashMap<String, Object> pRequestParamMap) throws Exception {
		System.err.println("UserLogMapper"+userLogMapper);
		 userLogMapper.InsertLog(pRequestParamMap);
		
	}

	public List<?> userLogList(Map<String, Object> pRequestParamMap) {
		 		return userLogMapper.userLogList(pRequestParamMap);
		
	}
	
}
