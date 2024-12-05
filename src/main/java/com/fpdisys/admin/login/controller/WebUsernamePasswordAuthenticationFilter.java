/*
package com.fpdisys.admin.login.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

public class WebUsernamePasswordAuthenticationFilter extends UsernamePasswordAuthenticationFilter {

	@Override
	public Authentication attemptAuthentication(HttpServletRequest req, HttpServletResponse res)
			throws AuthenticationException {
		
		String user = req.getParameter("userId");
		String password = req.getParameter("passwd");
		
		if(user == null) {
			user = "";
		}
		
		if(password == null) {
			password = "";
		}
	
        // トークンの作成
        UsernamePasswordAuthenticationToken authRequest = new UsernamePasswordAuthenticationToken(user, password);
        
        setDetails(req, authRequest);
        return this.getAuthenticationManager().authenticate(authRequest);
	}
}*/
