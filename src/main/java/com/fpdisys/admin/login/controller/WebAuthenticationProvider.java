/*
package com.fpdisys.admin.login.controller;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationCredentialsNotFoundException;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.util.ObjectUtils;


@Configuration
@EnableWebSecurity
public class WebAuthenticationProvider implements AuthenticationProvider {

	@Override
	public Authentication authenticate(Authentication auth) throws AuthenticationException {
		String user = auth.getPrincipal().toString();
		String password = auth.getCredentials().toString();
		
		if (ObjectUtils.isEmpty(user)) {
			throw new AuthenticationCredentialsNotFoundException("ユーザー名もしくはパスワードに誤りがあります。");
		}

		if (ObjectUtils.isEmpty(password)) {
			throw new AuthenticationCredentialsNotFoundException("ユーザー名もしくはパスワードに誤りがあります。");
		}
		
		if (!user.equals("user")) {
			throw new AuthenticationCredentialsNotFoundException("ユーザー名もしくはパスワードに誤りがあります。");
		}

		if (!password.equals("pass")) {
			throw new AuthenticationCredentialsNotFoundException("ユーザー名もしくはパスワードに誤りがあります。");
		}
		
        Collection<GrantedAuthority> authorityList = new ArrayList<>();
        authorityList.add(new SimpleGrantedAuthority("ROLE_ADMIN"));

		// トークンを返却
		return new UsernamePasswordAuthenticationToken(user, password,authorityList);
	}

	@Override
	public boolean supports(Class<?> token) {
		return UsernamePasswordAuthenticationToken.class.isAssignableFrom(token);
	}

}*/
