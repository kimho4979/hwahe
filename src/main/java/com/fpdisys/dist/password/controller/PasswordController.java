package com.fpdisys.dist.password.controller;

import java.security.MessageDigest;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.dist.customInfo.service.CustomInfoService;
import com.fpdisys.dist.password.domain.PasswordVO;
import com.fpdisys.dist.password.service.PasswordService;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class PasswordController extends BaseController {

protected Log log = LogFactory.getLog(this.getClass());	
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Autowired
	private PasswordService passwordService;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Autowired
	private CustomInfoService customInfoService;
	
	@RequestMapping(value="/password/passwordFind.do")
	public String passwordFind(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model, HttpSession session){
		session.setAttribute("authCount", 0);
		log.info("========== PASSWORD FIND PAGE ==============");

		return "/auction/passwordFind";
	}
	
	@RequestMapping(value="/password/sendMail.json")
	public String sendMailButton(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		
		log.info("========== SEND MAIL ==============");
		
		String userId = (String)pRequestParamMap.get("id");
		String idcheck = (String)pRequestParamMap.get("idcheck");
		
		try{
			passwordService.updatePasswordInitYn(userId);	
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
		
		if(idcheck.equals("email")){
			String genNum = generateNumber(6)+"";
		
			pRequestParamMap.put("userId", userId);
			pRequestParamMap.put("title", "맞춤알림 설정 인증번호");
			pRequestParamMap.put("content", "화훼유통정보시스템 인증번호는 ["+genNum+"]입니다."); 
			int result = customInfoService.sendMail(pRequestParamMap);
		
			model.addAttribute("code", genNum);
			model.addAttribute("result","1");
		}else if(idcheck.equals("kakao")){
			String genNum = generateNumber(6)+"";
			pRequestParamMap.put("msgType", "6");
			pRequestParamMap.put("userId", userId);
			pRequestParamMap.put("sms", "SMS");
			pRequestParamMap.put("template", "bizp_2017081816055818404313871");
			pRequestParamMap.put("title", "맞춤알림 설정 인증번호");
			pRequestParamMap.put("subject", "화훼유통정보시스템 인증번호는 "+genNum+"입니다.");
			int result = customInfoService.sendKakao(pRequestParamMap);
		
			model.addAttribute("code", genNum);
			model.addAttribute("result","2");
		}
		
		return "jsonView";
	}
	
	@RequestMapping(value="/password/changePasswd.json")
	public String changePasswd(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		
		log.info("========== CHANGE PASSWORD ==============");
		// 인증코드 비교
			pRequestParamMap.put("userId", pRequestParamMap.get("id"));
			pRequestParamMap.put("userId", pRequestParamMap.get("id"));
			pRequestParamMap.put("authCode", pRequestParamMap.get("code1"));
			
				int authCode = customInfoService.compareAuthCode(pRequestParamMap);
				
				if(authCode == 0){
					model.addAttribute("result", false); 
					model.addAttribute("resultMsg", "인증실패하였습니다.");
					return "jsonView";
				}
				
				if(pRequestParamMap.get("passwdChk")==null || pRequestParamMap.get("passwdChk").equals("")){
					model.addAttribute("result", false);
					model.addAttribute("resultMsg", "비밀번호를 입력하세요.");
					return "jsonView";
				}
				
				//비밀번호 확인
				if(pRequestParamMap.get("passwd")==null || pRequestParamMap.get("passwd").equals("")){
					model.addAttribute("result", false);
					model.addAttribute("resultMsg", "비밀번호를 입력하세요.");
					return "jsonView";
				}else{
					if(pRequestParamMap.get("passwdChk")!=null&&!pRequestParamMap.get("passwdChk").toString().equals(pRequestParamMap.get("passwd").toString())){
						model.addAttribute("result", false);
						model.addAttribute("resultMsg", "비밀번호가 일치하지 않습니다.");
						return "jsonView";
					}else{
						String msg=validationPasswd(pRequestParamMap.get("passwd").toString());
						if(!msg.equals("success")){
							model.addAttribute("result", false);
							model.addAttribute("resultMsg", msg);
							return "jsonView";
						}
					}
				}
		try{
			String base = (String) pRequestParamMap.get("passwd"); // 입력받은 pwd를 암호화 시키기 위해 base 에 넣음
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
			byte[] hash = digest.digest(base.getBytes("UTF-8"));
			StringBuffer hexString = new StringBuffer();
			for (int i = 0; i < hash.length; i++) {
				String hex = Integer.toHexString(0xff & hash[i]);
				if (hex.length() == 1)
					hexString.append('0');
				hexString.append(hex);
			}			
			String pwd = hexString.toString();
			
			pRequestParamMap.put("passwdChk", pwd);
			
			
			int result = passwordService.updateChangePassword(pRequestParamMap);

			if(result==0){
				model.addAttribute("result", false);
			}else{
				model.addAttribute("result", true);
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
			log.error("오류발생!! ");
		} 

		//return "/auction/passwordFind2";
		return "jsonView";
	}
	
	@RequestMapping(value="/password/findEmail.json")
	public String selectEmail(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		
		log.info("========== FIND MAIL ==============");
		try{
			
			List<PasswordVO> list = passwordService.passwordMailInfo(pRequestParamMap);
			
			model.addAttribute("list",list);
			
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
	
	public int generateNumber(int length) {
		 
		String numStr = "1";
		String plusNumStr = "1";
	 
		for (int i = 0; i < length; i++) {
			numStr += "0";
	 
			if (i != length - 1) {
				plusNumStr += "0";
			}
		}
	 
		Random random = new Random();
		int result = random.nextInt(Integer.parseInt(numStr)) + Integer.parseInt(plusNumStr);
	 
		if (result > Integer.parseInt(numStr)) {
			result = result - Integer.parseInt(plusNumStr);
		}
	 
		return result;
	}
	
	public String validationPasswd(String pw){
		String returnValue = "success";
		  Pattern p = Pattern.compile("([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])");
		  Matcher m = p.matcher(pw);
		  Pattern p2 = Pattern.compile("(\\w)\\1\\1\\1");
		  Matcher m2 = p2.matcher(pw);
		  Pattern p3 = Pattern.compile("([\\{\\}\\[\\]\\/?.,;:|\\)*~`!^\\-_+<>@\\#$%&\\\\\\=\\(\\'\\\"])\\1\\1\\1");
		  Matcher m3 = p3.matcher(pw);
		  if(spaceCheck(pw)){	//패스워드 공백 문자열 체크
			returnValue = "비밀번호에 공백문자를 허용하지 않습니다.";
		  }else if(pw.length() < 10 || pw.length() > 16){	//자릿수 검증
			returnValue = "비밀번호는 10자 이상, 16자 이하로 구성하세요.";
		  }else if(!m.find()){	//정규식 이용한 패턴 체크
			returnValue = "비밀번호는 영문,숫자,특수문자(!@$%^&* 만 허용)를\n조합하여 10~16자로 구성하세요.";
		  }else if(m2.find() || m3.find()){	// 동일 문자 4번 입력 시 패턴 체크
			returnValue = "비밀번호에 동일문자를 4번 이상 사용할 수 없습니다.";
		  }else if(continueNumberCheck(pw)){	// 비밀번호 연속 숫자 4자리 체크
			returnValue = "비밀번호에 연속된 숫자를 4자 이상 사용 할 수 없습니다.";
		  }
		  return returnValue;
	}
	
	public boolean spaceCheck(String spaceCheck){
	  for(int i = 0 ; i < spaceCheck.length() ; i++) {
		if(spaceCheck.charAt(i) == ' ')
		  return true;
	  }
	  return false;
	}
	
	public boolean continueNumberCheck(String numberCheck){
	  int o = 0;
	  int d = 0;
	  int p = 0;
	  int n = 0;		
	  int limit = 4;
	  for(int i = 0 ; i < numberCheck.length() ; i++) {
		char tempVal = numberCheck.charAt(i);
		if (i > 0 && (p = o - tempVal) > -2 && p < 2 && (n = p == d ? n + 1 : 0) > limit - 3)
		  return true;
		d = p;
		o = tempVal;
	  }
	  return false;
	}
	
}