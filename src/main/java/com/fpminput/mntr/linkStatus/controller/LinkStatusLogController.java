    package com.fpminput.mntr.linkStatus.controller;

import com.at.service.aTService;
import com.egovapi.service.CommonApiLogService;
import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.dist.trans.service.TsaleService;
import com.fpminput.mntr.linkStatus.service.LinkStatusLogService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

@Controller
public class LinkStatusLogController extends BaseController {
   protected Log log = LogFactory.getLog(this.getClass());
   @Autowired
   protected MessageSource messageSource;
   @Resource(
      name = "propertiesService"
   )
   protected EgovPropertyService propertyService;
   @Autowired
   LinkStatusLogService linkStatusLogService;
   @Autowired
   TsaleService tsaleService;
   @Autowired
   aTService aTService;
   @Autowired
   CommonApiLogService commonApiLogService;
   @Autowired
   TsaleService calService;

   @RequestMapping({"/linkStatus/linkStatusLog.do"})
   public String linkStatusLog(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
      this.log.info("==========lmhlmh==============");
      HttpSession httpSession = pRequest.getSession();
      return httpSession.getAttribute("SESSION_USER_ID") != null && !httpSession.getAttribute("SESSION_USER_ID").equals("") ? "/linkStatus/linkStatusLog" : "redirect:/mnt/mem01/mem01Form.do";
   }

   @RequestMapping({"/mntr/linkStatus/selectLogList.json"})
   public String selectLogList(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession session, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
      try {
         List<EgovMap> resultList = this.linkStatusLogService.selectLogList(pRequestParamMap);
         model.addAttribute("list", resultList);
      } catch (ArithmeticException var8) {
         this.log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
      } catch (NumberFormatException var9) {
         this.log.error("오류발생 숫자로 변환 할 수 없습니다!!");
      } catch (ArrayIndexOutOfBoundsException var10) {
         this.log.error("오류발생 배열인텍스에서 벗어났습니다!!");
      } catch (NegativeArraySizeException var11) {
         this.log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
      } catch (NullPointerException var12) {
         this.log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
      } catch (NoSuchMethodError var13) {
         this.log.error("오류발생 메서드를 찾을수 없습니다!!");
      } catch (NoClassDefFoundError var14) {
         this.log.error("오류발생 클래스를 찾을 수 없습니다!!");
      } catch (RuntimeException var15) {
         this.log.error("오류발생 런타임!!");
      } catch (Exception var16) {
         this.log.error("오류발생!!");
      }

      return "jsonView";
   }

   @RequestMapping({"/mntr/linkStatus/seelctSysGp.json"})
   public String seelctSysGp(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession session, ModelMap model) {
      HashMap pRequestParamMap = new HashMap();

      try {
         List<EgovMap> resultList = this.linkStatusLogService.selectSysGp(pRequestParamMap);
         model.addAttribute("list", resultList);
      } catch (ArithmeticException var8) {
         this.log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
      } catch (NumberFormatException var9) {
         this.log.error("오류발생 숫자로 변환 할 수 없습니다!!");
      } catch (ArrayIndexOutOfBoundsException var10) {
         this.log.error("오류발생 배열인텍스에서 벗어났습니다!!");
      } catch (NegativeArraySizeException var11) {
         this.log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
      } catch (NullPointerException var12) {
         this.log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
      } catch (NoSuchMethodError var13) {
         this.log.error("오류발생 메서드를 찾을수 없습니다!!");
      } catch (NoClassDefFoundError var14) {
         this.log.error("오류발생 클래스를 찾을 수 없습니다!!");
      } catch (RuntimeException var15) {
         this.log.error("오류발생 런타임!!");
      } catch (Exception var16) {
         this.log.error("오류발생!!");
      }

      return "jsonView";
   }

   @RequestMapping({"/mntr/linkStatus/reProcessing.do"})
   public void reProcessing(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam("logSeq") String param) {
      Map<String, Object> pRequestParamMap = new HashMap();
      pRequestParamMap.put("logSeq", param);
      EgovMap result = this.linkStatusLogService.selectLog(pRequestParamMap);
      String sysGp = result.get("sysGp").toString();
      String startDate = result.get("startDate").toString().substring(0, 8);

      try {
         //String url = "http://210.103.25.28:8082/";
    	 String url = "https://192.168.124.124:8080/";
         Map<String, Object> sendMap = new HashMap();
         if (sysGp.equals("2")) {
            System.out.println("================= 행사일정 API 재기동 ====================");
            url = url + "neisUpdate.do";
            sendMap.put("yyyymmdd", startDate);
         } else if (sysGp.equals("3")) {
            System.out.println("================= 시험일정 API 재기동 ====================");
            url = url + "qnetUpdate.do";
            sendMap.put("yyyymmdd", startDate);
         } else if (sysGp.equals("4")) {
            System.out.println("================= 식물검역통계 API 재기동 ====================");
            url = url + "plntUpdate.do";
            sendMap.put("yyyymmdd", startDate);
         } else {
            if (!sysGp.equals("5")) {
               throw new Exception("SYS_GP 값이 잘못되었습니다.");
            }

            System.out.println("================= 품목별수출입실적 API 재기동 ====================");
            url = url + "custUpdate.do";
            sendMap.put("yyyymmdd", startDate);
         }

         RestTemplate client = new RestTemplate();
         HttpHeaders header = new HttpHeaders();
         header.set("Content-Type", "application/json;");
         header.set("charset", "UTF-8");
         HttpEntity<Map<String, Object>> request = new HttpEntity(sendMap, header);
         client.postForObject(url, request, Map.class, new Object[0]);
      } catch (Exception var13) {
         System.out.println("================= 잘못된 재기동 요청입니다.====================");
         System.out.println(var13.getMessage());
         var13.printStackTrace();
      }

   }
}