package com.fpminput.mntr.linkStatus.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpminput.mntr.linkStatus.mapper.LinkStatusMapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class LinkStatusService extends BaseService {
	
	@Autowired
	LinkStatusMapper linkStatusMapper;

	/*
	 * 수동배치 실행
	 */
	public List<EgovMap> selectRunManualBatchList(Map<String, Object> pRequestParamMap){
		return linkStatusMapper.selectRunManualBatchList(pRequestParamMap);		
	}
	
	/*
	 * 연계현황 조회
	 */
	public List<EgovMap> selectCheckList(Map<String, Object> pRequestParamMap){
		return linkStatusMapper.selectCheckList(pRequestParamMap);		
	}
	
	/*
	 * 연계현황 상세조회 :: 로그조회
	 */
	public List<EgovMap> selectCheckListDetailLog(Map<String, Object> pRequestParamMap){
		return linkStatusMapper.selectCheckListDetailLog(pRequestParamMap);		
	}

	public List<EgovMap> selectFailList(Map<String, Object> pRequestParamMap) {
		return linkStatusMapper.selectFailList(pRequestParamMap);		
	}
	
}
