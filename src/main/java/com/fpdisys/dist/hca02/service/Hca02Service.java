package com.fpdisys.dist.hca02.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.hca02.domain.Hca02ExcelVO;
import com.fpdisys.dist.hca02.domain.Hca02VO;
import com.fpdisys.dist.hca02.mapper.Hca02Mapper;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Service
public class Hca02Service extends BaseService {
	
	@Autowired
	Hca02Mapper hca02Mapper;

	public List<Hca02VO> selectHca02(Map<String, Object> pRequestParamMap, PaginationInfo paginationInfo){
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
		
		
		
		return hca02Mapper.selectHca02(pRequestParamMap);		
	}

	public List<Map<String, String>> selectCropTrendList(Hca02VO hca02vo) {
		return hca02Mapper.selectCropTrendList(hca02vo);
	}
	
	// 재배동향 :: Excel
	public List<Hca02ExcelVO> selectHca02Excel(Map<String, Object> pRequestParamMap){
		return hca02Mapper.selectHca02Excel(pRequestParamMap);		
	}


	
	/*public List<?> selectGridList(Map<String, Object> pRequestParamMap){
		return hca02Mapper.selectGridList(pRequestParamMap);		
	}
	*/
	
}