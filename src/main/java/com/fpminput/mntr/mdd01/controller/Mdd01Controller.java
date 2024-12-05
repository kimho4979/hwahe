package com.fpminput.mntr.mdd01.controller;

import java.util.Calendar;
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
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fpdisys.base.mvc.PageableTO;
import com.fpminput.mntr.mdd01.service.Mdd01Service;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class Mdd01Controller {

	protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Autowired
	Mdd01Service mdd01Service;
	
	
	// 발송이력관리 목록페이지 이동
	@RequestMapping("/mdc01/mdd01.do")
	public String mdd01(	HttpServletRequest pRequest, HttpServletResponse pResponse,
				@RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
		log.info("==========/mdc01/mdd01.do==============");
	
		Calendar cal = Calendar.getInstance();
		model.addAttribute("nowYear", cal.get(Calendar.YEAR) );
		String mon = (cal.get(Calendar.MONTH)+1)+"";
		if(mon.length() == 1) mon = "0" +mon;
	 	model.addAttribute("nowMon", mon);
	 		
		return "/mdd01/history";
	}
	
	
	// 발송이력관리 발송로그 조회 
	@RequestMapping("/mntr/mdd01/getLogList.json")
	public String getLogList(HttpServletRequest pRequest, HttpServletResponse pResponse,
			HttpSession session, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						
		log.info("==========getLogList============="+pRequestParamMap.toString());
  		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		PageableTO pageTo = new PageableTO();
		int currentPage =	Integer.parseInt(pRequestParamMap.get("pageNumber").toString());
		int pageSize = Integer.parseInt(pRequestParamMap.get("pageSize").toString());
		
		pageTo.setCurrentPage(currentPage);
		pageTo.setPageSize(pageSize);
		
		
		try{
			List<EgovMap> resultList = (List<EgovMap>)mdd01Service.selectMdd01List(pRequestParamMap);
			model.addAttribute("list", resultList);
			
			int total = 0;
			if(resultList != null && resultList.size() > 0){
				Map<String, String> result = (Map<String, String>)resultList.get(0);
				if(result.get("TOTAL_COUNT1") != null){
					total= Integer.parseInt(String.valueOf(result.get("TOTAL_COUNT1")));
				}
			}
			log.info("pageNo : " + currentPage);
			Long totalLong = Long.parseLong(resultList.size()+"");
			pageTo.setTotalElements(totalLong);
			int totalPage= total/pageSize + (total%pageSize == 0?0:1);
			pageTo.setTotalPages(totalPage);
			
			model.addAttribute("page",pageTo );
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
	
	
	// 발송이력관리 발송로그 상세 보기
	@RequestMapping("/mntr/mdd01/pushLogDetail.do")
	public String pushLogDetail( HttpServletRequest pRequest, HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
		log.info("==========/mntr/mdd01/pushLogDetail.do==============");
		
		Map<String, String> detail  = (Map<String, String>)mdd01Service.selectMdd01Detail(pRequestParamMap); 
		model.addAttribute("detail", detail);
		
		return "/mdd01/logDetailModal";
	}
	
	
	
	
}
