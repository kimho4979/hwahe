/*
package com.fpdisys.admin.login.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.authentication.configurers.GlobalAuthenticationConfigurerAdapter;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

	*/
/**
	 * 独自認証を設定
	 *//*

	@Configuration
	protected static class AuthenticationConfiguration extends GlobalAuthenticationConfigurerAdapter {

		@Autowired
		private WebAuthenticationProvider webAuthenticationProvider;

		@Override
		public void configure(AuthenticationManagerBuilder auth) throws Exception {
			auth.authenticationProvider(webAuthenticationProvider);
		}
	}

	*/
/**
	 * Web Security設定
	 *//*

	@Override
	public void configure(WebSecurity web) throws Exception {
		web.ignoring().antMatchers("/css/**", "/img/**", "/js/**");
	}

	*/
/**
	 * HTTP Security設定
	 *//*

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		WebUsernamePasswordAuthenticationFilter filter = new WebUsernamePasswordAuthenticationFilter();
		// 独自フィルター作成
		filter.setAuthenticationManager(authenticationManager());
		filter.setRequiresAuthenticationRequestMatcher(new AntPathRequestMatcher("/customInfo/loginCustom.do", "POST")); // ログイン時URL
		filter.setAuthenticationSuccessHandler(new SimpleUrlAuthenticationSuccessHandler("/admin/top")); // 成功時URL
		filter.setAuthenticationFailureHandler(new SimpleUrlAuthenticationFailureHandler("/admin/login?error")); // 失敗時URL
		filter.setUsernameParameter("userId"); // ユーザ パラメータ名
		filter.setPasswordParameter("passwd"); // パスワード パラメータ名

		http.authorizeRequests().antMatchers("/customInfo/mainLoginForm.do").permitAll().anyRequest().authenticated();
		http.addFilter(filter);
	}
}*/
