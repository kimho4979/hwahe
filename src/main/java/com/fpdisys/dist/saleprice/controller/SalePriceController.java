package com.fpdisys.dist.saleprice.controller;

import java.io.IOException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.at.domain.AtMarketVO;
import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.base.util.JsonUtils;
import com.fpdisys.dist.saleprice.domain.SalePriceVO;
import com.fpdisys.dist.saleprice.service.SalePriceService;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class SalePriceController extends BaseController{

protected Log log = LogFactory.getLog(this.getClass());	
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Autowired
	SalePriceService salePriceService;
	
	@RequestMapping(value="/auction/SalePrice.do")
	public String SalePrice(
 			HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
	 		@RequestParam Map<String, Object> pRequestParamMap,
	 		ModelMap model) {			 
 		
		PaginationInfo paginationInfo = new PaginationInfo();
		
		try{	
			// 월 셋팅 
				String regMonth="";
				if(pRequestParamMap.get("datepicker")!=null && !StringUtils.isBlank(pRequestParamMap.get("datepicker").toString())){
					regMonth = pRequestParamMap.get("datepicker").toString();
				}else{
					regMonth = salePriceService.selectFastDay();
				}
				model.addAttribute("regMonth", regMonth);
				pRequestParamMap.put("REG_MONTH", regMonth);
			  
			  
				List<SalePriceVO> resultList = salePriceService.selectSalePrice(pRequestParamMap);						
				List<SalePriceVO> pointSale = salePriceService.selectPointSalePrice(pRequestParamMap, paginationInfo);	
				
				if(!pointSale.isEmpty()){					
					
					if(paginationInfo != null){					
						
						SalePriceVO data = (SalePriceVO)pointSale.get(0);
						paginationInfo.setTotalRecordCount(Integer.parseInt(data.getTotalCount()));
					}
				
				}else{
					paginationInfo.setTotalRecordCount(0);
				}
				
				String jsonList =  JsonUtils.toJson(resultList);
				
				model.addAttribute("resultList", resultList);				
				model.addAttribute("list", jsonList);				
				model.addAttribute("pointSale", pointSale);		
				model.addAttribute("paginationInfo", paginationInfo);
				
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
		 		
		  	return "/auction/SalePrice";
		  	
	 }
	
	
	 @RequestMapping(value="/hdb02/chartList.json")
		public String chartList(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse,
				HttpSession  session,
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{		 						
		 	  		
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
			try{
				List<SalePriceVO> resultList = salePriceService.selectSalePrice(pRequestParamMap);				
				
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
			} catch (RuntimeException e) {
				log.error("오류발생 런타임!!");
			} catch (Exception e) {
				log.error("오류발생!!");
			} 													
			 return "jsonView";
		}
	 
	 @RequestMapping(value="/biz/getBizMsg.json")
		public String getBizMsg(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{
			 if(pRequestParamMap.get("key").equals("flower")){
				 List<?> resultList  =  (List<?>)salePriceService.getBizMsg(pRequestParamMap);
				model.addAttribute("list", resultList);
			 }
			
			 return "jsonView";
		} 
	 
	 @RequestMapping(value="/biz/delBizMsg.json")
		public String delBizMsg(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{
			 if(pRequestParamMap.get("key").equals("flower")){
				 salePriceService.delBizMsg(pRequestParamMap);
			 }
			
			 return "jsonView";
		} 
	 
	 
	 @RequestMapping(value="/biz/getBizMail.json")
		public String getBizMail(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{
		 if(pRequestParamMap.get("key").equals("flower")){
			 List<?> resultList  =  (List<?>)salePriceService.getBizMail(pRequestParamMap);
				model.addAttribute("list", resultList);
		 }
			 return "jsonView";
		} 
	
	 @RequestMapping(value="/biz/delBizMail.json")
		public String delBizMail(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{
			 if(pRequestParamMap.get("key").equals("flower")){
				 salePriceService.delBizMail(pRequestParamMap);
			 }
			
			 return "jsonView";
		} 
	 
	// 20171107 김민주 카카오메시지 로그 저장
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/biz/BizMsgOracleInsert.json")
		public String BizMsgOracleInsert(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse,
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{
		
			//log.debug("pRequestParamMap : \n " + pRequestParamMap.toString());
			
			log.debug("카카오 메시지 로그 저장 로직 시작");
		 	List<Map<String, String>> insertList = null;
			try {
				String list = String.valueOf(pRequestParamMap.get("list"));
				list = list.replaceAll("&#34;", "\"");
				//log.debug("list data : \n " + list);
				
			 	if(!StringUtils.isBlank(list)){
			 		list ="{\"ALL\":"+list+"}";
				}
			 	
				log.debug("Json Parsing Before");
				// 파싱
				insertList = (List<Map<String, String>>)getVoFromMultiJson(list, "ALL", new HashMap<String, String>().getClass());
				log.debug("Json Parsing After");
				
				// 오라클 데이터 인서트
				if(insertList != null && insertList.size() > 0){
					salePriceService.insertBizMSGForOarcle(insertList);
					log.debug("data Insert Or Update Success");
				}
				
				log.debug("카카오 메시지 로그 저장 로직 종료");
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
	 
	 
	 public List getVoFromMultiJson(String pJsonString, String pNodeName, Class pClass) throws ParseException, JsonParseException, JsonMappingException, IOException, ParseException

		{
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
