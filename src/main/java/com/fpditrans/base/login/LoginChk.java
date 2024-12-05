package com.fpditrans.base.login;

import java.io.Serializable;
import java.util.Iterator;
import java.util.Locale;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import com.fpditrans.base.mvc.BaseVo;
/**
 * @Class Name : LoginChk.java
 * @Description : LoginChk Class
 * @Modification Information
 * @ 로그인 체크	클래스 
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
public class LoginChk implements Serializable{
	 private javax.servlet.http.HttpServletRequest request;
	 private javax.servlet.http.HttpSession session;
	 private javax.servlet.http.HttpServletResponse response;
		
	 private String l_loginPage = "";
	 
	 private String l_reqUri = null;

	 private Map	l_map = null;
	 
	 private java.io.PrintWriter  l_out  ;
	 
	 private String l_checkbox_enable_open_file_window = null;
	 
	 /**
	  * 생성자 
	  * @param request
	  * @param response
	  */
	 public LoginChk(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response){
			this.request	  = request;
			this.response	 = response;
			this.session	  = request.getSession(false);
			this.l_reqUri	= request.getRequestURI();
			this.l_map		= request.getParameterMap();  
			this.l_loginPage  = "/login/loginForm.do";
			this.l_checkbox_enable_open_file_window  = StringUtils.defaultString(request.getParameter("ar_checkbox_enable_open_file_window"),"");
			try{
				//The PrintWriter uses the character encoding returned by getCharacterEncoding(). 
				//If the response's character encoding has not been specified as described in 
				//getCharacterEncoding (i.e., the method just returns the default value ISO-8859-1), 
				//getWriter updates it to ISO-8859-1. 
				//response.setCharacterEncoding("euc-kr"); 
				//l_out	  = response.getWriter();
				
			}catch (Exception e){
			}
			
			try{
		  		if ( request.getRealPath(request.getRequestURI()).matches("/*_eng/*"))
					  this.session.setAttribute("LANGUAGE",			 "ENG");
		  		else 
					  this.session.setAttribute("LANGUAGE",			 "KOR");
			}catch ( Exception e){
			}
			

		}
	 
	 /**
	  * Login화면의 url을 구한다
	  * @param void
	  * @return void
	  * @see	#		
	  */
	  public String getLoginPage() throws Exception{
	 	 return l_loginPage;
	  }
	  
	  
	  /**
		* login check하여 login되어있지않으면 login page로 redirect
		* @param void
		* @return void
		* @see	#		
		*/
		public boolean isLogin() throws Exception{
			String l_user_id;
			try {
				l_user_id = (String) session.getAttribute("CONNECTION_USER_IDENTITY_ABCDEFGHIJKLMN");
				System.out.println("sess_l_user_id>>:"+l_user_id);
			}catch ( Exception e) {
				l_user_id = "";
			}

			try{
				if ( l_user_id == null || l_user_id.equals("")) {
//					javax.servlet.RequestDispatcher rd = session.getServletContext().getRequestDispatcher(getLoginPage() + "?ar_req_uri="+ l_reqUri);
//					rd.forward(request, response);
					return false;
				}
			}catch( Exception e) {
				throw e;
			}
			return true;
		}
		
		/**
			* login check하여 login되어있지않으면 false return . redirect 시키지 않음
			* @param void
			* @return void
			* @see	#		
			*/
			public boolean isLoginNoRedirect() throws Exception{
				String l_user_id;
				try {
					l_user_id = (String) session.getAttribute("CONNECTION_USER_IDENTITY_ABCDEFGHIJKLMN");
				}catch ( Exception e) {
					l_user_id = "";
				}
				
				try{
					if ( l_user_id == null || l_user_id.equals("")) {
						this.request.setAttribute("reqUri", l_reqUri);
						return false;
					}
				}catch( Exception e) {
					throw e;
				}

				return true;
			}
			
			/**
			* login page로 redirect
			* @param void
			* @return void
			* @see	#		
			*/
			public void redirectLogin() throws Exception{

				try{
						javax.servlet.RequestDispatcher rd = session.getServletContext().getRequestDispatcher(getLoginPage() + " ?reqUri="+ l_reqUri);
						rd.forward(request, response);
				}catch( Exception e) {
					throw e;
				}
			}
			
			/**
			* session 정보  return
			* @param void
			* @return String
			* @see	#		 
			*/
			public String getAttribute(String p_Attribute_name) {
				String l_rtn_value;
				if ( session == null)
					return "";
				try{
					l_rtn_value = (String) session.getAttribute(p_Attribute_name);
					if ( l_rtn_value == null)
						return "";
				}catch( Exception e){
					return "";
				}
					
				return l_rtn_value;
			}
			
			/**
				* 사용자 ID return
				* @param void
				* @return String
				* @see	#	  
				*/
				public String getUserId() {
					return getAttribute("CONNECTION_USER_IDENTITY_ABCDEFGHIJKLMN");
				}
				
				/**
					* 사용자 NAME return
					* @param void
					* @return String
					* @see	#	  
					*/
					public String getUserName() {
						return getAttribute("SESSION_USER_NAME");
					}

					/**
					* 
					* @param void
					* @return String
					* @see	#	  
					*/
					public String getUserMasking() {
						return getAttribute("SESSION_USER_MASKING");
					}
					
					public String getUserType(){
						return getAttribute("SESSION_USER_TYPE");
					}
					
					public String getCmpCode(){
						return getAttribute("SESSION_CMP_CODE");
					}
					
					public String getUseYn(){
						return getAttribute("SESSION_USER_YN");
					}
					
					public String getGrpAuthCode(){
						return getAttribute("SESSION_GRP_AUTH_CODE");
					}
					
					
					
					
					
					
				
				/**
				* 사용자 Locale return
				* @param void
				* @return String
				* @see	#	  
				*/
				public Locale getLocale() {
					 Locale l_rtn_value;
					 
					if ( session == null)
						return Locale.getDefault();
					try{
						l_rtn_value = (Locale) session.getAttribute("LOCALE");
						if ( l_rtn_value == null)
							return Locale.getDefault();
					}catch( Exception e){
						return Locale.getDefault();
					}
						
					return l_rtn_value;
				}

				/**
				 * 사용자 Locale set
				 * @param void
				 * @return String
				 * @see	#	  
				 */
				 public void setLocale(Locale p_locale) {
					 Locale l_rtn_value;
					 
					 if ( session == null)
						 return ;
					 try{
						  session.setAttribute("LOCALE",  p_locale);
					 }catch( Exception e){
						  session.setAttribute("LOCALE",  Locale.getDefault());
					 }

				 }
				 
				 /**
					* 사용자가 원래 가고자 했던 page로의 parameter들을 
					* login id, passwd 입력화면의 form에 hidden으로 형성시켜준다
					* @param void
					* @return void
					* @see	#	
					* 이거 쓰면 <input...이 문서 제일 위로 가능 경우가 발생함 원인은 모르겠음 
					* 그래서 아래의 getInParameters를 사용  
					*/
					public void printlnParametersXXXXXXXX(){
						try { 
							if (l_map != null && l_map.size() > 0) {
								String key = null;
								String[] values = null;
								String l_value = "";
								Iterator it = l_map.keySet().iterator();
								while (it.hasNext()) {
									key = (String) it.next();
									values = (String[]) l_map.get(key);
									if (values != null){
										for (int inx = 0; inx < values.length; inx++) {
											l_value = (values[inx] == null) ? "" : values[inx];
											if ( ! key.equals("usrId") &&	! key.equals("pass") )
												this.l_out.println("<input type=\"hidden\" name=\"" + key + "\" value=\"" + l_value + "\" > " );
										}
									}
								}
							}
						}catch(Exception e){
							this.l_out.print("//--------------------------------------------------");
							this.l_out.print("// Message from printlnParameters  ");
							this.l_out.print("// redirection hidden parameer setting failed ");
							this.l_out.print("//--------------------------------------------------");
						}
					}
					
					public String getlnParameters(){
						String l_rtn ="";
						try { 
							if (l_map != null && l_map.size() > 0) {
								String key = null;
								String[] values = null;
								String l_value = "";
								Iterator it = l_map.keySet().iterator();
								while (it.hasNext()) {
									key = (String) it.next();
									values = (String[]) l_map.get(key);
									if (values != null){
										for (int inx = 0; inx < values.length; inx++) {
											l_value = (values[inx] == null) ? "" : values[inx];
											if ( ! key.equals("userId") &&	! key.equals("pass") )
												//this.l_out.println("<input type=\"hidden\" name=\"" + key + "\" value=\"" + l_value + "\" > " );
												l_rtn = l_rtn + "<input type=\"hidden\" name=\"" + key + "\" value=\"" + l_value + "\" > " ;
										}
									}
								}
							}
						}catch(Exception e){
							 l_rtn = l_rtn + "//--------------------------------------------------";
							 l_rtn = l_rtn + "// Message from printlnParameters  ";
							 l_rtn = l_rtn + "// redirection hidden parameer setting failed ";
							 l_rtn = l_rtn + "//--------------------------------------------------";
						}
						return l_rtn;
					}
					
					/**
					* 세션데이터를  map Object 로 변환
					* @param pMap
					*/
					public void putSessionToParameterMap( Map p_map ){
						p_map.put("SESSION_USER_ID", getUserId());
						p_map.put("SESSION_USER_NAME", getUserName());
						//p_map.put("SESSION_USER_MASKING", getUserMasking());
						p_map.put("SESSION_USER_MASKING", "Y");
//						p_map.put("SESSION_USER_AUTH", getUserAuth());
						p_map.put("SESSION_USER_TYPE", getUserType());
						p_map.put("SESSION_GRP_AUTH_CODE", getGrpAuthCode());	
						p_map.put("SESSION_CMP_CODE", getCmpCode());		
						
					}
					
					/** 
					*  세션 데이터를  BaseVO 로 변환
					* @param pBaseVo
					*/
					public void putSessionToVo( BaseVo p_baseVo ){
							p_baseVo.setSessionUserId(getUserId());
							p_baseVo.setSessionUserName(getUserName());
							p_baseVo.setSessionUserMasking(getUserMasking());
//							p_map.put("SESSION_USER_AUTH", getUserAuth());
							p_baseVo.setSessionUserType(getUserType());
							p_baseVo.setSessionUseYn(getUseYn());
							p_baseVo.setSessionGrpAuthCode(getGrpAuthCode());
					

							
					}
			
			

	  
	  
			

}
