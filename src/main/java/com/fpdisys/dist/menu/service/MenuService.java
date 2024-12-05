package com.fpdisys.dist.menu.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.base.service.CacheService;
import com.fpdisys.base.util.JsonUtils;
import com.fpdisys.dist.menu.domain.AuthorizedMenu;
import com.fpdisys.dist.menu.domain.MainMenu;
import com.fpdisys.dist.menu.domain.Menu;
import com.fpdisys.dist.menu.domain.MenuTreeMap;
import com.fpdisys.dist.menu.domain.MenuVO;
import com.fpdisys.dist.menu.domain.UserMenuInfo;
import com.fpdisys.dist.menu.mapper.MenuMapper;
import com.google.common.collect.Maps;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import net.sf.ehcache.Ehcache;
import net.sf.ehcache.Element;

@Service
public class MenuService extends BaseService {
	protected Log LOG = LogFactory.getLog(this.getClass());	

	@Autowired
	private MenuMapper menuMapper;
	
	//@Resource(name="menuAliasService")
	//private MenuAliasService menuAliasService;
	
	@Resource(name="cacheService")
	private CacheService cacheService;

	// 캐시 메모리 셋팅명
	private String cacheSetAliasName = "menuMem";
	// 캐시 메모리 키명
	private String cacheKeyAliasName = "menuAliasCache";

	// 캐시 메모리 셋팅명
	private String cacheSetName = "menuMem";
	// 캐시 메모리 키명
	private String cacheKeyName = "menuCache";

	
	
	 /**
	  * 메뉴전체 가져오기 
	  * @return
	  */
	 public List<Menu> findActiveMenus() {
		  return menuMapper.activeMenus();
	 }
	
	 /**
	  * 사용자 권한에 따른 메뉴가져오기 
	  * @param userCode
	  * @return
	  */
	 public List<AuthorizedMenu> getAuthorizedMenuList(String userCode) {
			List<AuthorizedMenu> authorizedMenus = menuMapper.getAuthorizedMenuByUserCode(userCode);
			return authorizedMenus;
	}
	 
	 public List<AuthorizedMenu> getAuthorizedMenuListNoLogin() {
			List<AuthorizedMenu> authorizedMenus = menuMapper.getAuthorizedMenuNoLogin();
			return authorizedMenus;
	}
	 public List<AuthorizedMenu> getAuthorizedMenuListNoLogin2() {
			List<AuthorizedMenu> authorizedMenus = menuMapper.getAuthorizedMenuNoLogin2();
			return authorizedMenus;
	}
	 
	 public Map<String, AuthorizedMenu> getAuthorizedMenuMap(String userName) {
			List<AuthorizedMenu> authorizedMenus = getAuthorizedMenuList(userName);
			return toAuthorizedMenuMap(authorizedMenus);
		}
	 
	 public Map<String, AuthorizedMenu> toAuthorizedMenuMap(List<AuthorizedMenu> authorizedMenus) {
			Map map = Maps.newHashMap();

			for(AuthorizedMenu authorizedMenu : authorizedMenus) {
				map.put(authorizedMenu.getMenuCode(), authorizedMenu);
			}

			return map;
	  } 
	 public List<MainMenu> toMainMenuList(List<AuthorizedMenu> authorizedMenus) {
			Map<String, MainMenu> mainMenuMap = Maps.newLinkedHashMap();

			Iterator<AuthorizedMenu> authorizedMenuIterator = authorizedMenus.iterator();

			while (authorizedMenuIterator.hasNext()) {
				AuthorizedMenu authorizedMenu = authorizedMenuIterator.next();

				switch (authorizedMenu.getMenuLevel()) {
					case 1:
						mainMenuMap.put(authorizedMenu.getMenuCode(), new MainMenu(authorizedMenu));
						break;

					case 2:
						MainMenu rootMenu = mainMenuMap.get(authorizedMenu.getParentMenuCode());
						if (rootMenu != null) {
							rootMenu.addChild(authorizedMenu);
						}
						break;
						

					case 3:
						MainMenu secondMenu = null;
						

						for (MainMenu _rootMenu : mainMenuMap.values()) {
							
							for (MainMenu _secondMenu : _rootMenu.getChild()) {
								if (_secondMenu.getId().equals(authorizedMenu.getParentMenuCode())) {
									secondMenu = _secondMenu;
									break;
								}
							}
						}

						if (secondMenu != null) {
							secondMenu.addChild(authorizedMenu);
						}
						break;
				}
			}

			return new ArrayList<>(mainMenuMap.values());
		}
	 
	 
	 public UserMenuInfo getUserMenuInfo(String userName) {
			List<AuthorizedMenu> authorizedMenus = getAuthorizedMenuList(userName);

			Map<String, AuthorizedMenu> authorizedMenuMap = toAuthorizedMenuMap(authorizedMenus);

			List<MainMenu> mainMenuList = toMainMenuList(authorizedMenus);

			String mainMenuJson = JsonUtils.toJson(mainMenuList);

			//return UserMenuInfo.of(authorizedMenuMap, mainMenuList, mainMenuJson, HashUtils.MD5(mainMenuJson));
			return null;
	}
	 public UserMenuInfo getUserMenuInfoNoLogin() {
			List<AuthorizedMenu> authorizedMenus = getAuthorizedMenuListNoLogin();

			Map<String, AuthorizedMenu> authorizedMenuMap = toAuthorizedMenuMap(authorizedMenus);

			List<MainMenu> mainMenuList = toMainMenuList(authorizedMenus);

			String mainMenuJson = JsonUtils.toJson(mainMenuList);

			//return UserMenuInfo.of(authorizedMenuMap, mainMenuList, mainMenuJson, HashUtils.MD5(mainMenuJson));
			return null;
		}	
	 
	 public UserMenuInfo getUserMenuInfoNoLogin2() {
			List<AuthorizedMenu> authorizedMenus = getAuthorizedMenuListNoLogin2();

			Map<String, AuthorizedMenu> authorizedMenuMap = toAuthorizedMenuMap(authorizedMenus);

			List<MainMenu> mainMenuList = toMainMenuList(authorizedMenus);

			String mainMenuJson = JsonUtils.toJson(mainMenuList);

			//return UserMenuInfo.of(authorizedMenuMap, mainMenuList, mainMenuJson, HashUtils.MD5(mainMenuJson));
			return null;
		}	 
	 
	 public List<Menu> getFindAllByOrderByMnuLvAscMnuIxAsc() {
		  return menuMapper.getFindAllByOrderByMnuLvAscMnuIxAsc();
	 }
	 
	 public  int insertMenu(Map<String, Object> pReqParamMap){
		 
		 return menuMapper.insertMenu(pReqParamMap);
	 }
	 
	 
	 public  int updateMenu(Map<String, Object> pReqParamMap){
		 
		 return menuMapper.updateMenu(pReqParamMap);
	 }
	 
	 public  Map<String, Object> menuProc(Map<String, Object> pRequestParamMap){
		 
		 Map<String, Object> resultMap = new HashMap<String, Object>();
		 resultMap.put("opCode", pRequestParamMap.get("opCode"));
		 
		 resultMap.put("mnuCd", pRequestParamMap.get("mnuCd"));
		 resultMap.put("mnuNm", pRequestParamMap.get("mnuNm"));
		 resultMap.put("icon", pRequestParamMap.get("icon"));
		 resultMap.put("mnuLv", pRequestParamMap.get("mnuLv"));
		 resultMap.put("mnuIx", pRequestParamMap.get("mnuIx"));
		 resultMap.put("mnuUpCd", pRequestParamMap.get("mnuUpCd"));
		 resultMap.put("progCd", pRequestParamMap.get("progCd"));
		 resultMap.put("program", pRequestParamMap.get("program"));
		 resultMap.put("remark", pRequestParamMap.get("remark"));
		 resultMap.put("useYn", pRequestParamMap.get("useYn"));
		 
		 
		 
		 resultMap.put("oRetCode","" );
		 resultMap.put("oRetMsg","" );
		 
		 
		 return resultMap;
	 }
	 
	 public int getMargeMenu(Map<String, Object> pReqParamMap){
		 return menuMapper.getMargeMenu(pReqParamMap);
	 }

	public List<?> adminLoginProc(Map<String, Object> pReqParamMap) {
		// TODO Auto-generated method stub
		return menuMapper.adminLoginProc(pReqParamMap);
	}
/*	public ModelAndView selectMenu(Map<String, Object> pRe){
		
		ModelAndView mv = new ModelAndView();
		//mv.setViewName("/inc/2020/IncHeader2");
		//Map<String, Object> resultMap = new HashMap<String, Object>();
		//mv.addObject("list", menuMapper.selectMenu(pRe));
		System.err.println("MenuMapper" + menuMapper);
		mv.setView(new RedirectView("/inc/2020/IncHeader2.do",true));
		return mv;
		
	}
	*/

	/**
	 * 캐싱 실행
	 */
	public void setCacheMenuTree() {
		try {
			LOG.info(":::::::::::::::::: 메뉴 트리 캐싱 수행 시작 ::::::::::::::::::");

			// 캐쉬 데이터 조회
			Ehcache cache = this.cacheService.getCache(this.cacheSetName);
			Element value = cache.get(this.cacheKeyName);

			// 이미 캐쉬에 존재하는 경우 기존 데이터 제거
			if( value != null ) {
				LOG.debug("이미 캐시에 존재하는 경우 기존 캐시 데이터에서 제거함");
				cache.remove(this.cacheKeyName);
			}
			
			List<MenuVO> list = (List<MenuVO>) this.menuMapper.selectListForCache();
			for(int i =0 ; i < list.size(); i++){
				LOG.debug("list 값을 출력함 = " + list.get(i));
			}
			
			if( list != null && list.size() > 0 ) {
				MenuTreeMap menuTreeMap = new MenuTreeMap();
				
				int listCnt = list.size();
				for (int i = 0; i < listCnt; i++) {
					MenuVO menu = (MenuVO) list.get(i);
					// 메뉴 트리맵에 현재 메뉴 정보 삽입
					menuTreeMap.put(menu);
					LOG.debug("menu = " + menu);
				}
				cache.put(new Element(this.cacheKeyName, menuTreeMap));
				LOG.debug("cache = " + cache);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			LOG.info(":::::::::::::::::: 메뉴 트리 캐싱 수행 완료  ::::::::::::::::::");
		}
	}

	/**
	 * 캐싱에 저장된 메뉴 트리 맵 반환
	 */
	public MenuTreeMap getMenuTree() {
		// 캐쉬 데이터 조회
		Ehcache cache = this.cacheService.getCache(this.cacheSetName); //cacheSetName = menuMem
		Element value = cache.get(cacheKeyName);
		LOG.debug("value 값 = " + value);
		// 캐쉬에 존재하지 않는 경우 캐쉬에 새로 저장
		if( value == null ) { // "cacheMenu" 로 저장된 cache가 없으면 재실행하도록 하는 구문이다.
			LOG.info("::::::::::::::::::::::::::: 메뉴 캐싱 재실행 : cacheMenu로 정의된 캐시가 없다.::::::::::::::::::::::::::::::::");
			setCacheMenuTree();
			cache = this.cacheService.getCache(this.cacheSetName);
			value = cache.get(this.cacheKeyName);
		}
		LOG.debug("value.getValue 값 = " + value.getObjectValue());
		LOG.debug("cacheSetName = " + cacheSetName);
		LOG.debug("cacheKeyName = " + cacheKeyName);
		
		MenuTreeMap menuTreeMap = (MenuTreeMap) value.getObjectValue();

		LOG.debug("menuTreeMap = " + menuTreeMap);
		return menuTreeMap;
	}

	/**
	 * 메뉴 아이디에 해당하는 메뉴 정보 반환
	 */
	public MenuVO getByMenuId(String menuId) { 
		//test로 사용되고 있는 itemdaily.do 부분의 menuId 는 50으로 맞게 출력되고 있음
		LOG.info( "메뉴 아이디 지정 조회 by ID [" + menuId + "]" );
		MenuTreeMap menuTreeMap = (MenuTreeMap) getMenuTree();
		return menuTreeMap.getById(menuId);
	}

	/**
	 * 지정 메뉴 아이디가 속해있는 뎁스의 상위 메뉴 객체 정보 반환
	 */
	public MenuVO getUpperMenuVOByMenuIdAndDepth(String menuId, int depth) {
		MenuTreeMap menuTreeMap = getMenuTree();
		MenuVO menuVO = menuTreeMap.getByUpperId(menuId, depth);
		return menuVO;
	}

	/**
	 * 메뉴 ID 카운트 조회
	 */
	public int getMenuIdCnt(String menuId) {
		return this.menuMapper.selectMenuIdCnt(menuId);
	}

	/**
	 * 메뉴 정보 조회
	 */
	public MenuVO getInfo(String menuId) {
		return (MenuVO) this.menuMapper.select(menuId);
	}

	/**
	 * 메뉴 등록 처리
	 */
	public Map<String, Object> create(MenuVO menuDTO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		try {
			// 메뉴 정보 등록
			String result = (String) this.menuMapper.insert(menuDTO);
			LOG.info("menu info insert result >> " + result);
	
			/*// 메뉴 별칭 정보 셋팅
			MenuAliasVO menuAliasVO = new MenuAliasVO();
			menuAliasVO.setMenuId(menuDTO.getMenuId());
			menuAliasVO.setAccessBit(menuDTO.getAccessBit());
			menuAliasVO.setProgramId(menuDTO.getProgramId());
			menuAliasVO.setRegUserId(menuDTO.getRegUserId());
			menuAliasVO.setRegIp(menuDTO.getRegIp());
	
			// 메뉴 별칭 정보 등록 처리
			result = (String) this.menuAliasService.createList(menuAliasVO);
			LOG.info("menu alias info insert result >> " + result);*/
	
			// 캐시 메모리 갱신
			setCacheMenuTree();
		//	this.menuAliasService.setCacheMenuAlias();
	
			resultMap.put("result", true);
		} catch(Exception e) {
			e.printStackTrace();
			resultMap.put("result", false);
		}
		return resultMap;
	}

	/**
	 * 메뉴 목록 조회[상위 메뉴 아이디에 의한]
	 */
	public List<MenuVO> getMenuListByUpperId(String upperId) {
		return (List<MenuVO>) this.menuMapper.selectListByUpperId(upperId);
	}

	/**
	 * 전체 메뉴 최고 단계 정보 조회
	 */
	public int getMaxDepth() {
		return this.menuMapper.selectMaxDepth();
	}

	/**
	 * 메뉴 수정 처리
	 */
	public Map<String, Object> modify(MenuVO menuDTO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		// 기존 메뉴 정보 조회
		//MenuVO oldMenuVO = (MenuVO) getInfo(menuDTO.getMenuId());

		// 수정 처리
		int cnt = this.menuMapper.update(menuDTO);
		LOG.info("menu info update result >> " + cnt);
		resultMap.put("cnt", cnt);

/*		// 프로그램 정보가 변경된 경우 메뉴 별칭 정보 재등록
		if(!menuDTO.getProgramId().equals(oldMenuVO.getProgramId())) {
			// 기존 메뉴 별칭 정보 삭제
			this.menuAliasService.removeList(menuDTO.getMenuId());

			// 메뉴 별칭 정보 셋팅
			MenuAliasVO menuAliasVO = new MenuAliasVO();
			menuAliasVO.setMenuId(menuDTO.getMenuId());
			// 기존 메뉴정보의 출력권한 정보로 기본셋팅함.
			menuAliasVO.setAccessBit(oldMenuVO.getDisplayBit());
			menuAliasVO.setProgramId(menuDTO.getProgramId());
			menuAliasVO.setRegUserId(menuDTO.getModUserId());
			menuAliasVO.setRegIp(menuDTO.getModIp());

			// 신규 메뉴 별칭 정보 등록
//			String result = (String) this.menuAliasService.createList(menuAliasVO);
//			LOG.info("menu alias info insert result >> " + result);
//			resultMap.put("result", result);
		}*/

		// 메뉴명이 변경된 경우 하위 메뉴 경로 정보 변경
		/*if(!menuDTO.getMenuNm().equals(oldMenuVO.getMenuNm())) {
			int pathUpdateCnt = this.menuMapper.updatePathNmInSubMenus(menuDTO);
			LOG.info("menu name path info update result >> " + pathUpdateCnt);
			resultMap.put("pathUpdateCnt", pathUpdateCnt);
		}*/

		// 캐시 메모리 갱신
		setCacheMenuTree();
	//	this.menuAliasService.setCacheMenuAlias();

		return resultMap;
	}

	/**
	 * 하위 메뉴 수 조회
	 */
	public int getSubMenuCnt(String upperId) {
		return this.menuMapper.selectSubMenuCnt(upperId);
	}

	/**
	 * 메뉴 삭제
	 */
	public Map<String, Object> remove(String menuId) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		// 메뉴 별칭 정보 삭제
	//	int cnt = this.menuAliasService.removeList(menuId);
	//	LOG.info("menu alias remove cnt >>> " + cnt);

		// 메뉴 정보 삭제
		//cnt = this.menuMapper.delete(menuId);

		// 캐시 메모리 갱신
		setCacheMenuTree();
	//	this.menuAliasService.setCacheMenuAlias();

//		resultMap.put("cnt", cnt);
		return resultMap;
	}

	/**
	 * 메뉴 출력 권한값 변경
	
	public int modifyDisplayBit(Map<String, Object> paramMap) {
		return this.menuMapper.updateDisplayBit(paramMap);
	}
	 */
	/**
	 * 해당 프로그램 메뉴 목록 조회
	 */
	public List<MenuVO> getListByProgramId(String[] programId) {
		return (List<MenuVO>) this.menuMapper.selectListByProgramId(programId);
	}

	/**
	 * 대상 정보와 프로그램 정보에 의한 메뉴 정보 조회
	public EgovMap getMenuIdByTargetAndProgram(int targetId, String programId) {
		return this.menuMapper.selectMenuIdByTargetAndProgram(targetId, programId);
	}
	*/
	/**
	 * 캐싱에 저장된 메뉴 트리 맵 반환
	 */
	public MenuTreeMap getMenuTree2(String target) {

		// 캐쉬에 존재하지 않는 경우 캐쉬에 새로 저장
		MenuTreeMap menuTreeMap = new MenuTreeMap();
		
		LOG.info( "::::::::::::::::::::::::::: 전체 메뉴 로딩 ::::::::::::::::::::::::::::::::" );
		List<MenuVO> list = (List<MenuVO>) this.menuMapper.selectMenuList(target);

		if( list != null && list.size() > 0 ) {
			int listCnt = list.size();
			for (int i = 0; i < listCnt; i++) {
				MenuVO menu = (MenuVO) list.get(i);
				// 메뉴 트리맵에 현재 메뉴 정보 삽입
				menuTreeMap.put(menu);
			}
		}
		return menuTreeMap;
	}

	public List<EgovMap> getContentsMenuList(String programId) {
		return this.menuMapper.selectContentsMenuList(programId);
	}
	/**
	 * getCacheByUrl
	 * @param url
	 * @return
	 */
	public MenuVO getCacheByUrl(String url){
		MenuVO vo = null;
		try {
			//캐쉬 데이터 조회
			Ehcache cache = this.cacheService.getCache(this.cacheSetAliasName);
			Element value = cache.get(this.cacheKeyAliasName);

			LOG.debug("###################################### = getCacheByURL(" + url + ")");
			if(value==null) {
				LOG.debug("#################################### value = " + value);
				setCacheMenuAlias();
				cache = this.cacheService.getCache(this.cacheSetAliasName);
				value = cache.get(this.cacheKeyAliasName);
			}
			
			@SuppressWarnings("unchecked")
			Map<String, Object> aliasMap = (Map<String, Object>) value.getObjectValue();
			LOG.debug("################################### value.getObjectValue() = " + value.getObjectValue());
			vo = (MenuVO) aliasMap.get(url);
			LOG.debug("#################################### value = " + value);

			LOG.debug("getCacheByUrl 수행완료 vo = " + vo);
		} catch (Exception e) {
			LOG.debug("Exception e 부분 출력");
			e.printStackTrace();
		}
		return vo;
		//return menuMapper.getCacheByUrl(url);
	}
	
	public void setCacheMenuAlias() { 
		try { 
			egovLogger.info(" :::::::::::::: 메뉴 별칭 캐싱 수행 시작 SETCACHEMENUALIAS()::::::::::::::::");
			Ehcache cache = this.cacheService.getCache(this.cacheSetAliasName);
			Element value = cache.get(this.cacheKeyAliasName);
			
			if(value != null) {
				cache.remove(this.cacheKeyAliasName);
			}
			List<MenuVO> list = (List<MenuVO>) this.menuMapper.selectListForCache2();
			/* menuId, url, 설명을 가져오는 쿼리 */
			
			if(list != null && list.size() > 0) {
				Map<String ,Object> aliasMap = new HashMap<String, Object>();
				for(MenuVO vo : list) {
					aliasMap.put(vo.getUrl(), vo);
					LOG.debug("aliasMap = " + aliasMap);
				}
				cache.put(new Element(this.cacheKeyAliasName, aliasMap));
				LOG.debug("cache = " + cache);
			}
		} catch(Exception e) {
			egovLogger.error(e.getMessage(), e);
		} finally {
			egovLogger.info("::::::::::::::: 메뉴 별칭 캐싱 수행 완료 :::::::::::::::::");
		}
	}
	/**
	 * 메뉴 update를 하기 위해서 기존의 cache를 제거하고
	 * 새로운 캐시 별칭을 가져오기 위한 작업
	 * 
	 */
	public void setCacheMenuAliasUpdate() {
		try {
			egovLogger.info(" :::::::::::::: 메뉴 업데이트 별칭 캐싱 수행 시작 ::::::::::::::");
			Ehcache cache = this.cacheService.getCache(this.cacheSetAliasName);
			Element value = cache.get(this.cacheKeyAliasName);
			if(value != null) {
				LOG.debug("캐시에 value 가 있어서 삭제 ");
				cache.remove(this.cacheKeyAliasName);
			}
			List<MenuVO> list = (List<MenuVO>) this.menuMapper.selectListForCache2();
			if(list != null && list.size() > 0) {
				Map<String ,Object> aliasMap = new HashMap<String, Object>();
				for(MenuVO vo : list) {
					aliasMap.put(vo.getUrl(), vo);
					LOG.debug("aliasMap = " + aliasMap);
				}
				cache.put(new Element(this.cacheKeyAliasName, aliasMap));
				LOG.debug("cache = " + cache);
			}
		} catch(Exception e) {
			egovLogger.error(e.getMessage(), e);
		} finally { 
			egovLogger.info(":::::::::::::: 메뉴 업데이트 별칭 캐싱 수행 완료 ::::::::::::::");
		}
	}
	/**
	 * 메뉴 업데이트 시 getByMenuId 할 경우 cache 갱신이 안되서 새로 만들었다.
	 * @param menuId
	 * @return
	 */
	public MenuVO getByMenuIdUpdate(String menuId) {
		LOG.info("getByMenuIdUpdate에 의한 메뉴 아이디 지정 조회 ID [" + menuId + "]");
		MenuTreeMap menuTreeMap = (MenuTreeMap) getMenuTreeUpdate();
		return menuTreeMap.getById(menuId);
	}
	/**
	 * getMenuByMenuIdUpdate에 의해서 트리 개싱을 새롭게 수행하기 위해서 만들어진 메서드
	 * @return
	 */
	private MenuTreeMap getMenuTreeUpdate() {
		Ehcache cache = this.cacheService.getCache(this.cacheSetName);
		Element value = cache.get(cacheKeyName);
		if(value != null) {
			LOG.debug("메뉴 캐시 제거하기");
			cache.remove(this.cacheKeyName);
		}
		setCacheMenuTree();
		cache = this.cacheService.getCache(this.cacheSetName);
		value = cache.get(this.cacheKeyName);

		LOG.debug("value.getValue() 값 = " + value.getObjectValue());
		LOG.debug("cacheSetName = " + cacheSetName);
		LOG.debug("cacheKeyName = " + cacheKeyName);
		
		MenuTreeMap menuTreeMap = (MenuTreeMap) value.getObjectValue();
		return menuTreeMap;
	}

	public List<Map<String,Object>> getCustomInfo(Map pMap) {
		return menuMapper.getCustomInfo(pMap);
	}

	public int updateAcsYn(Map<String, String> o) {
		return menuMapper.updateAcsYn(o);
	}
}
