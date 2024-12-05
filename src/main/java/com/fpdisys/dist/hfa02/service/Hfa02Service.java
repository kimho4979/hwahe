package com.fpdisys.dist.hfa02.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.hfa02.domain.Hfa02VO;
import com.fpdisys.dist.hfa02.mapper.Hfa02Mapper;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Service
public class Hfa02Service extends BaseService {
	
	@Autowired
	Hfa02Mapper hfa02Mapper;

	public List<Hfa02VO> selecthfa02(Map<String, Object> pRequestParamMap, PaginationInfo paginationInfo ){
		
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
		
		
		return hfa02Mapper.selectHfa02(pRequestParamMap);		
	}
	
	/*public int updateCropInfoInput(Map<String, Object> pReqParamMap){
		return mab01Mapper.updateCropInfoInput(pReqParamMap);
	}
	
	public int insertCropInfoInput(Map<String, Object> pReqParamMap){
		return mab01Mapper.insertCropInfoInput(pReqParamMap);
	}
	
	public int deleteCropInfoInput(Map<String, Object> pReqParamMap){
		return mab01Mapper.deleteCropInfoInput(pReqParamMap);
	}*/

	
	public int insertNotice(Map<String, Object> pReqParamMap){	
		
		return hfa02Mapper.insertNotice(pReqParamMap);
	}
	
	public int insertNoticeFile(Map<String, Object> pRequestParamMap){
		return hfa02Mapper.insertNoticeFile(pRequestParamMap);		
	}
	
	public int updateNotice(Map<String, Object> pReqParamMap){
		return hfa02Mapper.updateNotice(pReqParamMap);
	}
	
	public int updateNoticeFile(Map<String, Object> pRequestParamMap){
		return hfa02Mapper.updateNoticeFile(pRequestParamMap);		
	}	
	
	public int deleteNotice(Map<String, Object> pRequestParamMap){
		return hfa02Mapper.deleteNotice(pRequestParamMap);		
	}	
	
	public int deleteNoticeFile(Map<String, Object> pRequestParamMap){
		return hfa02Mapper.deleteNoticeFile(pRequestParamMap);		
	}
	
}
