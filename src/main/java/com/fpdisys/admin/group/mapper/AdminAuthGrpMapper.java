package com.fpdisys.admin.group.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.admin.group.domain.AdminAuthGrpVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("adminAuthGrpMapper")
public interface AdminAuthGrpMapper {
	List<?> selectAdminAuthGrpAll(Map<String, Object> pRequestParamMap);
	
	List<?> selectAdminAuthGrpSearch(Map<String, Object> pRequestParamMap);
	
	List<?> selectAdminAuthGrpSearchPageAble(Map<String, Object> pRequestParamMap);
	
	List<?> selectActiveAdminAuthGrp(Map<String, Object> pRequestParamMap);
	
	AdminAuthGrpVO getAdminAuthGrpOne(Map<String, Object> pRequestParamMap);
	
	int insertAdminAuthGrp(Map<String, Object> pRequestParamMap);
	
	int updateAdminAuthGrp(Map<String, Object> pRequestParamMap);
	
	int getMargeAdminAuthGrp(Map<String, Object> pRequestParamMap);
	

}
