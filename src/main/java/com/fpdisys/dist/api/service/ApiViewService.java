package com.fpdisys.dist.api.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.api.domain.ApiViewVO;
import com.fpdisys.dist.api.mapper.ApiViewMapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class ApiViewService extends BaseService {
	
	@Autowired
	ApiViewMapper apiViewMapper;
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	// 사용자 입력
	public int insertApiUser(Map<String, Object> pRequestParamMap){
		return apiViewMapper.insertApiUser(pRequestParamMap);
	}
	
	// 공공데이터 개방 신청 자동승인, 활용기간, 트래픽 조회
	public List<ApiViewVO> selectSettingList(Map<String, Object> pRequestParamMap){
		return apiViewMapper.selectSettingList(pRequestParamMap);
	}
	
	// 공공데이터 개방 신청 :: 상세기능 정보
	public List<EgovMap> selectDetailFunctionList(Map<String, Object> pRequestParamMap){
		return apiViewMapper.selectDetailFunctionList(pRequestParamMap);
	}
	
	// 공공데이터 개방 신청 정보 입력
	public int insertApiData(Map<String, Object> pRequestParamMap){
		return apiViewMapper.insertApiData(pRequestParamMap);
	}
	
	// 공공데이터 개방 신청 :: 회원 정보
	public List<EgovMap> selectMemberList(Map<String, Object> pRequestParamMap){
		return apiViewMapper.selectMemberList(pRequestParamMap);
	}
	
	// 공공데이터 개방 신청 :: 신청한 공공데이터가 있는 경우
	public List<EgovMap> selectExsistList(Map<String, Object> pRequestParamMap){
		return apiViewMapper.selectExsistList(pRequestParamMap);
	}
	
	// 공공데이터 개방 재신청 정보 입력
	public int updateApiData(Map<String, Object> pRequestParamMap){
		return apiViewMapper.updateApiData(pRequestParamMap);
	}
	
	// 공공데이터 개방 수정 정보 입력
	public int updateApiDataInUser(Map<String, Object> pRequestParamMap){
		return apiViewMapper.updateApiDataInUser(pRequestParamMap);
	}
	
}
