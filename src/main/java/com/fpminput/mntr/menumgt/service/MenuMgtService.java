package com.fpminput.mntr.menumgt.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpminput.mntr.menumgt.mapper.MenuMgtMapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class MenuMgtService extends BaseService {

	@Autowired
	MenuMgtMapper menuMgtMapper;
	
	// 메뉴관리 List
	public List<EgovMap> selectMenuMgtList(){
		return menuMgtMapper.selectMenuMgtList();		
	}
	
	// 메뉴관리 useYn List
	public List<EgovMap> selectMenuMgtUseYnList(Map<String, Object> pRequestParamMap){
		return menuMgtMapper.selectMenuMgtUseYnList(pRequestParamMap);		
	}
	
	// 메뉴관리 입력
	public int insertMenuInput(Map<String, Object> pReqParamMap){
		return menuMgtMapper.insertMenuInput(pReqParamMap);
	}
	
	// 메뉴관리 수정
	public int updateMenuInput(Map<String, Object> pReqParamMap){
		return menuMgtMapper.updateMenuInput(pReqParamMap);
	}
	
	// 그룹관리 삭제 :: menuCd
	public int deleteMenuCdInput(Map<String, Object> pReqParamMap){
		return menuMgtMapper.deleteMenuCdInput(pReqParamMap);
	}
		
	// 그룹관리 삭제 :: menuUpCd
	public int deleteMenuUpCdInput(Map<String, Object> pReqParamMap){
		return menuMgtMapper.deleteMenuUpCdInput(pReqParamMap);
	}
	
	// 메뉴관리 하위 List
	public Map<String, String> selectMenuUnderMgtList(Map<String, Object> pRequestParamMap){
		return menuMgtMapper.selectMenuUnderMgtList(pRequestParamMap);		
	}
	
	// 그룹관리 List
	public List<EgovMap> selectGroupMgtList(Map<String, Object> pRequestParamMap){
		return menuMgtMapper.selectGroupMgtList(pRequestParamMap);		
	}
	
	// 그룹관리 등록
	public int insertGroupMenuInput(Map<String, Object> pReqParamMap){
		return menuMgtMapper.insertGroupMenuInput(pReqParamMap);
	}
	
	// 그룹관리 수정
	public int updateGroupMenuInput(Map<String, Object> pReqParamMap){
		return menuMgtMapper.updateGroupMenuInput(pReqParamMap);
	}
	
	// 그룹관리 삭제
	public int deleteGroupMenuInput(Map<String, Object> pReqParamMap){
		return menuMgtMapper.deleteGroupMenuInput(pReqParamMap);
	}
	
	// 그룹메뉴관리 List
	public List<EgovMap> selectGroupList(Map<String, Object> pRequestParamMap){
		return menuMgtMapper.selectGroupList(pRequestParamMap);		
	}
	
	// 그룹 & 메뉴 Join List
	public List<EgovMap> selectGroupMenuJoinList(Map<String, Object> pRequestParamMap){
		return menuMgtMapper.selectGroupMenuJoinList(pRequestParamMap);		
	}
	
	// 그룹 & 메뉴관리 입력
	public int insertGroupMenuJoinInput(Map<String, Object> pReqParamMap){
		return menuMgtMapper.insertGroupMenuJoinInput(pReqParamMap);
	}
	
	// 그룹 & 메뉴관리 삭제 :: groupCd
	public int deleteGroupMenuJoinInputGroupCd(Map<String, Object> pReqParamMap){
		return menuMgtMapper.deleteGroupMenuJoinInputGroupCd(pReqParamMap);
	}
	
	// 그룹 & 메뉴관리 삭제
	public int deleteGroupMenuJoinInput(Map<String, Object> pReqParamMap){
		return menuMgtMapper.deleteGroupMenuJoinInput(pReqParamMap);
	}
	
	// 비로그인 메인메뉴 List
	public List<EgovMap> selectNoLoginMenuList(Map<String, Object> pRequestParamMap){
		return menuMgtMapper.selectNoLoginMenuList(pRequestParamMap);		
	}
	
}