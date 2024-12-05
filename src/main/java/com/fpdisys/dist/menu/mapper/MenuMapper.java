package com.fpdisys.dist.menu.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.menu.domain.AuthorizedMenu;
import com.fpdisys.dist.menu.domain.Menu;
import com.fpdisys.dist.menu.domain.MenuVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("MenuMapper")
public interface MenuMapper {
		List<AuthorizedMenu> getAuthorizedMenuByUserCode(String userCode);

		List<Menu> activeMenus();
		
		List<Menu> activeMenusNOTSYSTEM();
		List<Menu> getFindAllByOrderByMnuLvAscMnuIxAsc();
		
		List<AuthorizedMenu> getAuthorizedMenuNoLogin();
		List<AuthorizedMenu> getAuthorizedMenuNoLogin2();
		
		int insertMenu(Map<String, Object> pReqParamMap);
		int updateMenu(Map<String, Object> pReqParamMap);
		Menu findOne(Map<String, Object> pReqParamMap);
		Menu findOne(String mnuCd);
		
		int getMargeMenu(Map<String, Object> pReqParamMap);

		List<?> adminLoginProc(Map<String, Object> pReqParamMap);
		
		List<?> selectMenu(Map<String, Object> pRe);
		
		
		List<MenuVO> selectListForCache();

		int selectMenuIdCnt(String menuId);

		MenuVO select(String menuId);

		
		
		
		String insert(MenuVO menuDTO);

		List<MenuVO> selectListByUpperId(String upperId);

		int selectMaxDepth();

		int update(MenuVO menuDTO);

		int selectSubMenuCnt(String upperId);

		int delete(String menuId);

	//	int updateDisplayBit(Map<String, Object> paramMap);

		List<MenuVO> selectListByProgramId(String[] programId);

	//	EgovMap selectMenuIdByTargetAndProgram(int targetId, String programId);

		List<MenuVO> selectMenuList(String target);

		List<EgovMap> selectContentsMenuList(String programId);

		List<MenuVO> getCacheByUrl(String url);

		List<MenuVO> selectListForCache2();

		List<Map<String, Object>> getCustomInfo(Map pMap);

		int updateAcsYn(Map<String, String> o);

}
