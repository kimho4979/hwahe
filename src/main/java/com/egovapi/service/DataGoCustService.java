package com.egovapi.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.egovapi.mapper.DataGoCustMapper;
import com.egovapi.util.CommonApiUtil;

@Service
public class DataGoCustService {
	
	protected Log log = LogFactory.getLog(this.getClass());		

	@Autowired
	DataGoCustMapper dataGoCustMapper;
	
	@Autowired
	CommonApiLogService commonApiLogService;

	/**
	 * 공공데이터 관세청-품목별 수출입실적 서비스 데이터 최신화
	 * @param dataList
	 * @param pRequestParamMap 
	 * @param mclass
	 */
	public void dataType1Insert(List<Map<String, String>> dataList, Map<String, String> pRequestParamMap) {
		// 데이터 입력
		java.util.Locale currentLocale = new java.util.Locale("KOREAN", "KOREA");
		String pattern = "yyyy-MM-dd HH:mm:ss";
		
		System.out.println(new java.text.SimpleDateFormat(pattern,currentLocale).format(new java.util.Date()) + "와스에서 디비로 가기전 데이터 확인 \t : " + pRequestParamMap.get("natCd"));
		System.out.println(new java.text.SimpleDateFormat(pattern,currentLocale).format(new java.util.Date()) + "와스에서 디비로 가기전 데이터 확인 \t : " + pRequestParamMap.get("hsCd"));
		System.out.println(new java.text.SimpleDateFormat(pattern,currentLocale).format(new java.util.Date()) + "와스에서 디비로 가기전 데이터 확인 \t : " + pRequestParamMap.get("yyyymm"));
		Map<String, String> data = dataList.get(0);
		data.put("yyyymm", pRequestParamMap.get("yyyymm"));
		data.put("hsCd", pRequestParamMap.get("hsCd"));
		data.put("statCd",pRequestParamMap.get("natCd"));
		///////////dataGoCustMapper.dataType1BeforeDelete(data);
		dataGoCustMapper.dataType1Insert(data);
	}
	
}
