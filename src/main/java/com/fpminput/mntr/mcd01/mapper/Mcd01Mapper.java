package com.fpminput.mntr.mcd01.mapper;

import java.util.List;
import java.util.Map;

import com.fpminput.mntr.mcd01.domain.Mcd01VO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("mcd01Mapper")
public interface Mcd01Mapper {

	List<?> selectGongiList(Map<String, Object> pRequestParamMap);

	Mcd01VO selectSimilarInputSeq(Map<String, Object> pRequestParamMap);
		
	int insertGongiInput(Map<String, Object> pRequestParamMap);
	int insertGongiFile(Map<String, Object> pRequestParamMap);
	
	int updateGongiInfoInput(Map<String, Object> pRequestParamMap);
	int updateGongiFile(Map<String, Object> pRequestParamMap);
	
	int deleteGongiInfoInput(Map<String, Object> pRequestParamMap);
	int deleteGongiFileInfoInput(Map<String, Object> pRequestParamMap);
	
	Mcd01VO selectSumNail(String seqNo);
/*	
	int updateCnsmpPcInput(Map<String, Object> pReqParamMap);

	int deleteCnsmpPcInput(Map<String, Object> pReqParamMap);
*/
}
