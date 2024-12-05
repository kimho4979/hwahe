package com.fpdisys.dist.haa03.controller;

import java.util.ArrayList;
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
import com.fpdisys.dist.haa03.service.Haa03Service;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * @Class Name : Haa03Controller.java
 * @Description : Haa03Controller Class
 *	 
 * @로그인  콘트롤러
 * @  수정일	  수정자			  수정내용
 * @ ---------	---------	-------------------------------
 * @ 2016.08.18			최초생성
 *
 * @author 우림인포텍
 * @version 1.0
 * @see
 *
 *  Copyright (C) by woorim All right reserved.
 */

@Controller
public class Haa03Controller extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());	
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Autowired
	private Haa03Service haa03Service;
	
	/**
	 * 공판장별 품목 경락가격  리스트 및 챠트 
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return String
	 */
	@RequestMapping(value="/haa03/haa03.do")
	public String goHaa03(HttpServletRequest pRequest, HttpServletResponse pRes, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) { 
		return "/auction/Haa03";
	}
	
	/**
	 * 공판장별 품종 경락가격  리스트 및 챠트 
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return String
	 */
	@RequestMapping(value="/haa03/selectData.json")
	public String selectData(HttpServletRequest pRequest, HttpServletResponse pRes, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
	 		try{
				
	 			String searchProductGubun =pRequestParamMap.get("FLOWER_CD").toString();	  
	 			pRequestParamMap.put("searchProductGubun", searchProductGubun);
	 			String searchDateGubun =pRequestParamMap.get("DATE_GUBN").toString();	 
	 		 	
	 		 	//날짜검색구분 (1 : 경매일자 1개월  2: 경매일자 6개월 3: 경매일자 1년)
	 		 	if(pRequestParamMap.get("DATE_GUBN")!= null){	 			 		
	 		 		if("1".equals(searchDateGubun)){
	 		 			int searchRegDtStart = -1;	 			 
	 		 			pRequestParamMap.put("searchRegDt", searchRegDtStart); 		
	 		 		}else if("6".equals(searchDateGubun)){
	 		 			int searchRegDtStart = -6;	 			 
	 					
	 		 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
	 		 		}else if("12".equals(searchDateGubun)){
	 		 			int searchRegDtStart = -12;	 			 
	 					
	 		 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
	 		 		}
	 			}else{
	 				int searchRegDtStart = -1;	
	 				pRequestParamMap.put("searchRegDt", searchRegDtStart);	
	 				pRequestParamMap.put("searchDateGubun", "1");
	 			} 
	 		 	
			 	model.addAttribute("searchDateGubun", searchDateGubun);		
			 	
			 	 List<EgovMap> selectListaTFlower=new ArrayList<EgovMap>();
				 List<EgovMap> selectListBuSanFlower=new ArrayList<EgovMap>();
				 List<EgovMap> selectListBukyoungFlower=new ArrayList<EgovMap>();
				 List<EgovMap> selectListKwangJuFlower=new ArrayList<EgovMap>();
				 List<EgovMap> selectListHanKookUmFlower=new ArrayList<EgovMap>();
				 List<EgovMap> selectListHanKookBonFlower=new ArrayList<EgovMap>();
					
				 List<EgovMap> selectListFlower = haa03Service.selectListaTFlower(pRequestParamMap);
				 
				 for(int i=0; i<selectListFlower.size();i++){
	 				if(selectListFlower.get(i).get("cmpCd").equals("0000000001")){
	 					selectListaTFlower.add((EgovMap)selectListFlower.get(i));
	 				}else if(selectListFlower.get(i).get("cmpCd").equals("1508500020")){
	 					selectListBuSanFlower.add((EgovMap)selectListFlower.get(i));
	 				} else if(selectListFlower.get(i).get("cmpCd").equals("6068207466")){
	 					selectListBukyoungFlower.add((EgovMap)selectListFlower.get(i));
	 				}else if(selectListFlower.get(i).get("cmpCd").equals("4108212335")){
	 					selectListKwangJuFlower.add((EgovMap)selectListFlower.get(i));
	 				}else if(selectListFlower.get(i).get("cmpCd").equals("3848200087")){
	 					selectListHanKookUmFlower.add((EgovMap)selectListFlower.get(i));
	 				}else if(selectListFlower.get(i).get("cmpCd").equals("1288202296")){
	 					selectListHanKookBonFlower.add((EgovMap)selectListFlower.get(i));
	 				}else if(selectListFlower.get(i).get("cmpCd").equals("6158209828")){
	 					selectListHanKookBonFlower.add((EgovMap)selectListFlower.get(i));
	 				}
	 				
	 				
	 			}
	 				 
	 			model.addAttribute("selectListaTFlower", selectListaTFlower);  
	 			model.addAttribute("selectListBuSanFlower", selectListBuSanFlower);	
	 			model.addAttribute("selectListBukyoungFlower", selectListBukyoungFlower);	
	 			model.addAttribute("selectListKwangJuFlower", selectListKwangJuFlower);
	 			model.addAttribute("selectListHanKookUmFlower", selectListHanKookUmFlower);
	 			model.addAttribute("selectListHanKookBonFlower", selectListHanKookBonFlower);			
	 		 
	 			if("1".equals(searchDateGubun)){
					 List<EgovMap> selectListaTFlowerGraph =  (List<EgovMap>)haa03Service.selectListaTFlowerGraph(pRequestParamMap);
					 List<EgovMap> selectListBuSanFlowerGraph =  (List<EgovMap>)haa03Service.selectListBuSanFlowerGraph(pRequestParamMap);
					 List<EgovMap> selectListBukyoungFlowerGraph =  (List<EgovMap>)haa03Service.selectListBukyoungFlowerGraph(pRequestParamMap);
					 List<EgovMap> selectListKwangJuFlowerGraph =  (List<EgovMap>)haa03Service.selectListKwangJuFlowerGraph(pRequestParamMap);
					 List<EgovMap> selectListHanKookUmFlowerGraph =  (List<EgovMap>)haa03Service.selectListHanKookUmFlowerGraph(pRequestParamMap);
					 List<EgovMap> selectListHanKookBonFlowerGraph =  (List<EgovMap>)haa03Service.selectListHanKookBonFlowerGraph(pRequestParamMap);
					 						 				
					 
					model.addAttribute("list", selectListaTFlowerGraph);	
					model.addAttribute("list2", selectListBuSanFlowerGraph);	
					model.addAttribute("list3", selectListBukyoungFlowerGraph);
					model.addAttribute("list4", selectListKwangJuFlowerGraph);
					model.addAttribute("list5", selectListHanKookUmFlowerGraph);
					model.addAttribute("list6", selectListHanKookBonFlowerGraph);
					 	
				 }else {
					 
					 List<EgovMap> selectListaTFlowerMonth =  (List<EgovMap>)haa03Service.selectListaTFlowerMonth(pRequestParamMap);
					 List<EgovMap> selectListBuSanFlowerMonth =  (List<EgovMap>)haa03Service.selectListBuSanFlowerMonth(pRequestParamMap);
					 List<EgovMap> selectListBukyoungFlowerMonth =  (List<EgovMap>)haa03Service.selectListBukyoungFlowerMonth(pRequestParamMap);
					 List<EgovMap> selectListKwangJuFlowerMonth =  (List<EgovMap>)haa03Service.selectListKwangJuFlowerMonth(pRequestParamMap);
					 List<EgovMap> selectListHanKookUmFlowerMonth =  (List<EgovMap>)haa03Service.selectListHanKookUmFlowerMonth(pRequestParamMap);
					 List<EgovMap> selectListHanKookBonFlowerMonth =  (List<EgovMap>)haa03Service.selectListHanKookBonFlowerMonth(pRequestParamMap);
					 				
					 model.addAttribute("list", selectListaTFlowerMonth);	
					 model.addAttribute("list2", selectListBuSanFlowerMonth);	
					 model.addAttribute("list3", selectListBukyoungFlowerMonth);
					 model.addAttribute("list4", selectListKwangJuFlowerMonth);
					 model.addAttribute("list5", selectListHanKookUmFlowerMonth);
					 model.addAttribute("list6", selectListHanKookBonFlowerMonth);
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
		return "/auction/Haa03";
	 	
	}
	
	@RequestMapping(value="/haa03/selectGraphList.json")
	public String selectGraphList(
			HttpServletRequest pRequest, 
			HttpServletResponse pResponse,
			HttpSession  session,
	 		@RequestParam Map<String, Object> pRequestParamMap,
	 		ModelMap model)
	{		 
		String searchProductGubun =pRequestParamMap.get("FLOWER_CD").toString();	  
		pRequestParamMap.put("searchProductGubun", searchProductGubun);
		String searchDateGubun =pRequestParamMap.get("DATE_GUBN").toString();	 
	 	
	 	//날짜검색구분 (1 : 경매일자 1개월  2: 경매일자 6개월 3: 경매일자 1년)
	 	if(pRequestParamMap.get("DATE_GUBN")!= null){	 			 		
	 		if("1".equals(searchDateGubun)){
	 			int searchRegDtStart = -1;
	 			pRequestParamMap.put("searchRegDt", searchRegDtStart);				
	 		}else if("6".equals(searchDateGubun)){
	 			int searchRegDtStart = -6;
	 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
	 		}else if("12".equals(searchDateGubun)){
	 			int searchRegDtStart = -12;
	 			pRequestParamMap.put("searchRegDt", searchRegDtStart);  
	 		}
	 			}else{
	 				int searchRegDtStart = -1;	
	 				pRequestParamMap.put("searchRegDt", searchRegDtStart);	
	 				pRequestParamMap.put("searchDateGubun", "1");
	 			}

		try{
			 if("1".equals(searchDateGubun)){
				 List<EgovMap> selectListaTFlowerGraph =  (List<EgovMap>)haa03Service.selectListaTFlowerGraph(pRequestParamMap);
				 List<EgovMap> selectListBuSanFlowerGraph =  (List<EgovMap>)haa03Service.selectListBuSanFlowerGraph(pRequestParamMap);
				 List<EgovMap> selectListBukyoungFlowerGraph =  (List<EgovMap>)haa03Service.selectListBukyoungFlowerGraph(pRequestParamMap);
				 List<EgovMap> selectListKwangJuFlowerGraph =  (List<EgovMap>)haa03Service.selectListKwangJuFlowerGraph(pRequestParamMap);
				 List<EgovMap> selectListHanKookUmFlowerGraph =  (List<EgovMap>)haa03Service.selectListHanKookUmFlowerGraph(pRequestParamMap);
				 List<EgovMap> selectListHanKookBonFlowerGraph =  (List<EgovMap>)haa03Service.selectListHanKookBonFlowerGraph(pRequestParamMap);
				 						 				
				 
				model.addAttribute("list", selectListaTFlowerGraph);	
				model.addAttribute("list2", selectListBuSanFlowerGraph);	
				model.addAttribute("list3", selectListBukyoungFlowerGraph);
				model.addAttribute("list4", selectListKwangJuFlowerGraph);
				model.addAttribute("list5", selectListHanKookUmFlowerGraph);
				model.addAttribute("list6", selectListHanKookBonFlowerGraph);
				 	
			 }else {
				 
				 List<EgovMap> selectListaTFlowerMonth =  (List<EgovMap>)haa03Service.selectListaTFlowerMonth(pRequestParamMap);
				 List<EgovMap> selectListBuSanFlowerMonth =  (List<EgovMap>)haa03Service.selectListBuSanFlowerMonth(pRequestParamMap);
				 List<EgovMap> selectListBukyoungFlowerMonth =  (List<EgovMap>)haa03Service.selectListBukyoungFlowerMonth(pRequestParamMap);
				 List<EgovMap> selectListKwangJuFlowerMonth =  (List<EgovMap>)haa03Service.selectListKwangJuFlowerMonth(pRequestParamMap);
				 List<EgovMap> selectListHanKookUmFlowerMonth =  (List<EgovMap>)haa03Service.selectListHanKookUmFlowerMonth(pRequestParamMap);
				 List<EgovMap> selectListHanKookBonFlowerMonth =  (List<EgovMap>)haa03Service.selectListHanKookBonFlowerMonth(pRequestParamMap);
				 				
				 model.addAttribute("list", selectListaTFlowerMonth);	
				 model.addAttribute("list2", selectListBuSanFlowerMonth);	
				 model.addAttribute("list3", selectListBukyoungFlowerMonth);
				 model.addAttribute("list4", selectListKwangJuFlowerMonth);
				 model.addAttribute("list5", selectListHanKookUmFlowerMonth);
				 model.addAttribute("list6", selectListHanKookBonFlowerMonth);
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
	
	
	
}
