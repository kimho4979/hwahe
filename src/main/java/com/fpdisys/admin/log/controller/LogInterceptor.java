package com.fpdisys.admin.log.controller;

import java.util.HashMap;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.PageContext;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.log4j.Logger;
import org.apache.logging.log4j.LogManager;
import org.springframework.util.StringUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.fpdisys.admin.log.service.UserLogService;
import com.fpdisys.dist.menu.domain.MenuVO;
import com.fpdisys.dist.menu.service.MenuService;
import com.ibm.icu.util.Calendar;
import com.ibm.icu.util.GregorianCalendar;

public class LogInterceptor implements HandlerInterceptor {
	 
	@Resource
	public UserLogService userLogService;
	
	@Resource
	public MenuService menuService;
	
	protected Log log = LogFactory.getLog(this.getClass());	
	@Override
	public void afterCompletion(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		
		// TODO Auto-generated method stub
		
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {
	}

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object arg2) throws Exception {
			return true;
			/*int nYear;int nMonth;int nDay;
			//String requestURI = request.getRequestURI();
			String requestURI = "/main/flowerMain.do";
			System.err.println(request.getRemoteHost());
			
			Calendar calendar = new GregorianCalendar(Locale.KOREA);
			nYear = calendar.get(Calendar.YEAR);
			nMonth = calendar.get(Calendar.MONTH) + 1;
			nDay = calendar.get(Calendar.DAY_OF_MONTH);
			System.out.println("GregorianCalendar = " + nYear + "-" + nMonth + "-" + nDay);
			
			HashMap<String , Object> map = new HashMap<String, Object>();
			map.put("USER_IP", request.getRemoteHost());
			map.put("MENU_ID",requestURI);
			
			System.err.println(requestURI);
			userLogService.InsertLog(map);
			try{
				log.debug(" ############################## RequestURI : " + requestURI);
				MenuVO currentMenuVO = menuService.getCacheByUrl(requestURI); //menuAlias 갔다오는 부분입니다.
				MenuVO currentMenuInfo = null;
				try {
					currentMenuInfo = this.menuService.getByMenuId(currentMenuVO.getMenuId()); //menu 갔다오는 부분
					log.debug("## menuId : " + currentMenuVO.getMenuId() + ", menuNm : " + currentMenuInfo.getMenuNm());
				
				} catch (Exception e) {
					e.printStackTrace();
				}
				request.setAttribute("currentMenuInfo", currentMenuInfo);
				log.debug("## 메뉴 정보 View setAttribute : " + System.currentTimeMillis());
				System.out.println(RequestContextHolder.currentRequestAttributes().getAttribute("javax.servlet.forward.request_uri", PageContext.PAGE_SCOPE));
				log.debug("################################################LogInterceptor Finish#############");
			} catch (Exception e) {
				e.printStackTrace();
			} 
		return true;*/
	}
}
