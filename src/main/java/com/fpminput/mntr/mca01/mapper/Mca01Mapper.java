package com.fpminput.mntr.mca01.mapper;

import java.util.List;
import java.util.Map;

import com.fpminput.mntr.mca01.domain.Mca01VO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("mca01Mapper")
public interface Mca01Mapper {

	List<?> selectSugeupInput(Map<String, Object> pRequestParamMap);
	
	List<Mca01VO> selectSugeupInputSeq(Map<String, Object> pRequestParamMap);
	
	int insertSugeupInput(Map<String, Object> pReqParamMap);
	int insertSugeupFile(Map<String, Object> pRequestParamMap);
	
	int updateSugeupInfoInput(Map<String, Object> pRequestParamMap);
	int updateSugeupFile(Map<String, Object> pRequestParamMap);
	
	int deleteSugeupInfoInput(Map<String, Object> pRequestParamMap);
	int deleteSegeupFileInfoInput(Map<String, Object> pRequestParamMap);
	
	Mca01VO selectSumNail(String seqNo);
	
/*	
	int updateCnsmpPcInput(Map<String, Object> pReqParamMap);

	int deleteCnsmpPcInput(Map<String, Object> pReqParamMap);
*/
}
