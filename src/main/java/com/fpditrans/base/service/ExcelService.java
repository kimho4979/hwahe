package com.fpditrans.base.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;


public interface ExcelService {
	public Integer insertExcelDataFlowerCompany(List<Map<String,String>> param) throws Exception;

	public List<Map<String,Object>> getDataList(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> getLocation(String year, String loc) throws Exception;  
	
	public List<Map<String, Object>> callKosisData(Map<String, Object> m) throws Exception;

	public int updateCompanyData(Map map) throws Exception;

	public List<Map<String, String>> getRmateLocation()throws Exception;

	public void insertExcelDataFlowerCompanyOne(Map<String, String> o) throws Exception;
}
