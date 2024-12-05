package com.fpdisys.dist.customInfo.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.customInfo.domain.CustomInfoSnsVO;
import com.fpdisys.dist.customInfo.domain.CustomInfoVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("customInfoMapper")
public interface CustomInfoMapper {

	int saveCustomInfo(Map<String, Object> pRequestParamMap);
	
	int saveCustomInfoDtl(Map<String, Object> pRequestParamMap);
	
	void deleteCustomInfoDtl(Map<String, Object> pRequestParamMap);
	
	int saveCustomInfoReal(Map<String, Object> pRequestParamMap);

	CustomInfoVO getCustomInfo(Map<String, Object> pRequestParamMap);

	List<CustomInfoSnsVO> getSnsList(Map<String, Object> pRequestParamMap);

	CustomInfoVO loginCustomInfo(Map<String, Object> pRequestParamMap);
	
	List<String> getPumName(Map<String, Object> pRequestParamMap);
	
	List<String> getGoodName(Map<String, Object> pRequestParamMap);
	
	List<CustomInfoVO> getCustomInfoMs(Map<String, Object> pRequestParamMap);
	
	int updateCustomInfoDtl(Map<String, Object> pRequestParamMap);
	
	int updateCustomInfoReal(Map<String, Object> pRequestParamMap);
	
	int deleteCustomInfoReal(String userId);
	
	int sendMail(Map<String, Object> pRequestParamMap);
	
	int sendKakao(Map<String, Object> pRequestParamMap);

	List<CustomInfoVO> getCustomInfoList(Map<String, Object> pRequestParamMap);

	void updateCustomInfoPw(Map<String, Object> pRequestParamMap);

	void insertAuthCode(Map<String, Object> pRequestParamMap);

	void deleteAuthCode(Map<String, Object> pRequestParamMap);

	int compareAuthCode(Map<String, Object> pRequestParamMap);

	EgovMap getUserSearch(Map<String, Object> pRequestParamMap);

	void deleteUserSearch(Map<String, Object> pRequestParamMap);

	int insertUserSearch(Map<String, Object> pRequestParamMap);

	int updateUserSearch(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectMainSet(Map<String, Object> pRequestParamMap);
	
	int insertMainSet(Map<String, Object> pRequestParamMap);

	int deleteMainSet(Map<String, Object> pRequestParamMap);

	void leaveMember(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> getFavoriteList(String userId);

	void insertFavor(Map<String, Object> pRequestParamMap);

	int selectFavor(Map<String, Object> pRequestParamMap);

	void deleteFavor(Map<String, Object> pRequestParamMap);

	void deleteCustomInfo(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectMenuList();


	
}
