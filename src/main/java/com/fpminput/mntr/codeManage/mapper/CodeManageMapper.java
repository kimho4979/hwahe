package com.fpminput.mntr.codeManage.mapper;

import java.util.List;
import java.util.Map;

import com.fpminput.mntr.codeManage.domain.CodeManageVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("codeManageMapper")
public interface CodeManageMapper {
	
	List<EgovMap> selectToIntSaleData(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectRealCodeList(Map<String, Object> pRequestParamMap);

	int updateRealCode(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectSaleCodeList(Map<String, Object> pRequestParamMap);

	int updateSaleCode(Map<String, Object> pRequestParamMap);
	
	int mergeMappingTable(Map<String, Object> pRequestParamMap);
	
	int deleteRaw(Map<String, Object> pRequestParamMap);
	
	int insertIntoTIntSale(Map<String, Object> pRequestParamMap);
	
	int deleteSaleCodeDate(Map<String, Object> pRequestParamMap);
	
	int insertSaleCodeDate(Map<String, Object> pRequestParamMap);
	
	int deleteSaleCodeMonth(Map<String, Object> pRequestParamMap);
	
	int insertSaleCodeMonth(Map<String, Object> pRequestParamMap);
	
	int mergeFlowerGubnNong(Map<String, Object> pRequestParamMap);

	int insertCodeUpdateLog(Map<String, Object> pRequestParamMap);

	void procTranCodeSms();
	
	List<Map<String, Object>> selectItemList(Map<String, Object> pRequestParamMap) throws Exception;
	
	List<Map<String, Object>> selectKindList(Map<String, Object> pRequestParamMap) throws Exception;
	
	List<Map<String, Object>> selectKindForMapping(Map<String, Object> pRequestParamMap) throws Exception;
	
	int insertIntoItem(Map<String, Object> pRequestParamMap);
	int insertIntoKind(Map<String, Object> pRequestParamMap);
	int insertIntoMapping2(Map<String, Object> pRequestParamMap);
	int insertIntoMapping(Map<String, Object> pRequestParamMap);
	int insertIntoItem505(Map<String, Object> pRequestParamMap);
}