package com.fpdisys.admin.menu.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.admin.menu.domain.AdminMenuVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("adminMenuMapper")
public interface AdminMenuMapper {
	
	List<?> getFindAllByOrderByMnuLvAscMnuIxAsc(Map<String, Object> pRequestParamMap);
	List<?> activeAdminMenus(Map<String, Object> pRequestParamMap);
	
	 int insertAdminMenu(Map<String, Object> pReqParamMap);
	 
	 int updateAdminMenu(Map<String, Object> pReqParamMap);
	 
	 AdminMenuVO findAdminMenuOne(Map<String, Object> pReqParamMap);
	 
	 int getAdminMargeMenu(Map<String, Object> pReqParamMap);
	void deleteAdminMenuProc(Map<String, Object> pRequestParamMap);
	  
	 

}
