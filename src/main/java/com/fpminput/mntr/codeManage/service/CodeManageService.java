package com.fpminput.mntr.codeManage.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpminput.mntr.codeManage.domain.CodeManageVO;
import com.fpminput.mntr.codeManage.mapper.CodeManageMapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class CodeManageService extends BaseService {

	@Autowired
	CodeManageMapper CodeManageMapper;
	
	public List<EgovMap> selectToIntSaleData(Map<String, Object> pRequestParamMap){
		return CodeManageMapper.selectToIntSaleData(pRequestParamMap);
	}
	// 실시간 데이터 리스트 :: List
	public List<EgovMap> selectRealCodeList(Map<String, Object> pRequestParamMap) {
		
		return CodeManageMapper.selectRealCodeList(pRequestParamMap);
	}
	
	// 실시간 데이터 수정 :: Update
	public int updateRealCode(Map<String, Object> pRequestParamMap) {
		
		return CodeManageMapper.updateRealCode(pRequestParamMap);
	}
	
	// 정산 데이터 리스트 :: List
	public List<EgovMap> selectSaleCodeList(Map<String, Object> pRequestParamMap) {
		
		return CodeManageMapper.selectSaleCodeList(pRequestParamMap);
	}
	
	// 정산 데이터 수정 :: Update
	public int updateSaleCode(Map<String, Object> pRequestParamMap) {
		
		return CodeManageMapper.updateSaleCode(pRequestParamMap);
	}
	public int mergeMappingTable(Map<String, Object> pRequestParamMap) {
		return CodeManageMapper.mergeMappingTable(pRequestParamMap);
	}
	//T_INT_SALE_RAW 데이터 delete
	public int deleteRaw(Map<String, Object> pRequestParamMap) {
		return CodeManageMapper.deleteRaw(pRequestParamMap);
	}
	//T_INT_SALE_RAW에 T_INT_MAPPING과 T_SALE 조인해서 나온 것들을 insert 시킨다.-> T_INT_SALE
	public int insertIntoTIntSale(Map<String, Object> pRequestParamMap) {
		return CodeManageMapper.insertIntoTIntSale(pRequestParamMap);
	}

	public int deleteSaleCodeDate(Map<String, Object> pRequestParamMap) {
		
		return CodeManageMapper.deleteSaleCodeDate(pRequestParamMap);
	}
	
	public int insertSaleCodeDate(Map<String, Object> pRequestParamMap) {
		return CodeManageMapper.insertSaleCodeDate(pRequestParamMap);
	}
	
	public int deleteSaleCodeMonth(Map<String, Object> pRequestParamMap) {
	
		return CodeManageMapper.deleteSaleCodeMonth(pRequestParamMap);
	}
	
	public int insertSaleCodeMonth(Map<String, Object> pRequestParamMap) {
	
		return CodeManageMapper.insertSaleCodeMonth(pRequestParamMap);
	}

	public int mergeFlowerGubnNong(Map<String, Object> pRequestParamMap) {
	
		return CodeManageMapper.mergeFlowerGubnNong(pRequestParamMap);
	}

	public int insertCodeUpdateLog(Map<String, Object> pRequestParamMap) {
		
		return CodeManageMapper.insertCodeUpdateLog(pRequestParamMap);
	}

	public void procTranCodeSms() {
		CodeManageMapper.procTranCodeSms();
	}


	public List<Map<String, Object>> selectItemList(Map<String, Object> pRequestParamMap) throws Exception {

		return CodeManageMapper.selectItemList(pRequestParamMap);
	}

	public List<Map<String, Object>> selectKindList(Map<String, Object> pRequestParamMap) throws Exception {
		return CodeManageMapper.selectKindList(pRequestParamMap);
	}

	public int insertIntoItem(Map<String, Object> pRequestParamMap) {
		return CodeManageMapper.insertIntoItem(pRequestParamMap);
	}

	public int insertIntoKind(Map<String, Object> pRequestParamMap) {
		return CodeManageMapper.insertIntoKind(pRequestParamMap);		
	}

	public int insertIntoMapping(Map<String, Object> pRequestParamMap) {
		return CodeManageMapper.insertIntoMapping(pRequestParamMap);
	}

	public int insertIntoItem505(Map<String, Object> pRequestParamMap) {
		return CodeManageMapper.insertIntoItem505(pRequestParamMap);
	}

	public List<Map<String, Object>> selectKindForMapping(Map<String, Object> pRequestParamMap) throws Exception {
		return CodeManageMapper.selectKindForMapping(pRequestParamMap);
	}

	public int insertIntoMapping2(Map<String, Object> pRequestParamMap) {
		return CodeManageMapper.insertIntoMapping2(pRequestParamMap);
		
	}
	
	
	
}