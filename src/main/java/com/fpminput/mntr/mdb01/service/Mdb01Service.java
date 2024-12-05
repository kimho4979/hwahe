package com.fpminput.mntr.mdb01.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpminput.mntr.mdb01.mapper.Mdb01Mapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class Mdb01Service extends BaseService {
	
	@Autowired
	Mdb01Mapper mdb01Mapper;

	// 정산정보관리 모니터요원 목록 조회
	public List<EgovMap> selectUserList(Map<String, Object> pRequestParamMap) {
		return mdb01Mapper.selectUserList(pRequestParamMap);
	}

	// 정산정보관리 모니터요원 등록 전 아이디 중복 체크
	public int checkUserId(Map<String, Object> pRequestParamMap) {
		return mdb01Mapper.checkUserId(pRequestParamMap);
	}

	// 정산정보관리 모니터요원 등록
	public void insertUserInput(Map<String, Object> pRequestParamMap) {
		mdb01Mapper.insertUserInput(pRequestParamMap);
		mdb01Mapper.insertUserAuthInput(pRequestParamMap);
		
		// 등록 로그 추가
		pRequestParamMap.put("userLogType", "1");
		mdb01Mapper.userInputLog(pRequestParamMap);
	}

	// 정산정보관리 모니터요원 상세정보 조회
	public Map<String, String> detailUserInput(Map<String, Object> pRequestParamMap) {
		return mdb01Mapper.detailUserInput(pRequestParamMap);
	}

	// 정산정보관리 모니터요원 수정처리
	public void updateUserInput(Map<String, Object> pRequestParamMap) {
		mdb01Mapper.updateUserInput(pRequestParamMap);
		mdb01Mapper.updateUserAuthInput(pRequestParamMap);
		// 수정 로그 추가
		pRequestParamMap.put("userLogType", "2");
		mdb01Mapper.userInputLog(pRequestParamMap);
	}

	// 정산정보관리 모니터요원 삭제처리
	public void deleteUserInput(Map<String, Object> pRequestParamMap) {
		String deleteValue = String.valueOf(pRequestParamMap.get("deleteValue"));
		String[] deleteArr = deleteValue.split(",");
		List<String> list = new ArrayList<String>();
		
		// 삭제 로그 추가
		pRequestParamMap.put("userLogType", "3");
		for (int i = 0; i < deleteArr.length; i++) {
			pRequestParamMap.put("userId", deleteArr[i]);
			mdb01Mapper.userInputLog(pRequestParamMap);
			list.add(deleteArr[i]);
		}
		mdb01Mapper.deleteUserAuthInput(list);
		mdb01Mapper.deleteUserInput(list);

	}

	// 정산정보관리 모니터요원 사용자 정보 변경이력
	public List<EgovMap> selectUserInfoLogList(Map<String, Object> pRequestParamMap) {
		return mdb01Mapper.selectUserInfoLogList(pRequestParamMap);
	}
	
	
	
	
}
