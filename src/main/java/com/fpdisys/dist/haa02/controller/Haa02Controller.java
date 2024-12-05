package com.fpdisys.dist.haa02.controller;

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
import com.fpdisys.dist.haa02.service.Haa02Service;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * @Class Name : Haa02Controller.java
 * @Description : Haa02Controller Class
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
public class Haa02Controller extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());	
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Autowired
	private Haa02Service haa02Service;
	
	
	/**
	 * 공판장별 품목 경락가격  리스트 및 챠트 
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return String
	 */
	@RequestMapping(value="/haa02/haa02.do")
	public String goHaa02(HttpServletRequest pRequest, HttpServletResponse pRes, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) { 
		return "/auction/Haa02";
	}
	
	@RequestMapping(value="/haa02/selectData.json")
	public String selectData(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		
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
	 	


		 List<EgovMap> selectListaTFlower=new ArrayList<EgovMap>();
		 List<EgovMap> selectListBuSanFlower=new ArrayList<EgovMap>();
		 List<EgovMap> selectListBukyoungFlower=new ArrayList<EgovMap>();
		 List<EgovMap> selectListKwangJuFlower=new ArrayList<EgovMap>();
		 List<EgovMap> selectListHanKookUmFlower=new ArrayList<EgovMap>();
		 List<EgovMap> selectListHanKookBonFlower=new ArrayList<EgovMap>();
		 
			List<EgovMap> selectListFlower = haa02Service.selectListaTFlower(pRequestParamMap);
			
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
		 
	 	
		try{
			
			 if("1".equals(searchDateGubun)){
				 List<EgovMap> selectListaTFlowerGraph =  (List<EgovMap>)haa02Service.selectListaTFlowerGraph(pRequestParamMap);
				 List<EgovMap> selectListBuSanFlowerGraph =  (List<EgovMap>)haa02Service.selectListBuSanFlowerGraph(pRequestParamMap);
				 List<EgovMap> selectListBukyoungFlowerGraph =  (List<EgovMap>)haa02Service.selectListBukyoungFlowerGraph(pRequestParamMap);
				 List<EgovMap> selectListKwangJuFlowerGraph =  (List<EgovMap>)haa02Service.selectListKwangJuFlowerGraph(pRequestParamMap);
				 List<EgovMap> selectListHanKookUmFlowerGraph =  (List<EgovMap>)haa02Service.selectListHanKookUmFlowerGraph(pRequestParamMap);
				 List<EgovMap> selectListHanKookBonFlowerGraph =  (List<EgovMap>)haa02Service.selectListHanKookBonFlowerGraph(pRequestParamMap);
				 						 				
				 
				model.addAttribute("list", selectListaTFlowerGraph);	
				model.addAttribute("list2", selectListBuSanFlowerGraph);	
				model.addAttribute("list3", selectListBukyoungFlowerGraph);
				model.addAttribute("list4", selectListKwangJuFlowerGraph);
				model.addAttribute("list5", selectListHanKookUmFlowerGraph);
				model.addAttribute("list6", selectListHanKookBonFlowerGraph);
				 	
			 }else {
				 
				 List<EgovMap> selectListaTFlowerMonth =  (List<EgovMap>)haa02Service.selectListaTFlowerMonth(pRequestParamMap);
				 List<EgovMap> selectListBuSanFlowerMonth =  (List<EgovMap>)haa02Service.selectListBuSanFlowerMonth(pRequestParamMap);
				 List<EgovMap> selectListBukyoungFlowerMonth =  (List<EgovMap>)haa02Service.selectListBukyoungFlowerMonth(pRequestParamMap);
				 List<EgovMap> selectListKwangJuFlowerMonth =  (List<EgovMap>)haa02Service.selectListKwangJuFlowerMonth(pRequestParamMap);
				 List<EgovMap> selectListHanKookUmFlowerMonth =  (List<EgovMap>)haa02Service.selectListHanKookUmFlowerMonth(pRequestParamMap);
				 List<EgovMap> selectListHanKookBonFlowerMonth =  (List<EgovMap>)haa02Service.selectListHanKookBonFlowerMonth(pRequestParamMap);
				 				
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
		}  catch (Exception e) {
			e.printStackTrace();
		}													
		 return "jsonView";
	}
	
}
