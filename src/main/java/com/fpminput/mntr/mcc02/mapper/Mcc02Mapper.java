package com.fpminput.mntr.mcc02.mapper;

import java.util.List;
import java.util.Map;

import com.fpminput.mntr.mcc02.domain.Mcc02VO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("mcc02Mapper")
public interface Mcc02Mapper {

	List<?> selectSimilarList(Map<String, Object> pRequestParamMap);

	List<Mcc02VO> selectSimilarInputSeq(Map<String, Object> pRequestParamMap);
		
	int insertSimilarInput(Map<String, Object> pRequestParamMap);
	int insertSimilarFile(Map<String, Object> pRequestParamMap);
	
	int updateSimilarInfoInput(Map<String, Object> pRequestParamMap);
	int updateSimilarFile(Map<String, Object> pRequestParamMap);
	
	int deleteSimilarInfoInput(Map<String, Object> pRequestParamMap);
	int deleteSimilarFileInfoInput(Map<String, Object> pRequestParamMap);
	
	Mcc02VO selectSumNail(String seqNo);
/*	
	int updateCnsmpPcInput(Map<String, Object> pReqParamMap);

	int deleteCnsmpPcInput(Map<String, Object> pReqParamMap);
*/
}
