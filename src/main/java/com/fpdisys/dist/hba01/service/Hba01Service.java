package com.fpdisys.dist.hba01.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.hba01.domain.Hba01VO;
import com.fpdisys.dist.hba01.mapper.Hba01Mapper;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Service
public class Hba01Service extends BaseService {
	
	@Autowired
	Hba01Mapper hba01Mapper;

	public List<Hba01VO> selectHba01(Map<String, Object> pRequestParamMap, PaginationInfo paginationInfo){
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
		
		
		return hba01Mapper.selectHba01(pRequestParamMap);		
	}
	
	public List<Hba01VO> selectHba02(Map<String, Object> pRequestParamMap, PaginationInfo paginationInfo){
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
		
		
		return hba01Mapper.selectHba02(pRequestParamMap);		
	}
	
	
	public List<Hba01VO> selectSugup(Hba01VO hba01vo){
		return hba01Mapper.selectSugup(hba01vo);
	}
	
	public int insertForecast(Map<String, Object> pReqParamMap){	
		
		return hba01Mapper.insertForecast(pReqParamMap);
	}
	
	public int insertForecastFile(Map<String, Object> pRequestParamMap){
		return hba01Mapper.insertForecastFile(pRequestParamMap);		
	}	
	
	public Map<String, String> selectFileDown(String seq){
		return hba01Mapper.selectFileDown(seq);		
	}
	
	public int updateForecast(Map<String, Object> pReqParamMap){
		return hba01Mapper.updateForecast(pReqParamMap);
	}
	
	public int updateForecastFile(Map<String, Object> pRequestParamMap){
		return hba01Mapper.updateForecastFile(pRequestParamMap);		
	}	
	
	public int deleteSugeup(Map<String, Object> pRequestParamMap){
		return hba01Mapper.deleteSugeup(pRequestParamMap);		
	}	
	
	public int deleteSugeupFile(Map<String, Object> pRequestParamMap){
		return hba01Mapper.deleteSugeupFile(pRequestParamMap);		
	}

	public void updateForecastClickCnt(Map<String, Object> pRequestParamMap) {
		hba01Mapper.updateForecastClickCnt(pRequestParamMap);
	}
	
	
}