package com.fpditrans.trans.login.domain;

import java.util.Collection;
import java.util.Map;

import org.codehaus.jackson.annotate.JsonIgnore;
import org.codehaus.jackson.annotate.JsonProperty;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Data;
/**
 * @Class Name : UserVO.java
 * @Description : UserVO Class
 *	 
 * @  회원정보  도메인 클래스 
 * @  수정일	  수정자			  수정내용
 * @ ---------	---------	-------------------------------
 * @ 2016.08.03			최초생성
 *
 * @author 우림인포텍
 * @version 1.0
 * @see
 * 
 * Copyright (C) by woorim All right reserved.
 */


@Data
public class LoginUser implements UserDetails {

	@JsonProperty("username")
	private String username;

	@JsonProperty("password")
	private String password;
	
	@JsonProperty("userType")
	private String userType;
	
	@JsonProperty("compCode")
	private String compCode;
	
	@JsonProperty("compCode")
	private String compName;
	
	
	@Override
	public String getPassword() {
		return password;
	}

	@Override
	public String getUsername() {
		return username;
	}
	
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return null;
	}
	
	 @Override
		@JsonIgnore
		public boolean isAccountNonExpired() {
			return true;
		}

		@Override
		@JsonIgnore
		public boolean isAccountNonLocked() {
			return true;
		}

		@Override
		@JsonIgnore
		public boolean isCredentialsNonExpired() {
			return true;
		}

		@Override
		@JsonIgnore
		public boolean isEnabled() {
			return true;
		}

		

}
