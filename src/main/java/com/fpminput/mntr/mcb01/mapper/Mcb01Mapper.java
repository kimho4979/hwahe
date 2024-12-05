package com.fpminput.mntr.mcb01.mapper;

import java.util.List;
import java.util.Map;

import com.fpminput.mntr.mca01.domain.Mca01VO;
import com.fpminput.mntr.mcb01.domain.Mcb01VO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("mcb01Mapper")
public interface Mcb01Mapper {

	List<?> selectMonthList(Map<String, Object> pRequestParamMap);

	List<Mcb01VO> selectMonthInputSeq(Map<String, Object> pRequestParamMap);
		
	int insertMonthInput(Map<String, Object> pReqParamMap);
	int insertMonthFile(Map<String, Object> pRequestParamMap);
	
	int updateMonthInfoInput(Map<String, Object> pRequestParamMap);
	int updateMonthFile(Map<String, Object> pRequestParamMap);
	
	int deleteMonthInfoInput(Map<String, Object> pRequestParamMap);
	int deleteMonthFileInfoInput(Map<String, Object> pRequestParamMap);
	
	Mcb01VO selectSumNail(String seqNo);
/*	
	int updateCnsmpPcInput(Map<String, Object> pReqParamMap);

	int deleteCnsmpPcInput(Map<String, Object> pReqParamMap);
*/
}
