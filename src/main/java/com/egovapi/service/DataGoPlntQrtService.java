package com.egovapi.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.egovapi.mapper.DataGoPlntQrtMapper;
import com.egovapi.util.CommonApiUtil;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class DataGoPlntQrtService {
	
	protected Log log = LogFactory.getLog(this.getClass());		

	@Autowired
	DataGoPlntQrtMapper dataGoPlntQrtMapper;
	
	@Autowired
	CommonApiLogService commonApiLogService;

	/**
	 * 공공데이터 식물검역통계-수입실적 서비스 데이터 최신화
	 * @param dataList
	 * @param pRequestParamMap 
	 * @param mclass
	 */
	public void dataType3ImpInsert(List<Map<String, String>> dataList, Map<String, String> pRequestParamMap) {
		String logStat = "1";
		String errorDetail = "";
		String jobId = (String)pRequestParamMap.get("jobId");
		String logSeq = (String)pRequestParamMap.get("logSeq");
		String idx = (String)pRequestParamMap.get("idx");
		
		Map<String, String > map = new HashMap<String, String>();
		map.put("yyyymm", pRequestParamMap.get("yyyymm"));
		//map.put("mclass", mclass);
		// 데이터 추가 전 삭제
		if(idx!=null&& idx.equals("1")){
			dataGoPlntQrtMapper.dataType3ImpBeforeDelete(map);
		}
		
		// 데이터 입력
		for (int i = 0; i < dataList.size(); i++) {
			try {
				dataGoPlntQrtMapper.dataType3ImpInsert(dataList.get(i));
			} catch (Exception e) {
				// 오류처리
				if(e.toString().indexOf("ORA-00001") < 0){
					logStat = "2";
					errorDetail = CommonApiUtil.getSqlErrorMessage(e.toString());
					commonApiLogService.insertFailLog(errorDetail, dataList.get(i), jobId, logSeq);
				}
			}
		}
		// 결과 반영
		if(!"1".equals(logStat)) commonApiLogService.updateResultLog(logStat, errorDetail, jobId, logSeq);
		
		// 최종갱신결과 업데이트
		commonApiLogService.updateJobList(jobId, logStat);
	}
	
	/**
	 * 공공데이터 식물검역통계-수입실적 서비스 데이터 최신화
	 * @param dataList
	 * @param pRequestParamMap 
	 * @param mclass
	 */
	public void dataType3ExpInsert(List<Map<String, String>> dataList, Map<String, String> pRequestParamMap) {
		String logStat = "1";
		String errorDetail = "";
		String jobId = (String)pRequestParamMap.get("jobId");
		String logSeq = (String)pRequestParamMap.get("logSeq");
		String idx = (String)pRequestParamMap.get("idx");
		
		
		Map<String, String > map = new HashMap<String, String>();
		map.put("yyyymm", pRequestParamMap.get("yyyymm"));
		//map.put("mclass", mclass);
		// 데이터 추가 전 삭제
		if(idx!=null&& idx.equals("1")){
			dataGoPlntQrtMapper.dataType3ExpBeforeDelete(map);
		}
		
		// 데이터 입력
		for (int i = 0; i < dataList.size(); i++) {
			try {
				dataGoPlntQrtMapper.dataType3ExpInsert(dataList.get(i));
			} catch (Exception e) {
				// 오류처리
				if(e.toString().indexOf("ORA-00001") < 0){
					logStat = "2";
					errorDetail = CommonApiUtil.getSqlErrorMessage(e.toString());
					commonApiLogService.insertFailLog(errorDetail, dataList.get(i), jobId, logSeq);
				}
			}
		}
		// 결과 반영
		if(!"1".equals(logStat)) commonApiLogService.updateResultLog(logStat, errorDetail, jobId, logSeq);
		
		// 최종갱신결과 업데이트
		commonApiLogService.updateJobList(jobId, logStat);
	}
	public List<String> selectNatCdList(){
		return dataGoPlntQrtMapper.selectNatCdList();
	}
	
	public List<String> selectHsCdList(){
		return dataGoPlntQrtMapper.selectHsCdList();
	}
	public void logInsertCall(Map<String, String> map){
		dataGoPlntQrtMapper.logInsertCall(map);
	}
	public List<Map<String, Object>> chkEventList(Map<String, String> map){
		return dataGoPlntQrtMapper.chkEventList(map);
	}
}
