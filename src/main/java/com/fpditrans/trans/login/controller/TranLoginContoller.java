package com.fpditrans.trans.login.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fpditrans.base.exception.FpdiTransRunException;
import com.fpditrans.base.mvc.BaseController;
import com.fpditrans.trans.login.service.TranLoginService;

import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * @Class Name : LoginContoller.java
 * @Description : LoginContoller Class
 *	 
 * @로그인  콘트롤러
 * @  수정일	  수정자			  수정내용
 * @ ---------	---------	-------------------------------
 * @ 2016.07.28			최초생성
 *
 * @author 우림인포텍
 * @version 1.0
 * @see
 *
 *  Copyright (C) by woorim All right reserved.
 */
@Controller
public class TranLoginContoller extends BaseController { 
protected Log log = LogFactory.getLog(this.getClass());	
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Autowired
	private TranLoginService  loginService;
	
	
	/**
	 * 로그인 폼 호출 
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return
	 */
	 @RequestMapping(value="/tran/mem01/mem01Form.do")
		public String loginForm(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{
		 	String userIp=pRequest.getRemoteHost();
		 	String returnUrl="/flowerMain/flowerMain";
		 	
		 	if(userIp!=null&&(userIp.equals("218.239.230.30")||userIp.equals("103.108.108.254")||userIp.equals("127.0.0.1")||userIp.equals("0:0:0:0:0:0:0:1"))){
		 		// 내부망 or 우림ip
		 		returnUrl="/tran/mem01/Login";
		 	}else{
		 		returnUrl="/tran/mem01/Login";
		 		//return "redirect:/main/flowerMain.do";
		 	}
			
			return returnUrl;
		}
	 
		
	 /**
	  * 로그인 처리 (json)
	  * @param pRequest
	  * @param pResponse
	  * @param pRequestParamMap
	  * @param model
	  * @return
	  */
		@RequestMapping(value="/tran/cmn/login/loginProc.json")
		public String loginProcJson(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
				@RequestParam Map<String, Object> pRequestParamMap,
				ModelMap model)
		{
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
//			String l_rtnModel = loginProc(pRequest,pResponse,pRequestParamMap,model);
			loginProc(pRequest,pResponse,pRequestParamMap,model);
			logger.debug(">>>>>>> msg : " + model.get("msg"));
			logger.debug(">>>>>>> uri : " + model.get("uri"));

//			SUCCESS
//			"Invalid user"
//			"Password is incorrect";
//			null
			resultMap.clear();
			if ( model.get("msg") == null || model.get("msg").equals(""))
			{
				resultMap.put("code", messageSource.getMessage("fpdisys.main.rtn_code.OK", null, Locale.getDefault()) );
				resultMap.put("msg", "");
				resultMap.put("passChange", model.get("passChange"));
			}else
			{
				resultMap.put("code", messageSource.getMessage("fpdisys.main.rtn_code.NOK", null, Locale.getDefault()) );
				resultMap.put("msg", model.get("msg"));
			}
			
		
			//----------------------------------------------------------------
			// return json 
			//----------------------------------------------------------------  
			model.clear();
			model.addAttribute("result", resultMap);
			return "jsonView";
			
		}
	 
	 
	 
		/**
		 * 로그인처리 
		 * @param pRequest
		 * @param pResponse
		 * @param pRequestParamMap
		 * @param model
		 * @return
		 */
		 @SuppressWarnings("unchecked")
			@RequestMapping(value="/tran/login/loginProc.do")
			public String loginProc(
					HttpServletRequest pRequest, 
					HttpServletResponse pResponse, 
					@RequestParam Map<String, Object> pRequestParamMap,
					ModelMap model)
					
			{
			 	try{
			 		
			 		//---------------------------------------------------
					// declare local variables
					//---------------------------------------------------
					String lMsg = "";
					String lUri = "";
					String lLoginResult = "";
					String lLoginYn = "";
			
					String dbIdCnt				= "" ;
					String dbPassCnt			 = "" ;
					String dbUsrId				= "" ;
					String dbCmpCode		  	 = "" ;
					String dbUsrYn				 = "" ;
					String dbGrpAuthCode			 = "" ;
					String dbUsrType 			 = "";	
					String dbUsrLastLoginDt 	 = "";
					
				 	log.info("===========================================");
					log.info("======  loginProc ======");
					log.info("===========================================");
					log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
			//		printRequest(pRequest);
					log.info("===========================================");
					String lReqUri	= StringUtils.defaultString((String)pRequestParamMap.get("reqUri"),"/tran/main.do");
					String lUsrId	= StringUtils.defaultString((String)pRequestParamMap.get("loginId"),"");
					
					//---------------------------------
					// 사용자 정보 DB select
					//---------------------------------
					List<?> lDbList = loginService.selectLogin(pRequestParamMap);
					log.info("===========================================" + lDbList);
					
					model.addAttribute("resultList", lDbList);
					
				  //---------------------------------
					// select된 row 가져옴
					//---------------------------------
					Map<String,Object> dbRow = null;
					 if ( lDbList.size() > 0 )
						{
							dbRow = (Map<String,Object>)  lDbList.get(0);
					
							 dbIdCnt					= (String)dbRow.get("idCnt");
							 dbUsrId					= (String)dbRow.get("userId");
							 dbCmpCode			 	= (String)dbRow.get("compCode");
							 dbUsrYn				= (String)dbRow.get("useYn");
							 dbGrpAuthCode			= (String)dbRow.get("grpAuthCode");
							 dbUsrType				= (String)dbRow.get("userType");
							 dbUsrLastLoginDt		= (String)dbRow.get("lastLoginDate");
							 
							
							
						} else {
							
							dbIdCnt = "0";
				//			System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> record zero " );
						}
					 
					 
					//---------------------------------
						// 등록된 사용자가 아닌 경우
						//---------------------------------
						if ( "0".equals(dbIdCnt) ) {
							 lMsg = "아이디 또는 비밀번호를 다시 확인하세요.";
								lUri = pRequest.getRequestURI().replace ( pRequest.getServletPath(), "" ) + "/login/loginForm.do?reqUri=" + lReqUri;
								lLoginResult = "NO_USER_ID";
								lLoginYn = "N";
							
						}else{
							//---------------------------------
							// 비밀번호가 일치하지 않는 경우
							//---------------------------------
							if ( "0".equals( dbPassCnt) ) {
//								lMsg = "부적합한 비밀번호입니다.";
								lMsg = "아이디 또는 비밀번호를 다시 확인하세요.";
								lUri = pRequest.getRequestURI().replace ( pRequest.getServletPath(), "" ) + "/login/loginForm.do?reqUri=" + lReqUri;
								lLoginResult = "WRONG_PASSWORD";
								lLoginYn = "N";
							//---------------------------------
							// 비밀번호가 일치하는 경우
							//---------------------------------
							}else{
								lLoginResult = "SUCCESS";
								lLoginYn = "Y";
								lMsg = null;
								lUri = lReqUri;
								HttpSession  session = pRequest.getSession(true);
								session.setAttribute("CONNECTION_USER_IDENTITY_ABCDEFGHIJKLMN", lUsrId);
								session.setAttribute("SESSION_USER_ID",	dbUsrId);
								session.setAttribute("SESSION_CMP_CODE",	dbCmpCode);
								session.setAttribute("SESSION_USER_YN",  dbUsrYn);
								session.setAttribute("SESSION_GRP_AUTH_CODE",  dbGrpAuthCode);
								session.setAttribute("SESSION_USER_TYPE",  dbUsrType);
								session.setAttribute("SESSION_LAST_LOGIN_DATE",  dbUsrLastLoginDt);
							 	session.setAttribute("LOCALE",  Locale.getDefault());
								
								int lSessionPeriodSeconds = Integer.parseInt(StringUtils.defaultString((String)propertyService.getString("sessionPeriodSeconds"),"3600")) ;
								session.setMaxInactiveInterval( lSessionPeriodSeconds );
								
								
							}
							System.out.println(dbGrpAuthCode);
							// 권한이 개발자 /파일전송담당자/슈퍼관리자만/관리자만 사용가능 
							if(!dbGrpAuthCode.equals("M001")&&
								!dbGrpAuthCode.equals("F001")&&	
								!dbGrpAuthCode.equals("S001")&&
								!dbGrpAuthCode.equals("A001")&&
								!dbGrpAuthCode.equals("D001")
								){
									lMsg = "권한이 없습니다.";
									lUri = pRequest.getRequestURI().replace ( pRequest.getServletPath(), "" ) + "/login/loginForm.do?reqUri=" + lReqUri;
									lLoginResult = "NO_AUTH";
									lLoginYn = "N";
							
							
								}
						}
						//---------------------------------
						// 로그인 체크에 대한 결과를 DB에 log로 남김
						//---------------------------------
						String ipAddr = pRequest.getHeader("HTTP_X_FORWARDED_FOR");
						
						if(ipAddr == null || ipAddr.length() == 0 || ipAddr.equalsIgnoreCase("unknown"))
							ipAddr = pRequest.getHeader("REMOTE_ADDR");
						
						if(ipAddr == null || ipAddr.length() == 0 || ipAddr.equalsIgnoreCase("unknown"))
							ipAddr = pRequest.getRemoteAddr();
						
						pRequestParamMap.put("ipInfo", ipAddr );
						pRequestParamMap.put("macAddr",  "");
						pRequestParamMap.put("succYn", lLoginYn );
						pRequestParamMap.put("regstPrgm", "");
						pRequestParamMap.put("regststId", "");
						pRequestParamMap.put("loginResult", lLoginResult);
						
						
						/*try{
							startTx();
							loginMapper.insertLog(pRequestParamMap);
							commit();
							
							startTx();
							loginMapper.updateUserLastLoginDt(pRequestParamMap);
							commit();
							
							startTx();
							loginMapper.updateUserPassErrNum(pRequestParamMap);
							commit();
				
						}finally
						{
							rollback();
						}*/
						
						
						model.addAttribute("msg", lMsg);
						model.addAttribute("uri", lUri);
						model.addAttribute("code", lLoginResult);
						
					return "/tran/mem01/loginProc";
				} catch (Exception e) {
					throw new FpdiTransRunException(-1, "");
				}  	
			 	
			 	
			 	
			 	
			 	
			}
		 
		 
		 /**
		  * 로그아웃 처리 
		  * @param pRequest
		  * @param pResponse
		  * @param pRequestParamMap
		  * @param model
		  * @return
		  */
		 @RequestMapping(value="/tran/login/logoutProc.do"  )
			public String logoutProc(
					HttpServletRequest pRequest, 
					HttpServletResponse pResponse, 
					@RequestParam Map<String, Object> pRequestParamMap,
					Model model) 

			{
						 
				log.info("===========================================");
				log.info("======  logoutProc ======");
				log.info("===========================================");
				log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
				printRequest(pRequest);
				log.info("===========================================");

//				String result = "FAIL";
//				
//				HttpSession  session = pRequest.getSession(false);
//				if(session != null){
//					result = "SUCCESS";
//					session.invalidate();
//				}
//				
//				model.addAttribute("result", result);
		//
//		  		return "jsonView";
		  		
				Map<String, String> resultMap = new HashMap<String, String>();
				
				HttpSession  session = pRequest.getSession(false);
				 if(session != null){
						
		 			session.invalidate();
		 			
		 		}
					 
				 resultMap.put("code",  messageSource.getMessage("dms.rtn_code.SESSION_FINISH", null, Locale.getDefault()) );
				 resultMap.put("msg",  messageSource.getMessage("dms.rtn_code.SESSION_FINISH_MSG", null, Locale.getDefault()) );
					
				 model.addAttribute("code",  messageSource.getMessage("dms.rtn_code.SESSION_FINISH", null, Locale.getDefault()) );
				 model.addAttribute("msg",  messageSource.getMessage("dms.rtn_code.SESSION_FINISH_MSG", null, Locale.getDefault()) );
				model.addAttribute("result", resultMap);
				return "/tran/mem01/logOutProc";
			}
		 
		 
		 /**
		  * 로그아웃처리 (json)
		  * @param pRequest
		  * @param pResponse
		  * @param pRequestParamMap
		  * @param model
		  * @return
		  */
		 @RequestMapping(value="/tran/login/logout.json"  )
			public String logout(
					HttpServletRequest pRequest, 
					HttpServletResponse pResponse, 
					@RequestParam Map<String, Object> pRequestParamMap,
					Model model) 

			{
						 
				log.info("===========================================");
				log.info("======  logout ======");
				log.info("===========================================");
				log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
				printRequest(pRequest);
				log.info("===========================================");

//				String result = "FAIL";
//				
//				HttpSession  session = pRequest.getSession(false);
//				if(session != null){
//					result = "SUCCESS";
//					session.invalidate();
//				}
//				
//				model.addAttribute("result", result);
		//
//		  		return "jsonView";
		  		
				Map<String, String> resultMap = new HashMap<String, String>();
				
				HttpSession  session = pRequest.getSession(false);
				 if(session != null){
						
		 			session.invalidate();
		 		}
					 
				 resultMap.put("code",  messageSource.getMessage("fpdisys.main.rtn_code.SESSION_FINISH", null, Locale.getDefault()) );
				 resultMap.put("msg",  messageSource.getMessage("fpdisys.main.rtn_code.SESSION_FINISH_MSG", null, Locale.getDefault()) );
					
				
				model.addAttribute("result", resultMap);
				return "jsonView";
			}
		 	
		 
		 /**
		  * 세션  없을 경우 처리 
		  * @param pRequest
		  * @param pResponse
		  * @param pRequestParamMap
		  * @param model
		  * @return
		  */
	 @RequestMapping(value="/tran/login/sessionNullForReturn.do")
		public  String sessionNullForReturn(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse,
				@RequestParam Map<String, Object> pRequestParamMap,
				ModelMap model) 
		{
			
			log.info("===========================================");
			log.info("======  sessionNullForReturn ======");
			log.info("===========================================");
			log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
			printRequest(pRequest);
			log.info("===========================================");
			
			Map<String, String> resultMap = new HashMap<String, String>();
			resultMap.put("code",  messageSource.getMessage("fpdisys.main.rtn_code.SESSION_FINISH", null, Locale.getDefault()) );
			resultMap.put("msg", messageSource.getMessage("fpdisys.main.rtn_code.SESSION_FINISH_MSG", null, Locale.getDefault()) );
			log.info("resultMap:" + resultMap);
			
			model.addAttribute("result", resultMap);

	  		return "/tran/mem01/loginRedirect";
	  		
		}
		
		 
		 /**
		  * 세션  없을 경우 처리 (json)
		  * @param pRequest
		  * @param pResponse
		  * @param pRequestParamMap
		  * @param model
		  * @return
		  */
	 @RequestMapping(value="/tran/login/sessionNullForAjaxReturn.json")
		public  String sessionNullForAjaxReturn(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse,
				@RequestParam Map<String, Object> pRequestParamMap,
				ModelMap model) 
		{
			
			log.info("===========================================");
			log.info("======  sessionNullForAjaxReturn ======");
			log.info("===========================================");
			log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
			printRequest(pRequest);
			log.info("===========================================");
			
			Map<String, String> resultMap = new HashMap<String, String>();
			resultMap.put("code",  messageSource.getMessage("fpdisys.main.rtn_code.SESSION_FINISH", null, Locale.getDefault()) );
			resultMap.put("msg", messageSource.getMessage("fpdisys.main.rtn_code.SESSION_FINISH_MSG", null, Locale.getDefault()) );
			log.info("resultMap:" + resultMap);
			
			model.addAttribute("result", resultMap);

	  		return "jsonView";
	  		
		}
	 
	 /**
	  * 권한 없을 경우 처리 
	  * @param pRequest
	  * @param pResponse
	  * @param pRequestParamMap
	  * @param model
	  * @return
	  */
	 @RequestMapping(value="/tran/login/noAuthRedirect2.do")
		public String noAuthRedirect2(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{
					 
			log.info("===========================================");
			log.info("======  noAuthRedirect2 ======");
			log.info("===========================================");
			log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
			printRequest(pRequest);
			log.info("===========================================");
			model.put("pRequestParamMap", pRequestParamMap);
			return "/tran/mem01/noAuthRedirect";
		}
	 
	 
	 /**
	  * 권한 없을 경우 처리 (json)
	  * @param pRequest
	  * @param pResponse
	  * @param pRequestParamMap
	  * @param model
	  * @return
	  */
	 @RequestMapping(value="/tran/login/noAuthRedirect.json")
		public  String noAuthRedirect(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse,
				@RequestParam Map<String, Object> pRequestParamMap,
				ModelMap model) 
		{
			try {
				log.info("===========================================");
				log.info("======  noAuthRedirect ======");
				log.info("===========================================");
				log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
				printRequest(pRequest);
				log.info("===========================================");
				
				//----------------------------------------------------------------
				// return json 
				//----------------------------------------------------------------	
				Map<String, String> resultMap = new HashMap<String, String>();
				resultMap.put("code", messageSource.getMessage("fpdisys.main.rtn_code.NOK", null, Locale.getDefault()) );
				resultMap.put("msg", messageSource.getMessage("fpdisys.main.rtn_code.NO_AUTHORITY", null, Locale.getDefault()) +"(" + pRequestParamMap.get("noAuthUrl") + ")");
				
				model.addAttribute("result", resultMap);
				return "jsonView";
			} catch (Exception e) {
				throw new FpdiTransRunException(-1, "");
			}	
		}
}
