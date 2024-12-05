package com.fpdisys.admin.prog.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.admin.prog.domain.ProgVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("adminProgMapper")
public interface AdminProgMapper {
	List<?> selectProgAll(Map<String, Object> pRequestParamMap);
	
	List<?> selectProgSearch(Map<String, Object> pRequestParamMap);
	
	List<?> selectProgSearchPageAble(Map<String, Object> pRequestParamMap);
	
	List<?> getActiveProgSearch(Map<String, Object> pRequestParamMap);
	
	 int getAdminMergeProg(Map<String, Object> pReqParamMap);
	 
	 ProgVO getProg(Map<String, Object> pReqParamMap);
	
	

}
