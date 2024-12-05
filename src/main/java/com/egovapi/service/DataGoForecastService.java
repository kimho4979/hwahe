package com.egovapi.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.egovapi.mapper.DataGoForecastMapper;
import com.egovapi.util.CommonApiUtil;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class DataGoForecastService {
	
	protected Log log = LogFactory.getLog(this.getClass());		

	@Autowired
	DataGoForecastMapper dataGoForecastMapper;
	
	@Autowired
	CommonApiLogService commonApiLogService;

	/**
	 * 공공데이터 관세청-품목별 수출입실적 서비스 데이터 최신화
	 * @param dataList
	 * @param pRequestParamMap 
	 * @param mclass
	 */
	public void dataType2Insert(List<Map<String, String>> dataList, Map<String, String> pRequestParamMap) {
		String logStat = "1";
		String errorDetail = "";
		String jobId = (String)pRequestParamMap.get("jobId");
		String logSeq = (String)pRequestParamMap.get("logSeq");
		
		String yyyymmdd = dataList.get(0).get("yyyymm");
		Map<String, String > map = new HashMap<String, String>();
		map.put("yyyymmdd", yyyymmdd);
		map.put("baseTime", dataList.get(0).get("baseTime"));
		map.put("nx", dataList.get(0).get("nx"));
		map.put("ny", dataList.get(0).get("ny"));
		//map.put("mclass", mclass);
		// 데이터 추가 전 삭제
		dataGoForecastMapper.dataType2BeforeDelete(map);
		// 데이터 입력
		for (int i = 0; i < dataList.size(); i++) {
			try {
				dataGoForecastMapper.dataType2Insert(dataList.get(i));
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
		if(!"2".equals(logStat)) commonApiLogService.updateResultLog(logStat, errorDetail, jobId, logSeq);

		// 최종갱신결과 업데이트
		commonApiLogService.updateJobList(jobId, logStat);
	}
	
	public List<EgovMap> ForecastList(Map<String, Object> pRequestParamMap){
		return dataGoForecastMapper.ForecastList(pRequestParamMap);		
	}
	
	public void execForecast(Map<String, Object> pRequestParamMap){
		String logStat = "1";
		String errorDetail = "";
		String jobId = (String)pRequestParamMap.get("jobId");
		String logSeq = (String)pRequestParamMap.get("logSeq");
		
		try {
			dataGoForecastMapper.execForecast(pRequestParamMap);
		} catch (Exception e) {
			// 오류처리
			if(e.toString().indexOf("ORA-00001") < 0){
				logStat = "2";
				errorDetail = CommonApiUtil.getSqlErrorMessage(e.toString());
			}
		}
		// 결과 반영
		if(!"2".equals(logStat)) commonApiLogService.updateResultLog(logStat, errorDetail, jobId, logSeq);

		// 최종갱신결과 업데이트
		commonApiLogService.updateJobList(jobId, logStat);
	}
	
}
