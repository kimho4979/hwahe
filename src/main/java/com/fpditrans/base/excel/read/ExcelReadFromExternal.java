package com.fpditrans.base.excel.read;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fpditrans.base.service.ExcelService;

@Controller
public class ExcelReadFromExternal  {
	/////public ExcelReadFromExternal() {read();}
	@Autowired
	ExcelService excelService;
	
	@RequestMapping("/hga07/hga07.do")
	public String screen() {
		return "auction/Hga07";
	}
	
	
	@RequestMapping("/admin/flowerCompany.do")
	public String page(HttpServletRequest pRequest) {
		
		HttpSession httpSession = pRequest.getSession();
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}
		return "admin/flowerCompany";
	}
	
	
	@RequestMapping("/excel/kosis/upload.json")
	public String upload(ModelMap model,MultipartHttpServletRequest req) {
		String year = req.getParameter("year");
		for(MultipartFile f : req.getFiles("files")) {
			//System.out.println(f.getOriginalFilename());
			//System.out.println(year);
			try {
				List<Map<String,String>> r = ExcelRead.readFilter(f.getOriginalFilename(),f.getInputStream(),year);
				
				
				int rc = 0;
				int partitionSize = 999;
			    List<List<Map<String,String>>> partitions = new ArrayList<>();

			    for (int i=0; i<r.size(); i += partitionSize) {
			        partitions.add(r.subList(i, Math.min(i + partitionSize, r.size())));
			    }
			    
			    //startTx();
			    for (List<Map<String,String>> list : partitions) {
			        //DB 요청 
			    	rc += excelService.insertExcelDataFlowerCompany(list);
			    }
			    
			    
			    //commit();
				
				System.out.println("디비에 들어간 갯수  :  "+rc);
				model.addAttribute("msg",f.getOriginalFilename()+"파일 ("+rc+")건이 등록되었습니다.");
			} catch (Exception e) {
				//rollback();
				
				e.printStackTrace();
				System.out.println(e.getMessage());
				model.addAttribute("msg","오류발생");
				return "jsonView";
			}
			
		}
		return "jsonView";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/admin/kosis/updateCompanyData.json")
	public String update(ModelMap model,@RequestBody List<Map> pRequestParamMap) {
		try {
			System.out.println(pRequestParamMap);	
			System.out.println(new JSONObject(pRequestParamMap).toString(2));
			int c=0;
			for(Map map : pRequestParamMap) {
				System.out.println(map);
				c += excelService.updateCompanyData(map);
			}
			System.out.println(c);
			model.addAttribute("msg","("+c+")건이 수정되었습니다.");
		} catch (Exception e) {
			
			System.out.println(e.getMessage());
			model.addAttribute("msg","오류발생");
			return "jsonView";
		}
		
		
		return "jsonView";
	}
	
	
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/admin/kosis/onlineMagazine.json")
	public String read2(ModelMap model,@RequestParam Map pRequestParamMap) {
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
			model.addAttribute("list",excelService.getDataList(pRequestParamMap));
			model.addAttribute("list2",obj.toString());
			model.addAttribute("msg","성공");
			return "jsonView";
				
		} catch (Exception e) {
			
			System.out.println(e.getMessage());
			model.addAttribute("msg","오류발생");
			return "jsonView";
		}
	}
	
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/excel/kosis/onlineMagazine.json")
	public String read(ModelMap model,@RequestParam Map inParam) {
		try {
			Map<String,Object> map = null;
			Map<String,Object> pmap = new HashMap<String, Object>();
			if(null != inParam){
				for ( Object o  :inParam.keySet()) {
					//System.out.println(o);
					map = new ObjectMapper().readValue(o.toString(),Map.class);
					//System.out.println(map);
					
				}
				
				pmap.put("year",map.get("year"));
				pmap.put("locDo",map.get("locDo"));
				pmap.put("locSi",map.get("locSi"));
				pmap.put("locGu",map.get("locGu"));
				pmap.put("location",map.get("location"));
				pmap.put("gubun1",map.get("gubun1"));
				pmap.put("gubun2",map.get("gubun2"));
				pmap.put("gubun3",map.get("gubun3"));
				pmap.put("chkopt",map.get("chkopt"));
				pmap.put("lvl",map.get("lvl"));
			}
			
			System.out.println("지역별 :파람: "+pmap);
			excelService.callKosisData(pmap);
			List<Map<String,String>> rmate = excelService.getRmateLocation();
			// System.out.println(new JSONObject(pmap).toString(2));
			List<Map<String,Object>> mmap = new ArrayList<Map<String, Object>>();
			List<Map<String,Object>> rmap = new ArrayList<Map<String, Object>>();
			mmap = (List<Map<String,Object>>)pmap.get("o_cursor");
			System.out.println("지역 : "+pmap.get("locDo"));
			for (Map<String,Object> o : mmap) {
				String[] _oo = new String[]{"채소, 화훼 및 과실작물 시설 재배업","채소, 화훼작물 및 종묘 재배업","화훼류 및 식물 도매업","화훼작물 재배업"};
				o.put("loc2", pmap.get("location"));
				o.put("loc", pmap.get("locDo"));
				
				// 100 / 32 강원도
				// 200 / 31 경기도
				// 300 / 38 경상남도
				// 400 / 37 경상북도
				// 500 / 24 광주
				// 600 / 22 대구
				// 700 / 25 대전
				// 800 / 21 부산
				// 900 / 11 서울
				// 1000 / 26 울산
				// 1100 / 23 인천
				// 1200 / 36 전라남도
				// 1300 / 35 전라북도
				// 1400 / 39 제주
				// 1500 / 34 충청남도
				// 1600 / 33 충청북도
				// 1700 / 29 세종
				//switch (pmap.get("locDo").toString())
				for (Map<String, String> rmateo : rmate) {	
					if(rmateo.get("CODE2").equals(pmap.get("locDo").toString()) 
						&& rmateo.get("LABEL").equals(o.get("CPNM1").toString())) {
						o.put("code", rmateo.get("CODE"));
						o.put("id", rmateo.get("CODE"));
					}else if(pmap.get("locDo").toString().equals("al") && rmateo.get("LABEL").equals(o.get("CPNM1").toString())) {
						o.put("code", rmateo.get("CODE"));
						o.put("id", rmateo.get("CODE"));
					}
				}
				//지역별 코드 추출 (알메이트, KOSIS)
				/*for (Map<String, String> rmateo : rmate) {
					//System.out.println("지역부분 짜름 :: "+o.get("CPNM1").toString().substring(0, 2));
					//System.out.println("지역부분 짜름 :: "+rmateo.get("LABEL"));
					if(rmateo.get("LABEL").equals(o.get("CPNM1"))) {
						o.put("code", rmateo.get("CODE"));
						o.put("id", rmateo.get("CODE"));
					}
				}*/
				
				// 화훼관련 조건분류1
				List<String>_o = (List<String>)pmap.get("chkopt");
				if (_o.size() == 0) {
					if(!o.get("INDST_NM").toString().equals(_oo[0])
						&& !o.get("INDST_NM").toString().equals(_oo[1])
						&& !o.get("INDST_NM").toString().equals(_oo[2])
						&& !o.get("INDST_NM").toString().equals(_oo[3])
						) {
						rmap.add(o);
					}
				}
				
				//화훼관련 조건분류2
				for(String oo : (List<String>)pmap.get("chkopt")) {
					if(oo.equals("1") && o.get("INDST_NM").toString().equals("채소, 화훼 및 과실작물 시설 재배업")){
						rmap.add(o);
					} else if(oo.equals("2") && o.get("INDST_NM").toString().equals("채소, 화훼작물 및 종묘 재배업")) {
						rmap.add(o);
					} else if(oo.equals("3") && o.get("INDST_NM").toString().equals("화훼류 및 식물 도매업")) {
						rmap.add(o);
					} else if(oo.equals("4") && o.get("INDST_NM").toString().equals("화훼작물 재배업")) {
						rmap.add(o);
					} else {
						
					}  
					
				}
				
			}
			// 합계 summary 구하기 
			int c=0;
			for(Map<String,Object> o : rmap) {
				c += Integer.parseInt(o.get("VAL").toString());
			}
			Map<String,Object> _m = new HashMap<>();
			_m.put("INDST_NM", "-");
			_m.put("CPNM1", "합계");
			_m.put("GUBUN1", "-");
			_m.put("GUBUN2", "-");
			_m.put("GUBUN3", "-");
			_m.put("VAL", c);
			
			rmap.add(0, _m);
			
			model.addAttribute("list",rmap);
			model.addAttribute("msg","성공");
			return "jsonView";
				
		} catch (Exception e) {
			System.out.println(e.getMessage());
			model.addAttribute("msg","오류발생");
			return "jsonView";
		}
		
	}
	
	enum flowerType{
		a("채소, 화훼 및 과실작물 시설 재배업"), 
		b("채소, 화훼작물 및 종묘 재배업"), 
		c("화훼류 및 식물 도매업"),
		d("화훼작물 재배업");
		
		final private String name; 
		public String getName() { 
			return name; 
		} 
		private flowerType(String name){ 
			this.name = name; 
		} 
	}
	
	
	@RequestMapping("/excel/kosis/getLocation.json")
	public String getLoc(ModelMap model, @RequestParam String loc, @RequestParam String year) {
		try {
			List<Map<String, Object>> result =  excelService.getLocation(year,loc);
			List<Map<String, Object>> result1 =  new ArrayList<Map<String,Object>>();
			List<Map<String, Object>> result2 =  new ArrayList<Map<String,Object>>();
			List<Map<String, Object>> result3 =  new ArrayList<Map<String,Object>>();
			
			for(Map<String,Object> o : result) {
				
				if(Integer.parseInt(o.get("LVL").toString()) == 1) {
					result1.add(o);
				}else 
				if(Integer.parseInt(o.get("LVL").toString()) == 2) {
					result2.add(o);
				}else 
				if(Integer.parseInt(o.get("LVL").toString()) == 3) {
					result3.add(o);
				}
			}
			
			System.out.println(result1);
			System.out.println(result2);
			System.out.println(result3);
			
			/////////excelService.callKosisData(a);
			//System.out.println("커서 결과값"+a.get("o_cursor"));
			//System.out.println(new JSONObject(a).toString(2));
			
			model.addAttribute("list", result);
			model.addAttribute("list1", result1);
			model.addAttribute("list2", result2);
			model.addAttribute("list3", result3);
			model.addAttribute("msg","성공");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			model.addAttribute("msg","오류발생");
			return "jsonView";
		}
		return "jsonView";
	}
	
	
}
