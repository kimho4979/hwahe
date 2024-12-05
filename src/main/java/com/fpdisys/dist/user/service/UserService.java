package com.fpdisys.dist.user.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.user.domain.User;
import com.fpdisys.dist.user.mapper.UserMapper;

@Service
public class UserService extends BaseService{

	@Autowired
	UserMapper userMapper;
	
	public List<?> selectAllUserList(Map<String, Object> pReqParamMap){
		return  userMapper.selectAllUserList(pReqParamMap);
	}
	public List<?> selectAllUserAuthList(Map<String, Object> pReqParamMap){
		return userMapper.selectAllUserAuthList(pReqParamMap);
	}
	
	public User selectUserFindOne(Map<String, Object> pReqParamMap){
		return userMapper.selectUserFindOne(pReqParamMap);
	}
	
	public int countUserCd(Map<String, Object> pReqParamMap){
		return userMapper.countUserCd(pReqParamMap);
	}
	
	public User loginCheck(Map<String, Object> pReqParamMap){
		return userMapper.loginCheck(pReqParamMap);
	}
	
	public void updateUser(Map<String, Object> pReqParamMap){
		userMapper.updateUser(pReqParamMap);
	}
	
	public void insertUser(Map<String, Object> pReqParamMap){
		userMapper.insertUser(pReqParamMap);
	}
	
	public Map<String, Object> createProc(Map<String, Object> pReqParamMap){
		
			pReqParamMap.put("userId", pReqParamMap.get("userCd").toString());
			pReqParamMap.put("userType", "U");
			pReqParamMap.put("useYn", "Y");
			
			this.insertUser(pReqParamMap);
		
			pReqParamMap.put("message", "OK");
			
		return pReqParamMap;
	}
	
	
	public Map<String, Object> duplicateProc(Map<String, Object> pReqParamMap){
	
		 int iCheck = 0;
		 
		 iCheck = countUserCd(pReqParamMap);
		 if(iCheck>0){
			 pReqParamMap.put("dupCheck", "N");
			 pReqParamMap.put("message", "중복된 아이디입니다.");
		 }else{
			 pReqParamMap.put("dupCheck", "Y");
			 pReqParamMap.put("message", "사용하셔도 되는 아이디 입니다.");
		 }
	
		
		return pReqParamMap;
	}
	
	public void insertUserAuth(Map<String, Object> pReqParamMap){
		
		
		userMapper.insertUserAuth(pReqParamMap);
	}
	
	public Map<String, Object> createAdminAuthProc(Map<String, Object> pReqParamMap){
		
		pReqParamMap.put("userId", pReqParamMap.get("userCd").toString());
		pReqParamMap.put("grpAuthCd", "A0001");
		pReqParamMap.put("useYn", "Y");
		
		insertUserAuth(pReqParamMap);
	
		pReqParamMap.put("message", "OK");
		
	return pReqParamMap;
}
	
}
