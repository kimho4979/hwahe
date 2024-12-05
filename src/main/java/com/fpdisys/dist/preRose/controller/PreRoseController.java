package com.fpdisys.dist.preRose.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.dist.preRose.service.PreRoseService;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class PreRoseController extends BaseController {

protected Log log = LogFactory.getLog(this.getClass());	
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Autowired
	private PreRoseService preRoseService;
	
	// 장미가격 예측정보
	@RequestMapping(value="/preRose/preRose_sam.do")
	public String PreRosePrice_sample(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		 return "/auction/PreRosePrice_sample";
	}
	
	// 장미가격 예측정보
	@RequestMapping(value="/preRose/preRose.do")
	public String preRose(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		 return "/auction/PreRosePrice";
	}
	
	// 장미가격예측 품종 List
	@RequestMapping(value="/preRose/selectPreRosePumList.json")
	public String selectPreRosePumList(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
		
		List<EgovMap> list = null;
		
		try{
			list = preRoseService.selectPreRosePumListByCmpCd(pRequestParamMap);
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
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		
		return "jsonView";
		  	
	}
	
	// 장미가격예측 등급 List
	@RequestMapping(value="/preRose/selectPreRoseLvList.json")
	public String selectPreRoseLvList(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
		
		List<EgovMap> list = null;
		
		try{
			list = preRoseService.selectPreRosePumListByLvCd(pRequestParamMap);
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
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		
		return "jsonView";
		  	
	}
	
	// 장미가격예측 품종 List
	@RequestMapping(value="/preRose/selectPreRoseList.json")
	public String selectPreRoseList(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
		
		List<EgovMap> list = null;
		
		try{
			list = preRoseService.selectPreRoseList(pRequestParamMap);
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
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "jsonView";
		  	
	}
	
	// 장미가격예측 Chart List
	@RequestMapping(value="/preRose/selectPreRoseGridList.json")
	public String selectPreRoseChartList(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
		
		List<EgovMap> list = null;
		
		try{
			list = preRoseService.selectPreRoseGridList(pRequestParamMap);
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
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		
		return "jsonView";
		  	
	}
	
	// 장미가격 예측평가
	@RequestMapping(value="/preRose/preRoseEstimation.do")
	public String preRoseEstimation(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		 return "/auction/PreRosePriceEstimation";
	}
	
	// 장미가격예측 품종 List
		@RequestMapping(value="/preRose/selectPreRosePumListEst.json")
		public String selectPreRosePumListEst(HttpServletRequest pRequest, HttpServletResponse pResponse
				, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
			
			List<EgovMap> list = null;
			
			try{
				list = preRoseService.selectPreRosePumListEst(pRequestParamMap);
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
			} catch (Exception e) {
				log.error(e.getMessage());
			}
			
			return "jsonView";
			  	
		}
	
	// 장미가격예측 평가 List
	@RequestMapping(value="/preRose/selectPreEstList.json")
	public String selectPreEstList(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
		
		List<EgovMap> list = null;
		
		try{
			list = preRoseService.selectPreEstList(pRequestParamMap);
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
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "jsonView";
		  	
	}
	
	// 장미가격예측 Chart List
	@RequestMapping(value="/preRose/selectPreEstGridList.json")
	public String selectPreEstGridList(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
		
		List<EgovMap> list = null;
		
		try{
			list = preRoseService.selectPreEstGridList(pRequestParamMap);
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
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		
		return "jsonView";
		  	
	}
	 
}
