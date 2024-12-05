package com.fpdisys.dist.login.controller;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InterruptedIOException;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fpdisys.admin.data.service.ConfigService;
import com.fpdisys.base.exception.FpdisysRunException;
import com.fpdisys.base.login.LoginInfo;
import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.dist.login.mapper.LoginMapper;
import com.fpdisys.dist.menu.domain.UserMenuInfo;
import com.fpdisys.dist.menu.service.MenuService;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class LoginController extends BaseController { 
	
	@Autowired
	private ConfigService configService;
	
	@Autowired
	private LoginMapper loginMapper;
	
	protected Log log = LogFactory.getLog(this.getClass());

	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Autowired
	private MenuService  menuService;
	
	@RequestMapping(value="/cmn/login/loginForm.do")
	public String loginForm(
			HttpServletRequest pRequest, 
			HttpServletResponse pResponse, 
	 		@RequestParam Map<String, Object> pRequestParamMap,
	 		ModelMap model)
	{
				 
		log.info("===========================================");
		log.info("======  loginForm ======");
		log.info("===========================================");
		log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
		printRequest(pRequest);
		log.info("===========================================");
 		 
		return "/cmn/login/loginForm";
	}
	
	
	@RequestMapping(value="/cmn/login/mainForm.do")
	public String mainForm(
			HttpServletRequest pRequest, 
			HttpServletResponse pResponse, 
			HttpSession session,
	 		@RequestParam Map<String, Object> pRequestParamMap,
	 		ModelMap model)
	{
				 
		log.info("===========================================");
		log.info("======  mainForm ======");
		log.info("===========================================");
		log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
		printRequest(pRequest);
		log.info("===========================================");
		
		session.setAttribute("SESSION_ITEM_CD", "100100");
		
		LoginInfo loginInfo = new LoginInfo(pRequest, pResponse);
		loginInfo.putSessionToParameterMap(pRequestParamMap);
		UserMenuInfo userMenuInfo= null;
 		if(StringUtils.isBlank(loginInfo.getUserId())){
 			userMenuInfo = menuService.getUserMenuInfoNoLogin();
 		}else{
 			userMenuInfo = menuService.getUserMenuInfo(loginInfo.getUserId());
 		}
 		//log.info(">>>>userMenuInfo : " + userMenuInfo.getMainMenuJson());
 		log.info(">>>>loginInfo : " + loginInfo.toString());
 		
 		
 		model.addAttribute("userMenuInfo",userMenuInfo );
		return "/cmn/login/mainForm";
	}
	
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/cmn/login/loginProc.do")
	public String loginProc(
			HttpServletRequest pRequest, 
			HttpServletResponse pResponse, 
			@RequestParam Map<String, Object> pRequestParamMap,
			ModelMap model)
			
	{
		try {
			//---------------------------------------------------
			// declare local variables
			//---------------------------------------------------
			String lMsg = "";
			String lUri = "";
			String lLoginResult = "";
			String lLoginYn = "";
	
			String dbIdCnt				= "" ;
			String dbPassCnt			 = "" ;
			String dbUsrNm				= "" ;
			String dbUsrId				= "" ;
			String dbUsrEmail			= "";
			String dbHpNo				 = "";
			String dbUsrType			= "";
			String dbUseYn				 = "";
			String dbUsrPs				 = "";
			String dbGrpAuthCd			= "";
			
			
			
			/* String dbUsrOrgnId		  = "" ;
			String dbUsrOrgnNm		  = "" ;
			String dbUsrOrgnYypeCd	 = "" ;
			String dbUsrOrgnLvlCd	  = "" ;
			String dbUsrLogisCnterYn	= "" ;
			String dbUsrMngrRule		= "" ;
			String dbUsgEndDt		  = "";*/
			
			log.info("===========================================");
			log.info("======  loginProc ======");
			log.info("===========================================");
			log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
	//		printRequest(pRequest);
			log.info("===========================================");
	
			String lReqUri	= StringUtils.defaultString((String)pRequestParamMap.get("reqUri"),"/");
			String lUsrId	= StringUtils.defaultString((String)pRequestParamMap.get("userCd"),"");
		 
	
			log.info("===========================================");
			log.info("======  SQL pRequestParamMap ======");
			log.info(">>>>" +  pRequestParamMap.toString());
			log.info("===========================================");
			
	//		List l_db_List = generalService.generalDAO.list("common.login.selectLogin", pRequestParamMap); 
			
			//---------------------------------
			// 암호 encryption
			// 설정에서 encryption 사용이 true로 되어있는지 check
			//---------------------------------
	//		String l_passEnc = ES256Encryptor.encrypt((String) pRequestParamMap.get("pass"));
			String lPassInput = (String) pRequestParamMap.get("userPs");
			String lPassEnc ="";
	//TODO 패스워드 암호화		//sHA512Encryptor.encrypt((String) pRequestParamMap.get("pass"));
			log.info(">>>> l_passEnc:" +  lPassEnc);
			log.info(">>>> lPassInput:" +  lPassInput);
		/*	
			if ( propertyService.getString("passEnc").equals("true"))
			{
				pRequestParamMap.remove("pass");
				pRequestParamMap.put("pass", lPassEnc);
			}
			*/
			
			//---------------------------------
			// 사용자 정보 DB select
			//---------------------------------
			List<?> lDbList = loginMapper.selectLogin(pRequestParamMap);
			log.info("===========================================" + lDbList);
			
			model.addAttribute("resultList", lDbList);
			
			//---------------------------------
			// select된 row 가져옴
			//---------------------------------
			Map<String,Object> dbRow = null;
			
	//		System.out.println("l_db_List.size(): "+l_db_List.size() );
			if ( lDbList.size() > 0 )
			{
				dbRow = (Map<String,Object>)  lDbList.get(0);
				
				dbIdCnt				= (String)dbRow.get("idCnt");
				dbPassCnt			 = (String)dbRow.get("passCnt");
				dbUsrNm				= (String)dbRow.get("userNm");
				dbUsrId				= (String)dbRow.get("userCd");
				dbUsrPs				  = (String)dbRow.get("userPs");
				dbUseYn				  = (String)dbRow.get("useYn");
				dbGrpAuthCd			= (String)dbRow.get("grpAuthCd");
				
				
				
				
				
				/*dbUsrOrgnId			= (String)dbRow.get("orgnId");
				dbUsrOrgnNm			= (String)dbRow.get("orgnNm");
				dbUsrOrgnYypeCd		= (String)dbRow.get("typeCd");
				dbUsrOrgnLvlCd		= (String)dbRow.get("orgnLvlCd");
				dbUsrLogisCnterYn	 = (String)dbRow.get("logisCnterYn");
				dbUsrMngrRule		 = (String)dbRow.get("mngrRule");
				dbUsgEndDt			= (String)dbRow.get("usgEndDt");*/
	
			}else
			{
				dbIdCnt = "0";
	//			System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> record zero " );
			}
	
			
			logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> getRequestURI" + pRequest.getRequestURI().replace ( pRequest.getServletPath(), "" ) );
			
			//---------------------------------
			// 등록된 사용자가 아닌 경우
			//---------------------------------
			if ( "0".equals(dbIdCnt) ) {
	
//				lMsg = "부적합한 사용자입니다.";
				lMsg = "아이디 또는 비밀번호를 다시 확인하세요.";
				lUri = pRequest.getRequestURI().replace ( pRequest.getServletPath(), "" ) + "/cmn/login/loginForm.do?reqUri=" + lReqUri;
				lLoginResult = "NO_USER_ID";
				lLoginYn = "N";
			//---------------------------------
			// 등록된 사용자인 경우
			//---------------------------------
			}else{
				//---------------------------------
				// 비밀번호가 일치하지 않는 경우
				//---------------------------------
				if ( "0".equals( dbPassCnt) ) {
//					lMsg = "부적합한 비밀번호입니다.";
					lMsg = "아이디 또는 비밀번호를 다시 확인하세요.";
					lUri = pRequest.getRequestURI().replace ( pRequest.getServletPath(), "" ) + "/cmn/login/loginForm.do?reqUri=" + lReqUri;
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
	
					session.setAttribute("CONNECTION_USER_IDENTITY_ABCDEFGHIJKLMN",	lUsrId);
					session.setAttribute("SESSION_USER_ID",	dbUsrId);
					session.setAttribute("SESSION_USER_NAME",  dbUsrNm);
					session.setAttribute("SESSION_USER_TYPE",  dbUsrType);
					session.setAttribute("SESSION_USER_TYPE",  dbUsrType);
					session.setAttribute("SESSION_GRP_AUTH_TYPE",dbGrpAuthCd );
					
				//	session.setAttribute("SESSION_USER_ORGN_ID",  dbUsrOrgnId);
					//session.setAttribute("SESSION_USER_ORGN_NM",  dbUsrOrgnNm);
				//	session.setAttribute("SESSION_USER_ORGN_TYPE_CD",  dbUsrOrgnYypeCd);
					
				//	session.setAttribute("SESSION_USER_ORGN_LVL_CD",  dbUsrOrgnLvlCd);
				//	session.setAttribute("SESSION_USER_LOGIS_CNTER_YN",  dbUsrLogisCnterYn);
				//	session.setAttribute("SESSION_USER_MNGR_RULE",  dbUsrMngrRule);
					
				//	session.setAttribute("SESSION_LAST_LOGIN_DT",  dbUsgEndDt);
					session.setAttribute("LOCALE",  Locale.getDefault());
	
					//int lSessionPeriodSeconds = Integer.parseInt(StringUtils.defaultString((String)propertyService.getString("sessionPeriodSeconds"),"3600")) ;
					//session.setMaxInactiveInterval( lSessionPeriodSeconds );
					//session.setMaxInactiveInterval( 60*20 );
					
	
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
			pRequestParamMap.put("prgmId", "");
			pRequestParamMap.put("regststId", "");
			pRequestParamMap.put("loginResult", lLoginResult);
			
			try{
				startTx();
				loginMapper.insertLog(pRequestParamMap);
				commit();
				
				startTx();
				loginMapper.updateUserLastLoginDt(pRequestParamMap);
				commit();
				
				startTx();
				loginMapper.updateUserPassErrNum(pRequestParamMap);
				commit();

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
			} finally{
				rollback();
			}
			
			model.addAttribute("msg", lMsg);
			model.addAttribute("succYn", lLoginYn);
			model.addAttribute("uri", lUri);
			
			/*if ( propertyService.getString("passChange").equals("true"))
			{*/
				/*if( propertyService.getString("initPass").equals(lPassEnc))
				{
					model.addAttribute("passChange", "Y");
				}else
				{*/
					model.addAttribute("passChange", "N");
				/*}*/
			/*}*/
			
			
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
		return "/cmn/login/loginProc";	
	}
	 
	
	@RequestMapping(value="/cmn/login/logout.json"  )
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

//		String result = "FAIL";
//		
//		HttpSession  session = pRequest.getSession(false);
//		if(session != null){
//			result = "SUCCESS";
//			session.invalidate();
//		}
//		
//		model.addAttribute("result", result);
//
//  		return "jsonView";
  		
		Map<String, String> resultMap = new HashMap<String, String>();
		
		HttpSession  session = pRequest.getSession(false);
		 if(session != null){
				
 			session.invalidate();
 			
 		}
			 
		 resultMap.put("code",  messageSource.getMessage("dms.rtn_code.SESSION_FINISH", null, Locale.getDefault()) );
		 resultMap.put("msg",  messageSource.getMessage("dms.rtn_code.SESSION_FINISH_MSG", null, Locale.getDefault()) );
			
		
		model.addAttribute("result", resultMap);
		return "jsonView";
	}
	
	@RequestMapping(value="/cmn/login/logoutProc.do"  )
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

//		String result = "FAIL";
//		
//		HttpSession  session = pRequest.getSession(false);
//		if(session != null){
//			result = "SUCCESS";
//			session.invalidate();
//		}
//		
//		model.addAttribute("result", result);
//
//  		return "jsonView";
  		
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
		return "/cmn/login/logOutProc";
	}
	
	
	@RequestMapping(value="/cmn/login/sessionNullForAjaxReturn.json")
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
		resultMap.put("code",  messageSource.getMessage("dms.rtn_code.SESSION_FINISH", null, Locale.getDefault()) );
		resultMap.put("msg", messageSource.getMessage("dms.rtn_code.SESSION_FINISH_MSG", null, Locale.getDefault()) );
		log.info("resultMap:" + resultMap);
		
		model.addAttribute("result", resultMap);

  		return "jsonView";
  		
	}
	
	@RequestMapping(value="/cmn/login/noAuthRedirect2.do")
	public String noAuthRedirect2(
			HttpServletRequest pRequest, 
			HttpServletResponse pResponse, 
	 		@RequestParam Map<String, Object> pRequestParamMap,
	 		ModelMap model)
	{
				 
		log.info("===========================================");
		log.info("======  loginForm ======");
		log.info("===========================================");
		log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
		printRequest(pRequest);
		log.info("===========================================");
		model.put("pRequestParamMap", pRequestParamMap);
		return "/cmn/login/noAuthRedirect";
	}
	
	
	@RequestMapping(value="/cmn/login/noAuthRedirect.json")
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
			resultMap.put("code", messageSource.getMessage("dms.rtn_code.NOK", null, Locale.getDefault()) );
			resultMap.put("msg", messageSource.getMessage("dms.rtn_code.NO_AUTHORITY", null, Locale.getDefault()) +"(" + pRequestParamMap.get("noAuthUrl") + ")");
			
			model.addAttribute("result", resultMap);
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
			throw new FpdisysRunException(-1, "");
		}	
		return "jsonView";
	}
	
	@RequestMapping(value="/cmn/login/mainForm2.do")
	public String mainForm2(
			HttpServletRequest pRequest, 
			HttpServletResponse pResponse, 
	 		@RequestParam Map<String, Object> pRequestParamMap,
	 		ModelMap model)
	{
				 
		log.info("===========================================");
		log.info("======  mainForm2 ======");
		log.info("===========================================");
		log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
		printRequest(pRequest);
		log.info("===========================================");
		LoginInfo loginInfo = new LoginInfo(pRequest, pResponse);
		loginInfo.putSessionToParameterMap(pRequestParamMap);
		UserMenuInfo userMenuInfo= null;
 		if(StringUtils.isBlank(loginInfo.getUserId())){
 			userMenuInfo = menuService.getUserMenuInfoNoLogin();
 		}else{
 			userMenuInfo = menuService.getUserMenuInfo(loginInfo.getUserId());
 		}
 		//log.info(">>>>userMenuInfo : " + userMenuInfo.getMainMenuJson());
 		
 		model.addAttribute("userMenuInfo",userMenuInfo );
		return "/cmn/login/mainForm2";
	}
	
	
	@RequestMapping(value="/cmn/login/mainGarForm.do")
	public String mainFormGar(
			HttpServletRequest pRequest, 
			HttpServletResponse pResponse,
			HttpSession session,
	 		@RequestParam Map<String, Object> pRequestParamMap,
	 		ModelMap model)
	{
				 
		log.info("===========================================");
		log.info("======  mainFormGar ======");
		log.info("===========================================");
		log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
		printRequest(pRequest);
		log.info("===========================================");
		
			session.setAttribute("SESSION_ITEM_CD", "120900");
		
		LoginInfo loginInfo = new LoginInfo(pRequest, pResponse);
		loginInfo.putSessionToParameterMap(pRequestParamMap);
		UserMenuInfo userMenuInfo= null;
 		if(StringUtils.isBlank(loginInfo.getUserId())){
 			userMenuInfo = menuService.getUserMenuInfoNoLogin();
 		}else{
 			userMenuInfo = menuService.getUserMenuInfo(loginInfo.getUserId());
 		}
 		//log.info(">>>>userMenuInfo : " + userMenuInfo.getMainMenuJson());
 		
 		model.addAttribute("userMenuInfo",userMenuInfo );
		return "/cmn/login/mainFormGar";
	}
	
	@RequestMapping(value="/cmn/login/mainOniForm.do")
	public String mainFormOni(
			HttpServletRequest pRequest, 
			HttpServletResponse pResponse, 
			HttpSession session,
	 		@RequestParam Map<String, Object> pRequestParamMap,
	 		ModelMap model)
	{
				 
		log.info("===========================================");
		log.info("======  mainFormOni ======");
		log.info("===========================================");
		log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
		printRequest(pRequest);
		log.info("===========================================");
	
			session.setAttribute("SESSION_ITEM_CD", "120100");
		
		LoginInfo loginInfo = new LoginInfo(pRequest, pResponse);
		loginInfo.putSessionToParameterMap(pRequestParamMap);
		UserMenuInfo userMenuInfo= null;
 		if(StringUtils.isBlank(loginInfo.getUserId())){
 			userMenuInfo = menuService.getUserMenuInfoNoLogin();
 		}else{
 			userMenuInfo = menuService.getUserMenuInfo(loginInfo.getUserId());
 		}
 		//log.info(">>>>userMenuInfo : " + userMenuInfo.getMainMenuJson());
 		
 		model.addAttribute("userMenuInfo",userMenuInfo );
		return "/cmn/login/mainFormOni";
	}
	
	
	@RequestMapping(value="/cmn/login/mainPapForm.do")
	public String mainFormPap(
			HttpServletRequest pRequest, 
			HttpServletResponse pResponse,
			HttpSession session,
	 		@RequestParam Map<String, Object> pRequestParamMap,
	 		ModelMap model)
	{
				 
		log.info("===========================================");
		log.info("======  mainFormPap ======");
		log.info("===========================================");
		log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
		printRequest(pRequest);
		log.info("===========================================");
		
		session.setAttribute("SESSION_ITEM_CD", "120700");
		
		LoginInfo loginInfo = new LoginInfo(pRequest, pResponse);
		loginInfo.putSessionToParameterMap(pRequestParamMap);
		UserMenuInfo userMenuInfo= null;
 		if(StringUtils.isBlank(loginInfo.getUserId())){
 			userMenuInfo = menuService.getUserMenuInfoNoLogin();
 		}else{
 			userMenuInfo = menuService.getUserMenuInfo(loginInfo.getUserId());
 		}
 		//log.info(">>>>userMenuInfo : " + userMenuInfo.getMainMenuJson());
 		
 		model.addAttribute("userMenuInfo",userMenuInfo );
		return "/cmn/login/mainFormPap";
	}
	
	@RequestMapping(value="/cmn/login/mainRadForm.do")
	public String mainFormRad(
			HttpServletRequest pRequest, 
			HttpServletResponse pResponse, 
			HttpSession session,
	 		@RequestParam Map<String, Object> pRequestParamMap,
	 		ModelMap model)
	{
				 
		log.info("===========================================");
		log.info("======  mainFormRad ======");
		log.info("===========================================");
		log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
		printRequest(pRequest);
		log.info("===========================================");
		
			session.setAttribute("SESSION_ITEM_CD", "110100");
		
		LoginInfo loginInfo = new LoginInfo(pRequest, pResponse);
		loginInfo.putSessionToParameterMap(pRequestParamMap);
		UserMenuInfo userMenuInfo= null;
 		if(StringUtils.isBlank(loginInfo.getUserId())){
 			userMenuInfo = menuService.getUserMenuInfoNoLogin();
 		}else{
 			userMenuInfo = menuService.getUserMenuInfo(loginInfo.getUserId());
 		}
 		//log.info(">>>>userMenuInfo : " + userMenuInfo.getMainMenuJson());
 		
 		model.addAttribute("userMenuInfo",userMenuInfo );
		return "/cmn/login/mainFormRad";
	}
	
	//@RequestMapping(value="/login/adminLogin.do")
	@RequestMapping(value="/mnt/mem01/mem01Form.do")
	public String adminLogin(
			HttpServletRequest pRequest, 
			HttpServletResponse pResponse, 
			HttpSession session,
	 		@RequestParam Map<String, Object> pRequestParamMap,
	 		ModelMap model)
	{
		model.addAttribute("msg", pRequestParamMap.get("msg"));
		
		String userIp=pRequest.getRemoteHost();
		String returnUrl="/flowerMain/flowerMain";
		if (userIp.equals("0:0:0:0:0:0:0:1")) {
			userIp = "127.0.0.1";
		}
		
		// 임시로그인 주석처리  at 2023.03.20 by 신정철
		// userIp = "127.0.0.1";
		Map<String,Object> pRequestParam = new HashMap<String,Object>(); 
		pRequestParam.put("IP", "관리자IP");
		List<Map<String,Object>> configIpList =  configService.selectConfig(pRequestParam);
		boolean ipcnt = false;
		for(Map<String,Object> map : configIpList) {
			if(userIp!=null&&(
					userIp.equals(map.get("CONFIG_VAL").toString())
					//userIp.equals("127.0.0.1") || userIp.equals("211.218.243.40") // 이현우과장님 요청사항 23.11.27
					//|| userIp.equals("115.89.203.83")	// 화훼유통정보관리자 허용ip 등록	at 2023.03.20 by 신정철
					
// #########################################################################################
//				CTCJOHN
//				기존 허용 ip 주석처리 2023.03.20 by 신정철
//				|| userIp.equals("218.239.230.30")		// asis
//				|| userIp.equals("103.108.108.254")		// asis
//				|| userIp.equals("106.241.33.158")		// asis
//				|| userIp.equals("125.128.69.50")		// asis
//				|| userIp.equals("125.128.69.58")		// asis
// #########################################################################################
					)){
				// 내부망 or 우림ip
				ipcnt = true;
				return "/mem01/Login";
			}else{
				ipcnt = false;
			}
		}
		if(ipcnt) {
			returnUrl="/mem01/Login";
		} else {
			return "redirect:/main/flowerMain.do";
		}
		return returnUrl;
	}
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/login/adminLoginProc.do")
	public String adminLoginProc(
			HttpServletRequest pRequest, 
			HttpServletResponse pResponse, 
			@RequestParam Map<String, Object> pRequestParamMap,
			RedirectAttributes redirectAttributes,
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
			String dbSanCd 	 = "";
			
		 	log.info("===========================================");
			log.info("======  loginProc ===lmh===");
			log.info("===========================================");
			log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
	//		printRequest(pRequest);
			log.info("===========================================");
			String lReqUri	= StringUtils.defaultString((String)pRequestParamMap.get("reqUri"),"/maa01/maa01.do");
			String lUsrId	= StringUtils.defaultString((String)pRequestParamMap.get("loginId"),"");
			
			//---------------------------------
			// 사용자 정보 DB select
			//---------------------------------
			List<?> lDbList = menuService.adminLoginProc(pRequestParamMap);
			
			log.info("===================lDbList========================"+lDbList);
			model.addAttribute("resultList", lDbList);
			
		  //---------------------------------
			// select된 row 가져옴
			//---------------------------------
			Map<String,Object> dbRow = null;
			
			 if ( lDbList.size() > 0 )							
				{
				 	
					dbRow = (Map<String,Object>)  lDbList.get(0);
					String userId= (String)dbRow.get("userId");
					System.err.println("userId------->"+userId);
					
					if("admin".equals(userId.trim())){
						
					 dbIdCnt					= (String)dbRow.get("idCnt");
					 dbUsrId					= (String)dbRow.get("userId");
					 dbCmpCode			 	= (String)dbRow.get("compCode");
					 dbUsrYn				= (String)dbRow.get("useYn");
					 dbGrpAuthCode			= (String)dbRow.get("grpAuthCode");
					 dbUsrType				= (String)dbRow.get("userType");
					 dbUsrLastLoginDt		= (String)dbRow.get("lastLoginDate");
					 dbSanCd			 =(String)dbRow.get("remark");
					 
					 
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
						session.setAttribute("SESSION_SAN_CD",  dbSanCd);
					 	session.setAttribute("LOCALE",  Locale.getDefault());
						
						//int lSessionPeriodSeconds = Integer.parseInt(StringUtils.defaultString((String)propertyService.getString("sessionPeriodSeconds"),"3600")) ;
						//session.setMaxInactiveInterval( lSessionPeriodSeconds );
					 	//session.setMaxInactiveInterval( 60*20 );
						
				 	}else {
				 		lMsg ="권한이 없습니다.";
						lUri = pRequest.getRequestURI().replace ( pRequest.getServletPath(), "" ) + "/login/loginForm.do?reqUri=" + lReqUri;
						lLoginResult = "NO_AUTH";
						lLoginYn = "N";
				 
							model.addAttribute("msg", lMsg.trim());
						/*model.addAttribute("code", lLoginResult);*/
						redirectAttributes.addFlashAttribute("vo", model);
						return "redirect:/login/adminLogin1.do";
								
				 	}
			
				} else {
				
					dbIdCnt = "0";
		//System.out.println(">>>>>>>>>>>>>>>>>>>>>>lmhlmh>>>>>>>>>>> record zero " );
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
				
//						lMsg = "부적합한 비밀번호입니다.";
						lMsg = "아이디 또는 비밀번호를 다시 확인하세요.";
						lUri = pRequest.getRequestURI().replace ( pRequest.getServletPath(), "" ) + "/login/loginForm.do?reqUri=" + lReqUri;
						lLoginResult = "WRONG_PASSWORD";
						lLoginYn = "N";
					//---------------------------------
					// 비밀번호가 일치하는 경우
					//---------------------------------
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
		} catch (Exception e) {
			throw new FpminputRunException(-1, "");
		}
	 	return "redirect:/admin/adminNoticeForm.do";
	}
	
	@RequestMapping(value="/login/adminLogin1.do")
	public String adminLogin1(
			HttpServletRequest pRequest, 
			HttpServletResponse pResponse, 
			HttpSession session,
	 		@RequestParam Map<String, Object> pRequestParamMap,
	 		ModelMap model)
	{
		model.addAttribute("msg", pRequestParamMap.get("msg"));
		
	
				 
		return "/admin/Login" ;
	}
	@RequestMapping(value="/login/adminLogOut.do")
	public String adminLogOut(
			HttpServletRequest pRequest, 
			HttpServletResponse pResponse, 
			HttpSession session,
	 		@RequestParam Map<String, Object> pRequestParamMap,
	 		ModelMap model)
	{
		model.addAttribute("msg", pRequestParamMap.get("msg"));
		
		session.invalidate();
		return "redirect:/" ;
	}
}
