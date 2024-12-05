package com.fpdisys.admin.user.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.admin.user.domain.AdminUserVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("adminUserMapper")
public interface AdminUserMapper {
	
	List<?> selectAdminUserAll(Map<String, Object> pRequestParamMap);
	
	List<?> selectAdminUserSearch(Map<String, Object> pRequestParamMap);
	
	List<?> selectAdminUserSearchPageAble(Map<String, Object> pRequestParamMap);
	
	AdminUserVO selectAdminUserSearchOne(Map<String, Object> pRequestParamMap);
	
	int insertAdminUser(Map<String, Object> pRequestParamMap);
	
	int updateAdminUser(Map<String, Object> pRequestParamMap);
	
	int getMargeAdminUser(Map<String, Object> pRequestParamMap);
	
	List<?> selectAdminGrpAuth(Map<String, Object> pRequestParamMap);
	
	int insertAdminUserAuth(Map<String, Object> pRequestParamMap);
	
	int updateAdminUserAuth(Map<String, Object> pRequestParamMap);
	
	int getMargeAdminUserAuth(Map<String, Object> pRequestParamMap);
	
	int selectAdminUserDuplicated(Map<String, Object> pRequestParamMap);
	
	List<?> selectAdminUserSanCd(Map<String, Object> pRequestParamMap);
	
	List<?> selectAdminSanCdPageAble(Map<String, Object> pRequestParamMap);
	
	int selectCntAdminSanCd(Map<String, Object> pRequestParamMap);
	
	
	
}
