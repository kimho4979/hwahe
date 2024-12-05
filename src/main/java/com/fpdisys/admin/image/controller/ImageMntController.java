package com.fpdisys.admin.image.controller;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fpdisys.admin.image.service.CommonService;
import com.fpdisys.base.util.FileUtils;

@Controller
public class ImageMntController {
	
	@Autowired
	private FileUtils fileUtil;
	
	@Autowired
	private CommonService commonService;
	
	@RequestMapping("/admin/img/manage.do")
	public String manage(ModelMap model,HttpServletRequest pRequest){
		HttpSession httpSession = pRequest.getSession();
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}
		return "sys/imageMnt/uploadForm";
	}
	
	@RequestMapping("/admin/img/manage.json")
	public String manageJson(ModelMap model){
		model.addAttribute("flower", commonService.getFlowerCode());
		model.addAttribute("mok", commonService.getMokCode());
		////model.addAttribute("jong", commonService.getJongCode());
		return "jsonView";	
	}
	@RequestMapping("/admin/img/upload.json")
	public String upload(ModelMap model, MultipartHttpServletRequest req){
		
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("cdId",req.getParameter("cdId"));
		param.put("colorTxt",req.getParameter("colorTxt"));
		param.put("rgbColor",req.getParameter("rgbColor"));
		param.put("txtJong",req.getParameter("txtJong").toString().split("-")[1].trim());
		List<Map<String,Object>> result = null;
		try{
			param.put("IDX", param.get("txtJong"));
			result = fileUtil.parseInsertFileInfo(param, req);
			param.put("ramdomFileName", result.get(0).get("STORED_FILE_NAME"));
			param.put("originFileName", result.get(0).get("ORIGINAL_FILE_NAME"));
			commonService.updatePumImage(param);
		}catch(Exception e1){
			model.addAttribute("msg","처리중오류발생.");
			e1.printStackTrace();
			return "jsonView";
		}
		
		model.addAttribute("msg","업로드성공");
		return "jsonView";
	}
	
	
	@RequestMapping("/admin/img/getJongCodeP.json")
	public String getJongCodeP(ModelMap model, @RequestParam String data){
		Map<String,Object> p = new HashMap<String, Object>();
		p.put("mok", data);
		model.addAttribute("jong",commonService.getJongCodeP(p));
		return "jsonView";
	}
	
	
	@RequestMapping("/hfd01/download.do")
	public void downloadfile(ModelMap model,
			@RequestParam String path
			,@RequestParam String origin
			,HttpServletRequest request,HttpServletResponse response) throws Exception{
		fileUtil.downFile(path, origin, request, response);
	}
	
	
	@RequestMapping("/admin/img/getImgList.do")
	public String getImgList(ModelMap model,HttpServletRequest pRequest){
		HttpSession httpSession = pRequest.getSession();
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}
		return "sys/imageMnt/imgList";
	}
	@SuppressWarnings("unchecked")
	@RequestMapping("/admin/img/getImgList.json")
	public String getImgListJSON(ModelMap model,@RequestParam Map pRequestParamMap){
		try {
			
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
			
			
			
			
			System.out.println(pRequestParamMap);
			model.addAttribute("list",commonService.getImgList(pRequestParamMap));
			model.addAttribute("list2",obj.toString());
			model.addAttribute("msg","성공");
			return "jsonView";
				
		} catch (Exception e) {
			
			System.out.println(e.getMessage());
			model.addAttribute("msg","오류발생");
			return "jsonView";
		}
	}
	
	@RequestMapping("/admin/img/initUpdate.json")
	public String initUpdate(ModelMap model,@RequestBody String data) throws JsonParseException, JsonMappingException, IOException{
		data = (URLDecoder.decode(data));
		data = data.split("=")[0];
		System.out.println(data);
		Map<String,Object> param = null;
		Map<String,Object> map = new ObjectMapper().readValue(data,Map.class);
		if(map.get("type").equals("del"))
			commonService.deletePumImage(map);
		else
			commonService.updatePumImage(map);
		
		//Map<String,Object> param = new HashMap<String, Object>();
		//param.put("searchJongNm", searchJongNm);
		//model.addAttribute("list",commonService.getImgList(param));
		//model.addAttribute("msg","테스트");
		return "jsonView";
	}
	
	@RequestMapping("/hfd01/hfd01.do")
	public String flowerGallery(){
		return "sys/imageMnt/flrgry";
	}
	
	@RequestMapping("/hfd01/getImages.json")
	public String getImages(ModelMap model,@RequestParam Map searchJongNm) throws JsonParseException, JsonMappingException, IOException{
		Map<String,Object> map = null;
		Map<String,Object> pmap = new HashMap<String, Object>();
		if(null != searchJongNm){
			for ( Object o  :searchJongNm.keySet()) {
				//System.out.println(o);
				map = new ObjectMapper().readValue(o.toString(),Map.class);
				//System.out.println(map);
				
			}
			
			pmap.put("value",map.get("value"));
			pmap.put("type",map.get("type"));
		}
		pmap.put("isGallery","true");
		System.out.println(pmap);
		model.addAttribute("data", commonService.getImgList(pmap));
		return "jsonView";
	}
	
}
