package com.fpdisys.base.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class XSSFilter implements Filter {
	FilterConfig filterConfig;
	
	public void init(FilterConfig filterConfig) throws ServletException {
		this.filterConfig = filterConfig;
	}
 
	public void destroy() {
		this.filterConfig = null;
	}
 
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		HttpServletRequest req = (HttpServletRequest) request ;
		
		if(excludeUrl(req)){
			chain.doFilter(request, response); //걸러내는 URI일 경우 요청값 그대로 처리
		  }else{
			  chain.doFilter(new XSSRequestWrapper((HttpServletRequest) request), response); //아닐경우 요청값 변경
		  }
	}
	private boolean excludeUrl(HttpServletRequest request) {
		String uri = request.getRequestURI().toString().trim();
		// api 호출
		// 카카오톡 호출메시지
		// 품종별 (관엽 ") 조회
		// 실시간 (관엽 ") 조회
		// 일자별 (관엽 ") 조회
		// 경매기록부 조회
		if(uri.startsWith("/customInfo/")||uri.startsWith("/egov/api/")||uri.startsWith("/biz/")||uri.startsWith("/hab01/")||uri.startsWith("/haa00/")
				||uri.startsWith("/real/")||uri.startsWith("/hab02/")||uri.startsWith("/yuchal/")||uri.startsWith("/menuMgt/")
				||uri.startsWith("/send/")||uri.startsWith("/haa04/")||uri.startsWith("/haa00_new/")||uri.startsWith("/hab11/")){
			return true;
		}else{
			return false;
		}
	 }
}
