package com.fpdisys.admin.faq.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.admin.faq.domain.AdminBbsFileVO;


import com.fpdisys.admin.faq.domain.AdminBbsVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("adminBbsMapper")
public interface AdminBbsMapper {
	
	List<?> selectAdminBbsAll(Map<String, Object> pRequestParamMap);
	
	List<?> selectAdminBbsSearch(Map<String, Object> pRequestParamMap);
	
	List<?> selectAdminBbsSearchPageAble(Map<String, Object> pRequestParamMap);
	
	List<?> selectAdminBbsFileSearch(Map<String, Object> pRequestParamMap);
	
	AdminBbsVO findBbsOne(Map<String, Object> pRequestParamMap);
	
	AdminBbsFileVO findBbsFileOne(Map<String, Object> pRequestParamMap);
	
	void insertAdminFaq(Map<String, Object> pRequestParamMap);
	
	void updateAdminFaq(Map<String, Object> pRequestParamMap);

	void deleteAdminFaq(Map<String, Object> pRequestParamMap);

}
