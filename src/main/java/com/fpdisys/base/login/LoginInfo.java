package com.fpdisys.base.login;

import java.io.Serializable;
import java.util.Iterator;
import java.util.Locale;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.fpdisys.base.mvc.BaseVo;

public class LoginInfo implements Serializable
{
	private final Logger logger = LogManager.getLogger(getClass());
	
	public final javax.servlet.http.HttpServletRequest request;
	private final javax.servlet.http.HttpSession session;
	public final javax.servlet.http.HttpServletResponse response;

	private final String mLoginPage ;
	public final String mReqUri ;
	private final Map	mMap ;
	
	
	/**
	* 생성자
	* @param request jsp의 request
	* @return response jsp의 response
	* @see	#		 
	*/
	public LoginInfo(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response){
		this.request	  = request;
		this.response	 = response;
		this.session	  = request.getSession(false);
		this.mReqUri	  = request.getRequestURI();
		this.mMap		 = request.getParameterMap();  
		this.mLoginPage	= "/cmn/login/loginForm.do";

		logger.debug(this.mLoginPage);
		
		try{
	 		if ( request.getRealPath(request.getRequestURI()).matches("/*_eng/*"))
				 this.session.setAttribute("LANGUAGE",			 "ENG");
	 		else 
				 this.session.setAttribute("LANGUAGE",			 "KOR");
		} catch (ArithmeticException e) {
			logger.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
		} catch (NumberFormatException e) {
			logger.error("오류발생 숫자로 변환 할 수 없습니다!!");
		} catch (ArrayIndexOutOfBoundsException e) {
			logger.error("오류발생 배열인텍스에서 벗어났습니다!!");
		} catch (NegativeArraySizeException e) {
			logger.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
		} catch (NullPointerException e) {
			logger.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
		} catch (NoSuchMethodError e) {
			logger.error("오류발생 메서드를 찾을수 없습니다!!");
		} catch (NoClassDefFoundError e) {
			logger.error("오류발생 클래스를 찾을 수 없습니다!!");
		} catch (RuntimeException e) {
			logger.error("오류발생 런타임!!");
		} catch (Exception e) {
			logger.error("오류발생!! ");
		} 

	}
	
	/**
	* <PRE>
	* 1. MethodName: isLogin
	* 2. ClassName	: LoginInfo
	* 3. Commnet	: 단순 session 체크
	*				login check하여 login되어있지않으면 login page로 redirect
	* 4. 작성자	: Administrator
	* 5. 작성일	: 2014. 10. 6. 오전 10:29:42
	* </PRE>
	* 		@return boolean
	* 		@return
	*/
	public boolean isLogin() 
	{
		String usrId = null;
		try {
			usrId = (String) session.getAttribute("CONNECTION_USER_IDENTITY_ABCDEFGHIJKLMN");
		} catch (ArithmeticException e) {
			logger.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
		} catch (NumberFormatException e) {
			logger.error("오류발생 숫자로 변환 할 수 없습니다!!");
		} catch (ArrayIndexOutOfBoundsException e) {
			logger.error("오류발생 배열인텍스에서 벗어났습니다!!");
		} catch (NegativeArraySizeException e) {
			logger.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
		} catch (NullPointerException e) {
			logger.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
		} catch (NoSuchMethodError e) {
			logger.error("오류발생 메서드를 찾을수 없습니다!!");
		} catch (NoClassDefFoundError e) {
			logger.error("오류발생 클래스를 찾을 수 없습니다!!");
		} catch (RuntimeException e) {
			logger.error("오류발생 런타임!!");
		} catch (Exception e) {
			logger.error("오류발생!! ");
		}
		if( usrId == null || "".equals(usrId)) {
			return false;
		}

		return true;
	}
	
	public String getAttribute(String pAttributeName) {
		String rtnValue;
		if ( session == null){
			return "";
		}
			
		try{
				rtnValue = (String) session.getAttribute(pAttributeName);
			if ( rtnValue == null){
				return "";
			}
		} catch (ArithmeticException e) {
				logger.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
				return "";
		} catch (NumberFormatException e) {
			logger.error("오류발생 숫자로 변환 할 수 없습니다!!");
				return "";
		} catch (ArrayIndexOutOfBoundsException e) {
			logger.error("오류발생 배열인텍스에서 벗어났습니다!!");
				return "";
		} catch (NegativeArraySizeException e) {
			logger.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
				return "";
		} catch (NullPointerException e) {
			logger.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
				return "";
		} catch (NoSuchMethodError e) {
			logger.error("오류발생 메서드를 찾을수 없습니다!!");
			return "";
		} catch (NoClassDefFoundError e) {
			logger.error("오류발생 클래스를 찾을 수 없습니다!!");
			return "";
		} catch (RuntimeException e) {
			logger.error("오류발생 런타임!!");
			return "";
		} catch (Exception e) {
			logger.error("오류발생!! ");
			return "";
		} 
			
		return rtnValue;
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
	* MENU_ID return
	* @param void
	* @return String
	* @see	#	  
	*/
	public String getMenuId() {
		return getAttribute("SESSION_MENU_ID");
	}

	
	/**
	* 
	* @param void
	* @return String
	* @see	#	  
	*/
	public String getUserMskAuthYn() {
		return getAttribute("SESSION_USER_MASK_AUTH_YN");
	}

	
	public String getUserOrgnId() {
		return getAttribute("SESSION_USER_ORGN_ID");
	}
	
	public String getUserOrgnTypeCd() {
		return getAttribute("SESSION_USER_ORGN_TYPE_CD");
	}

	
	public String getUserOrgnNm() {
		return getAttribute("SESSION_USER_ORGN_NM");
	}
	
	
	public String getUserOrgnLvlCd() {
		return getAttribute("SESSION_USER_ORGN_LVL_CD");
	}
	
	
	public String getUserLogisCnterYn() {
		return getAttribute("SESSION_USER_LOGIS_CNTER_YN");
	}
	
	public String getUserMngrRule() {
		return getAttribute("SESSION_USER_MNGR_RULE");
	}
	
	public String getItemCd(){
		return getAttribute("SESSION_ITEM_CD");
	}
	

	/**
	 * 사용자 Locale return
	 * @param void
	 * @return String
	 * @see	#	  
	 */
	 public Locale getLocale() {
		 Locale rtnVvalue;
		 
		 if ( session == null){
			 return Locale.getDefault();
		 }
			 
		 try{
			 rtnVvalue = (Locale) session.getAttribute("LOCALE");
			 if ( rtnVvalue == null){
				 return Locale.getDefault();
			 }
 		} catch (ArithmeticException e) {
	 		logger.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
	 		return Locale.getDefault();
 		} catch (NumberFormatException e) {
 			logger.error("오류발생 숫자로 변환 할 수 없습니다!!");
	 		return Locale.getDefault();
 		} catch (ArrayIndexOutOfBoundsException e) {
 			logger.error("오류발생 배열인텍스에서 벗어났습니다!!");
	 		return Locale.getDefault();
 		} catch (NegativeArraySizeException e) {
 			logger.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
	 		return Locale.getDefault();
 		} catch (NullPointerException e) {
 			logger.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
	 		return Locale.getDefault();
 		} catch (NoSuchMethodError e) {
 			logger.error("오류발생 메서드를 찾을수 없습니다!!");
 			return Locale.getDefault();
 		} catch (NoClassDefFoundError e) {
 			logger.error("오류발생 클래스를 찾을 수 없습니다!!");
 			return Locale.getDefault();
 		} catch (RuntimeException e) {
 			logger.error("오류발생 런타임!!");
 			return Locale.getDefault();
 		} catch (Exception e) {
 			logger.error("오류발생!! ");
 			return Locale.getDefault();
 		} 
			 
		 return rtnVvalue;
	 }

	 /**
	  * 사용자 Locale set
	  * @param void
	  * @return String
	  * @see	#	  
	  */
	  public void setLocale(Locale pLocale) {
//	 	 Locale rtnValue;
	 	 
		  if ( session == null){
  			return ;
  		}
	  	try{
  			session.setAttribute("LOCALE",  pLocale);
  		} catch (ArithmeticException e) {
  			logger.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
  			session.setAttribute("LOCALE",  Locale.getDefault());
  		} catch (NumberFormatException e) {
  			logger.error("오류발생 숫자로 변환 할 수 없습니다!!");
  			session.setAttribute("LOCALE",  Locale.getDefault());
  		} catch (ArrayIndexOutOfBoundsException e) {
  			logger.error("오류발생 배열인텍스에서 벗어났습니다!!");
  			session.setAttribute("LOCALE",  Locale.getDefault());
  		} catch (NegativeArraySizeException e) {
  			logger.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
  			session.setAttribute("LOCALE",  Locale.getDefault());
  		} catch (NullPointerException e) {
  			logger.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
  			session.setAttribute("LOCALE",  Locale.getDefault());
  		} catch (NoSuchMethodError e) {
  			logger.error("오류발생 메서드를 찾을수 없습니다!!");
  			session.setAttribute("LOCALE",  Locale.getDefault());
  		} catch (NoClassDefFoundError e) {
  			logger.error("오류발생 클래스를 찾을 수 없습니다!!");
  			session.setAttribute("LOCALE",  Locale.getDefault());
  		} catch (RuntimeException e) {
  			logger.error("오류발생 런타임!!");
  			session.setAttribute("LOCALE",  Locale.getDefault());
  		} catch (Exception e) {
  			logger.error("오류발생!! ");
  			session.setAttribute("LOCALE",  Locale.getDefault());
  		} 

	  }
	  
	
	public String getlnParameters(){
		String rtnString ="";
		String temp = "";
			StringBuffer lStrBuffer = new StringBuffer(rtnString);
			lStrBuffer.append("//--------------------------------------------------");
			lStrBuffer.append("// Message from printlnParameters  ");
			lStrBuffer.append("// redirection hidden parameer setting failed ");
			lStrBuffer.append("//--------------------------------------------------");
			rtnString = lStrBuffer.toString();
			temp  = lStrBuffer.toString();
			
		try { 
			if (mMap != null && mMap.size() > 0) {
				String key = null;
				String[] values = null;
				String lValue = "";
				Iterator it = mMap.keySet().iterator();
				while (it.hasNext()) {
					key = (String) it.next();
					values = (String[]) mMap.get(key);
					if (values != null){
						for (int inx = 0; inx < values.length; inx++) {
							lValue = (values[inx] == null) ? "" : values[inx];
							if ( ! key.equals("usrId") &&	! key.equals("pass") )
								//this.l_out.println("<input type=\"hidden\" name=\"" + key + "\" value=\"" + l_value + "\" > " );
//								rtnString = rtnString + "<input type=\"hidden\" name=\"" + key + "\" value=\"" + lValue + "\" > " ;
								lStrBuffer.append("<input type=\"hidden\" name=\"" + key + "\" value=\"" + lValue + "\" > ");
						}
					}
				}
				rtnString = lStrBuffer.toString();
			}
		} catch (ArithmeticException e) {
			logger.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
			rtnString = temp;
		} catch (NumberFormatException e) {
			logger.error("오류발생 숫자로 변환 할 수 없습니다!!");
			rtnString = temp;
		} catch (ArrayIndexOutOfBoundsException e) {
			logger.error("오류발생 배열인텍스에서 벗어났습니다!!");
			rtnString = temp;
		} catch (NegativeArraySizeException e) {
			logger.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
			rtnString = temp;
		} catch (NullPointerException e) {
			logger.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
			rtnString = temp;
		} catch (NoSuchMethodError e) {
			logger.error("오류발생 메서드를 찾을수 없습니다!!");
			rtnString = temp;
		} catch (NoClassDefFoundError e) {
			logger.error("오류발생 클래스를 찾을 수 없습니다!!");
			rtnString = temp;
		} catch (RuntimeException e) {
			logger.error("오류발생 런타임!!");
			rtnString = temp;
		} catch (Exception e) {
			logger.error("오류발생!! ");
			rtnString = temp;
		} 
		 return rtnString;
	}
	
	public void putSessionToParameterMap( Map pMap ){
		pMap.put("SESSION_USER_ID", getUserId());
		pMap.put("SESSION_USER_NAME", getUserName());
		pMap.put("SESSION_USER_MASKING", getUserMskAuthYn());
		pMap.put("SESSION_USER_ORGN_ID", getUserOrgnId());
		pMap.put("SESSION_USER_ORGN_NM", getUserOrgnNm());
		pMap.put("SESSION_USER_ORGN_TYPE_CD", getUserOrgnTypeCd());

		pMap.put("SESSION_USER_ORGN_LVL_CD", getUserOrgnLvlCd());
		pMap.put("SESSION_USER_LOGIS_CNTER_YN", getUserLogisCnterYn());
		
		pMap.put("SESSION_ITEM_CD", getItemCd());
		
		pMap.put("SESSION_MENU_ID", getMenuId());
//		p_map.put("SESSION_USER_AUTH", getUserAuth());

		logger.debug("======== SESSION ================" );
		logger.debug(pMap );
		logger.debug("=================================" );
	}
	
	public void putSessionToVo( BaseVo pBaseVo ){
		pBaseVo.setSessionUserId(getUserId());
		pBaseVo.setSessionUserName(getUserName());
		pBaseVo.setSessionUserMskAuthYn(getUserMskAuthYn());
		pBaseVo.setSessionUserOrgnId(getUserOrgnId());
		pBaseVo.setSessionUserOrgnNm(getUserOrgnNm());
		pBaseVo.setSessionUserOrgnTypeCd(getUserOrgnTypeCd());

		pBaseVo.setSessionUserOrgnLvlCd(getUserOrgnLvlCd());
		pBaseVo.setSessionUserLogisCnterYn(getUserLogisCnterYn());
		//pBaseVo.setSessionSearchItemCd(getItemCd());
		pBaseVo.setSessionMenuId(getMenuId());
//		p_map.put("SESSION_USER_AUTH", getUserAuth());

		logger.debug("======== SESSION ================" );
		logger.debug(pBaseVo );
		logger.debug("=================================" );
		
	}
	

}
