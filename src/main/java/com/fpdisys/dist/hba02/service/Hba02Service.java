package com.fpdisys.dist.hba02.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.hba02.domain.Hba02VO;
import com.fpdisys.dist.hba02.mapper.Hba02Mapper;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Service
public class Hba02Service extends BaseService {
	
	@Autowired
	Hba02Mapper hba02Mapper;

	public List<Hba02VO> selectHba02(Map<String, Object> pRequestParamMap, PaginationInfo paginationInfo){
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
		
		
		return hba02Mapper.selectHba02(pRequestParamMap);		
	}
	
public int insertForecast(Map<String, Object> pReqParamMap){	
		
		return hba02Mapper.insertForecast(pReqParamMap);
	}
	
	public int insertForecastFile(Map<String, Object> pRequestParamMap){
		return hba02Mapper.insertForecastFile(pRequestParamMap);		
	}	
	
	public Map<String, String> selectFileDown(String seq){
		return hba02Mapper.selectFileDown(seq);		
	}
	
	public int updateForecast(Map<String, Object> pReqParamMap){
		return hba02Mapper.updateForecast(pReqParamMap);
	}
	
	public int updateForecastFile(Map<String, Object> pRequestParamMap){
		return hba02Mapper.updateForecastFile(pRequestParamMap);		
	}	
	
	public int deleteSugeup(Map<String, Object> pRequestParamMap){
		return hba02Mapper.deleteSugeup(pRequestParamMap);		
	}	
	
	public int deleteSugeupFile(Map<String, Object> pRequestParamMap){
		return hba02Mapper.deleteSugeupFile(pRequestParamMap);		
	}
	
}