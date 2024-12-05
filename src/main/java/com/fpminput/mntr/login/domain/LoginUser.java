package com.fpminput.mntr.login.domain;

import java.util.Collection;

import lombok.Data;

import org.codehaus.jackson.annotate.JsonIgnore;
import org.codehaus.jackson.annotate.JsonProperty;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

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
