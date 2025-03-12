package com.fpdisys.dist.customInfo.controller;

import java.security.MessageDigest;
import java.util.HashMap;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.dist.customInfo.domain.CustomInfoVO;
import com.fpdisys.dist.customInfo.service.CustomInfoService;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
 
@Controller
public class CustomInfoController extends BaseController {
//public class CustomInfoController extends HandlerInterceptorAdapter{
  protected Log log = LogFactory.getLog(getClass());
  
  @Autowired
  protected MessageSource messageSource;
  
  @Resource(name = "propertiesService")
  protected EgovPropertyService propertiesService;
  
  @Autowired
  private CustomInfoService customInfoService;
  
  @RequestMapping({"/customInfo/mainLoginForm.do"})
  public String mainLoginForm(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
    if (pRequest.getSession().getAttribute("userId") != null) {
      String userId = pRequest.getSession().getAttribute("userId").toString();
      if (userId != null && !userId.equals(""))
        return "redirect:/customInfo/mainInfoModForm.do"; 
    } 
    return "/customInfo/mainLoginForm";
  }
  
  @RequestMapping({"/customInfo/customInfoForm.do"})
  public String goCustomInfoForm(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
    if (pRequest.getSession().getAttribute("userId") != null) {
      String userId = pRequest.getSession().getAttribute("userId").toString();
      if (userId != null && !userId.equals(""))
        return "redirect:/customInfo/loginCustomInfo.do"; 
    } 
    return "/customInfo/customLoginForm";
  }
//  @RequestMapping({"/customInfo/nextStep.do"})
//  public String nextStep(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
//	String requestURL = pRequest.getRequestURL().toString();
//	System.out.println(requestURL);
//    return "/customInfo/customInfoRegForm";
//  }
  
  @RequestMapping({"/customInfo/nextStep.json"})
  public String nextStep(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
    if (pRequestParamMap.get("vaildation") == null || pRequestParamMap.get("vaildation").equals("")) {
          return "jsonView";
        } 

    pRequest.getSession().setAttribute("vaildation", pRequestParamMap.get("vaildation").toString());
    return "jsonView";
  }
  
  @RequestMapping({"/customInfo/customInfoRegForm.do"})
  public String customInfoRegForm(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
    return "/customInfo/customInfoRegForm";
  }
  
  @RequestMapping({"/customInfo/customInfoRegForm2.do"})
  public String customInfoRegForm2(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession session, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
	  pRequest.getSession().setAttribute("regForm", "Y");
	  return "/customInfo/customInfoRegForm2";
  }
  
  @RequestMapping({"/customInfo/customInfoRegForm3.do"})
  public String customInfoRegForm3(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession session, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
	  // redirect:/customInfo/customInfoForm.do
	  pRequest.getSession().setAttribute("regForm2", "Y");
	  pRequest.getSession().setAttribute("userId", pRequestParamMap.get("userId"));
	  return "/customInfo/customInfoRegForm3";
  }
  
  @RequestMapping({"/customInfo/customInfoSuccess.do"})
  public String customInfoRegFormSuccess(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
	  //redirect:/customInfo/customInfoForm.do
	  pRequest.getSession().setAttribute("regForm3", "Y");
	  return "/customInfo/customInfoRegFormSuccess";
  }
  
  @RequestMapping({"/customInfo/saveUser.json"})
  public String saveUser(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
    if (pRequestParamMap.get("userId") == null || pRequestParamMap.get("userId").equals("")) {
      model.addAttribute("result", Boolean.valueOf(false));
      model.addAttribute("resultMsg", "아이디를 입력하세요.");
      return "jsonView";
    } 
    CustomInfoVO customVo = this.customInfoService.getCustomInfo(pRequestParamMap);
    if (customVo != null) {
      model.addAttribute("result", Boolean.valueOf(false));
      model.addAttribute("resultMsg", "이미 사용중인 계정입니다.");
      return "jsonView";
    } 
    if (pRequestParamMap.get("passwdChk") == null || pRequestParamMap.get("passwdChk").equals("")) {
      model.addAttribute("result", Boolean.valueOf(false));
      model.addAttribute("resultMsg",  "비밀번호를 입력하세요.");
      return "jsonView";
    } 
    if (pRequestParamMap.get("passwd") == null || pRequestParamMap.get("passwd").equals("")) {
      model.addAttribute("result", Boolean.valueOf(false));
      model.addAttribute("resultMsg", "비밀번호를 입력하세요.");
      return "jsonView";
    } 
    if (pRequestParamMap.get("passwdChk") != null && !pRequestParamMap.get("passwdChk").toString().equals(pRequestParamMap.get("passwd").toString())) {
      model.addAttribute("result", Boolean.valueOf(false));
      model.addAttribute("resultMsg", "비밀번호가 일치하지 않습니다.");
      return "jsonView";
    } 
    String msg = validationPasswd(pRequestParamMap.get("passwd").toString());
    if (!msg.equals("success")) {
      model.addAttribute("result", Boolean.valueOf(false));
      model.addAttribute("resultMsg", msg);
      return "jsonView";
    } 
    String base = (String)pRequestParamMap.get("passwd");
    try {
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
      pRequestParamMap.put("passwd", pwd);
      int result = this.customInfoService.saveUser(pRequestParamMap);
      if (result == 0) {
        model.addAttribute("result", Boolean.valueOf(false));
      } else {
        model.addAttribute("result", Boolean.valueOf(true));
      } 
      CustomInfoVO user = this.customInfoService.loginCustomInfo(pRequestParamMap);
      List<CustomInfoVO> list = this.customInfoService.getCustomInfoMs(pRequestParamMap);
      pRequest.getSession().setAttribute("user", user);
      pRequest.getSession().setAttribute("userId", user.getUserId());
      pRequest.getSession().setAttribute("userGubun", user.getUserGubun());
      pRequestParamMap.put("userId", user.getUserId());
      EgovMap searchList = this.customInfoService.getUserSearch(pRequestParamMap);
      pRequest.getSession().setAttribute("searchList", searchList);
      model.addAttribute("list", list);
    } catch (Exception e) {
      model.addAttribute("resultMsg", "사용자 정보 저장을 실패하였습니다.");
      model.addAttribute("result", Boolean.valueOf(false));
      e.printStackTrace();
    } 
    return "jsonView";
  }
  
  @RequestMapping({"/customInfo/saveCustomInfo.json"})
  public String saveCustomInfo(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
    int authCode = this.customInfoService.compareAuthCode(pRequestParamMap);
    if (authCode == 0) {
      model.addAttribute("result", Boolean.valueOf(false));
      model.addAttribute("resultMsg", "인증실패하였습니다.");
      return "jsonView";
    } 
    String base = (String)pRequestParamMap.get("passwd");
    try {
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
      pRequestParamMap.put("passwd", pwd);
      int result = this.customInfoService.saveCustomInfo(pRequestParamMap);
      if (result == 0) {
        model.addAttribute("result", Boolean.valueOf(false));
      } else {
        model.addAttribute("result", Boolean.valueOf(true));
      } 
    } catch (Exception e) {
      model.addAttribute("resultMsg", "사용자 정보 저장을 실패하였습니다.");
      model.addAttribute("result", Boolean.valueOf(false));
      e.printStackTrace();
    } 
    return "jsonView";
  }
  
  @RequestMapping({"/customInfo/updateCustomInfo.json"})
  public String updateCustomInfo(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap, HttpSession session, ModelMap model) {
	  try{
			//customInfoService.updateCustomInfoReal(pRequestParamMap);
			customInfoService.updateCustomInfo(pRequestParamMap);
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
  
  @RequestMapping({"/customInfo/getCustomInfo.json"})
  public String getCustomInfo(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
	  	
	  	String userId = pRequestParamMap.get("userId").toString();
		HttpSession session = pRequest.getSession(true);
		String sessionId = session.getAttribute("userId").toString();
		//System.out.println("param : " + userId);
		//System.out.println("session : " +sessionId);
		if(!sessionId.equals(userId)) {
			model.addAttribute("error", "인증실패하였습니다.");
			return "jsonView";
		}
	    
		CustomInfoVO customVo = this.customInfoService.getCustomInfo(pRequestParamMap);
		model.addAttribute("customInfo", customVo);
		return "jsonView";
  }
  
  @RequestMapping({"/customInfo/getCustomInfoSns.json"})
  public String getCustomInfoData(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
    return "jsonView";
  }
  
  @RequestMapping({"/customInfo/sendAuthCode.json"})
  public String sendAuthCode(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
    String genNum = (new StringBuilder(String.valueOf(generateNumber(6)))).toString();
	pRequestParamMap.put("title", "맞춤알림 설정 인증번호");
	pRequestParamMap.put("content", "화훼유통정보시스템 인증번호는 ["+genNum+"]입니다."); 
    pRequestParamMap.put("authCode", genNum);
    int result = this.customInfoService.sendMail(pRequestParamMap);
    this.customInfoService.deleteAuthCode(pRequestParamMap);
    this.customInfoService.insertAuthCode(pRequestParamMap);
    if (result > 0) {
      model.addAttribute("result", Boolean.valueOf(true));
    } else {
      model.addAttribute("result", Boolean.valueOf(false));
    } 
    return "jsonView";
  }
  
  @RequestMapping({"/customInfo/sendAuthCodeKakao.json"})
  public String sendAuthCodeKakao(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
    String genNum = (new StringBuilder(String.valueOf(generateNumber(6)))).toString();
    pRequestParamMap.put("msgType", "6");
    pRequestParamMap.put("sms", "SMS");
    pRequestParamMap.put("template", "bizp_2017081816055818404313871");
	pRequestParamMap.put("title", "맞춤알림 설정 인증번호");
	pRequestParamMap.put("subject", "화훼유통정보시스템 인증번호는 "+genNum+"입니다.");
    pRequestParamMap.put("authCode", genNum);
    int result = this.customInfoService.sendKakao(pRequestParamMap);
    this.customInfoService.deleteAuthCode(pRequestParamMap);
    this.customInfoService.insertAuthCode(pRequestParamMap);
    if (result > 0) {
      model.addAttribute("result", Boolean.valueOf(true));
    } else {
      model.addAttribute("result", Boolean.valueOf(false));
    } 
    return "jsonView";
  }
  
  @RequestMapping({"/customInfo/compareAuthCode.json"})
  public String compareAuthCode(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam("userId") String userId, @RequestParam("authCode") String authCode, ModelMap model) {
    int authCount;
    Map<String, Object> pRequestParamMap = new HashMap<>();
    pRequestParamMap.put("userId", userId);
    pRequestParamMap.put("authCode", authCode);
    this.logger.debug(">>>>>>> user id : {}", userId);
    this.logger.debug(">>>>>>> auth code : {}", authCode);
    String sessionAuthCount = String.valueOf(pRequest.getSession().getAttribute("authCount"));
    this.logger.debug(">>>>>>> sessionAuthCount : {}", sessionAuthCount);
    if (sessionAuthCount.equals("null")) {
      authCount = 0;
    } else {
      authCount = Integer.parseInt(sessionAuthCount);
    } 
    this.logger.debug("authCount : {}", Integer.valueOf(authCount));
    if (authCount < 5) {
      int result = this.customInfoService.compareAuthCode(pRequestParamMap);
      this.logger.debug(">>>>>>> result : {}", Integer.valueOf(result));
      if (result > 0) {
        //25.03. 22.4 프로세스 검증 누락 – 취약(1) 반영 
        request.getSession().setAttribute("auth_id", userId);
        request.getSession().setAttribute("auth_result", Boolean.valueOf(true));

        model.addAttribute("result", Boolean.valueOf(true));
      } else {
        //25.03. 22.4 프로세스 검증 누락 – 취약(1) 반영 
        request.getSession().setAttribute("auth_result", Boolean.valueOf(false));

        model.addAttribute("result", Boolean.valueOf(false));
        pRequest.getSession().setAttribute("authCount", Integer.valueOf(authCount + 1));
      } 
    } else {
      model.addAttribute("result", Boolean.valueOf(false));
      model.addAttribute("msg", "countOver");
    } 
    return "jsonView";
  }
  
  @RequestMapping({"/customInfo/getPumName.json"})
  public String getPumName(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
    List<String> pumName = this.customInfoService.getPumName(pRequestParamMap);
    model.addAttribute("pumName", pumName);
    return "jsonView";
  }
  
  @RequestMapping({"/customInfo/getGoodName.json"})
  public String getGoodName(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
    List<String> goodName = this.customInfoService.getGoodName(pRequestParamMap);
    model.addAttribute("goodName", goodName);
    return "jsonView";
  }
  
  public int generateNumber(int length) {
    String numStr = "1";
    String plusNumStr = "1";
    for (int i = 0; i < length; i++) {
      numStr = String.valueOf(numStr) + "0";
      if (i != length - 1)
        plusNumStr = String.valueOf(plusNumStr) + "0"; 
    } 
    Random random = new Random();
    int result = random.nextInt(Integer.parseInt(numStr)) + Integer.parseInt(plusNumStr);
    if (result > Integer.parseInt(numStr))
      result -= Integer.parseInt(plusNumStr); 
    return result;
  }
  
  @RequestMapping({"/customInfo/loginCustomInfo.do"})
  public String loginCustomInfo(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap, HttpSession session, ModelMap model) {
    if (pRequest.getSession().getAttribute("userId") != null && !pRequest.getSession().getAttribute("userId").equals("")) {
      pRequestParamMap.put("userId", pRequest.getSession().getAttribute("userId").toString());
      List<CustomInfoVO> list = this.customInfoService.getCustomInfoMs(pRequestParamMap);
      model.addAttribute("list", list);
    } else {
      String userId = (String)pRequestParamMap.get("userId");
      String passwd = (String)pRequestParamMap.get("passwd");
      this.log.info("======== USER_ID  : " + userId + " =========");
      this.log.info("======== PASSWORD : " + passwd + " =========");
      try {
        if (userId != null && passwd != null) {
          // 25.02 22.5 취약점 대응
          // String base = passwd;
          // MessageDigest digest = MessageDigest.getInstance("SHA-256");
          // byte[] hash = digest.digest(base.getBytes("UTF-8"));
          // StringBuffer hexString = new StringBuffer();
          // for (int i = 0; i < hash.length; i++) {
          //   String hex = Integer.toHexString(0xFF & hash[i]);
          //   if (hex.length() == 1)
          //     hexString.append('0'); 
          //   hexString.append(hex);
          // } 
          // String pwd = hexString.toString();
          // pRequestParamMap.put("passwd", pwd);
          pRequestParamMap.put("passwd", passwd);

          CustomInfoVO user = this.customInfoService.loginCustomInfo(pRequestParamMap);
          List<CustomInfoVO> list = this.customInfoService.getCustomInfoMs(pRequestParamMap);
          if (user == null)
            return "redirect:/customInfo/customInfoForm.do"; 
          pRequest.getSession().setAttribute("user", user);
          pRequest.getSession().setAttribute("userId", user.getUserId());
          pRequest.getSession().setAttribute("userGubun", user.getUserGubun());
          pRequestParamMap.put("userId", user.getUserId());
          EgovMap searchList = this.customInfoService.getUserSearch(pRequestParamMap);
          pRequest.getSession().setAttribute("searchList", searchList);
          model.addAttribute("list", list);
        } else {
          return "redirect:/customInfo/customInfoForm.do";
        } 
      }  catch (ArithmeticException e) {
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
    return "/customInfo/customInfoRegFormStep2";
  }
  
  @RequestMapping({"/customInfo/loginCustomInfo.json"})
  public String loginCustomInfo1(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap, HttpSession session, ModelMap model) {
    String userId = (String)pRequestParamMap.get("userId");
    String passwd = (String)pRequestParamMap.get("passwd");
    try {
      if (userId != null && passwd != null) {
        String base = passwd;
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
        pRequestParamMap.put("passwd", pwd);
        CustomInfoVO user = this.customInfoService.loginCustomInfo(pRequestParamMap);
        List<CustomInfoVO> list = this.customInfoService.getCustomInfoMs(pRequestParamMap);
        if (user != null) {
          pRequest.getSession().setAttribute("userId", user.getUserId());
          pRequest.getSession().setAttribute("userGubun", user.getUserGubun());
          pRequestParamMap.put("userId", user.getUserId());
          EgovMap searchList = this.customInfoService.getUserSearch(pRequestParamMap);
          pRequest.getSession().setAttribute("searchList", searchList);
        } 
        model.addAttribute("user", user);
        model.addAttribute("list", list);
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
    return "jsonView";
  }
  
  @RequestMapping({"/customInfo/getCustomInfoMs.json"})
  public String getCustomInfoMs(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap, HttpSession session, ModelMap model) {
    try {
      List<CustomInfoVO> list = this.customInfoService.getCustomInfoMs(pRequestParamMap);
      model.addAttribute("list", list);
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
  
  @RequestMapping({"/customInfo/changePass.json"})
  public String changePass(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
    List<CustomInfoVO> m = this.customInfoService.getCustomInfoList(pRequestParamMap);
    for (int j = 0; j < m.size(); j++) {
      try {
        String id = ((CustomInfoVO)m.get(j)).getUserId();
        String base = ((CustomInfoVO)m.get(j)).getPasswd();
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
        System.out.println(pwd);
        pRequestParamMap.put("userId", id);
        pRequestParamMap.put("newPass", pwd);
        this.customInfoService.updateCustomInfoPw(pRequestParamMap);
      } catch (Exception ex) {
        throw new RuntimeException(ex);
      } 
    } 
    return "jsonView";
  }
  
  @RequestMapping({"/customInfo/mainInfoModForm.do"})
  public String mainInfoModForm(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
    if (pRequest.getSession().getAttribute("userId") == null || pRequest.getSession().getAttribute("userId").toString().equals(""))
      return "redirect:/customInfo/mainLoginForm.do"; 
    return "/customInfo/mainInfoModForm";
  }
  
  @RequestMapping({"/customInfo/loginCustom.do"})
  public String loginCustom(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap, HttpSession session, ModelMap model) {
    pRequest.getSession().invalidate();
    pRequest.getSession().removeAttribute("userId");
    pRequest.getSession().removeAttribute("userGubun");
    pRequest.getSession().removeAttribute("acsYn");
    String userId = (String)pRequestParamMap.get("userId");
    String passwd = (String)pRequestParamMap.get("passwd");
    try {
      if (userId != null && passwd != null) {
        String base = passwd;
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
        System.out.println("#####pwd####");
        System.out.println(pwd);
        pRequestParamMap.put("passwd", pwd);
        CustomInfoVO user = this.customInfoService.loginCustomInfo(pRequestParamMap);
        List<CustomInfoVO> list = this.customInfoService.getCustomInfoMs(pRequestParamMap);
        if (user != null) {
          pRequest.getSession().setAttribute("userId", user.getUserId());
          pRequest.getSession().setAttribute("userGubun", user.getUserGubun());
          pRequest.getSession().setAttribute("acsYn",user.getAcsYn());
          System.out.println("#####################");
          System.out.println(user.getAcsYn());
          System.out.println("#####################");
          pRequestParamMap.put("userId", user.getUserId());
          EgovMap searchList = this.customInfoService.getUserSearch(pRequestParamMap);
          pRequest.getSession().setAttribute("searchList", searchList);
          return "/customInfo/mainInfoModForm";
        } 
        model.addAttribute("msg", "로그인 정보가 올바르지 않습니다");
        model.addAttribute("user", user);
        model.addAttribute("list", list);
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
	} catch (Exception e) {
		e.printStackTrace();
		log.error("오류발생!!");
	}
    return "/customInfo/mainLoginForm";
  }
  
  @RequestMapping({"/customInfo/logOut.do"})
  public String logOut(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> pRequestParamMap, RedirectAttributes redirectAttrs, ModelMap model) {
    request.getSession().invalidate();
    request.getSession().removeAttribute("userId");
    request.getSession().removeAttribute("userGubun");
    return "redirect:/main/flowerMain.do";
  }
  
  @RequestMapping({"/customInfo/getUserSearch.json"})
  public String getUserSearch(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
    if (pRequest.getSession().getAttribute("userId") != null) {
      String userId = pRequest.getSession().getAttribute("userId").toString();
      if (userId == null || userId.equals("")) {
        pRequest.getSession().invalidate();
        model.addAttribute("msg", "로그인 후 이용하실 수 있습니다.");
        return "redirect:/main/flowerMain.do";
      } 
      pRequestParamMap.put("userId", userId);
      EgovMap searchList = this.customInfoService.getUserSearch(pRequestParamMap);
      model.addAttribute("searchList", searchList);
      pRequest.getSession().setAttribute("searchList", searchList);
    } else if (pRequest.getSession().getAttribute("userId") == null || pRequest.getSession().getAttribute("userId").toString().equals("")) {
      return "redirect:/customInfo/mainLoginForm.do";
    } 
    return "jsonView";
  }
  
  @RequestMapping({"/customInfo/insertUserSearch.json"})
  public String setUserSearch(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
    if (pRequest.getSession().getAttribute("userId") != null) {
      String userId = pRequest.getSession().getAttribute("userId").toString();
      if (userId == null || userId.equals("")) {
        pRequest.getSession().invalidate();
        model.addAttribute("msg", "로그인 후 이용하실 수 있습니다.");
        return "redirect:/main/flowerMain.do";
      } 
      pRequestParamMap.put("userId", userId);
      EgovMap searchList = this.customInfoService.getUserSearch(pRequestParamMap);
      int cnt = 0;
      if (searchList != null && !searchList.isEmpty()) {
        cnt = this.customInfoService.updateUserSearch(pRequestParamMap);
      } else {
        cnt = this.customInfoService.insertUserSearch(pRequestParamMap);
      } 
      model.addAttribute("cnt", Integer.valueOf(cnt));
      searchList = this.customInfoService.getUserSearch(pRequestParamMap);
      pRequest.getSession().setAttribute("searchList", searchList);
    } 
    return "jsonView";
  }
  
  @RequestMapping({"/customInfo/selectMenuList.json"})
  public String selectMenuList(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession session, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
    this.log.info("============selectMenuMgtList============" + pRequestParamMap.toString());
    List<EgovMap> resultList = null;
    try {
      resultList = this.customInfoService.selectMenuList();
      model.addAttribute("list", resultList);
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
	} catch (Exception e) {
		log.error(e.getMessage());
	}	
    return "jsonView";
  }
  
  @RequestMapping({"/customInfo/selectMainSet.json"})
  public String selectMainSet(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
    if (pRequest.getSession().getAttribute("userId") != null) {
      String userId = pRequest.getSession().getAttribute("userId").toString();
      if (userId == null || userId.equals("")) {
        pRequest.getSession().invalidate();
        model.addAttribute("msg", "로그인 후 이용하실 수 있습니다.");
        return "redirect:/main/flowerMain.do";
      } 
      pRequestParamMap.put("userId", userId);
      List<EgovMap> selectMainSet = this.customInfoService.selectMainSet(pRequestParamMap);
      model.addAttribute("selectMainSet", selectMainSet);
    } else {
      pRequest.getSession().invalidate();
      model.addAttribute("msg", "로그인 후 이용하실 수 있습니다.");
      return "redirect:/main/flowerMain.do";
    } 
    return "jsonView";
  }
  
  @RequestMapping({"/customInfo/insertMainSet.json"})
  public String insertMainSet(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
    if (pRequest.getSession().getAttribute("userId") != null) {
      String userId = pRequest.getSession().getAttribute("userId").toString();
      if (userId == null || userId.equals("")) {
        pRequest.getSession().invalidate();
        model.addAttribute("msg", "로그인 후 이용하실 수 있습니다.");
        return "redirect:/main/flowerMain.do";
      } 
      pRequestParamMap.put("userId", userId);
      int cnt = 0;
      cnt = this.customInfoService.deleteMainSet(pRequestParamMap);
      pRequestParamMap.put("menuOrder", "1");
      pRequestParamMap.put("menuCd", pRequestParamMap.get("orderNum01"));
      pRequestParamMap.put("menuNm", pRequestParamMap.get("orderTxt01"));
      cnt = this.customInfoService.insertMainSet(pRequestParamMap);
      pRequestParamMap.put("menuOrder", "2");
      pRequestParamMap.put("menuCd", pRequestParamMap.get("orderNum02"));
      pRequestParamMap.put("menuNm", pRequestParamMap.get("orderTxt02"));
      cnt = this.customInfoService.insertMainSet(pRequestParamMap);
      pRequestParamMap.put("menuOrder", "3");
      pRequestParamMap.put("menuCd", pRequestParamMap.get("orderNum03"));
      pRequestParamMap.put("menuNm", pRequestParamMap.get("orderTxt03"));
      cnt = this.customInfoService.insertMainSet(pRequestParamMap);
      pRequestParamMap.put("menuOrder", "4");
      pRequestParamMap.put("menuCd", pRequestParamMap.get("orderNum04"));
      pRequestParamMap.put("menuNm", pRequestParamMap.get("orderTxt04"));
      cnt = this.customInfoService.insertMainSet(pRequestParamMap);
      model.addAttribute("cnt", Integer.valueOf(cnt));
    } 
    return "jsonView";
  }
  
  @RequestMapping({"/customInfo/boomarkList.json"})
  public String customFrom(HttpServletRequest pRequest, HttpServletResponse pRes, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
    if (pRequest.getSession().getAttribute("userId") != null) {
      String userId = pRequest.getSession().getAttribute("userId").toString();
      List<EgovMap> favoriteList = this.customInfoService.getFavoriteList(userId);
      model.addAttribute("favoriteList", favoriteList);
    } 
    return "jsonView";
  }
  
  @RequestMapping({"/customInfo/deleteUser.json"})
  public String leaveMember(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) throws Exception {
    if (request.getSession().getAttribute("userId") != null) {
      pRequestParamMap.put("userId", request.getSession().getAttribute("userId").toString());
    } else {
      model.addAttribute("success", "N");
      return "jsonView";
    } 
    try {
      this.customInfoService.leaveMember(pRequestParamMap);
      model.addAttribute("success", "Y");
    } catch (Exception e) {
      model.addAttribute("success", "N");
      return "jsonView";
    } 
    return "jsonView";
  }
  
  @RequestMapping({"/customInfo/insertFavor.json"})
  public String insertFavor(HttpServletRequest pRequest, HttpServletResponse pRes, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
    if (pRequest.getSession().getAttribute("userId") != null && !pRequest.getSession().getAttribute("userId").toString().equals("")) {
      pRequestParamMap.put("userId", pRequest.getSession().getAttribute("userId").toString());
      int count = this.customInfoService.selectFavor(pRequestParamMap);
      if (count == 0) {
        this.customInfoService.insertFavor(pRequestParamMap);
        model.addAttribute("loginFail", "N");
      } else {
        model.addAttribute("loginFail", "D");
      } 
    } else {
      model.addAttribute("loginFail", "Y");
    } 
    return "jsonView";
  }
  
  @RequestMapping({"/customInfo/deleteFavor.json"})
  public String deleteFavor(HttpServletRequest pRequest, HttpServletResponse pRes, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
    if (pRequest.getSession().getAttribute("userId") != null && !pRequest.getSession().getAttribute("userId").toString().equals("")) {
      pRequestParamMap.put("userId", pRequest.getSession().getAttribute("userId").toString());
      this.customInfoService.deleteFavor(pRequestParamMap);
      model.addAttribute("success", "Y");
      List<EgovMap> favoriteList = this.customInfoService.getFavoriteList(pRequest.getSession().getAttribute("userId").toString());
      model.addAttribute("favoriteList", favoriteList);
    } else {
      model.addAttribute("success", "N");
    } 
    return "jsonView";
  }
  
  public String validationPasswd(String pw) {
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
  
  public boolean spaceCheck(String spaceCheck) {
    for (int i = 0; i < spaceCheck.length(); i++) {
      if (spaceCheck.charAt(i) == ' ')
        return true; 
    } 
    return false;
  }
  
  public boolean continueNumberCheck(String numberCheck) {
    int o = 0;
    int d = 0;
    int p = 0;
    int n = 0;
    int limit = 4;
    for (int i = 0; i < numberCheck.length(); i++) {
      char tempVal = numberCheck.charAt(i);
      if (i > 0 && (p = o - tempVal) > -2 && p < 2)
        if ((n = (p == d) ? (n + 1) : 0) > limit - 3)
          return true;  
      d = p;
      o = tempVal;
    } 
    return false;
  }
}