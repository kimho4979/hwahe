package com.fpdisys.dist.auth.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.menu.domain.AuthGroupMenu;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("authGroupMenuMapper")
public interface AuthGroupMenuMapper {
	
	List<?> findByGrpAuthCd(Map<String, Object> pReqParamMap);
	
	List<?> findByGrpAuthCdPageAble(Map<String, Object> pReqParamMap);
	
	int insertAuthGroupMenu(Map<String, Object> pReqParamMap);
	
	int updateAuthGroupMenu(Map<String, Object> pReqParamMap);
	
	void deleteByGrpAuthCdAndMnuCd(Map<String, Object> pReqParamMap);
	void  deleteByGrpAuthCd(Map<String, Object> pReqParamMap);
	
	List<?> findByMnuCd(Map<String, Object> pReqParamMap);
	
	void saveAuthGroupMenu(AuthGroupMenu authGroupMenu);
	
	
	
	
	

}
