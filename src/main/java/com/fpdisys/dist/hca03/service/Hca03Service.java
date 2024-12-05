package com.fpdisys.dist.hca03.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.hca03.domain.Hca03ExcelVO;
import com.fpdisys.dist.hca03.domain.Hca03VO;
import com.fpdisys.dist.hca03.mapper.Hca03Mapper;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Service
public class Hca03Service extends BaseService {
	
	@Autowired
	Hca03Mapper hca03Mapper;

	public List<Hca03VO> selectHca03(Map<String, Object> pRequestParamMap, PaginationInfo paginationInfo){
		
		if(pRequestParamMap.get("currentPageNo") == null || StringUtils.isEmpty(pRequestParamMap.get("currentPageNo")) == true)
			pRequestParamMap.put("currentPageNo", "1");
		
		paginationInfo.setCurrentPageNo(Integer.parseInt(pRequestParamMap.get("currentPageNo").toString()));
	  
		if(pRequestParamMap.get("PAGE_ROW") == null || StringUtils.isEmpty(pRequestParamMap.get("PAGE_ROW")) == true){
			paginationInfo.setRecordCountPerPage(6);
		}else{
			paginationInfo.setRecordCountPerPage(Integer.parseInt(pRequestParamMap.get("PAGE_ROW").toString()));
		}
		
		//20.03.16 페이징 크기로 인해 10->5 수정
		paginationInfo.setPageSize(5);
		
		int start = paginationInfo.getFirstRecordIndex();
		int end = start + paginationInfo.getRecordCountPerPage();
		pRequestParamMap.put("START",start+1);
		pRequestParamMap.put("END",end);
		
		return hca03Mapper.selectHca03(pRequestParamMap);		
	}
	
	public List<Hca03VO> selectHca03Test(Map<String, Object> pRequestParamMap, PaginationInfo paginationInfo){
		
		if(pRequestParamMap.get("currentPageNo") == null || StringUtils.isEmpty(pRequestParamMap.get("currentPageNo")) == true)
			pRequestParamMap.put("currentPageNo", "1");
		
		paginationInfo.setCurrentPageNo(Integer.parseInt(pRequestParamMap.get("currentPageNo").toString()));
	  
		if(pRequestParamMap.get("PAGE_ROW") == null || StringUtils.isEmpty(pRequestParamMap.get("PAGE_ROW")) == true){
			paginationInfo.setRecordCountPerPage(6);
		}else{
			paginationInfo.setRecordCountPerPage(Integer.parseInt(pRequestParamMap.get("PAGE_ROW").toString()));
		}
		
		//20.03.16 페이징 크기로 인해 10->5 수정
		paginationInfo.setPageSize(5);
		
		int start = paginationInfo.getFirstRecordIndex();
		int end = start + paginationInfo.getRecordCountPerPage();
		pRequestParamMap.put("START",start+1);
		pRequestParamMap.put("END",end);
		
		return hca03Mapper.selectHca03Test(pRequestParamMap);		
	}
	
	public List<Hca03VO> selectJakgwangList(Hca03VO hca03vo){
		return hca03Mapper.selectJakgwangList(hca03vo);
	}

	public Map<String, String> selectCropFileDetail(String fileSeq) {
		return hca03Mapper.selectCropFileDetail(fileSeq);
	}

	public List<Hca03VO> selectCropMainChart(Map<String, Object> pRequestParamMap) {
		return hca03Mapper.selectCropMainChart(pRequestParamMap);
	}
	
	public List<Hca03ExcelVO> selectHca03Excel(Map<String, Object> pRequestParamMap) {
		return hca03Mapper.selectHca03Excel(pRequestParamMap);
	}
	
}