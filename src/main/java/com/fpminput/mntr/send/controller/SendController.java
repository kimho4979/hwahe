package com.fpminput.mntr.send.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.DeserializationConfig;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fpdisys.base.mvc.BaseController;
import com.fpminput.mntr.send.service.SendService;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class SendController extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
			
	@Autowired
	SendService sendService;
	
	// SMS 발송
	@RequestMapping(value="/send/sendSms.do")
	public String sendSms(HttpServletRequest pRequest, HttpServletResponse pResponse 
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
		
		log.info("==========lmhlmh==============");
		HttpSession httpSession = pRequest.getSession();
		
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			
			return "redirect:/mnt/mem01/mem01Form.do";
		}
		 
		return "/send/sms/send";
	}
	
	// SMS 발송 :: INSERT
	@RequestMapping(value="/send/sendSmsTranferInsert.json")
	public String sendSmsTranferInsert(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, String phoneList, ModelMap model){		 						

		log.info("============sendSmsTranferInsert============"+pRequestParamMap.toString());
		
		try{
			if(!StringUtils.isBlank(phoneList)){
				phoneList ="{\"ALL\":"+phoneList+"}";
			}
			List<Map<String, String>> phoneBook = (List<Map<String, String>>)getVoFromMultiJson(phoneList, "ALL", new HashMap<String, String>().getClass());
			
			for(int i=0; i<phoneBook.size(); i++){
				String receiveNum = phoneBook.get(i).get("mob");
				pRequestParamMap.put("receiveNum", receiveNum);
				sendService.insertSmsTranfer(pRequestParamMap);
				//sendService.insertSmsTranferLog(pRequestParamMap);
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
			log.error(e.getMessage());
		}								
		return "jsonView";
	}
	
	// EMAIL 발송
	@RequestMapping(value="/send/sendEmail.do")
	public String sendEmail(HttpServletRequest pRequest, HttpServletResponse pResponse 
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		
		log.info("==========lmhlmh==============");
		HttpSession httpSession = pRequest.getSession();
		
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			
			return "redirect:/mnt/mem01/mem01Form.do";
		}
		 
		return "/send/email/send";
	}
	
	// SMS 발송 :: INSERT
	@RequestMapping(value="/send/sendEmailTranferInsert.json")
	public String sendEmailTranferInsert(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, String phoneList, ModelMap model){		 						

		log.info("============sendEmailTranferInsert============"+pRequestParamMap.toString());
		
		try{
			sendService.insertEmailTranfer(pRequestParamMap);
			//sendService.insertEmailTranferLog(pRequestParamMap);
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
	
	// PhoneBook List JSON
	public List getVoFromMultiJson(String pJsonString, String pNodeName, Class pClass) throws ParseException, JsonParseException, JsonMappingException, IOException, ParseException{
		//----------------------------------------------------------------
		// JSON STRING -> JSON OBJECT로 변환  ObjectMapper.configure( org.codehaus.jackson.map.SerializationConfig.Feature.FAIL_ON_EMPTY_BEANS, false);
		//----------------------------------------------------------------
		JSONObject jSONObject = new JSONObject();
		// jSONObject = (JSONObject) new JSONParser().parse(pJsonString.toString());
		jSONObject = (JSONObject) new JSONParser().parse(pJsonString);

		//----------------------------------------------------------------
		// data node 구함
		//----------------------------------------------------------------
		JSONArray lJsonArray = ((JSONArray)jSONObject.get(pNodeName));
		ArrayList lRtn = new ArrayList();


		ObjectMapper lObjectMapper = new ObjectMapper();
		lObjectMapper.configure(DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES, false);

		for ( int inx = 0 ; inx < lJsonArray.size(); inx++)
		{
		  Object lClass = lObjectMapper.readValue(lJsonArray.get(inx).toString(), pClass);
		  lRtn.add(lClass);
		}

		return lRtn;
	}
 
}
