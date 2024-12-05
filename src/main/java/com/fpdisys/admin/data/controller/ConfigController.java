package com.fpdisys.admin.data.controller;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;
import java.net.URLDecoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Workbook;
import org.json.JSONObject;
import org.openjdk.tools.sjavac.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fpdisys.admin.data.service.ConfigService;
import com.fpminput.mntr.dailyRptMgt.controller.dailyRptSendexcel;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class ConfigController {
	
	@Autowired
	private ConfigService configService;
	
	@Autowired
	private dailyRptSendexcel dailyRptSendExcel;
	
	@RequestMapping("/admin/data/config.do")
	public String manage(ModelMap model){
		return "sys/data/Config";
	}

	@RequestMapping(value="admin/data/selectDailyConfig.json")
 	public String selectDailyConfig(HttpServletRequest pRequest,HttpServletResponse pResponse
 			,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){
 		
		try{
			List<Map<String, Object>> list2 = configService.selectDailyConfig(pRequestParamMap);
			for(int i=0; i<list2.size(); i++){
				list2.get(i).put("idx", i);
			}
			model.addAttribute("list", list2);
		} catch(Exception e){
			e.printStackTrace();
		}
 		
 		return "jsonView";
 	}
	 @RequestMapping(value="/admin/data/authKeyUpdate.json")
	 public ResponseEntity<HashMap<String, String>> authKeyUpdate(HttpServletRequest request,HttpServletResponse response,@RequestParam String key,@RequestParam String configCode) throws SQLException{
		HashMap<String, String> resultMap = new HashMap<>();
		HashMap<String, String> requestMap = new HashMap<>();
		requestMap.put("key", key);
		requestMap.put("configCode", configCode);
		if(configCode.equals("01")){
		try{
			URL url = new URL(
					"https://open.neis.go.kr/hub/schoolInfo?TYPE=json&KEY=" + key);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.connect();

            BufferedInputStream bis = new BufferedInputStream(conn.getInputStream());
            BufferedReader reader = new BufferedReader(new InputStreamReader(bis,"UTF-8"));
            StringBuffer st = new StringBuffer();
            String line;
            while ((line = reader.readLine()) != null) {
                st.append(line);
            }
			JSONObject jsonObject = new JSONObject(st.toString());
			if(jsonObject.isNull("schoolInfo")){
				resultMap.put("result", "유효하지않은 key입니다.");
				return new ResponseEntity<HashMap<String, String>>(resultMap,HttpStatus.NOT_FOUND);
			}
			}catch(Exception e){
				e.printStackTrace();
			}	
		}
			configService.authKeyUpdate(requestMap);
			resultMap.put("result", "update 완료.");
			
		return new ResponseEntity<HashMap<String, String>>(resultMap,HttpStatus.OK);
	 }
	@RequestMapping(value="/admin/data/authKeySelect.json")
	public ResponseEntity<HashMap<String, Object>> authKeySelect(HttpServletRequest request,HttpServletResponse response) throws SQLException{
		HashMap<String, Object> resultMap = new HashMap<>();
		List<Map<String, Object>> list = configService.authKeySelect(); 
		resultMap.put("list", list);
		resultMap.put("result", "update 완료.");
		return new ResponseEntity<HashMap<String, Object>>(resultMap,HttpStatus.OK);
	}
	
	@RequestMapping(value="/admin/data/saveDailyConfig.json")
	public String saveDailyConfig(HttpServletRequest pRequest,HttpServletResponse pResponse
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
			configService.saveDailyConfig(param);
		} catch(Exception e){
			e.printStackTrace();
		}

 		return "jsonView";
	}
	@RequestMapping(value="/admin/data/addResearch.json")
	public String addResearch(@RequestBody String[] addList) {
		// addList를 사용하여 원하는 작업 수행

		// 여기서 예를 들어 배열 내용을 콘솔에 출력하는 작업을 해보겠습니다.
		for (String value : addList) {
			configService.updateCompCode(value);
		}
		// 처리 결과를 반환 (예: 성공 여부 메시지)
		return "Success";
	}
	@RequestMapping(value="/admin/data/removeResearch.json")
	public String removeResearch(@RequestBody String[] addList) {
		// addList를 사용하여 원하는 작업 수행

		// 여기서 예를 들어 배열 내용을 콘솔에 출력하는 작업을 해보겠습니다.
		for (String value : addList) {
			configService.removeCompCode(value);
		}
		// 처리 결과를 반환 (예: 성공 여부 메시지)
		return "Success";
	}
	
	@RequestMapping(value="/admin/data/preview.do")
	public void preview(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap ,ModelMap model){
		Workbook wb = dailyRptSendExcel.get_mainFlowerAuc_excel(pRequestParamMap.get("searchEndDate").toString());
		try {
			// 컨텐츠 타입과 파일명 지정
			pResponse.setContentType("ms-vnd/excel");
			pResponse.setHeader("Content-Disposition", "attachment;filename="+new String(("주요절화류 도매가격 동향").getBytes("KSC5601"),"8859_1")+".xls");
		
			// 엑셀 출력
			wb.write(pResponse.getOutputStream());
			wb.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	@RequestMapping(value="admin/data/getNeisKey.do")
	@ResponseBody
	public String getNeisKey(@RequestParam String type){
		return configService.getNeisKey(type);
	}
	
	@RequestMapping(value="/admin/data/preview2.do")
	public void preview2(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap ,ModelMap model){
		Workbook wb = dailyRptSendExcel.get_dayPumAuc_excel(pRequestParamMap.get("searchEndDate").toString());
		try {
			// 컨텐츠 타입과 파일명 지정
			pResponse.setContentType("ms-vnd/excel");
			pResponse.setHeader("Content-Disposition", "attachment;filename="+new String(("일별 품목별 경매실적 및 동향").getBytes("KSC5601"),"8859_1")+".xls");
			
			// 엑셀 출력
			wb.write(pResponse.getOutputStream());
			wb.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="admin/data/selectPumJongInfo.json")
 	public String selectPumJongInfo(HttpServletRequest pRequest,HttpServletResponse pResponse
 			,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){
 		
		try{
			List<Map<String, Object>> list2 = configService.selectPumJongInfo(pRequestParamMap);
			model.addAttribute("list", list2);
		} catch(Exception e){
			e.printStackTrace();
		}
 		
 		return "jsonView";
 	}
	
	@RequestMapping("/admin/data/selectConfig.json")
	public String selectConfig(HttpServletRequest pRequest,HttpServletResponse pResponse
			,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model) {
		List<Map<String, Object>> list =  configService.selectConfig(pRequestParamMap);
		model.addAttribute("list",list);
		return "jsonView";
	}
	
	@RequestMapping("/admin/data/selectConfig2.json")
	public String selectConfig2(HttpServletRequest pRequest,HttpServletResponse pResponse
			,@RequestBody Map<String, Object> pRequestParamMap,ModelMap model) {
		List<Map<String, Object>> list =  configService.selectConfig(pRequestParamMap);
		model.addAttribute("list",list);
		return "jsonView";
	}
	
	@RequestMapping("/admin/data/setupIpConfig.json")
	public String setupIpConfig(HttpServletRequest pRequest,HttpServletResponse pResponse
			,@RequestBody List<Map<String, Object>> pRequestParamMap,ModelMap model) {
		System.out.println(pRequestParamMap);
		try {
			if(null != pRequestParamMap && pRequestParamMap.size() > 0) {
				for (Map<String, Object> map : pRequestParamMap) {
					if(map.get("requestType").equals("new")) {
						//insert
						configService.insertIpData(map);
					} else if(map.get("requestType").equals("edit")) {
						//update
						configService.updateIpData(map);
					} else {
						//delete
						configService.deleteIpData(map);
					}
				}
			}	
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			model.addAttribute("msg","error");
		}
		model.addAttribute("msg","success");
		//List<Map<String, Object>> list =  configService.selectConfig(pRequestParamMap);
		//model.addAttribute("list",list);
		return "jsonView";
	}

}
