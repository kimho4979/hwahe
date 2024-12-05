package com.fpminput.mntr.mcc01.mapper;

import java.util.List;
import java.util.Map;

import com.fpminput.mntr.mcb01.domain.Mcb01VO;
import com.fpminput.mntr.mcc01.domain.Mcc01VO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("mcc01Mapper")
public interface Mcc01Mapper {

	List<?> selectSimilarList(Map<String, Object> pRequestParamMap);

	List<Mcc01VO> selectSimilarInputSeq(Map<String, Object> pRequestParamMap);
		
	int insertSimilarInput(Map<String, Object> pRequestParamMap);
	int insertSimilarFile(Map<String, Object> pRequestParamMap);
	
	int updateSimilarInfoInput(Map<String, Object> pRequestParamMap);
	int updateSimilarFile(Map<String, Object> pRequestParamMap);
	
	int deleteSimilarInfoInput(Map<String, Object> pRequestParamMap);
	int deleteSimilarFileInfoInput(Map<String, Object> pRequestParamMap);
	
	Mcc01VO selectSumNail(String seqNo);
/*	
	int updateCnsmpPcInput(Map<String, Object> pReqParamMap);

	int deleteCnsmpPcInput(Map<String, Object> pReqParamMap);
*/
}
