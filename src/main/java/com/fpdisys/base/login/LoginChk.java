package com.fpdisys.base.login;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InterruptedIOException;
import java.io.Serializable;
import java.util.Iterator;
import java.util.Locale;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.fpdisys.base.mvc.BaseVo;

public class LoginChk implements Serializable{
	 private javax.servlet.http.HttpServletRequest request;
		private javax.servlet.http.HttpSession session;
		private javax.servlet.http.HttpServletResponse response;
		protected Log log = LogFactory.getLog(this.getClass());
		
		private String l_loginPage = "";
		  
		private String l_reqUri = null;

		private Map	l_map = null;
		
		private java.io.PrintWriter  l_out  ;
		private String l_checkbox_enable_open_file_window = null;
		
		public LoginChk(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response){
			this.request	  = request;
			this.response	 = response;
			this.session	  = request.getSession(false);
			this.l_reqUri	= request.getRequestURI();
			this.l_map		= request.getParameterMap();  
			this.l_loginPage  = "/cmn/login/loginForm.do";
			this.l_checkbox_enable_open_file_window  = StringUtils.defaultString(request.getParameter("ar_checkbox_enable_open_file_window"),"");
			//try{
			//The PrintWriter uses the character encoding returned by getCharacterEncoding(). 
			//If the response's character encoding has not been specified as described in 
			//getCharacterEncoding (i.e., the method just returns the default value ISO-8859-1), 
			//getWriter updates it to ISO-8859-1. 
			//response.setCharacterEncoding("euc-kr"); 
			//l_out	  = response.getWriter();
			
		//}catch (Exception e){
		// }
			
			try{
		  		if ( request.getRealPath(request.getRequestURI()).matches("/*_eng/*"))
					  this.session.setAttribute("LANGUAGE",			 "ENG");
		  		else 
					  this.session.setAttribute("LANGUAGE",			 "KOR");
			} catch (ArithmeticException e) {
				log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
			} catch (NumberFormatException e) {
				log.error("오류발생 숫자로 변환 할 수 없습니다!!");
			} catch (ArrayIndexOutOfBoundsException e) {
				log.error("오류발생 배열인텍스에서 벗어났습니다!!");
			} catch (NegativeArraySizeException e) {
				log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
			} catch (NullPointerException e) {
				log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
			} catch (NoSuchMethodError e) {
				log.error("오류발생 메서드를 찾을수 없습니다!!");
			} catch (NoClassDefFoundError e) {
				log.error("오류발생 클래스를 찾을 수 없습니다!!");
			} catch (RuntimeException e) {
				log.error("오류발생 런타임!!");
			} catch (Exception e) {
				log.error("오류발생!!");
			}
			

		}
		
		/**
		  * Login화면의 url을 구
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

				try{
					l_user_id = (String) session.getAttribute("CONNECTION_USER_IDENTITY_ABCDEFGHIJKLMN");
						System.out.println("sess_l_user_id>>:"+l_user_id);
					if ( l_user_id == null || l_user_id.equals("")) {
						return false;
					}
				} catch (ArithmeticException e) {
					log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
				} catch (NumberFormatException e) {
					log.error("오류발생 숫자로 변환 할 수 없습니다!!");
				} catch (ArrayIndexOutOfBoundsException e) {
					log.error("오류발생 배열인텍스에서 벗어났습니다!!");
				} catch (NegativeArraySizeException e) {
					log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
				} catch (NullPointerException e) {
					log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
				} catch (NoSuchMethodError e) {
					log.error("오류발생 메서드를 찾을수 없습니다!!");
				} catch (NoClassDefFoundError e) {
					log.error("오류발생 클래스를 찾을 수 없습니다!!");
				} catch (RuntimeException e) {
					log.error("오류발생 런타임!!");
				} catch (Exception e) {
					log.error("오류발생!!");
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
				
			 try{
					l_user_id = (String) session.getAttribute("CONNECTION_USER_IDENTITY_ABCDEFGHIJKLMN");
					if ( l_user_id == null || l_user_id.equals("")) {
						this.request.setAttribute("reqUri", l_reqUri);
						return false;
					}
				} catch (ArithmeticException e) {
					log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
				} catch (NumberFormatException e) {
					log.error("오류발생 숫자로 변환 할 수 없습니다!!");
				} catch (ArrayIndexOutOfBoundsException e) {
					log.error("오류발생 배열인텍스에서 벗어났습니다!!");
				} catch (NegativeArraySizeException e) {
					log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
				} catch (NullPointerException e) {
					log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
				} catch (NoSuchMethodError e) {
					log.error("오류발생 메서드를 찾을수 없습니다!!");
				} catch (NoClassDefFoundError e) {
					log.error("오류발생 클래스를 찾을 수 없습니다!!");
				} catch (RuntimeException e) {
					log.error("오류발생 런타임!!");
				} catch (Exception e) {
					log.error("오류발생!!");
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
				} catch (InterruptedIOException  e) {
					log.error("입출력 오류 입출력 도중에 알수없는 인터럽트가 발생하였습니다!!");
				} catch (FileNotFoundException e) {
					log.error("입출력 오류 파일을 찾을 수 없습니다!!");
				} catch (IOException e) {
					log.debug("입출력 오류!!");
				} catch (ClassNotFoundException e) {
					log.error("오류발생 클래스를 찾을 수 없습니다!!");
				} catch (NoSuchMethodException e) {
					log.error("오류발생 메서드를 찾을수 없습니다!!");
				} catch (ArithmeticException e) {
					log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
				} catch (NumberFormatException e) {
					log.error("오류발생 숫자로 변환 할 수 없습니다!!");
				} catch (ArrayIndexOutOfBoundsException e) {
					log.error("오류발생 배열인텍스에서 벗어났습니다!!");
				} catch (NegativeArraySizeException e) {
					log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
				} catch (NullPointerException e) {
					log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
				} catch (NoSuchMethodError e) {
					log.error("오류발생 메서드를 찾을수 없습니다!!");
				} catch (NoClassDefFoundError e) {
					log.error("오류발생 클래스를 찾을 수 없습니다!!");
				} catch (RuntimeException e) {
					log.error("오류발생 런타임!!");
				} catch (Exception e) {
					log.error("오류발생!! ");
				} 
			}
			
			/**
			* session 정보  return
			* @param void
			* @return String
			* @see	#		 
			*/
			public String getAttribute(String p_Attribute_name) {
				String l_rtn_value = null;
				if ( session == null)
					return "";
				try{
					l_rtn_value = (String) session.getAttribute(p_Attribute_name);
					if ( l_rtn_value == null)
						return "";
				} catch (ArithmeticException e) {
					log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
				} catch (NumberFormatException e) {
					log.error("오류발생 숫자로 변환 할 수 없습니다!!");
				} catch (ArrayIndexOutOfBoundsException e) {
					log.error("오류발생 배열인텍스에서 벗어났습니다!!");
				} catch (NegativeArraySizeException e) {
					log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
				} catch (NullPointerException e) {
					log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
				} catch (NoSuchMethodError e) {
					log.error("오류발생 메서드를 찾을수 없습니다!!");
				} catch (NoClassDefFoundError e) {
					log.error("오류발생 클래스를 찾을 수 없습니다!!");
				} catch (RuntimeException e) {
					log.error("오류발생 런타임!!");
				} catch( Exception e){
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
			

		//
		//
//			/**
//			* 사용자 MAIN_MENU_TYPE return
//			* @param void
//			* @return String
//			* @see	#	  
//			*/
//			public String getMainMenuType() {
//				return getAttribute("MAIN_MENU_TYPE");
//			}
		//
		//	
		//	
//			/**
//			* 사용자 ACCOUNT_PERIOD return
//			* @param void
//			* @return String
//			* @see	#	  
//			*/
//			public String getAccountPeriod() {
//				return getAttribute("ACCOUNT_PERIOD");
//			}  
		//
		//
		//	
		//
//			/**
//			* 사용자 LANGUAGE return
//			* @param void
//			* @return String
//			* @see	#	  
//			*/
//			public String getLangauge() {
//				return getAttribute("LANGUAGE");
//			}	
//						
//			/**
//			* 사용자 AUTH return
//			* @param void
//			* @return String
//			* @see	#	  
//			*/
//			public String getUserAuth() {
//				return getAttribute("USER_AUTH");
//			}

			/**
			* 사용자 Locale return
			* @param void
			* @return String
			* @see	#	  
			*/
			public Locale getLocale() {
				 Locale l_rtn_value = null;
				 
				if ( session == null)
					return Locale.getDefault();
				try{
					l_rtn_value = (Locale) session.getAttribute("LOCALE");
					if ( l_rtn_value == null)
						return Locale.getDefault();
				} catch (ArithmeticException e) {
					log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
				} catch (NumberFormatException e) {
					log.error("오류발생 숫자로 변환 할 수 없습니다!!");
				} catch (ArrayIndexOutOfBoundsException e) {
					log.error("오류발생 배열인텍스에서 벗어났습니다!!");
				} catch (NegativeArraySizeException e) {
					log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
				} catch (NullPointerException e) {
					log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
				} catch (NoSuchMethodError e) {
					log.error("오류발생 메서드를 찾을수 없습니다!!");
				} catch (NoClassDefFoundError e) {
					log.error("오류발생 클래스를 찾을 수 없습니다!!");
				} catch (RuntimeException e) {
					log.error("오류발생 런타임!!");
				} catch( Exception e){
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
		 		} catch (ArithmeticException e) {
			 		log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
		 		} catch (NumberFormatException e) {
			 		log.error("오류발생 숫자로 변환 할 수 없습니다!!");
		 		} catch (ArrayIndexOutOfBoundsException e) {
			 		log.error("오류발생 배열인텍스에서 벗어났습니다!!");
		 		} catch (NegativeArraySizeException e) {
			 		log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
		 		} catch (NullPointerException e) {
			 		log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
		 		} catch (NoSuchMethodError e) {
		 			log.error("오류발생 메서드를 찾을수 없습니다!!");
		 		} catch (NoClassDefFoundError e) {
		 			log.error("오류발생 클래스를 찾을 수 없습니다!!");
		 		} catch (RuntimeException e) {
		 			log.error("오류발생 런타임!!");
		 		} catch( Exception e){
					  session.setAttribute("LOCALE",  Locale.getDefault());
				}

			 }
			 
//			/**
//			* 사용자 Product return
//			* @param void
//			* @return String
//			* @see	#	  
//			*/
//			public String getProduct() {
//				return getAttribute("PRODUCT");
//			}
		//
//			/**
//			 * 
//			 * @param void
//			 * @return String
//			 * @see	#	  
//			 */
//			 public String getEnableOpenFileWindow() {
//				 return getAttribute("ENABLE_OPEN_FILE_WINDOW");
//			 }
//			 
//			 public void setEnableOpenFileWindow() {
//				 session.setAttribute("ENABLE_OPEN_FILE_WINDOW", l_checkbox_enable_open_file_window);
//			 }
			 
			 
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
				} catch (ArithmeticException e) {
					log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
				} catch (NumberFormatException e) {
					log.error("오류발생 숫자로 변환 할 수 없습니다!!");
				} catch (ArrayIndexOutOfBoundsException e) {
					log.error("오류발생 배열인텍스에서 벗어났습니다!!");
				} catch (NegativeArraySizeException e) {
					log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
				} catch (NullPointerException e) {
					log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
				} catch (NoSuchMethodError e) {
					log.error("오류발생 메서드를 찾을수 없습니다!!");
				} catch (NoClassDefFoundError e) {
					log.error("오류발생 클래스를 찾을 수 없습니다!!");
				} catch (RuntimeException e) {
					log.error("오류발생 런타임!!");
				} catch(Exception e){
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
				} catch (ArithmeticException e) {
					log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
				} catch (NumberFormatException e) {
					log.error("오류발생 숫자로 변환 할 수 없습니다!!");
				} catch (ArrayIndexOutOfBoundsException e) {
					log.error("오류발생 배열인텍스에서 벗어났습니다!!");
				} catch (NegativeArraySizeException e) {
					log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
				} catch (NullPointerException e) {
					log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
				} catch (NoSuchMethodError e) {
					log.error("오류발생 메서드를 찾을수 없습니다!!");
				} catch (NoClassDefFoundError e) {
					log.error("오류발생 클래스를 찾을 수 없습니다!!");
				} catch (RuntimeException e) {
					log.error("오류발생 런타임!!");
				} catch(Exception e){
					 l_rtn = l_rtn + "//--------------------------------------------------";
					 l_rtn = l_rtn + "// Message from printlnParameters  ";
					 l_rtn = l_rtn + "// redirection hidden parameer setting failed ";
					 l_rtn = l_rtn + "//--------------------------------------------------";
				}
				return l_rtn;
			}
			
			public void putSessionToParameterMap( Map p_map ){
				p_map.put("SESSION_USER_ID", getUserId());
				p_map.put("SESSION_USER_NAME", getUserName());
				//p_map.put("SESSION_USER_MASKING", getUserMasking());
				p_map.put("SESSION_USER_MASKING", "Y");
//				p_map.put("SESSION_USER_AUTH", getUserAuth());

				
			}
			
			public void putSessionToVo( BaseVo p_baseVo ){
				p_baseVo.setSessionUserId(getUserId());
				p_baseVo.setSessionUserName(getUserName());
				p_baseVo.setSessionUserMasking(getUserMasking());
//				p_map.put("SESSION_USER_AUTH", getUserAuth());

				
			}
			
		} 

