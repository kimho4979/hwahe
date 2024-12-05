package com.fpditrans.base.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface ExcelMapper {

	public Integer insertExcelDataFlowerCompany(List<Map<String, String>> param) throws Exception;

	public List<Map<String, Object>> getDataList(Map<String, Object> param) throws Exception;

	public List<Map<String, Object>> getLocation(Map<String, Object> m) throws Exception; 

	public List<Map<String, Object>> callKosisData(Map<String, Object> m) throws Exception;

	public int updateCompanyData(Map map) throws Exception ;

	public List<Map<String, String>> getRmateLocation() throws Exception ;

	public void insertExcelDataFlowerCompanyOne(Map<String, String> o)throws Exception ;
	
	
}
