package com.fpminput.mntr.codeManage.controller;

import static org.hamcrest.CoreMatchers.nullValue;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.base.util.HttpUtil;
import com.fpminput.mntr.codeManage.domain.CodeManageVO;
import com.fpminput.mntr.codeManage.service.CodeManageService;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class CodeManageController extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired 
	protected MessageSource messageSource; 
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
			
	@Autowired
	CodeManageService codeManageService;
	
	
	/*
	// 실시간 데이터 코드 관리
	@RequestMapping(value="/code/realCode.do")
	public String realCode(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			 			 				
		
		HttpSession httpSession = pRequest.getSession();
		
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			
			return "redirect:/mnt/mem01/mem01Form.do";
		}
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		DateFormat df = new SimpleDateFormat("yyyyMMdd");
		
		pRequestParamMap.put("searchEndDate", df.format(cal.getTime()));

		cal.add(Calendar.MONTH, -1);
		
		pRequestParamMap.put("searchStartDate", df.format(cal.getTime()));
		
		model.addAttribute("pRequestParamMap",pRequestParamMap);
		model.addAttribute("userId",httpSession.getAttribute("SESSION_USER_ID"));
		 
		return "/codeManage/real/realCode";
	}
	
	// 실시간 데이터 코드 관리 :: List
	@RequestMapping(value="/code/realCodeList.json")
	public String realCodeList(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						

		log.info("============selectRealCodeList============"+pRequestParamMap.toString());	
	 	
		List<EgovMap> list = null;
		
		try{
			
			JSONObject obj= new JSONObject();
			String startCount = "";
			String endCount = "";
			if(pRequestParamMap.get("startCount")!=null &&
						!StringUtils.isBlank(pRequestParamMap.get("startCount").toString())){
						startCount =pRequestParamMap.get("startCount").toString();
						pRequestParamMap.put("startCount", startCount);
					}else{
						startCount ="1";
						pRequestParamMap.put("startCount", startCount);
					}
			if(pRequestParamMap.get("endCount")!=null &&
						!StringUtils.isBlank(pRequestParamMap.get("endCount").toString())){
				endCount =pRequestParamMap.get("endCount").toString();
						pRequestParamMap.put("endCount", endCount);
					}else{
						endCount ="20";
						pRequestParamMap.put("endCount", endCount);
					}
			
			String pageNo2= "";
			if(pRequestParamMap.get("pageNo2")!=null &&
						!StringUtils.isBlank(pRequestParamMap.get("pageNo2").toString())){
				pageNo2 = pRequestParamMap.get("pageNo2").toString();
						obj.put("pageNo2", pageNo2);
					}else{
						obj.put("pageNo2", "1");
					}
			
			
			if(pRequestParamMap.get("searchStartDate")== null ||
					StringUtils.isBlank(pRequestParamMap.get("searchStartDate").toString())){
				
				Calendar cal = Calendar.getInstance();
				cal.setTime(new Date());
				DateFormat df = new SimpleDateFormat("yyyyMMdd");
				
				pRequestParamMap.put("searchEndDate", df.format(cal.getTime()));

				cal.add(Calendar.MONTH, -1);
				
				pRequestParamMap.put("searchStartDate", df.format(cal.getTime()));
			}
			log.info("obj+++++++++ : " + obj.toString());
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
								
			list = codeManageService.selectRealCodeList(pRequestParamMap);
			
			model.addAttribute("list2", obj);
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
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		
		return "jsonView";
	}
	
	
	// 실시간 데이터 코드 관리 :: UPDATE
	@RequestMapping(value="/code/realCodeUpdate.json")
	public String realCodeUpdate(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						

		log.info("============updateRealCode============"+pRequestParamMap.toString());	
		
		try{
			codeManageService.mergeFlowerGubnNong(pRequestParamMap);
			
			codeManageService.updateRealCode(pRequestParamMap);
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
	}*/
	
	
	// 정산 데이터 코드 관리
	@RequestMapping(value="/code/saleCode.do")
	public String saleCode(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			 			 				
		log.info("==========lmhlmh==============");
		HttpSession httpSession = pRequest.getSession();
		
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		
		pRequestParamMap.put("searchEndDate", df.format(cal.getTime()));

	//	cal.add(Calendar.MONTH, -1);
		
		pRequestParamMap.put("searchStartDate", df.format(cal.getTime()));
		
		model.addAttribute("pRequestParamMap",pRequestParamMap);
		model.addAttribute("userId",httpSession.getAttribute("SESSION_USER_ID"));
		 
		return "/codeManage/sale/saleCode";
	}
	
	// 정산 데이터 코드 관리 :: List
	@RequestMapping(value="/code/saleCodeList.json")
	public String saleCodeList(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						

		log.info("============selectSaleCodeList============"+pRequestParamMap.toString());	
	 	
		List<EgovMap> list = null;
		List<EgovMap> pumL = null;
		List<EgovMap> goodL = null;
		try{
			JSONObject obj= new JSONObject();
			String startCount = "";
			String endCount = "";
			if(pRequestParamMap.get("startCount")!=null &&
						!StringUtils.isBlank(pRequestParamMap.get("startCount").toString())){
						startCount =pRequestParamMap.get("startCount").toString();
						pRequestParamMap.put("startCount", startCount);
					}else{
						startCount ="1";
						pRequestParamMap.put("startCount", startCount);
					}
			if(pRequestParamMap.get("endCount")!=null &&
						!StringUtils.isBlank(pRequestParamMap.get("endCount").toString())){
				endCount =pRequestParamMap.get("endCount").toString();
						pRequestParamMap.put("endCount", endCount);
					}else{
						endCount ="20";
						pRequestParamMap.put("endCount", endCount);
					}
			
			String pageNo2= "";
			if(pRequestParamMap.get("pageNo2")!=null &&
						!StringUtils.isBlank(pRequestParamMap.get("pageNo2").toString())){
				pageNo2 = pRequestParamMap.get("pageNo2").toString();
						obj.put("pageNo2", pageNo2);
					}else{
						obj.put("pageNo2", "1");
					}
			
			
			if(pRequestParamMap.get("searchStartDate")== null ||
					StringUtils.isBlank(pRequestParamMap.get("searchStartDate").toString())){
				
				Calendar cal = Calendar.getInstance();
				cal.setTime(new Date());
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
				
				pRequestParamMap.put("searchEndDate", df.format(cal.getTime()));

				//cal.add(Calendar.MONTH, -1);
				
				pRequestParamMap.put("searchStartDate", df.format(cal.getTime()));
			}
			log.info("obj+++++++++ : " + obj.toString());
		
			
			list = codeManageService.selectSaleCodeList(pRequestParamMap);
			
		//	pumL = codeManageService.selectPumList(pRequestParamMap);
			
			
			model.addAttribute("list2", obj);
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
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		
		return "jsonView";
	}
	
	
	// 정산 데이터 코드 관리 :: UPDATE
	@RequestMapping(value="/code/saleCodeUpdate.json")
	public String saleCodeUpdate(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						

		log.info("============updateSaleCode============"+pRequestParamMap.toString());	
		log.info("#### insertInto #### : " + pRequestParamMap.toString());
		try{
			String regIp = HttpUtil.getRealIp(pRequest);
			pRequestParamMap.put("regIp",regIp);
			HttpSession httpSession = pRequest.getSession();
			if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
				return "jsonView";
			}else{
				String userId = String.valueOf(httpSession.getAttribute("SESSION_USER_ID"));
				pRequestParamMap.put("userId",userId);
			}
			log.info("#### insertInto #### : " + pRequestParamMap.toString());
			
			Object sale = pRequestParamMap.get("txtsale");
			Object changeMejang = pRequestParamMap.get("changeMejang");
			/*로그 적재*/
			codeManageService.insertCodeUpdateLog(pRequestParamMap);
			
			/*농협 코드 머지*/
			codeManageService.mergeFlowerGubnNong(pRequestParamMap);
			
			/*실시간 데이터 변경*/
			codeManageService.updateRealCode(pRequestParamMap);
			
			/*정산 데이터 변경*/
			codeManageService.updateSaleCode(pRequestParamMap);
			
			/* t_int_mapping에 데이터 insert하는 부분. 
			 * t_sale 테이블에 있는 데이터만 t_int_mapping에 넣기 위함.
			 * t_int_sale에 해당하는 데이터를 넣어야 함.  t_int_sale의 데이터에 맞추기 위해서 t_sale의 값을 다시 가져와야함.
			 * select * from t_sale where 해당하는 값의 조건.... 그래서 나온것들을 insert한다...! to t_int_sale에다가*/   
			if(sale.equals("sale") && !changeMejang.equals("5")) {
				//List<EgovMap> list2 = null;
				codeManageService.mergeMappingTable(pRequestParamMap);
				log.info("T_INT_MAPPING 테이블에 머지 인서트 되었습니다.");
				//list2 = codeManageService.selectToIntSaleData(pRequestParamMap);
				//pRequestParamMap.put("list2", list2);
				//System.out.println("list2 값 확인 : " + list2);
				codeManageService.deleteRaw(pRequestParamMap);
				codeManageService.insertIntoTIntSale(pRequestParamMap);
				System.out.println("파람값 확인 : " + pRequestParamMap.toString());

			}
			
			/*'마감로직추가'*/
			codeManageService.deleteSaleCodeDate(pRequestParamMap);
			
			codeManageService.insertSaleCodeDate(pRequestParamMap);
			
			codeManageService.deleteSaleCodeMonth(pRequestParamMap);
			
			codeManageService.insertSaleCodeMonth(pRequestParamMap);
			
			
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
	
	/**
	 * 팝업창 띄우기.
	 * @param codeVO
	 * @param pRequest
	 * @param pResponse
	 * @param session
	 * @param param
	 * @param model
	 * @param status
	 * @param result
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/codeManage/sale/popupEtc.do")
	public ModelAndView popupEtc(@ModelAttribute("codeVO") CodeManageVO codeVO,HttpServletRequest pRequest, HttpServletResponse pResponse, 
			HttpSession session, @RequestParam Map<String, Object> param, ModelMap model, SessionStatus status, BindingResult result) throws Exception {
		if(logger.isDebugEnabled()) {
			logger.debug("/codeManage/sale/popupEtc/ [param: " + param + "]");
		}
		log.info("#########################팝업 모달#############################");
		log.info("############## : " + param.toString());
		log.info("############### : " + param.get("RNUM"));
		log.info("################ : " + param.get("CMP_CD"));
		log.info("################# : " + param.get("ITEM_NM"));
		log.info("################### : " + param.get("ITEM_CD"));
		log.info("#################### : " + param.get("KIND_CD"));
		log.info("##################### : " + param.get("KIND_NM"));
		log.info("###################### : " + param.get("mejang"));
		
		//List<?> pumList = codeManageService.selectPumList(codeVO);
		model.addAttribute("codeVO", new CodeManageVO());
		ModelAndView list = new ModelAndView();
		
		//list.addObject("pumList", pumList);
		
		list.setViewName("/codeManage/sale/popupEtc");
		list.addAllObjects(param);
		return list;
	}
	/**
	 * 품목 리스트 조회해오는 메서드
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/codeManage/sale/selectItem.json")
	public String selectItemJson(HttpServletRequest pRequest, HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) throws Exception{
		try {
			System.out.println("selectItem.json : " + pRequestParamMap);
			List<Map<String, Object>> list = codeManageService.selectItemList(pRequestParamMap);
			model.addAttribute("list", list);
			System.out.println("item : " + list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "jsonView";
	}
	/**
	 * 팝업 모달에서 품종 리스트 조회해오는 메서드
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/codeManage/sale/selectKind.json")
	public String selectKindJson(HttpServletRequest pRequest, HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) throws Exception{
		try {
		System.out.println("selectKind.json  : " + pRequestParamMap);
		List<Map<String, Object>> klist = codeManageService.selectKindList(pRequestParamMap);
		model.addAttribute("klist", klist);
		System.out.println("kind : " + klist);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return "jsonView";
	}
	/**
	 * 팝업 모달에서 기존의 것들과 매핑하는 경우
	 * @param pRequest
	 * @param pResponse
	 * @param session
	 * @param pRequestParamMap
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/codeManage/sale/insertInto.json")
	public String insertInto(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){

		
		log.info("#### insertInto #### : " + pRequestParamMap.toString());
		log.info("### itemCd ### : " + pRequestParamMap.get("itemCd"));
		log.info("### itemNm ### : " + pRequestParamMap.get("itemNm"));
		log.info("### kindCd ###:" + pRequestParamMap.get("kindCd"));
		log.info("### kindNm ###:" + pRequestParamMap.get("kindNm"));
		log.info("### flowerCd ###:" + pRequestParamMap.get("flowerCd"));
		log.info("### cmpCd ###:" + pRequestParamMap.get("cmpCd"));
		log.info("### cmpGood ###:" + pRequestParamMap.get("cmpGood"));
		log.info("### pumNm ###:" + pRequestParamMap.get("pumNm"));
		log.info("### goodNm ###:" + pRequestParamMap.get("goodNm"));
		
		Object itemCd = pRequestParamMap.get("itemCd");
		Object kindCd = pRequestParamMap.get("kindCd");
		
		//누가 등록했는지 확인하기 위해서 세션을 받아오는 작업.
		HttpSession httpSession = pRequest.getSession();
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "jsonView";
		}else{
			String userId = String.valueOf(httpSession.getAttribute("SESSION_USER_ID"));
			pRequestParamMap.put("userId",userId);
			pRequestParamMap.put("userIp", pRequest.getRemoteHost());
			log.info("### userId ### : " + pRequestParamMap.get("userId"));
			log.info("### userIp ### : " + pRequestParamMap.get("userIp"));
		}

		if(itemCd != null) {
			/*원래 있던 코드들과 매핑*/
			if(kindCd != null) { 
				codeManageService.insertIntoMapping(pRequestParamMap);
			}
		}
		/* itemCd는 505 인것으로 kindCd를 max + 1 으로 새로 이름을 딴다. 이때 분류값을 잘 갖고 가야한다 */
		else {
			codeManageService.insertIntoKind(pRequestParamMap);
			codeManageService.insertIntoMapping(pRequestParamMap);
		}
		return "jsonView";
	
	
	}
	/**
	 * 팝업 모달에서 데이터를 새로 추가하는경우
	 * @param pRequest
	 * @param pResponse
	 * @param session
	 * @param pRequestParamMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/codeManage/sale/insertIntoKind.json")
	public String insertIntoKind(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession session
			,@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) throws Exception {
		
		log.info("#### insertInto #### : " + pRequestParamMap.toString());
		log.info("### cmpCd ###:" + pRequestParamMap.get("cmpCd"));
		log.info("### cmpGood ###:" + pRequestParamMap.get("cmpGood"));
		log.info("### flowerGubn ### : " + pRequestParamMap.get("flowerGubn"));
		log.info("### flowerCd ###:" + pRequestParamMap.get("flowerCd"));
		log.info("### itemCd ### : " + pRequestParamMap.get("itemCd"));
		log.info("### itemNm ### : " + pRequestParamMap.get("itemNm"));
		log.info("### kindCd ###:" + pRequestParamMap.get("kindCd"));
		log.info("### kindNm ###:" + pRequestParamMap.get("kindNm"));
		
		Object itemCd = pRequestParamMap.get("itemCd");
		Object kindCd = pRequestParamMap.get("kindCd");
		String aa = "505";

		//누가 등록했는지 확인하기 위해서 세션을 받아오는 작업.
		HttpSession httpSession = pRequest.getSession();
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "jsonView";
		}else{
			String userId = String.valueOf(httpSession.getAttribute("SESSION_USER_ID"));
			pRequestParamMap.put("userId",userId);
			pRequestParamMap.put("userIp", pRequest.getRemoteHost());
			log.info("### userId ### : " + pRequestParamMap.get("userId"));
			log.info("### userIp ### : " + pRequestParamMap.get("userIp"));
		}

		if(itemCd.equals(aa)) {
			System.out.println("itemCd는 505입니다.");
			int resultKind = codeManageService.insertIntoKind(pRequestParamMap);
			System.out.println("resultKind = " + resultKind);
			if(resultKind != 0) {
				/*List<Map<String, Object>> lis = codeManageService.selectKindForMapping(pRequestParamMap);*/
				codeManageService.insertIntoMapping2(pRequestParamMap);
			}
		} else {
			System.out.println("itemCd는 505가 아닙니다.");
			int resultKind = codeManageService.insertIntoKind(pRequestParamMap);
			if(resultKind != 0) {
			codeManageService.insertIntoMapping2(pRequestParamMap);
			}
		}
		return "jsonView";
	}
	
}
