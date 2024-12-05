package com.fpminput.mntr.apimgt.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpminput.mntr.apimgt.mapper.ApiMgtMapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class ApiMgtService extends BaseService {

	@Autowired
	ApiMgtMapper apiMgtMapper;
	
	// 공공데이터 OpenAPI SelectBox :: 공통
	public List<EgovMap> selectApiSelectBoxList(){
		return apiMgtMapper.selectApiSelectBoxList();		
	}
	
	// 공공데이터 개발설정 조회
	public List<EgovMap> selectApiMgtList(){
		return apiMgtMapper.selectApiMgtList();		
	}
	
	// 공공데이터 개발설정 수정
	public int updateApiMgtList(Map<String, Object> pReqParamMap){
		return apiMgtMapper.updateApiMgtList(pReqParamMap);
	}
	
	// 공공데이터 신청 조회
	public List<EgovMap> selectApiDegreeList(Map<String, Object> pReqParamMap){
		return apiMgtMapper.selectApiDegreeList(pReqParamMap);		
	}
	
	// 공공데이터 신청 수정
	public int updateApiDegreeList(Map<String, Object> pReqParamMap){
		return apiMgtMapper.updateApiDegreeList(pReqParamMap);
	}
	
	// 공공데이터 신청 조회
	public List<EgovMap> selectApiLogList(Map<String, Object> pReqParamMap){
		return apiMgtMapper.selectApiLogList(pReqParamMap);		
	}
	
}