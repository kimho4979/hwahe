package com.fpminput.mntr.mab01.mapper;

import java.util.List;
import java.util.Map;

import com.fpminput.mntr.mab01.domain.Mab01VO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("mab01Mapper")
public interface Mab01Mapper {

	List<?> selectCropInfoInput(Map<String, Object> pRequestParamMap);
	
	List<?> selectCropInfoInputAll(Map<String, Object> pRequestParamMap);
	
	Mab01VO selectCropInfoInputSeq(Mab01VO mab01vo);

	int updateCropInfoInput(Map<String, Object> pReqParamMap);

	int insertCropInfoInput(Map<String, Object> pReqParamMap);

	int deleteCropInfoInput(Map<String, Object> pReqParamMap);

	int insertCropFile(Map<String, Object> pRequestParamMap);

	int updateCropFile(Map<String, Object> pRequestParamMap);
	
	Map<String, String> selectSumNail(Map<String, Object> pRequestParamMap);
	
	int deleteCropFile(Map<String, Object> pReqParamMap);

}
