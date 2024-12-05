package com.fpminput.mntr.menumgt.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("menuMgtMapper")
public interface MenuMgtMapper {
	
	List<EgovMap> selectMenuMgtList();
	
	List<EgovMap> selectMenuMgtUseYnList(Map<String, Object> pRequestParamMap);
	
	int insertMenuInput(Map<String, Object> pReqParamMap);
	
	int updateMenuInput(Map<String, Object> pReqParamMap);
	
	int deleteMenuCdInput(Map<String, Object> pReqParamMap);
	
	int deleteMenuUpCdInput(Map<String, Object> pReqParamMap);
	
	Map<String, String> selectMenuUnderMgtList(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectGroupMgtList(Map<String, Object> pRequestParamMap);
	
	int insertGroupMenuInput(Map<String, Object> pReqParamMap);
	
	int updateGroupMenuInput(Map<String, Object> pReqParamMap);
	
	int deleteGroupMenuInput(Map<String, Object> pReqParamMap);
	
	List<EgovMap> selectGroupList(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectGroupMenuJoinList(Map<String, Object> pRequestParamMap);
	
	int insertGroupMenuJoinInput(Map<String, Object> pReqParamMap);
	
	int deleteGroupMenuJoinInput(Map<String, Object> pReqParamMap);
	
	int deleteGroupMenuJoinInputGroupCd(Map<String, Object> pReqParamMap);
	
	List<EgovMap> selectNoLoginMenuList(Map<String, Object> pRequestParamMap);

}