package com.fpditrans.base.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpditrans.base.mapper.ExcelMapper;
@Service
public class ExcelServiceImpl implements ExcelService {
	@Autowired
	ExcelMapper excelMapper;
	@Override
	public Integer insertExcelDataFlowerCompany(List<Map<String, String>> param) throws Exception {
		System.out.println(param);
		return excelMapper.insertExcelDataFlowerCompany(param);
	}
	@Override
	public List<Map<String, Object>> getDataList(Map<String, Object> param) throws Exception {
		
		
		String year = (param.get("year").toString());
		String locDo = (param.get("locDo") != null ? param.get("locDo").toString() : "");
		String locSi = (param.get("locSi") != null ? param.get("locSi").toString() : "");
		String locGu = (param.get("locGu") != null ? param.get("locGu").toString() : "");
		//String loc = (param.get("location") != null ? param.get("location").toString() : "");
		String loc = (param.get("loc") != null ? param.get("loc").toString() : "");
		
		String gubun1 = (param.get("gubun1") != null ? param.get("gubun1").toString() : "");
		String gubun2 = (param.get("gubun2") != null ? param.get("gubun2").toString() : "");
		String gubun3 = (param.get("gubun3") != null ? param.get("gubun3").toString() : "");
		String lvl = (param.get("lvl") != null ? param.get("lvl").toString() : "");
		
		////////param.put("locDo",locDo.substring(0, 2));
		return excelMapper.getDataList(param);
		
	}
	
	@Override
	public List<Map<String, Object>> getLocation(String year,String loc) throws Exception {
		Map<String,Object> m = new HashMap<>();
		m.put("year", year);
		m.put("loc", loc);
		List<Map<String, Object>> a = excelMapper.getLocation(m);
		for(Map<String,Object> o : a) {
			if(Pattern.matches("^[A-Z]*$", o.get("CD").toString().substring(2, 3))) {
				o.put("lvl", 1);
			}else if(Integer.parseInt(o.get("CD").toString().substring(4, 5)) > 0){
				o.put("lvl", 3);
			}else {
				o.put("lvl", 2);
			}
		}

		return a;
	}
	@Override
	public List<Map<String, Object>> callKosisData(Map<String, Object> param) throws Exception {
		String locDo = (param.get("locDo") != null ? param.get("locDo").toString() : "");
		param.put("locDo",locDo.substring(0, 2));
		StringBuilder sb = new StringBuilder("");
		List<String> chkopt = (ArrayList<String>)param.get("chkopt");
		int c=0;
		if(chkopt.size() > 0 ) {
			for(String o : chkopt) {
				String comma = "";
				//if(c != (chkopt.size()-1))comma = ",";
				if(o.equals("1")) 
					sb.append("1");
				if(o.equals("2")) 
					sb.append("2");
				if(o.equals("3")) 
					sb.append("3");
				if(o.equals("4")) 
					sb.append("4");
				c++;	
			}
			sb.append("");
			param.put("andQry", sb.toString());
		}
		return excelMapper.callKosisData(param);
	}
	@Override
	public int updateCompanyData(Map map) throws Exception {
		return excelMapper.updateCompanyData(map);
	}
	@Override
	public List<Map<String, String>> getRmateLocation() throws Exception {
		return excelMapper.getRmateLocation();
	}
	@Override
	public void insertExcelDataFlowerCompanyOne(Map<String, String> o) throws Exception {
		excelMapper.insertExcelDataFlowerCompanyOne(o);
	}

}
