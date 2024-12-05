package com.fpdisys.admin.group.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.admin.group.domain.AdminAuthGrpVO;
import com.fpdisys.admin.group.mapper.AdminAuthGrpMapper;
import com.fpdisys.base.mvc.BaseService;
@Service
public class AdminAuthGrpService extends BaseService {
	@Autowired
	private AdminAuthGrpMapper adminAuthGrpMapper;
	
	public List<?> selectAdminAuthGrpAll(Map<String, Object> pRequestParamMap){
		return adminAuthGrpMapper.selectAdminAuthGrpAll(pRequestParamMap);
	}
	
	public List<?> selectAdminAuthGrpSearch(Map<String, Object> pRequestParamMap){
		return adminAuthGrpMapper.selectAdminAuthGrpSearch(pRequestParamMap);
	}
	
	public List<?> selectAdminAuthGrpSearchPageAble(Map<String, Object> pRequestParamMap){
		return adminAuthGrpMapper.selectAdminAuthGrpSearchPageAble(pRequestParamMap);
	}
	
	public AdminAuthGrpVO getAdminAuthGrpOne(Map<String, Object> pRequestParamMap){
		return adminAuthGrpMapper.getAdminAuthGrpOne(pRequestParamMap);
	}
	
	public int insertAdminAuthGrp(Map<String, Object> pRequestParamMap){
		return adminAuthGrpMapper.insertAdminAuthGrp(pRequestParamMap);
	}
	
	public int updateAdminAuthGrp(Map<String, Object> pRequestParamMap){
		return adminAuthGrpMapper.updateAdminAuthGrp(pRequestParamMap);
	}
	
	public int getMargeAdminAuthGrp(Map<String, Object> pRequestParamMap){
		return adminAuthGrpMapper.getMargeAdminAuthGrp(pRequestParamMap);
	}
	
	public List<?> selectActiveAdminAuthGrp(Map<String, Object> pRequestParamMap){
		return adminAuthGrpMapper.selectActiveAdminAuthGrp(pRequestParamMap);
	}

}
