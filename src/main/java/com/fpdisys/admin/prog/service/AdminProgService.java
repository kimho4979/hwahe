package com.fpdisys.admin.prog.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.admin.prog.domain.ProgVO;
import com.fpdisys.admin.prog.mapper.AdminProgMapper;
import com.fpdisys.base.mvc.BaseService;

@Service
public class AdminProgService extends BaseService {
	
	@Autowired
	private AdminProgMapper adminProgMapper;
	
	
	public List<?> selectProgAll(Map<String, Object> pRequestParamMap){
		return adminProgMapper.selectProgAll(pRequestParamMap);
	}
	
	public List<?> selectProgSearch(Map<String, Object> pRequestParamMap){
		return adminProgMapper.selectProgSearch(pRequestParamMap);
	}
	
	public List<?> selectProgSearchPageAble(Map<String, Object> pRequestParamMap){
		return adminProgMapper.selectProgSearchPageAble(pRequestParamMap);
	}
	
	public List<?> getActiveProgSearch(Map<String, Object> pRequestParamMap){
		return adminProgMapper.getActiveProgSearch(pRequestParamMap);
	}
	
	public  int getMergeProg(Map<String, Object> pReqParamMap){
		return adminProgMapper.getAdminMergeProg(pReqParamMap);
	}
	 
	public  ProgVO getProg(Map<String, Object> pReqParamMap){
		return adminProgMapper.getProg(pReqParamMap);
	}

}
