package com.fpdisys.dist.login.domain;

import java.util.Collection;
import java.util.Map;

import org.codehaus.jackson.annotate.JsonIgnore;
import org.codehaus.jackson.annotate.JsonProperty;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.fpdisys.dist.menu.domain.AuthorizedMenu;

import lombok.Data;

@Data
public class LoginUser implements UserDetails {
	
	@JsonProperty("username")
	private String username;

	@JsonProperty("password")
	private String password;

	@JsonProperty("userNm")
	private String userNm;

	@JsonProperty("expires")
	private long expires;

	@JsonProperty("companyCode")
	private String companyCode;

	@JsonProperty("companyName")
	private String companyName;

	@JsonProperty("userType")
	private String userType;

	@JsonProperty("menuJsonHash")
	private String menuJsonHash;

	@JsonIgnore
	private Map<String, AuthorizedMenu> authorizedMenuMap;

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return null;
	}

	@Override
	public String getPassword() {
		return password;
	}

	@Override
	public String getUsername() {
		return username;
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
	
	public String getUserNm() {
		return userNm;
	}

	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}

	public long getExpires() {
		return expires;
	}

	public void setExpires(long expires) {
		this.expires = expires;
	}

	public String getCompanyCode() {
		return companyCode;
	}

	public void setCompanyCode(String companyCode) {
		this.companyCode = companyCode;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public String getMenuJsonHash() {
		return menuJsonHash;
	}

	public void setMenuJsonHash(String menuJsonHash) {
		this.menuJsonHash = menuJsonHash;
	}

	public Map<String, AuthorizedMenu> getAuthorizedMenuMap() {
		return authorizedMenuMap;
	}

	public void setAuthorizedMenuMap(Map<String, AuthorizedMenu> authorizedMenuMap) {
		this.authorizedMenuMap = authorizedMenuMap;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public void setPassword(String password) {
		this.password = password;
	}
}

