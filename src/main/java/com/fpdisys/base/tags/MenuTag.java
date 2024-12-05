package com.fpdisys.base.tags;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.lang3.StringUtils;

import com.fpdisys.base.IA;
import com.fpdisys.dist.menu.domain.MenuTreeMap;
import com.fpdisys.dist.menu.domain.MenuVO;
import com.fpdisys.dist.menu.service.MenuService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class MenuTag extends TagSupport {
    private static final long serialVersionUID = 1L;
	protected Log log = LogFactory.getLog(this.getClass());
    private String attributeName;
	private String menuId;
	private boolean upper;
	private Integer selectDepth;
	private MenuTreeMap menuTree;
	private String target;

	public void setAttributeName(String attributeName) {
		this.attributeName = attributeName;
	}
	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
	public void setUpper(boolean upper) {
		this.upper = upper;
	}
	public void setSelectDepth(Integer selectDepth) {
		this.selectDepth = selectDepth;
	}
	public MenuTreeMap getMenuTree() {
		return menuTree;
	}
	public void setMenuTree(MenuTreeMap menuTree) {
		this.menuTree = menuTree;
	}
	public void setTarget(String target) {
		this.target = target;
	}

	public int doStartTag() throws JspException {

		log.debug(" doStart 처음 ");
		if(!StringUtils.isEmpty(this.attributeName)) {
			MenuVO menuVO = null;
			try {
				log.debug("MenuTag.java의  doStartTag() ");
				MenuService menuService = (MenuService) IA.LoadSpringResource.getBeanByAnnotation(pageContext.getSession(), "menuService");
				log.debug("menuService =" + menuService);
				
				/* 캐싱에 저장된 메뉴 트리 맵 반환 */
				this.setMenuTree((MenuTreeMap)menuService.getMenuTree());
				menuVO = (MenuVO) this.menuTree.getById(menuId);
				
				if("all".equals(target)) {
					this.setMenuTree((MenuTreeMap)menuService.getMenuTree2(target));
					menuVO = (MenuVO) this.menuTree.getById(menuId);
					log.debug( "all");
				}
				
				//VOUtil.print(menuVO);
				//상위메뉴 정보 반환인 경우
				if(upper) {
					menuVO = (MenuVO) this.menuTree.getById(menuVO.getUpperId());
					log.debug(" menu Upper 정보 : " + menuVO );
				}

				// 지정 depth 정보가 있는 경우
				if(this.selectDepth != null && this.selectDepth.intValue() > -1) {
					menuVO = this.menuTree.getByUpperId(menuId, this.selectDepth);
					log.debug(" depth정보 : " + menuVO);
				} 
			} catch (Exception e) {
				e.printStackTrace();
			}
			pageContext.setAttribute(this.attributeName, menuVO, PageContext.PAGE_SCOPE);
			log.debug("pageContext = " + pageContext);
			log.debug("attributeName = " + attributeName); // attributeName = depth1MenuVO
		}
		log.debug("EVAL_PAGE = " + EVAL_PAGE);
		return EVAL_PAGE;
	}
}
