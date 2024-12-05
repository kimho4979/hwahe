package com.fpminput.mntr.mda01.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpminput.mntr.mda01.mapper.Mda01Mapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class Mda01Service extends BaseService {
	
protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired
	Mda01Mapper mda01Mapper;

	// 정산정보관리 계량/비계량 설정 정보 조회
	public List<EgovMap> selectkpiList(Map<String, Object> pRequestParamMap) {
		return mda01Mapper.selectkpiList(pRequestParamMap);
	}

	// 정산정보관리 계량/비계량 설정 등록전 기간 체크
	public int checkInsertBefore(Map<String, Object> pRequestParamMap) {
		return mda01Mapper.checkInsertBefore(pRequestParamMap);
	}

	// 정산정보관리 계량/비계량 설정 등록
	public void insertKpiInput(Map<String, Object> pRequestParamMap) {
		// 등록
		mda01Mapper.insertKpiInput(pRequestParamMap);
		// 등록 로그 추가
		pRequestParamMap.put("kpiLogType", "1");
		mda01Mapper.kpiInputLog(pRequestParamMap);
	}

	// 정산정보관리 계량/비계량 데이터 삭제
	public void deleteKpiInput(Map<String, Object> pRequestParamMap) {
		String deleteValue = String.valueOf(pRequestParamMap.get("deleteValue"));
		String[] deleteArr = deleteValue.split(",");
		
		// 삭제 로그 추가
		pRequestParamMap.put("kpiLogType", "3");
		List<String> list = new ArrayList<String>();
		for (int i = 0; i < deleteArr.length; i++) {
			pRequestParamMap.put("kpiSeq", deleteArr[i]);
			mda01Mapper.kpiInputLog(pRequestParamMap);
			list.add(deleteArr[i]);
		}
		
		// 삭제 처리
		mda01Mapper.deleteKpiInput(list);
	}

	// 정산정보관리 계량/비계량 데이터 삭제
	public Map<String, String> detailKpiInput(	Map<String, Object> pRequestParamMap) {
		return mda01Mapper.detailKpiInput(pRequestParamMap);
	}

	// 정산정보관리 계량/비계량 설정 수정
	public void updateKpiInput(Map<String, Object> pRequestParamMap) {
		// 수정
		mda01Mapper.updateKpiInput(pRequestParamMap);
		// 수정 로그 추가
		pRequestParamMap.put("kpiLogType", "2");
		mda01Mapper.kpiInputLog(pRequestParamMap);
	}

	// 정산정보관리 계량/비계량 변경이력 로그 조회
	public List<EgovMap> selectKpiLogList(Map<String, Object> pRequestParamMap) {
		return mda01Mapper.selectKpiLogList(pRequestParamMap);
	}

	
}
