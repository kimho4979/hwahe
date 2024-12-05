package com.fpdisys.dist.hfa01.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.hfa01.domain.Hfa01VO;
import com.fpdisys.dist.hfa01.mapper.Hfa01Mapper;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Service
public class Hfa01Service extends BaseService {
	
	@Autowired
	Hfa01Mapper hfa01Mapper;

	public List<Hfa01VO> selectHfa01(Map<String, Object> pRequestParamMap, PaginationInfo paginationInfo ){
		
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
		
		
		return hfa01Mapper.selectHfa01(pRequestParamMap);		
	}
	
	public List<Hfa01VO> selectMainGongi(Hfa01VO hfa01vo){
		return hfa01Mapper.selectMainGongi(hfa01vo);
	}
	
	public Hfa01VO selectMainGongiSeq(String seq){
		return (Hfa01VO) hfa01Mapper.selectMainGongiSeq(seq);
	}
	
	public int insertNotice(Map<String, Object> pReqParamMap){	
		
		return hfa01Mapper.insertNotice(pReqParamMap);
	}
	
	public int insertNoticeFile(Map<String, Object> pRequestParamMap){
		return hfa01Mapper.insertNoticeFile(pRequestParamMap);		
	}
	
	public int updateNotice(Map<String, Object> pReqParamMap){
		return hfa01Mapper.updateNotice(pReqParamMap);
	}
	
	public int updateNoticeFile(Map<String, Object> pRequestParamMap){
		return hfa01Mapper.updateNoticeFile(pRequestParamMap);		
	}	
	
	public int deleteNotice(Map<String, Object> pRequestParamMap){
		return hfa01Mapper.deleteNotice(pRequestParamMap);		
	}	
	
	public int deleteNoticeFile(Map<String, Object> pRequestParamMap){
		return hfa01Mapper.deleteNoticeFile(pRequestParamMap);		
	}

	public void updateNoticeClickCnt(Map<String, Object> pRequestParamMap) {
		hfa01Mapper.updateNoticeClickCnt(pRequestParamMap);	
	}
	
}
