package com.fpdisys.dist.customInfo.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class AuthInterceptor extends HandlerInterceptorAdapter {
	
  	protected Log log = LogFactory.getLog(getClass());

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    	if (request.getSession().getAttribute("vaildation") == null || request.getSession().getAttribute("vaildation").equals("")) {
    		request.getSession().removeAttribute("vaildation");
    		ModelAndView modelAndView = new ModelAndView("forward:/customInfo/customInfoRegForm.do");
        	throw new ModelAndViewDefiningException(modelAndView);
    	}
    	
    	String URL = request.getRequestURL().toString();
    	String vaildation = request.getSession().getAttribute("vaildation").toString();
    	Boolean sessionChk = false;
    	

    	if (URL.contains("customInfo/customInfoRegForm2.do") && vaildation.equals("2"))
    		sessionChk = true;
    	if (URL.contains("customInfo/customInfoRegForm3.do") && vaildation.equals("3")){

        	//25.03. 22.4 프로세스 검증 누락 – 취약(1) 반영 
			log.info("------------------>>> auth_result " + request.getSession().getAttribute("auth_result"));
			log.info("------------------>>> user_id " + request.getParameter("userId"));
			log.info("------------------>>> auth_id " + request.getSession().getAttribute("auth_id"));

			if(!((boolean)request.getSession().getAttribute("auth_result")) ||
				!(request.getParameter("userId").equals(request.getSession().getAttribute("auth_id")))) {
					sessionChk = false;
			}else {
				sessionChk = true;
				request.getSession().removeAttribute("vaildation");
			}
			request.getSession().removeAttribute("auth_result");
			// request.getSession().removeAttribute("auth_id");
    	}
    	if(!sessionChk){
    		request.getSession().removeAttribute("vaildation");
    		ModelAndView modelAndView = new ModelAndView("forward:/customInfo/customInfoRegForm.do");
        	throw new ModelAndViewDefiningException(modelAndView);
    	}
    	return true;
   }
    
}
 