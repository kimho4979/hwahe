package com.fpdisys.base.util;

import com.fpdisys.dist.menu.domain.AuthorizedMenu;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class JspPageInfo {
	

	private AuthorizedMenu authorizedMenu;
	
	private String pageId;

	private boolean authorized = true;

	private String menuName = "";

	private String menuRemark = "";

	private String programName = "";
	
	private String parentMenuCode ="";

	private String searchAuth = null;

	private String saveAuth = null;

	private String excelAuth = null;

	private String className = null;

	private String function1Auth = null;

	private String function2Auth = null;

	private String function3Auth = null;

	private String function4Auth = null;

	private String function5Auth = null;
		
		  
	public AuthorizedMenu getAuthorizedMenu() {
		return authorizedMenu;
	}

	public void setAuthorizedMenu(AuthorizedMenu authorizedMenu) {
		this.authorizedMenu = authorizedMenu;
	}

	public String getPageId() {
		return pageId;
	}

	public void setPageId(String pageId) {
		this.pageId = pageId;
	}

	public boolean isAuthorized() {
		return authorized;
	}

	public void setAuthorized(boolean authorized) {
		this.authorized = authorized;
	}

	public String getMenuName() {
		return menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public String getMenuRemark() {
		return menuRemark;
	}

	public void setMenuRemark(String menuRemark) {
		this.menuRemark = menuRemark;
	}

	public String getProgramName() {
		return programName;
	}

	public void setProgramName(String programName) {
		this.programName = programName;
	}

	public String getParentMenuCode() {
		return parentMenuCode;
	}

	public void setParentMenuCode(String parentMenuCode) {
		this.parentMenuCode = parentMenuCode;
	}

	public String getSearchAuth() {
		return searchAuth;
	}

	public void setSearchAuth(String searchAuth) {
		this.searchAuth = searchAuth;
	}

	public String getSaveAuth() {
		return saveAuth;
	}

	public void setSaveAuth(String saveAuth) {
		this.saveAuth = saveAuth;
	}

	public String getExcelAuth() {
		return excelAuth;
	}

	public void setExcelAuth(String excelAuth) {
		this.excelAuth = excelAuth;
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public String getFunction1Auth() {
		return function1Auth;
	}

	public void setFunction1Auth(String function1Auth) {
		this.function1Auth = function1Auth;
	}

	public String getFunction2Auth() {
		return function2Auth;
	}

	public void setFunction2Auth(String function2Auth) {
		this.function2Auth = function2Auth;
	}

	public String getFunction3Auth() {
		return function3Auth;
	}

	public void setFunction3Auth(String function3Auth) {
		this.function3Auth = function3Auth;
	}

	public String getFunction4Auth() {
		return function4Auth;
	}

	public void setFunction4Auth(String function4Auth) {
		this.function4Auth = function4Auth;
	}

	public String getFunction5Auth() {
		return function5Auth;
	}

	public void setFunction5Auth(String function5Auth) {
		this.function5Auth = function5Auth;
	}

	
	public static JspPageInfo of(String pageId, AuthorizedMenu authorizedMenu) {
		JspPageInfo jspPageInfo = new JspPageInfo();
		jspPageInfo.setPageId(pageId);

		if(authorizedMenu == null) {
			if(jspPageInfo.isAuthSkip(pageId) == false) {
				jspPageInfo.setAuthorized(false);
			}
		} else {
			jspPageInfo.setMenuName(authorizedMenu.getMenuName());
			jspPageInfo.setMenuRemark("");
			jspPageInfo.setProgramName(authorizedMenu.getProgramName());
			jspPageInfo.setSearchAuth(setAuth(authorizedMenu.getSearchAuth()));
			jspPageInfo.setSaveAuth(setAuth(authorizedMenu.getSaveAuth()));
			jspPageInfo.setExcelAuth(setAuth(authorizedMenu.getExcelAuth()));
			jspPageInfo.setFunction1Auth(setAuth(authorizedMenu.getFunction1Auth()));
			jspPageInfo.setFunction2Auth(setAuth(authorizedMenu.getFunction2Auth()));
			jspPageInfo.setFunction3Auth(setAuth(authorizedMenu.getFunction3Auth()));
			jspPageInfo.setFunction4Auth(setAuth(authorizedMenu.getFunction4Auth()));
			jspPageInfo.setFunction5Auth(setAuth(authorizedMenu.getFunction5Auth()));
			jspPageInfo.setClassName(authorizedMenu.getRemark());
			jspPageInfo.setParentMenuCode(authorizedMenu.getParentMenuCode());
		}

		return jspPageInfo;
	}

	public boolean isAuthSkip(String pageId) {
		switch(pageId.trim()) {
			case "main" :
			case "login" :
				return true;
		}

		return false;
	}
	
	public static String setAuth(String value) {
		if(value != null && value.equals("Y")) {
			return "Y";
		}
		return null;
	}
	
	
}


