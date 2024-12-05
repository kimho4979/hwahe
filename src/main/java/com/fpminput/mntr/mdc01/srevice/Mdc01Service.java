package com.fpminput.mntr.mdc01.srevice;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpminput.mntr.mdc01.mapper.Mdc01Mapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class Mdc01Service  extends BaseService {

	@Autowired
	Mdc01Mapper mdc01Mapper;

	// 정산정보관리 정산내역 목록 조회
	public List<EgovMap> selectMdc01List(Map<String, Object> pRequestParamMap) {
		return mdc01Mapper.selectMdc01List(pRequestParamMap);
	}
	// 정산정보관리 정산내역 목록 조회(No Paging)
	public List<EgovMap> selectMdc01FullList(Map<String, Object> pRequestParamMap) {
		return mdc01Mapper.selectMdc01FullList(pRequestParamMap);
	}

	// 정산정보관리 정산내역 상세 모달 사용자 정보 조회
	public Map<String, String> selectUserInfo(Map<String, Object> pRequestParamMap) {
		return mdc01Mapper.selectUserInfo(pRequestParamMap);
	}

	// 정산정보관리 정산내역 상세 모달 특정사용자의 출하예정물량 조회(해당 월 기준)
	public List<Map<String, String>> mdc01ShipmntExOfUser(Map<String, Object> pRequestParamMap) {
		return mdc01Mapper.mdc01ShipmntExOfUser(pRequestParamMap);
	}

	// 정산정보관리 정산내역 상세 모달 특정사용자의 출하물량 조회(해당 월 기준)
	public List<Map<String, String>> mdc01ShipmntOfUser(Map<String, Object> pRequestParamMap) {
		return mdc01Mapper.mdc01ShipmntOfUser(pRequestParamMap);
	}
	
	// 정산정보관리 정산내역 상세 모달 특정사용자의 작황동향 조회(해당 월 기준)
	public List<Map<String, String>> mdc01TypeCropOfUser(	Map<String, Object> pRequestParamMap) {
		return mdc01Mapper.mdc01TypeCropOfUser(pRequestParamMap);
	}

	// 정산정보관리 정산내역 상세 모달 특정사용자의 재배동향 조회(해당 월 기준)
	public List<Map<String, String>> mdc01TypeCultOfUser(Map<String, Object> pRequestParamMap) {
		return mdc01Mapper.mdc01TypeCultOfUser(pRequestParamMap);
	}
	
	// 정산정보관리 정산내역 상세 모달 특정사용자의 소비동향 조회(해당 월 기준)
	public List<Map<String, String>> mdc01TypeConsTrendOfUser(Map<String, Object> pRequestParamMap) {
		return mdc01Mapper.mdc01TypeConsTrendOfUser(pRequestParamMap);
	}

	// 정산정보관리 정산내역 상세 모달 특정사용자의 소매가격 조회(해당 월 기준)
	public List<Map<String, String>> mdc01TypeConsPriceOfUser(Map<String, Object> pRequestParamMap) {
		return mdc01Mapper.mdc01TypeConsPriceOfUser(pRequestParamMap);
	}
	public EgovMap deadLineManage(Map<String, Object> pRequestParamMap) {
		return mdc01Mapper.deadLineManage(pRequestParamMap);
	}
	public int updateDeadLineDate(Map<String, Object> pRequestParamMap) {
		return mdc01Mapper.updateDeadLineDate(pRequestParamMap);
	}

	
	
	
	
}
