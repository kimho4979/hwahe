package com.fpdisys.admin.faq.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.admin.faq.domain.AdminBbsFileVO;
import com.fpdisys.admin.faq.domain.AdminBbsVO;
import com.fpdisys.admin.faq.mapper.AdminBbsMapper;
import com.fpdisys.base.mvc.BaseService;

@Service
public class AdminBbsService extends BaseService {
	@Autowired
	AdminBbsMapper adminBbsMapper;
	

	public List<?> selectAdminBbsAll(Map<String, Object> pRequestParamMap){
		return adminBbsMapper.selectAdminBbsAll(pRequestParamMap);
	}
	
	public List<?> selectAdminBbsSearch(Map<String, Object> pRequestParamMap){
		return adminBbsMapper.selectAdminBbsSearch(pRequestParamMap);
	}
	
	public List<?> selectAdminBbsSearchPageAble(Map<String, Object> pRequestParamMap){
		return adminBbsMapper.selectAdminBbsSearchPageAble(pRequestParamMap);
	}
	
	public List<?> selectAdminBbsFileSearch(Map<String, Object> pRequestParamMap){
		return adminBbsMapper.selectAdminBbsFileSearch(pRequestParamMap);
	}
	
	public AdminBbsVO findBbsOne(Map<String, Object> pRequestParamMap){
		return adminBbsMapper.findBbsOne(pRequestParamMap);
	}
	
	public AdminBbsFileVO findBbsFileOne(Map<String, Object> pRequestParamMap){
		return adminBbsMapper.findBbsFileOne(pRequestParamMap);
	}
	
	
	public void insertAdminFaq(Map<String, Object> pRequestParamMap){
		adminBbsMapper.insertAdminFaq(pRequestParamMap);
	}
	
	public void updateAdminFaq(Map<String, Object> pRequestParamMap){
		adminBbsMapper.updateAdminFaq(pRequestParamMap);
	}

	public void deleteAdminFaq(Map<String, Object> pRequestParamMap) {
		adminBbsMapper.deleteAdminFaq(pRequestParamMap);
		
	}
}
