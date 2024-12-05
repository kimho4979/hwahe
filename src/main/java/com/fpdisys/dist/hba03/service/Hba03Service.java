package com.fpdisys.dist.hba03.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.hba02.domain.Hba02VO;
import com.fpdisys.dist.hba03.domain.Hba03VO;
import com.fpdisys.dist.hba03.mapper.Hba03Mapper;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Service
public class Hba03Service extends BaseService {
	
	@Autowired
	Hba03Mapper hba03Mapper;

	public List<Hba03VO> selectHba03(Map<String, Object> pRequestParamMap, PaginationInfo paginationInfo){
		if(pRequestParamMap.get("currentPageNo") == null || StringUtils.isEmpty(pRequestParamMap.get("currentPageNo")) == true)
			pRequestParamMap.put("currentPageNo", "1");
		
		paginationInfo.setCurrentPageNo(Integer.parseInt(pRequestParamMap.get("currentPageNo").toString()));
	  
		if(pRequestParamMap.get("PAGE_ROW") == null || StringUtils.isEmpty(pRequestParamMap.get("PAGE_ROW")) == true){
			paginationInfo.setRecordCountPerPage(10);
		}else{
			paginationInfo.setRecordCountPerPage(Integer.parseInt(pRequestParamMap.get("PAGE_ROW").toString()));
		}
		
		paginationInfo.setPageSize(5);
		
		int start = paginationInfo.getFirstRecordIndex();
		int end = start + paginationInfo.getRecordCountPerPage();
		pRequestParamMap.put("START",start+1);
		pRequestParamMap.put("END",end);
		
		
		return hba03Mapper.selectHba03(pRequestParamMap);
	}
	
public int insertForecast(Map<String, Object> pReqParamMap){	
		
		return hba03Mapper.insertForecast(pReqParamMap);
	}
	
	public int insertForecastFile(Map<String, Object> pRequestParamMap){
		return hba03Mapper.insertForecastFile(pRequestParamMap);		
	}	
	
	public Map<String, String> selectFileDown(String seq){
		return hba03Mapper.selectFileDown(seq);		
	}
	
	public int updateForecast(Map<String, Object> pReqParamMap){
		return hba03Mapper.updateForecast(pReqParamMap);
	}
	
	public int updateForecastFile(Map<String, Object> pRequestParamMap){
		return hba03Mapper.updateForecastFile(pRequestParamMap);		
	}	
	
	public int deleteSugeup(Map<String, Object> pRequestParamMap){
		return hba03Mapper.deleteSugeup(pRequestParamMap);		
	}	
	
	public int deleteSugeupFile(Map<String, Object> pRequestParamMap){
		return hba03Mapper.deleteSugeupFile(pRequestParamMap);		
	}
	
}