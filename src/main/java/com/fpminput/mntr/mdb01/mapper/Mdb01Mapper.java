package com.fpminput.mntr.mdb01.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("mdb01Mapper")
public interface Mdb01Mapper {

	List<EgovMap> selectUserList(Map<String, Object> pRequestParamMap);

	int checkUserId(Map<String, Object> pRequestParamMap);

	void insertUserInput(Map<String, Object> pRequestParamMap);

	void insertUserAuthInput(Map<String, Object> pRequestParamMap);

	Map<String, String> detailUserInput(Map<String, Object> pRequestParamMap);

	void updateUserInput(Map<String, Object> pRequestParamMap);

	void updateUserAuthInput(Map<String, Object> pRequestParamMap);

	void deleteUserInput(@Param("list") List<String> list);

	void deleteUserAuthInput(@Param("list") List<String> list);

	void userInputLog(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectUserInfoLogList(Map<String, Object> pRequestParamMap);

}
