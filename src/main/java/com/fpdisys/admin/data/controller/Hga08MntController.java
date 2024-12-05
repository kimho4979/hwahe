package com.fpdisys.admin.data.controller;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fpdisys.admin.data.service.Hga08MntService;
import com.fpdisys.base.util.FileUtils;
import com.fpditrans.base.excel.read.ExcelRead;

@Controller
public class Hga08MntController {
	
	@Autowired
	private FileUtils fileUtil;
	
	@Autowired
	private Hga08MntService hga08MntService;
	
	@RequestMapping("/admin/data/hga08manage.do")
	public String manage(ModelMap model){
		return "sys/data/Hga08Mnt";
	}
	
	@RequestMapping("/admin/data/readExcel.json")
	public String upload(ModelMap model,MultipartHttpServletRequest req) {
		try{
			for(MultipartFile f : req.getFiles("files")) {
				List<List<String>> data = ExcelRead.read(f.getOriginalFilename(),f.getInputStream());
				// 연도, 지역, 전업, 겸업
				
				int startYYYY = Integer.parseInt(data.get(0).get(1).substring(data.get(0).get(1).indexOf("Y")+1, data.get(0).get(1).indexOf("Y")+5));
				List<String> YYYYIdx = new ArrayList<>();
				for(String d : data.get(0)){
					String e = "";
					if (d.contains("Y20") == true || d.contains("Y19") == true )
						e = d.substring(d.indexOf("Y")+1, d.indexOf("Y")+5);
					YYYYIdx.add(e);
				}

				String reg = "[0-9 ]";
				
				List<Map<String, Object>> result = new ArrayList<>();
				for(int i=2; i<data.size(); i++){
					for(int j=1; j<data.get(0).size(); j++){
						Map<String, Object> e = new HashMap<String, Object>();
						e.put("YYYY", YYYYIdx.get(j));
						e.put("LOCATION", data.get(i).get(0).replaceAll(reg, ""));
						int k = 0;
						while(true){
							if (data.get(1).get(j+k).toString().contains("전업") == true)
								e.put("VAL1", data.get(i).get(j+k));
							else if (data.get(1).get(j+k).toString().contains("겸업") == true)
								e.put("VAL2", data.get(i).get(j+k));
							k++;
							if (j+k >= YYYYIdx.size() || !YYYYIdx.get(j).toString().equals(YYYYIdx.get(j+k).toString())){
								j += k-1;
								break;
							}
						}
						e.put("idx", result.size());
						result.add(e);
					}
				}
				
				hga08MntService.uploadExcel(result);
				
				System.out.println("sucess");
				model.addAttribute("list", result);
			}
		}catch(Exception e1){
			model.addAttribute("msg","처리중오류발생.");
			e1.printStackTrace();
			return "jsonView";
		}
		return "jsonView";
	}
	
	@RequestMapping(value="/admin/data/saveExcel.json")
	public String saveExcel(HttpServletRequest pRequest,HttpServletResponse pResponse
			,@RequestBody String data,ModelMap model){
		try{
			data = (URLDecoder.decode(data));
			data = data.split("=")[0];

			Map<String,Object> map = new ObjectMapper().readValue(data,Map.class);
			List<Map<String, Object>> insertList = new ArrayList<>();
			
			for (Object e : (List) map.get("insertList")){
				insertList.add((Map) e);
			}
			List<Map<String, Object>> updateList = new ArrayList<>();
			for (Object e : (List) map.get("updateList")){
				updateList.add((Map) e);
			}
			List<Map<String, Object>> deleteList = new ArrayList<>();
			for (Object e : (List) map.get("deleteList")){
				deleteList.add((Map) e);
			}
			
			Map<String, List<Map<String, Object>>> param = new HashMap<>();
			param.put("insertList", insertList);
			param.put("updateList", updateList);
			param.put("deleteList", deleteList);
			hga08MntService.saveExcel(param);
		} catch(Exception e){
			e.printStackTrace();
		}

 		return "jsonView";
	}
	
	@RequestMapping(value="admin/data/selectCultivationStatus.json")
 	public String selectCultivationStatus(HttpServletRequest pRequest,HttpServletResponse pResponse
 			,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){
 		
		try{
			List<Map> list2 = hga08MntService.selectCultivationStatus(pRequestParamMap);
			for(int i=0; i<list2.size(); i++){
				list2.get(i).put("idx", i);
			}
			model.addAttribute("list", list2);
		} catch(Exception e){
			e.printStackTrace();
		}
 		
 		return "jsonView";
 	}

}
