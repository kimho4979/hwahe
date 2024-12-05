package com.fpdisys.dist.hab09.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.hab01.domain.Hab01VO;
import com.fpdisys.dist.hab01.mapper.Hab01Mapper;
import com.fpdisys.dist.hab09.mapper.Hab09Mapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Service
public class Hab09Service extends BaseService {
	
	@Autowired 
	Hab09Mapper hab09Mapper;
	
	/*
	 * 일자별 경매동향
	 */
	public List<EgovMap> getAucBbsList(Map<String, Object> pRequestParamMap, PaginationInfo paginationInfo) {
		
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
		
		return hab09Mapper.getAucBbsList(pRequestParamMap);
	}
	
	/*
	 * 조회수 업데이트
	 */
	public void updateClickCnt(Map<String, Object> pRequestParamMap) {
		hab09Mapper.updateClickCnt(pRequestParamMap);
	}
	
	/*
	 * 팝업
	 */
	public Map<String, Object> selectHab09Detail(Map<String, Object> pRequestParamMap) {
		return hab09Mapper.selectHab09Detail(pRequestParamMap);
	}
	
	/*
	 * 경매건수가 0건 이상인 공판장 조회
	 */
	public List<EgovMap> getDataCmpList(Map<String, Object> dateParam) {
		return hab09Mapper.getDataCmpList(dateParam);
	}
	
	/*
	 * 게시글 업로드
	 */
	public void insertAucBbs(Map<String, Object> param) {
		hab09Mapper.insertAucBbs(param);
	}
	
	/*
	 * 일자별 경매동향 :: Excel
	 */
	public List<EgovMap> selectAucExcel(Map<String, Object> pRequestParamMap) {
		return hab09Mapper.selectAucExcel(pRequestParamMap);
	}
}
