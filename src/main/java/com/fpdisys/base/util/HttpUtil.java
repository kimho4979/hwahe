package com.fpdisys.base.util;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;

import com.fpditrans.trans.login.domain.UserVO;

 
/**
 * <pre>
 * wenbiz.core.util
 * HttpUtil.java
 * </pre>
 * @author mskim
 * @description 리퀘스트 유틸
 * @since 2017. 6. 20.
 * @version 1.0
 */
public class HttpUtil {
	private final HttpServletRequest request;
	private String siteType = "";

	public HttpUtil(HttpServletRequest request) {
		this.request = request;

		String[] requestURIs = request.getRequestURI().split("/");
		if (requestURIs[ConstantsMap.URI_INDEX.MENU_ID].indexOf(ConstantsMap.SITE_PREFIX.FRONT) > -1) {
			siteType = ConstantsMap.SITE_PREFIX.FRONT;
		} else if (requestURIs[ConstantsMap.URI_INDEX.MENU_ID].indexOf(ConstantsMap.SITE_PREFIX.MOBILE) > -1) {
			siteType = ConstantsMap.SITE_PREFIX.MOBILE;
		} else {
			siteType = ConstantsMap.SITE_PREFIX.ADMIN;
		}
	}

	/**
	 * 현재 접근URL이 Front 인지 Admin인지 반환
	 * <pre>
	 * 메소드명 : getSiteType
	 * 작성일 : 2017. 7. 27.
	 * 작성자 : swchoi
	 * 설명 :
	 * </pre>
	 * @return
	 */
	public String getSiteType() {
		return siteType;
	}

	/**
	 * 로그인여부 반환
	 * @return
	 */
	public boolean isLogin() {

		if (siteType.equals(ConstantsMap.SITE_PREFIX.FRONT)) {
			if (this.getPortalUser() == null) {
				return false;
			} else {
				return true;
			}
		} else {
			if (this.getAdminUser() == null) {
				return false;
			} else {
				return true;
			}
		}
	}

	public UserVO getUser() {
		UserVO user = null;
		if (siteType.equals(ConstantsMap.SITE_PREFIX.FRONT) || siteType.equals(ConstantsMap.SITE_PREFIX.MOBILE)) {
			if (request.getSession() != null) {
				user = (UserVO) request.getSession().getAttribute(ConstantsMap.SESSION_KEY.userLoginVO.toString());
			}
		} else {
			if (request.getSession() != null) {
				user = (UserVO) request.getSession().getAttribute(ConstantsMap.SESSION_KEY.adminLoginVO.toString());
			}
		}
		return user;
	}

	/**
	 * 포털사용자 정보 반환
	 * @return
	 */
	public UserVO getPortalUser() {
		UserVO user = null;

		if (request.getSession() != null) {
			user = (UserVO) request.getSession().getAttribute(ConstantsMap.SESSION_KEY.userLoginVO.toString());
		}
		return user;
	}

	/**
	 * 관리자 사용자 정보반환
	 * @return
	 */
	public UserVO getAdminUser() {
		UserVO user = null;

		if (request.getSession() != null) {
			user = (UserVO) request.getSession().getAttribute(ConstantsMap.SESSION_KEY.adminLoginVO.toString());
		}
		return user;
	}


	/**
	 * <pre>
	 * 메소드명 : goUrl
	 * 작성일 : 2017. 6. 20.
	 * 작성자 : mskim
	 * 설명 :
	 * </pre>
	 * @param response
	 * @param url
	 * @param msg
	 */
	public void goUrl(HttpServletResponse response, String url, String msg) {
		try {
			response.setContentType("text/html; charset=" + this.request.getCharacterEncoding());
			PrintWriter out = response.getWriter();
			out.write("<!DOCTYPE html>");
			out.write("<html lang=\"ko\">");
			out.write("	<head>");
			out.write("		<meta http-equiv=\"Content-Type\" content=\"text/html; charset="+this.request.getCharacterEncoding()+"\">");
			out.write("		<meta http-equiv=\"Expires\" content=\"0\">");
			out.write("		<meta http-equiv=\"Pragma\" content=\"no-cache\">");
			out.write("		<meta http-equiv=\"Cache-Control\" content=\"No-Cache\">");
			out.write("		<meta http-equiv=\"refresh\" content=\"0; url=" + url + "\">");
			out.write("		<title>Postplus</title>");
			out.write("		<script language='JavaScript'>");
			if(msg != null && !"".equals(msg)) {
				out.write("			alert(\"" + msg + "\");");
			}
			if(url == null) {
				out.write("			history.back();");
			}
			out.write("		</script>");
			out.write("	</head>");
			out.write("</html>");
			out.flush();
			out.close();
		} catch (java.io.IOException e) {
			e.printStackTrace();
		}
	}


	/**
	 * <pre>
	 * 메소드명 : getQueryString
	 * 작성일 : 2017. 6. 20.
	 * 작성자 : mskim
	 * 설명 :
	 * </pre>
	 * @param excepts
	 * @return
	 */
	public String getQueryString(String[] excepts) {
		return getQueryString(this.request.getQueryString(), excepts);
	}

	/**
	 * <pre>
	 * 메소드명 : getQueryString
	 * 작성일 : 2017. 6. 20.
	 * 작성자 : mskim
	 * 설명 :
	 * </pre>
	 * @param queryString
	 * @param excepts
	 * @return
	 */
	public String getQueryString(String queryString, String[] excepts) {
		String resultQueryString = new String();

		if(excepts == null) {
			return queryString;
		}

		try {
			String[] query = StringUtils.split(queryString, "&");
			String[] param;
			int idx = 0;
			boolean isExists = false;
			if(query != null) {
				for(int i = 0; i < query.length; i++) {
					param = StringUtils.split(query[i], "=");
					if(param == null || param.length < 1) {
						continue;
					}

					if(excepts != null && excepts.length > 0) {
						if(ArrayUtils.contains(excepts, param[0])) {
							isExists = true;
						} else {
							isExists = false;
						}
					}

					if(!isExists) {
						if(idx > 0) {
							resultQueryString += "&amp;";
						}

						if(!StringUtils.isEmpty(param[0])) {
							resultQueryString += param[0] + "=";
						}

						if(param.length > 1 && !StringUtils.isEmpty(param[1])) {
							resultQueryString += param[1];
						}

						idx ++;
						isExists = false;
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultQueryString;
	}

	public static String getRealIp(HttpServletRequest request) {
		String ip = request.getHeader("X-Forwarded-For");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}

		if (ip.equals("0:0:0:0:0:0:0:1")) {
			ip = "127.0.0.1";
		}
		return ip;
	}
	
	public boolean isLogining() {
		if(getUser() == null) {
			return false;
		} else {
			return true;
		}
	}
}