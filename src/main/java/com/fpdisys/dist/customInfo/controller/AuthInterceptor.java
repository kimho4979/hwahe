package com.fpdisys.dist.customInfo.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AuthInterceptor extends HandlerInterceptorAdapter {
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
    		sessionChk = true;
    		request.getSession().removeAttribute("vaildation");
    	}
    	if(!sessionChk){
    		request.getSession().removeAttribute("vaildation");
    		ModelAndView modelAndView = new ModelAndView("forward:/customInfo/customInfoRegForm.do");
        	throw new ModelAndViewDefiningException(modelAndView);
    	}
    	return true;
   }
    
}
 