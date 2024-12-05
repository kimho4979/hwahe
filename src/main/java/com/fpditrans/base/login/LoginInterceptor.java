package com.fpditrans.base.login;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;




/**
 * @Class Name : LoginInterceptor.java
 * @Description : LoginInterceptor Class
 * @Modification Information
 * @ 로그인 인터셉터  클래스 
 * @  수정일	  수정자			  수정내용
 * @ ---------	---------	-------------------------------
 * @ 2016.08.16			최초생성
 *
 * @author 우림인포텍
 * @since 2016. 03.16
 * @version 1.0
 * @see
 *
 *  Copyright (C) by WOORIM All right reserved.
 */
public class LoginInterceptor extends HandlerInterceptorAdapter 
{

	protected Log log = LogFactory.getLog(this.getClass());	
	
	@Autowired  
	protected MessageSource messageSource; 
	
	/**
	 * controller 이벤트 호출전 
	 */
	@Override
	public boolean preHandle(HttpServletRequest request,
							 HttpServletResponse response, 
							 Object handler) throws IOException 
	{
		log.debug(">>>>>>>>>>>LoginInterceptor >>>>>>>>>>>");
		if ( request.getServletPath().contains("/login/"))
		{
			log.debug(">>>>>>>>>>> contains /login/ ");
			return true;
		}
		//----------------------------------------------------------------
		// Login 되어있는지 check
		//----------------------------------------------------------------
		LoginInfo loginInfo = new LoginInfo(request, response);
		if(!loginInfo.isLogin())
		{
			log.debug(">>>>>>>>>>>>>>>> not login >>>>>>>>>" + request.getRequestURI() + "=="  + request.getServletPath() );

			//----------------------------------------------------------------
			// Login 되어있지 않으면 로그인화면으로 redirect 또는 로그인결과 json 으로 redirect
			//----------------------------------------------------------------
			String uri = request.getRequestURI().toLowerCase();
			if(uri.indexOf(".json") == -1)
			{
				log.debug(">>>>>>>>>>>>>>>>LoginInterceptor -> IsSessionCheckException >>>>>>>>>");
//				throw new IsSessionCheckException();//세션체크
				
				Map<String, String> resultMap = new HashMap<String, String>();
				String  code = messageSource.getMessage("fpdisys.main.rtn_code.SESSION_FINISH", null, Locale.getDefault()) ;
				//String msg = messageSource.getMessage("fpdisys.main.rtn_code.SESSION_FINISH_MSG", null, Locale.getDefault()) ;
				log.debug("CODE = ["+code+"]");
			  
				response.sendRedirect( request.getRequestURI().replace (request.getServletPath(), "" ) + "/login/sessionNullForReturn.do?reqUri=" + request.getServletPath());
			}else{
				log.debug(">>>>>>>>>>>>>>>>LoginInterceptor -> IsSessionCheckAjaxException >>>>>>>>>" + request.getRequestURI() + "=="  + request.getServletPath() + "==>" + request.getRequestURI().replace ( request.getServletPath(), "" ) );
				response.sendRedirect(  request.getRequestURI().replace (request.getServletPath(), "" ) + "/login/sessionNullForAjaxReturn.json");
			}
			return false;

//			ModelAndView mv = new ModelAndView("http://localhost:8080/ktisMvno/cmn/login/sessionNullForAjaxReturn.json"); 
//			ModelAndViewDefiningException mvde = new ModelAndViewDefiningException(mv); 
//			throw mvde; 

		}else{
			//TODO 로그 등록 
		}
	
		return true;
	}
	
	/**
	 * controller 호출 후 view 페이지 출력전 
	 */
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView)	
	{
		try {
			super.postHandle(request, response, handler, modelAndView);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * controller + view 페0ㅣ지 모두 출력 후 
	 */
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)  
	{
		try {
			super.afterCompletion(request, response, handler, ex);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
