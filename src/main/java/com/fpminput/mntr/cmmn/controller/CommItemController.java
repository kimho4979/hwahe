package com.fpminput.mntr.cmmn.controller;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InterruptedIOException;
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
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fpdisys.base.mvc.BaseController;
import com.fpminput.mntr.cmmn.domain.ItemVO;
import com.fpminput.mntr.cmmn.service.ItemService;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class CommItemController extends BaseController {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Autowired
	ItemService itemService;
	
	@RequestMapping(value="/common/item.do")
	public String itemList(
 			HttpServletRequest pRequest, HttpServletResponse pResponse, 
 			@RequestParam Map<String, Object> pRequestParamMap,
 			ModelMap model){
		
		/*try{
			
			ItemVO itemVo = new ItemVO();
			List<ItemVO> result = (List<ItemVO>)itemService.selectItemListLargeNm(itemVo);
			model.addAttribute("result",result);
			
		} catch (Exception e) {
			 	e.printStackTrace();
		} */
		
		return "/cmmn/commonItem";
	}
	
	@RequestMapping(value="/cmmn/item/itemListLargeNm.json")
	public String gridListLargeNm(
			HttpServletRequest pRequest, 
			HttpServletResponse pResponse,
			HttpSession  session,
	 		@RequestParam Map<String, Object> pRequestParamMap,
	 		ModelMap model){		 						
		try{
			
			String largeCd = (String)pRequestParamMap.get("largeCd");
			
			ItemVO itemVo = new ItemVO();
			itemVo.setLargeCd(largeCd);
			
			List<ItemVO> result = (List<ItemVO>)itemService.selectItemListLargeNm(itemVo);
			model.addAttribute("result",result);
			
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
	
	@RequestMapping(value="/cmmn/item/itemListSmallNm.json")
	public String gridListSmallNm(
			HttpServletRequest pRequest, 
			HttpServletResponse pResponse,
			HttpSession  session,
	 		@RequestParam Map<String, Object> pRequestParamMap,
	 		ModelMap model){		 						
		try{
			
			String largeCd = (String)pRequestParamMap.get("largeCd");
			
			ItemVO itemVo = new ItemVO();
			itemVo.setLargeCd(largeCd);
			
			List<ItemVO> result = (List<ItemVO>)itemService.selectItemListSmallNm(itemVo);
			model.addAttribute("result",result);
			
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