package com.fpdisys.dist.auth.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.auth.mapper.AuthGroupMenuMapper;
import com.fpdisys.dist.menu.domain.AuthGroupMenu;
import com.fpdisys.dist.menu.domain.Menu;
import com.fpdisys.dist.menu.mapper.MenuMapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class AuthGroupMenuService extends BaseService {
	@Autowired
	private MenuMapper menuMapper;
	
	@Autowired
	private AuthGroupMenuMapper authGroupMenuMapper;
	
	 @Transactional
		public void deleteByGrpAuthCdAndMnuCd(String grpAuthCd, String mnuCd) {
		  Map<String, Object> resultMap = new HashMap<String, Object>();
		  resultMap.put("grpAuthCd",  grpAuthCd);
		  resultMap.put("mnuCd", mnuCd);
		  
		  authGroupMenuMapper.deleteByGrpAuthCdAndMnuCd(resultMap);		 
		 
		}
	 
	 public void deleteByGrpAuthCd(String grpAuthCd) {
		  Map<String, Object> resultMap = new HashMap<String, Object>();
		  resultMap.put("grpAuthCd",  grpAuthCd);
		
		  
		  authGroupMenuMapper.deleteByGrpAuthCd(resultMap);		 
		 
		}
	 
		
	 @Transactional
		public void deleteByGrpAuthCdAndMnuCds(String grpAuthCd, List<String> mnuCds) {
			for(String mnuCd : mnuCds) {
				deleteByGrpAuthCdAndMnuCd(grpAuthCd, mnuCd);
			}
		}
	 
	 public List<?> findByGrpAuthCd(Map<String, Object> pReqParamMap) {
		 
		 List<AuthGroupMenu> resultList =  (List<AuthGroupMenu>)authGroupMenuMapper.findByGrpAuthCd(pReqParamMap);  
		 
		 return resultList;
	 }
	 
	 public List<?> findByGrpAuthCdPageAble(Map<String, Object> pReqParamMap) {
		 
		 List<EgovMap> resultList =  (List<EgovMap>)authGroupMenuMapper.findByGrpAuthCdPageAble(pReqParamMap);  
		 
		 return resultList;
	 }
	 
	 
	 @Transactional
		public void saveGroupMenus(List<AuthGroupMenu> authGroupMenuList) {
			for (AuthGroupMenu authGroupMenu : authGroupMenuList) {
				String mnuCd = authGroupMenu.getMnuCd();


				// TODO : 너무 귀찮아서 일단 2번 조회..ㅋㅋ
				Menu parent = menuMapper.findOne(mnuCd);

				if (StringUtils.isEmpty(parent.getMnuUpCd()) == false && parent.getMnuUpCd().contains("_root_") == false) {
					AuthGroupMenu parentAuthGroupMenu = new AuthGroupMenu();
					parentAuthGroupMenu.setMnuCd(parent.getMnuUpCd());
					parentAuthGroupMenu.setGrpAuthCd(authGroupMenu.getGrpAuthCd());
					parentAuthGroupMenu.setSchAh("N");
					parentAuthGroupMenu.setSavAh("N");
					parentAuthGroupMenu.setExlAh("N");
					parentAuthGroupMenu.setFn1Ah("N");
					parentAuthGroupMenu.setFn2Ah("N");
					parentAuthGroupMenu.setFn3Ah("N");
					parentAuthGroupMenu.setFn4Ah("N");
					parentAuthGroupMenu.setFn5Ah("N");

					saveAuthGroupMenu(parentAuthGroupMenu);

					parent = menuMapper.findOne(parent.getMnuUpCd());

					if (StringUtils.isEmpty(parent.getMnuUpCd()) == false && parent.getMnuUpCd().contains("_root_") == false) {
						parentAuthGroupMenu = new AuthGroupMenu();
						parentAuthGroupMenu.setMnuCd(parent.getMnuUpCd());
						parentAuthGroupMenu.setGrpAuthCd(authGroupMenu.getGrpAuthCd());
						parentAuthGroupMenu.setSchAh("N");
						parentAuthGroupMenu.setSavAh("N");
						parentAuthGroupMenu.setExlAh("N");
						parentAuthGroupMenu.setFn1Ah("N");
						parentAuthGroupMenu.setFn2Ah("N");
						parentAuthGroupMenu.setFn3Ah("N");
						parentAuthGroupMenu.setFn4Ah("N");
						parentAuthGroupMenu.setFn5Ah("N");

						saveAuthGroupMenu(parentAuthGroupMenu);
					}
				}

				saveAuthGroupMenu(authGroupMenu);
			}
		}
	 
	 public void saveAuthGroupMenu(AuthGroupMenu authGroupMenu){
		 authGroupMenuMapper.saveAuthGroupMenu(authGroupMenu);
	 }
	 
	 
}
