package com.fpdisys.admin.menu.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.admin.menu.domain.AdminMenuVO;
import com.fpdisys.admin.menu.mapper.AdminMenuMapper;
import com.fpdisys.base.mvc.BaseService;

@Service
public class AdminMenuService extends BaseService {
	@Autowired
	private AdminMenuMapper adminMenuMapper;
	
	public  List<?> getFindAllByOrderByMnuLvAscMnuIxAsc(Map<String, Object> pRequestParamMap){
		return adminMenuMapper.getFindAllByOrderByMnuLvAscMnuIxAsc(pRequestParamMap);
	}
	public List<?> activeAdminMenus(Map<String, Object> pRequestParamMap){
		return adminMenuMapper.activeAdminMenus(pRequestParamMap);
	}
	
	 public int insertAdminMenu(Map<String, Object> pReqParamMap){
		 return adminMenuMapper.insertAdminMenu(pReqParamMap);
	 }
	 
	 public int updateAdminMenu(Map<String, Object> pReqParamMap){
		 return adminMenuMapper.updateAdminMenu(pReqParamMap);
	 }
	 
	 public AdminMenuVO findAdminMenuOne(Map<String, Object> pReqParamMap){
		 return adminMenuMapper.findAdminMenuOne(pReqParamMap);
	 }
	 
	 public int getAdminMargeMenu(Map<String, Object> pReqParamMap){
		 return adminMenuMapper.getAdminMargeMenu(pReqParamMap);
	 }
	public void deleteAdminMenuProc(Map<String, Object> pRequestParamMap) {
		 adminMenuMapper.deleteAdminMenuProc(pRequestParamMap);
		
	}
	  

}
