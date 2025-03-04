package com.egovapi.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.egovapi.mapper.CommonApiLogMapper;

@Service
public class CommonApiLogService {

	@Autowired
	CommonApiLogMapper commonApiLogMapper;


	/**
	 * 데이터 입력실패시 해당 데이터 저장
	 * @param errorDetail
	 * @param map
	 * @param jobId
	 * @param logSeq 
	 */
	public void insertFailLog(String errorDetail, Map<String, String> map, String jobId, String logSeq) {
		Map<String, String> map2 = new HashMap<String, String>();
		map2.put("detail", errorDetail);
		map2.put("data", map.toString());
		map2.put("jobId", jobId);
		map2.put("logSeq", logSeq);
		commonApiLogMapper.insertFailLog(map2);
	}

	/**
	 * 배치 결과 로그 변경
	 * @param result
	 * @param errorDetail
	 * @param jobId
	 * @param logSeq 
	 */
	public void updateResultLog(String result, String errorDetail, String jobId, String logSeq) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("result", result);
		map.put("errorDetail", errorDetail);
		map.put("jobId", jobId);
		map.put("logSeq", logSeq);
		commonApiLogMapper.updateLog(map);
	}
	
	/**
	 * 배치 결과 리스트 업데이트
	 * @param jobId
	 * @param logStat
	 */
	@Transactional
	public void updateJobList(String jobId, String logStat) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("jobId", jobId);
		map.put("logStat", logStat);
		commonApiLogMapper.updateJobList(map);
	}

	/**
	 * 스케쥴러 시작 시 해당 잡에 대한 로그 데이터 생성
	 * @param map
	 * @return
	 */
	public void startJobLog(Map<String, String> map) {
		commonApiLogMapper.startJobLog(map);
	}
	
	
	
}
