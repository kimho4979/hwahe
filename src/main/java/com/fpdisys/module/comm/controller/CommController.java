package com.fpdisys.module.comm.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringArrayPropertyEditor;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.base.util.CommConstant;
import com.fpdisys.dist.search.service.SearchService;
import com.fpdisys.module.comm.service.CommService;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;


/**
 * @Class Name : Hab11Controller.java
 * @Description : Hab11Controller Class
 *
 * @ 경매통계 비교  콘트롤러
 * @  수정일	  수정자			  수정내용
 * @ ---------	---------	-------------------------------
 * @ 2022			최초생성
 *
 * @author Shin J.C
 * @version 1.0
 * @see
 *
 *  Copyright (C) by woorim All right reserved.
 */

@Controller
public class CommController extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());

	@Autowired
	protected MessageSource messageSource;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	@Autowired
	CommService commService;
	
	@Autowired
	SearchService searchService;

	@InitBinder
	public void initBinder(WebDataBinder binder) {
	    binder.registerCustomEditor(
	        String[].class,
	        new StringArrayPropertyEditor(null));
	}

	/**
	 * 공통코드 조회
	 * @param pRequest
	 * @param pResponse
	 * @param gpId
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/comm/selectComCdList.json")
	public String selectComCdList(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam(value="gpId") String gpId, ModelMap model) {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		List<EgovMap> list;

		paramMap.put("gpId", gpId);

		list = commService.selectComCdList(paramMap);

		model.addAttribute("data", list);

		return "jsonView";
	}


	/**
	 * 부류 조회 : 공통코드
	 * @param pRequest
	 * @param pResponse
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/comm/selectFlowerGubnList.json")
	public String selectFlowerGubnList(HttpServletRequest pRequest, HttpServletResponse pResponse, ModelMap model) {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		List<EgovMap> list;

		paramMap.put("gpId", CommConstant.GP_ID_FLOWER_GUBN);

		list = commService.selectComCdList(paramMap);

		model.addAttribute("data", list);

		return "jsonView";
	}

	/**
	 * 경매장 조회 : 공통코드
	 * @param pRequest
	 * @param pResponse
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/comm/selectMarketList.json")
	public String selectMarketList(HttpServletRequest pRequest, HttpServletResponse pResponse, ModelMap model) {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		List<EgovMap> list;

		paramMap.put("gpId", CommConstant.GP_ID_CMP_CD);

		list = commService.selectComCdList(paramMap);

		model.addAttribute("data", list);

		return "jsonView";
	}

	@RequestMapping(value="/comm/selectItemList.json")
	public String selectItemList(HttpServletRequest pRequest, HttpServletResponse pResponse,
			@RequestParam(value="saleDateFrom") String saleDateFrom,
			@RequestParam(value="saleDateTo") String saleDateTo,
			@RequestParam(value="flower[]", required=false)  List<String> flowerCtgrList,
			@RequestParam(value="market[]", required=false) List<String> marketList,
			@RequestParam(value="type") String type,
			ModelMap model) {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		List<EgovMap> list;
		
		if("tCmp".equals(type)){
			list = new ArrayList<EgovMap>();
			paramMap.put("flowerCd", flowerCtgrList);
			paramMap.put("cmpCd", marketList);
			paramMap.put("searchStrDate",saleDateFrom);
			paramMap.put("searchEndDate", saleDateTo);
			
			List<EgovMap> pumNameCmpTotalList  =  searchService.selectPumNameCmpTotal(paramMap);
			if(pumNameCmpTotalList != null && pumNameCmpTotalList.size() > 0){
				EgovMap newMap;
				for(int i=0;i<pumNameCmpTotalList.size();i++){
					newMap = new EgovMap();
					Map map = pumNameCmpTotalList.get(i);
					newMap.put("flowerCode", map.get("FLOWER_CODE"));
					newMap.put("itemCd", map.get("ITEM_CD"));
					newMap.put("itemNm", map.get("ITEM_NM"));
					newMap.put("flowerGubn", map.get("FLOWER_GUBN"));
					
					newMap.put("cdNm", map.get("ITEM_NM"));
					newMap.put("cdId", ((String)map.get("FLOWER_CODE"))+((String)map.get("ITEM_CD")));
					newMap.put("cdSeq", i);
					list.add(newMap);
				}
			}
		}else{
			paramMap.put("saleDateFrom", saleDateFrom);
			paramMap.put("saleDateTo", saleDateTo);
			paramMap.put("flowerCtgrList", flowerCtgrList);
			paramMap.put("marketList", marketList);
			list = commService.selectItemList(paramMap);
		}
		

		model.addAttribute("data", list);

		return "jsonView";

	 }

	@RequestMapping(value="/comm/selectItemDtlList.json")
	public String selectItemDtlList(HttpServletRequest pRequest, HttpServletResponse pResponse,
			@RequestParam(value="saleDateFrom") String saleDateFrom,
			@RequestParam(value="saleDateTo") String saleDateTo,
			@RequestParam(value="flower[]", required=false)  List<String> flowerCtgrList,
			@RequestParam(value="market[]", required=false) List<String> marketList,
			@RequestParam(value="item[]", required=false) List<String> itemList,
			@RequestParam(value="type") String type,
			ModelMap model) {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		List<EgovMap> list;
		
		if("tCmp".equals(type)){
			if(itemList != null && itemList.size() > 0 && itemList.indexOf("6043") > -1){
				itemList.add("6002");
			} else {
				itemList = new ArrayList<>();
			}
			
			paramMap.put("flowerCd", flowerCtgrList);
			paramMap.put("cmpCd", marketList);
			paramMap.put("searchStrDate",saleDateFrom);
			paramMap.put("searchEndDate", saleDateTo);
			paramMap.put("itemList", itemList);
			
			list  =  (List<EgovMap>)commService.selectGoodNameCmpTotal(paramMap);
			if(list != null && list.size() > 0){
				for(int i=0;i<list.size();i++){
					EgovMap map = list.get(i);
					map.put("cdNm", map.get("kindNm"));
					map.put("cdId", ((String)map.get("flowerCode"))+((String)map.get("itemCd"))+((String)map.get("kindCd")));
					map.put("cdSeq", i);
				}
			}
			
		}else{
			paramMap.put("saleDateFrom", saleDateFrom);
			paramMap.put("saleDateTo", saleDateTo);
			paramMap.put("flowerClassList", flowerCtgrList);
			paramMap.put("marketList", marketList);
			paramMap.put("itemList", itemList);
			list = commService.selectItemDtlList(paramMap);
		}

		model.addAttribute("data", list);

		return "jsonView";

	 }
}
