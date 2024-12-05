package com.fpdisys.dist.apiCall.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.apiCall.domain.ApiCallSaleDateVO;
import com.fpdisys.dist.apiCall.domain.ApiCallVO;
import com.fpdisys.dist.apiCall.domain.ApiCallYuchalVO;
import com.fpdisys.dist.apiCall.mapper.ApiCallMapper;

@Service
public class ApiCallService extends BaseService {
	
	@Autowired
	ApiCallMapper apiCallMapper;
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	// 공공데이터 URL 조회 시 Validation Check1 :: 유저정보 조회
	public List<ApiCallVO> selectCheckList(Map<String, Object> pRequestParamMap){
		return apiCallMapper.selectCheckList(pRequestParamMap);
	}
	
	// 공공데이터 URL 조회 :: 일자별 경매정보
	public List<ApiCallSaleDateVO> selectSaleDateList(Map<String, Object> pRequestParamMap){
		return apiCallMapper.selectSaleDateList(pRequestParamMap);
	}
	
	// 공공데이터 URL 조회 :: 유찰정보
	public List<ApiCallYuchalVO> selectPassedInList(Map<String, Object> pRequestParamMap){
		return apiCallMapper.selectPassedInList(pRequestParamMap);
	}
	
	// 공공데이터 log Insert :: 호출 건수 일자별 초기화
	public int insertLogList(Map<String, Object> pRequestParamMap){
		return apiCallMapper.insertLogList(pRequestParamMap);
	}
	
	// 공공데이터 log Update :: 호출 건수 증가
	public int updateLogList(Map<String, Object> pRequestParamMap){
		return apiCallMapper.updateLogList(pRequestParamMap);
	}
	
}
