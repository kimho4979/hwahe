package com.fpditrans.base.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import com.fpditrans.base.filter.XSSRequestWrapper;

/**
 * @Class Name : XSSFilter.java
 * @Description : XSSFilter Class
 * @Modification Information
 * @
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

public class XSSFilter implements Filter 
{
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
	}
 
	@Override
	public void destroy() {
	}
 
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
		throws IOException, ServletException {
		chain.doFilter(new XSSRequestWrapper((HttpServletRequest) request), response);
	}

	/*
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
		throws IOException, ServletException {
 
		chain.doFilter(new RequestWrapper((HttpServletRequest) request), response);
	}
	*/
}
