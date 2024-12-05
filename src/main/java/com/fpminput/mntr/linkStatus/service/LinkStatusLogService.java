package com.fpminput.mntr.linkStatus.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpminput.mntr.linkStatus.mapper.LinkStatusLogMapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class LinkStatusLogService extends BaseService {
	
	@Autowired
	LinkStatusLogMapper linkStatusLogMapper;

	/*
	 * 수동배치 실행
	 */
	public List<EgovMap> selectRunManualBatchList(Map<String, Object> pRequestParamMap){
		return linkStatusLogMapper.selectRunManualBatchList(pRequestParamMap);		
	}
	
	/*
	 * 연계현황 조회
	 */
	public List<EgovMap> selectCheckList(Map<String, Object> pRequestParamMap){
		return linkStatusLogMapper.selectCheckList(pRequestParamMap);		
	}
	
	/*
	 * 연계현황 상세조회 :: 로그조회
	 */
	public List<EgovMap> selectCheckListDetailLog(Map<String, Object> pRequestParamMap){
		return linkStatusLogMapper.selectCheckListDetailLog(pRequestParamMap);		
	}

	public List<EgovMap> selectFailList(Map<String, Object> pRequestParamMap) {
		return linkStatusLogMapper.selectFailList(pRequestParamMap);		
	}
	
	// 시스템 구분 공통코드 조회
	public List<EgovMap> selectSysGp(Map<String, Object> pRequestParamMap) {
		return linkStatusLogMapper.selectSysGp(pRequestParamMap);
	}
	
	// 연계 시스템 LOG 리스트 조회
	public List<EgovMap> selectLogList(Map<String, Object> pRequestParamMap) {
		return linkStatusLogMapper.selectLogList(pRequestParamMap);
	}
	
	public EgovMap selectLog(Map<String, Object> pRequestParamMap) {
		return linkStatusLogMapper.selectLog(pRequestParamMap);
	}
	
}
