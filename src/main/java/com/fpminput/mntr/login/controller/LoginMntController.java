package com.fpminput.mntr.login.controller;

import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base32;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fpdisys.base.mvc.BaseController;
import com.fpminput.mntr.login.domain.UserVO;
import com.fpminput.mntr.login.mapper.LoginMapper;
import com.fpminput.mntr.login.service.LoginMntService;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class LoginMntController extends BaseController {

	protected Log log = LogFactory.getLog(this.getClass());

	@Autowired
	private LoginMapper loginMapper;

	@Autowired
	protected MessageSource messageSource;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	@Autowired
	private LoginMntService loginService;

	/**
	 * 로그인 처리 (json)
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/cmn/login/loginProc.json")
	public String loginProcJson(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) { 
		
		Map<String, Object> resultMap = new HashMap<String, Object>();

		loginProc(pRequest, pResponse, pRequestParamMap, model);
		logger.debug(">>>>>>> msg : " + model.get("msg"));
		logger.debug(">>>>>>> uri : " + model.get("uri"));
		log.info("+++++++++loginProcloginProcloginProc===="
				+ pRequestParamMap.toString());

		resultMap.clear();
		if (model.get("msg") == null || model.get("msg").equals("")) {
			resultMap.put("code", messageSource.getMessage("fpminput.main.rtn_code.OK", null, Locale.getDefault()));
			resultMap.put("msg", "");
			resultMap.put("passChange", model.get("passChange"));
		} else {
			resultMap.put("code", messageSource.getMessage("fpminput.main.rtn_code.NOK", null, Locale.getDefault()));
			resultMap.put("msg", model.get("msg"));
		}

		// ----------------------------------------------------------------
		// return json
		// ----------------------------------------------------------------
		model.clear();
		model.addAttribute("result", resultMap);
		log.info("loginProc+resultMap+" + resultMap);
		return "jsonView";

	}

	/**
	 * 로그인처리
	 * 
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return
	 */
	
	@RequestMapping(value = "/login/loginProc.do")
	public String loginProc(HttpServletRequest pRequest, HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		try {

			// ---------------------------------------------------
			// declare local variables
			// ---------------------------------------------------
			String lMsg = "";
			String lUri = "";
			String lLoginResult = "";
			String lLoginYn = "";
			String otp = "";

			log.info("===========================================");
			log.info(">>>>pRequestParamMap.toString() : "
					+ pRequestParamMap.toString());
			log.info("===========================================");
			String lReqUri = StringUtils.defaultString(
					(String) pRequestParamMap.get("reqUri"), "/maa01/maa01.do");

			String base = pRequestParamMap.get("pwd").toString();
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
			byte[] hash = digest.digest(base.getBytes("UTF-8"));
			StringBuffer hexString = new StringBuffer();
			for (int i = 0; i < hash.length; i++) {
				String hex = Integer.toHexString(0xFF & hash[i]);
				if (hex.length() == 1)
					hexString.append('0');
				hexString.append(hex);
			}
			String pwd = hexString.toString();

			/* 사용자 정보 DB select */
			UserVO user = loginService.selectLogin(pRequestParamMap);

			if (user != null) {// USER_ID 있음
				if (user.getUseYn().equals("Y")) { // 사용여부 Y

					if (user.getUserType().equals("M")
							|| user.getUserType().equals("A")) {
						// 권한이 모니터요원, 관리자만 사용가능
						if (user.getUserPasswd().equals(
								pwd)) {
							// 비밀번호 일치
							
							int userLimitCnt = loginService.checkLimitDate(pRequestParamMap);
							
							if(userLimitCnt>0){
								
								otp = (String)pRequestParamMap.get("otp");
								String authKey = user.getAuthKey();
								
								try{
									
									long codeCheck = Integer.parseInt(otp);
									String encodedKey = authKey;
									long l = new Date().getTime();
									long ll = l / 30000;

									boolean check_code = false;
									check_code = check_code(encodedKey, codeCheck, ll);
									
									logger.info("코드 비교 결과 : check_code:{} ",check_code);

									if (!check_code) {
										lMsg = "OTP가 틀렸습니다.";
										lUri = pRequest.getRequestURI().replace(pRequest.getServletPath(), "")+ "/mnt/mem01/mem01Form.do?reqUri=" + lReqUri;
										lLoginResult = "NO_AUTH";
										lLoginYn = "N";
									} else {
										lLoginResult = "SUCCESS";
										lLoginYn = "Y";
										lUri = lReqUri;

										// 최종 로그인 시간 UPDATE, 로그인 실패횟수 초기화
										loginService.updateLastDate(pRequestParamMap);

										HttpSession session = pRequest.getSession(true);
										session.setAttribute("CONNECTION_USER_IDENTITY_ABCDEFGHIJKLMN",user.getUserId());
										session.setAttribute("SESSION_USER_ID",user.getUserId());
										session.setAttribute("SESSION_CMP_CODE",user.getCompCode());
										session.setAttribute("SESSION_SAN_CD",user.getRemark());
										session.setAttribute("SESSION_MONITOR_TYPE", user.getMonitorType());
										session.setAttribute("SESSION_USER_TYPE",user.getUserType());
										session.setAttribute("LOCALE", Locale.getDefault());
										session.setAttribute("SESSION_GRP_AUTH_CODE",user.getGrpAuthCode());

										
										System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
										System.out.println(user.getUserId());
										System.out.println(user.getCompCode());
										System.out.println(user.getRemark());
										System.out.println(user.getMonitorType());
										System.out.println(user.getUserType());
										System.out.println(Locale.getDefault());
										System.out.println();
										System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
										
										
										// int lSessionPeriodSeconds =
										// Integer.parseInt(StringUtils.defaultString((String)propertyService.getString("sessionPeriodSeconds"),"3600"));
										// session.setMaxInactiveInterval( lSessionPeriodSeconds );
										//session.setMaxInactiveInterval(60*20);

										model.addAttribute("user", user);
									}

								} catch (Exception e) {
									throw new BadCredentialsException("OTP코드가 일치하지 않습니다." );
								}
								
							}else{
								// 비밀번호 불일치
								lMsg = "로그인실패로 10분간 로그인이 제한됩니다.";
								lUri = pRequest.getRequestURI().replace(pRequest.getServletPath(), "")+ "/mnt/mem01/mem01Form.do?reqUri="+ lReqUri;
								lLoginResult = "LIMIT_LOGIN";
								lLoginYn = "N";
							}
							
							

						} else {
							// 비밀번호 불일치
							lMsg = "비밀번호가 틀립니다.";
							lUri = pRequest.getRequestURI().replace(pRequest.getServletPath(), "")+ "/mnt/mem01/mem01Form.do?reqUri="+ lReqUri;
							lLoginResult = "WRONG_PASSWORD";
							lLoginYn = "N";

							// 로그인 실패횟수 cnt+1
							if(user.getPassErrNum()>4){
								loginService.updateLimitLogin(pRequestParamMap);
							}
							loginService.wrongPasswd(pRequestParamMap);
						}

					} else {
						lMsg = "권한이 없습니다.";
						lUri = pRequest.getRequestURI().replace(
								pRequest.getServletPath(), "")
								+ "/mnt/mem01/mem01Form.do?reqUri=" + lReqUri;
						lLoginResult = "NO_AUTH";
						lLoginYn = "N";
					}
				} else {
					// 사용여부 N
					lMsg = "로그인 할 수 없는 계정입니다. 관리자에게 문의하세요.";
					lUri = pRequest.getRequestURI().replace(
							pRequest.getServletPath(), "")
							+ "/mnt/mem01/mem01Form.do?reqUri=" + lReqUri;
					lLoginResult = "NO_USE_YN";
					lLoginYn = "N";
				}

			} else {
				// USER_ID 없음
				lMsg = "입력하신 아이디가 없습니다.";
				lUri = pRequest.getRequestURI().replace(
						pRequest.getServletPath(), "")
						+ "/mnt/mem01/mem01Form.do?reqUri=" + lReqUri;
				lLoginResult = "NO_USER_ID";
				lLoginYn = "N";
			}

			model.addAttribute("msg", lMsg);
			model.addAttribute("uri", lUri);
			model.addAttribute("code", lLoginResult);


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
		
		return "/mem01/loginProc";
		
	}
	
// 2025-01-07 OTP 없이 입장가능	
//	@RequestMapping(value = "/login/loginProc.do")
//	public String loginProc(HttpServletRequest pRequest, HttpServletResponse pResponse,
//	                        @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
//
//	    try {
//
//	        // ---------------------------------------------------
//	        // declare local variables
//	        // ---------------------------------------------------
//	        String lMsg = "";
//	        String lUri = "";
//	        String lLoginResult = "";
//	        String lLoginYn = "";
//
//	        log.info("===========================================");
//	        log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
//	        log.info("===========================================");
//	        
//	        String lReqUri = StringUtils.defaultString((String) pRequestParamMap.get("reqUri"), "/maa01/maa01.do");
//
//	        String base = pRequestParamMap.get("pwd").toString();
//	        MessageDigest digest = MessageDigest.getInstance("SHA-256");
//	        byte[] hash = digest.digest(base.getBytes("UTF-8"));
//	        StringBuffer hexString = new StringBuffer();
//	        for (int i = 0; i < hash.length; i++) {
//	            String hex = Integer.toHexString(0xFF & hash[i]);
//	            if (hex.length() == 1) hexString.append('0');
//	            hexString.append(hex);
//	        }
//	        String pwd = hexString.toString();
//
//	        /* 사용자 정보 DB select */
//	        UserVO user = loginService.selectLogin(pRequestParamMap);
//
//	        if (user != null) { // USER_ID 있음
//	            if (user.getUseYn().equals("Y")) { // 사용여부 Y
//
//	                if (user.getUserType().equals("M") || user.getUserType().equals("A")) {
//	                    // 권한이 모니터요원, 관리자만 사용 가능
//	                    if (user.getUserPasswd().equals(pwd)) {
//	                        // 비밀번호 일치
//	                        int userLimitCnt = loginService.checkLimitDate(pRequestParamMap);
//
//	                        if (userLimitCnt > 0) {
//	                            // OTP 검증을 무력화하고 로그인 성공으로 처리
//	                            lLoginResult = "SUCCESS";
//	                            lLoginYn = "Y";
//	                            lUri = lReqUri;
//
//	                            // 최종 로그인 시간 UPDATE, 로그인 실패횟수 초기화
//	                            loginService.updateLastDate(pRequestParamMap);
//
//	                            HttpSession session = pRequest.getSession(true);
//	                            session.setAttribute("CONNECTION_USER_IDENTITY_ABCDEFGHIJKLMN", user.getUserId());
//	                            session.setAttribute("SESSION_USER_ID", user.getUserId());
//	                            session.setAttribute("SESSION_CMP_CODE", user.getCompCode());
//	                            session.setAttribute("SESSION_SAN_CD", user.getRemark());
//	                            session.setAttribute("SESSION_MONITOR_TYPE", user.getMonitorType());
//	                            session.setAttribute("SESSION_USER_TYPE", user.getUserType());
//	                            session.setAttribute("LOCALE", Locale.getDefault());
//	                            session.setAttribute("SESSION_GRP_AUTH_CODE", user.getGrpAuthCode());
//
//	                            model.addAttribute("user", user);
//	                        } else {
//	                            // 로그인 제한
//	                            lMsg = "로그인 실패로 10분간 로그인이 제한됩니다.";
//	                            lUri = pRequest.getRequestURI().replace(pRequest.getServletPath(), "") 
//	                                    + "/mnt/mem01/mem01Form.do?reqUri=" + lReqUri;
//	                            lLoginResult = "LIMIT_LOGIN";
//	                            lLoginYn = "N";
//	                        }
//
//	                    } else {
//	                        // 비밀번호 불일치
//	                        lMsg = "비밀번호가 틀립니다.";
//	                        lUri = pRequest.getRequestURI().replace(pRequest.getServletPath(), "") 
//	                                + "/mnt/mem01/mem01Form.do?reqUri=" + lReqUri;
//	                        lLoginResult = "WRONG_PASSWORD";
//	                        lLoginYn = "N";
//
//	                        // 로그인 실패횟수 증가
//	                        if (user.getPassErrNum() > 4) {
//	                            loginService.updateLimitLogin(pRequestParamMap);
//	                        }
//	                        loginService.wrongPasswd(pRequestParamMap);
//	                    }
//
//	                } else {
//	                    // 권한 없음
//	                    lMsg = "권한이 없습니다.";
//	                    lUri = pRequest.getRequestURI().replace(pRequest.getServletPath(), "") 
//	                            + "/mnt/mem01/mem01Form.do?reqUri=" + lReqUri;
//	                    lLoginResult = "NO_AUTH";
//	                    lLoginYn = "N";
//	                }
//	            } else {
//	                // 사용여부 N
//	                lMsg = "로그인 할 수 없는 계정입니다. 관리자에게 문의하세요.";
//	                lUri = pRequest.getRequestURI().replace(pRequest.getServletPath(), "") 
//	                        + "/mnt/mem01/mem01Form.do?reqUri=" + lReqUri;
//	                lLoginResult = "NO_USE_YN";
//	                lLoginYn = "N";
//	            }
//
//	        } else {
//	            // USER_ID 없음
//	            lMsg = "입력하신 아이디가 없습니다.";
//	            lUri = pRequest.getRequestURI().replace(pRequest.getServletPath(), "") 
//	                    + "/mnt/mem01/mem01Form.do?reqUri=" + lReqUri;
//	            lLoginResult = "NO_USER_ID";
//	            lLoginYn = "N";
//	        }
//
//	        model.addAttribute("msg", lMsg);
//	        model.addAttribute("uri", lUri);
//	        model.addAttribute("code", lLoginResult);
//
//	    } catch (ArithmeticException e) {
//	        log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
//	    } catch (NumberFormatException e) {
//	        log.error("오류발생 숫자로 변환할 수 없습니다!!");
//	    } catch (ArrayIndexOutOfBoundsException e) {
//	        log.error("오류발생 배열 인덱스를 벗어났습니다!!");
//	    } catch (NegativeArraySizeException e) {
//	        log.error("오류발생 배열 크기를 음수로 지정할 수 없습니다!!");
//	    } catch (NullPointerException e) {
//	        log.error("오류발생 특정 널 값을 가진 변수를 참조할 수 없습니다!!");
//	    } catch (NoSuchMethodError e) {
//	        log.error("오류발생 메서드를 찾을 수 없습니다!!");
//	    } catch (NoClassDefFoundError e) {
//	        log.error("오류발생 클래스를 찾을 수 없습니다!!");
//	    } catch (RuntimeException e) {
//	        log.error("오류발생 런타임!!");
//	    } catch (Exception e) {
//	        log.error("오류발생!!");
//	    }
//
//	    return "/mem01/loginProc";
//	}

	
	
	

	/**
	 * SSO 로그인처리
	 * 
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return
	 */
	@RequestMapping(value = " /login/loginSso.do")
	public String loginSsoProc(HttpServletRequest pRequest,
			HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
		try {

			// ---------------------------------------------------
			// declare local variables
			// ---------------------------------------------------
			String lMsg = "";
			String lUri = "";
			String lLoginResult = "";
			String lLoginYn = "";

			log.info("===========================================");
			log.info(">>>>pRequestParamMap.toString() : "
					+ pRequestParamMap.toString());
			log.info("===========================================");
			String lReqUri =""; 
					/*StringUtils.defaultString(
					(String) pRequestParamMap.get("reqUri"), "/maa01/maa01.do");*/

			/* 사용자 정보 DB select */
			UserVO user = loginService.selectSsoLogin(pRequestParamMap);

			if (user != null) {// USER_ID 있음
				if (user.getUseYn().equals("Y")) { // 사용여부 Y

					if (user.getUserType().equals("M") || user.getUserType().equals("A")) {
						// 권한이 모니터요원, 관리자만 사용가능
						lLoginResult = "SUCCESS";
						lLoginYn = "Y";
						lUri = lReqUri;

						HttpSession session = pRequest.getSession(true);
						session.setAttribute("CONNECTION_USER_IDENTITY_ABCDEFGHIJKLMN",user.getUserId());
						session.setAttribute("SESSION_USER_ID",user.getUserId());
						session.setAttribute("SESSION_CMP_CODE",user.getCompCode());
						session.setAttribute("SESSION_SAN_CD", user.getRemark());
						// session.setAttribute("SESSION_GRP_AUTH_CODE",
						// dbGrpAuthCode);
						session.setAttribute("SESSION_MONITOR_TYPE",user.getMonitorType());
						session.setAttribute("SESSION_USER_TYPE",user.getUserType());
						session.setAttribute("LOCALE", Locale.getDefault());

						// int lSessionPeriodSeconds = Integer.parseInt(StringUtils.defaultString((String)propertyService.getString("sessionPeriodSeconds"),"3600"));
						// session.setMaxInactiveInterval( lSessionPeriodSeconds );
						//session.setMaxInactiveInterval(60*20);

						model.addAttribute("user", user);

					} else {
						lMsg = "권한이 없습니다.";
						lUri = pRequest.getRequestURI().replace(pRequest.getServletPath(), "")+ "/mnt/mem01/mem01Form.do?reqUri=" + lReqUri;
						lLoginResult = "NO_AUTH";
						lLoginYn = "N";
					}
				} else {
					// 사용여부 N
					lMsg = "로그인 할 수 없는 계정입니다. 관리자에게 문의하세요.";
					lUri = pRequest.getRequestURI().replace(
							pRequest.getServletPath(), "")
							+ "/mnt/mem01/mem01Form.do?reqUri=" + lReqUri;
					lLoginResult = "NO_USE_YN";
					lLoginYn = "N";
				}

			} else {
				// USER_ID 없음
				lMsg = "만료된 SSO 입니다.";
				lUri = pRequest.getRequestURI().replace(
						pRequest.getServletPath(), "")
						+ "/mnt/mem01/mem01Form.do?reqUri=" + lReqUri;
				lLoginResult = "NO_USER_ID";
				lLoginYn = "N";
			}
			
			model.addAttribute("msg", lMsg);
			model.addAttribute("uri", lUri);
			model.addAttribute("code", lLoginResult);

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
		return "/mem01/loginProc";
	}
	
	
	public String encodedKey() throws Exception {
		byte[] buffer = new byte[5 + 5 * 5];
	    new Random().nextBytes(buffer);
	    Base32 codec = new Base32();
	    byte[] secretKey = Arrays.copyOf(buffer, 10);  //16자 이상이여하므로 10으로 설정 필요
	    byte[] bEncodedKey = codec.encode(secretKey);
	     
	    //인증키 생성
	    String encodedKey = new String(bEncodedKey); 
	    logger.info("encodedKey", encodedKey);
	    return encodedKey;
	}
	
	//코드 체크 함수
	private static boolean check_code(String secret, long code, long t) throws InvalidKeyException, NoSuchAlgorithmException {
		Base32 codec = new Base32();
		byte[] decodedKey = codec.decode(secret);

		int window = 3;
		for (int i = -window; i <= window; ++i) {
			long hash = verify_code(decodedKey, t + i);

			if (hash == code) {
				return true;
			}
		}

		return false;
	}
	
	//바코드 생성 함수
	public static String getQRBarcodeURL(String user, String host, String secret) {
		String format = "http://chart.apis.google.com/chart?123123213213fadsdsaf";

		return String.format(format, user, host, secret);
	}
	

	//코드 확인 함수
	private static int verify_code(byte[] key, long t) throws NoSuchAlgorithmException, InvalidKeyException{
		byte[] data = new byte[8];
		long value = t;
		for (int i = 8; i-- > 0; value >>>= 8) {
			data[i] = (byte) value;
		}

		SecretKeySpec signKey = new SecretKeySpec(key, "HmacSHA1");
		Mac mac = Mac.getInstance("HmacSHA1");
		mac.init(signKey);
		byte[] hash = mac.doFinal(data);

		int offset = hash[20 - 1] & 0xF;

		long truncatedHash = 0;
		for (int i = 0; i < 4; ++i) {
			truncatedHash <<= 8;
			truncatedHash |= (hash[offset + i] & 0xFF);
		}

		truncatedHash &= 0x7FFFFFFF;
		truncatedHash %= 1000000;

		return (int) truncatedHash;
	}
	

	/**
	 * 로그아웃 처리
	 * 
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/login/logoutProc.do")
	public String logoutProc(HttpServletRequest pRequest,
			HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, Model model)

	{

		log.info("===========================================");
		log.info("======  logoutProc ======");
		log.info("===========================================");
		log.info(">>>>pRequestParamMap.toString() : "
				+ pRequestParamMap.toString());
		printRequest(pRequest);
		log.info("===========================================");

		// String result = "FAIL";
		//
		// HttpSession session = pRequest.getSession(false);
		// if(session != null){
		// result = "SUCCESS";
		// session.invalidate();
		// }
		//
		// model.addAttribute("result", result);
		//
		// return "jsonView";

		Map<String, String> resultMap = new HashMap<String, String>();

		HttpSession session = pRequest.getSession(false);
		if (session != null) {

			session.invalidate();

		}

		/*
		 * resultMap.put("code",
		 * messageSource.getMessage("dms.rtn_code.SESSION_FINISH", null,
		 * Locale.getDefault()) ); resultMap.put("msg",
		 * messageSource.getMessage("dms.rtn_code.SESSION_FINISH_MSG", null,
		 * Locale.getDefault()) );
		 * 
		 * model.addAttribute("code",
		 * messageSource.getMessage("dms.rtn_code.SESSION_FINISH", null,
		 * Locale.getDefault()) ); model.addAttribute("msg",
		 * messageSource.getMessage("dms.rtn_code.SESSION_FINISH_MSG", null,
		 * Locale.getDefault()) );
		 */
		model.addAttribute("result", resultMap);
		return "redirect:/mnt/mem01/mem01Form.do";
	}

	/**
	 * 로그아웃처리 (json)
	 * 
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/login/logout.json")
	public String logout(HttpServletRequest pRequest,
			HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, Model model)

	{

		log.info("===========================================");
		log.info("======  logout ======");
		log.info("===========================================");
		log.info(">>>>pRequestParamMap.toString() : "
				+ pRequestParamMap.toString());
		printRequest(pRequest);
		log.info("===========================================");

		Map<String, String> resultMap = new HashMap<String, String>();

		HttpSession session = pRequest.getSession(false);
		if (session != null) {

			session.invalidate();
		}

		resultMap.put("code", messageSource.getMessage(
				"fpminput.main.rtn_code.SESSION_FINISH", null,
				Locale.getDefault()));
		resultMap.put("msg", messageSource.getMessage(
				"fpminput.main.rtn_code.SESSION_FINISH_MSG", null,
				Locale.getDefault()));

		model.addAttribute("result", resultMap);
		return "jsonView";
	}

	/**
	 * 세션 없을 경우 처리
	 * 
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/login/sessionNullForReturn.do")
	public String sessionNullForReturn(HttpServletRequest pRequest,
			HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		log.info("===========================================");
		log.info("======  sessionNullForReturn ======");
		log.info("===========================================");
		log.info(">>>>pRequestParamMap.toString() : "
				+ pRequestParamMap.toString());
		printRequest(pRequest);
		log.info("===========================================");

		Map<String, String> resultMap = new HashMap<String, String>();
		resultMap.put("code", messageSource.getMessage(
				"fpminput.main.rtn_code.SESSION_FINISH", null,
				Locale.getDefault()));
		resultMap.put("msg", messageSource.getMessage(
				"fpminput.main.rtn_code.SESSION_FINISH_MSG", null,
				Locale.getDefault()));
		log.info("resultMap:" + resultMap);

		model.addAttribute("result", resultMap);

		return "/mem01/loginRedirect";

	}

	/**
	 * 세션 없을 경우 처리 (json)
	 * 
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/login/sessionNullForAjaxReturn.json")
	public String sessionNullForAjaxReturn(HttpServletRequest pRequest,
			HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		log.info("===========================================");
		log.info("======  sessionNullForAjaxReturn ======");
		log.info("===========================================");
		log.info(">>>>pRequestParamMap.toString() : "
				+ pRequestParamMap.toString());
		printRequest(pRequest);
		log.info("===========================================");

		Map<String, String> resultMap = new HashMap<String, String>();
		resultMap.put("code", messageSource.getMessage("fpminput.main.rtn_code.SESSION_FINISH", null,Locale.getDefault()));
		resultMap.put("msg", messageSource.getMessage("fpminput.main.rtn_code.SESSION_FINISH_MSG", null,Locale.getDefault()));
		log.info("resultMap:" + resultMap);

		model.addAttribute("result", resultMap);

		return "jsonView";

	}

	/**
	 * 권한 없을 경우 처리
	 * 
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/login/noAuthRedirect2.do")
	public String noAuthRedirect2(HttpServletRequest pRequest,
			HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		log.info("===========================================");
		log.info("======  noAuthRedirect2 ======");
		log.info("===========================================");
		log.info(">>>>pRequestParamMap.toString() : "+ pRequestParamMap.toString());
		printRequest(pRequest);
		log.info("===========================================");
		model.put("pRequestParamMap", pRequestParamMap);
		return "/mem01/noAuthRedirect";
	}

	/**
	 * 권한 없을 경우 처리 (json)
	 * 
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/login/noAuthRedirect.json")
	public String noAuthRedirect(HttpServletRequest pRequest,
			HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
		try {
			log.info("===========================================");
			log.info("======  noAuthRedirect ======");
			log.info("===========================================");
			log.info(">>>>pRequestParamMap.toString() : "
					+ pRequestParamMap.toString());
			printRequest(pRequest);
			log.info("===========================================");

			// ----------------------------------------------------------------
			// return json
			// ----------------------------------------------------------------
			Map<String, String> resultMap = new HashMap<String, String>();
			resultMap.put("code", messageSource.getMessage("fpminput.main.rtn_code.NOK", null, Locale.getDefault()));
			resultMap.put("msg",messageSource.getMessage("fpminput.main.rtn_code.NO_AUTHORITY", null,Locale.getDefault())+ "(" + pRequestParamMap.get("noAuthUrl") + ")");

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
			log.error("오류발생!!");
		}
		return "jsonView";
	}
}
