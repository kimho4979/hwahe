package com.fpdisys.dist.user.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.user.domain.User;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("userMapper")
public interface UserMapper {

	
  List<?> selectAllUserList(Map<String, Object> pReqParamMap);

  List<?> selectAllUserAuthList(Map<String, Object> pReqParamMap);

  User selectUserFindOne(Map<String, Object> pReqParamMap);

  int countUserCd(Map<String, Object> pReqParamMap);

  User loginCheck(Map<String, Object> pReqParamMap);

  void updateUser(Map<String, Object> pReqParamMap);

  void insertUser(Map<String, Object> pReqParamMap);

  void insertUserAuth(Map<String, Object> pReqParamMap);
	
}
