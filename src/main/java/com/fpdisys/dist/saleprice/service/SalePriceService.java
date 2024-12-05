package com.fpdisys.dist.saleprice.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.saleprice.domain.SalePriceVO;
import com.fpdisys.dist.saleprice.mapper.SalePriceMapper;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Service
public class SalePriceService extends BaseService {
	
	@Autowired
	SalePriceMapper salePriceMapper;

	public List<SalePriceVO> selectSalePrice(Map<String, Object> pRequestParamMap){
		return salePriceMapper.selectSalePrice(pRequestParamMap);
	}	
	
	public List<SalePriceVO> 	selectPointSalePrice(Map<String, Object> pRequestParamMap,  PaginationInfo paginationInfo){
		
		if(pRequestParamMap.get("currentPageNo") == null || StringUtils.isEmpty(pRequestParamMap.get("currentPageNo")) == true)
			pRequestParamMap.put("currentPageNo", "1");
		
		paginationInfo.setCurrentPageNo(Integer.parseInt(pRequestParamMap.get("currentPageNo").toString()));
	  
		if(pRequestParamMap.get("PAGE_ROW") == null || StringUtils.isEmpty(pRequestParamMap.get("PAGE_ROW")) == true){
			paginationInfo.setRecordCountPerPage(6);
		}else{
			paginationInfo.setRecordCountPerPage(Integer.parseInt(pRequestParamMap.get("PAGE_ROW").toString()));
		}
		
		paginationInfo.setPageSize(10);
		
		int start = paginationInfo.getFirstRecordIndex();
		int end = start + paginationInfo.getRecordCountPerPage();
		pRequestParamMap.put("START",start+1);
		pRequestParamMap.put("END",end);
		
		
		return salePriceMapper.selectPointSalePrice(pRequestParamMap);
	}

	public String selectFastDay() {
		return salePriceMapper.selectFastDay();
	}
	
	public void delBizMsg(Map<String, Object> pRequestParamMap){
		 salePriceMapper.delBizMsg(pRequestParamMap);
	}	
	
	public List<?> getBizMsg(Map<String, Object> pRequestParamMap){
		return salePriceMapper.getBizMsg(pRequestParamMap);
	}	
	
	
	public void delBizMail(Map<String, Object> pRequestParamMap){
		salePriceMapper.delBizMail(pRequestParamMap);
	}	
	
	public List<?> getBizMail(Map<String, Object> pRequestParamMap){
		return salePriceMapper.getBizMail(pRequestParamMap);
	}

	
	public void insertBizMSGForOarcle(List<Map<String, String>> insertList) {
		
		Map<String, String> map = null;
		for (int i = 0; i < insertList.size(); i++) {
			map = insertList.get(i);
			salePriceMapper.insertBizMSGForOarcle(map);
		}
		
	}

	public String selectTodaySale() {
		return salePriceMapper.selectTodaySale();
	}
	
	public List<SalePriceVO> selectPointSalePriceExcel(Map<String, Object> pRequestParamMap){
		return salePriceMapper.selectPointSalePriceExcel(pRequestParamMap);
	}
	
}
