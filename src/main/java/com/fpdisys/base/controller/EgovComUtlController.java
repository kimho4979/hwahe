package com.fpdisys.base.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.rte.fdl.property.EgovPropertyService;


@Controller
public class EgovComUtlController {
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/**
	 * JSP 호출작업만 처리하는 공통 함수
	 */
	/*
	@RequestMapping(value = "/EgovPageLink.do")
	public String moveToPage(@RequestParam("link") String linkPage, HttpSession session, @RequestParam(value = "baseMenuNo", required = false) String baseMenuNo) {
		String link = linkPage;
		// service 사용하여 리턴할 결과값 처리하는 부분은 생략하고 단순 페이지 링크만 처리함
		if (linkPage == null || linkPage.equals("")) {
			link = "cmm/egovError";
		} else {
			if (link.indexOf(",") > -1) {
				link = link.substring(0, link.indexOf(","));
			}
		}
		// 선택된 메뉴정보를 세션으로 등록한다.
		//if (baseMenuNo != null && !baseMenuNo.equals("") && !baseMenuNo.equals("null")) {
		//	session.setAttribute("baseMenuNo", baseMenuNo);
		//}
		return link;
	}*/

	/**
	 * JSP 호출작업만 처리하는 공통 함수
	 */
	@RequestMapping(value = "/EgovPageLink.action")
	public String moveToPage_action(@RequestParam("link") String linkPage) {
		String link = linkPage;
		// service 사용하여 리턴할 결과값 처리하는 부분은 생략하고 단순 페이지 링크만 처리함
		if (linkPage == null || linkPage.equals("")) {
			link = "cmm/egovError";
		}
		return link;
	}

	/**
	 * validation rule dynamic java script
	 */
	@RequestMapping("/validator.do")
	public String validate() {
		return "cmm/validator";
	}
	
}
