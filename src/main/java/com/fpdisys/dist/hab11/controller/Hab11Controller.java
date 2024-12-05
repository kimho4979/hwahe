package com.fpdisys.dist.hab11.controller;

import java.util.HashMap;
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
import com.fpdisys.dist.hab11.service.Hab11Service;

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
public class Hab11Controller extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());

	@Autowired
	protected MessageSource messageSource;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	@Autowired
	Hab11Service hab11Service;


	@RequestMapping(value="/hab11/hab11.do")
	public String selectHab11(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		return "/auction/Hab11";
	}

	@RequestMapping(value="/hab11/selectList.json")
	public String selectList(HttpServletRequest pRequest, HttpServletResponse pResponse,
			@RequestParam(value="saleDate1From") String saleDate1From,
			@RequestParam(value="saleDate1To") String saleDate1To,
			@RequestParam(value="saleDate2From") String saleDate2From,
			@RequestParam(value="saleDate2To") String saleDate2To,
			@RequestParam(value="flower1[]", required=false) List<String> flowerCtgrList1,
			@RequestParam(value="market1[]", required=false) List<String> marketList1,
			@RequestParam(value="item1[]", required=false) List<String> itemList1,
			@RequestParam(value="itemDtl1[]", required=false) List<String> itemDtlList1,
			@RequestParam(value="flower2[]", required=false) List<String> flowerCtgrList2,
			@RequestParam(value="market2[]", required=false) List<String> marketList2,
			@RequestParam(value="item2[]", required=false) List<String> itemList2,
			@RequestParam(value="itemDtl2[]", required=false) List<String> itemDtlList2,
			ModelMap model) {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		List<EgovMap> list;
		paramMap.put("saleDate1From", saleDate1From);
		paramMap.put("saleDate1To", saleDate1To);
		paramMap.put("saleDate2From", saleDate2From);
		paramMap.put("saleDate2To", saleDate2To);
		paramMap.put("flowerCtgrList1", flowerCtgrList1);
		paramMap.put("marketList1", marketList1);
		paramMap.put("itemList1", itemList1);
		paramMap.put("itemDtlList1", itemDtlList1);
		paramMap.put("flowerCtgrList2", flowerCtgrList2);
		paramMap.put("marketList2", marketList2);
		paramMap.put("itemList2", itemList2);
		paramMap.put("itemDtlList2", itemDtlList2);
		list = hab11Service.selectList(paramMap);

		model.addAttribute("list", list);

		return "jsonView";

	}

	@RequestMapping(value="/hab11/cmprPopup.do")
	public String selectCmprPopup(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		return "/auction/Hab11_Cmpr_popup";
	}


}
