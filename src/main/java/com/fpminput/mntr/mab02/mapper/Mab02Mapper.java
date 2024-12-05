package com.fpminput.mntr.mab02.mapper;

import java.util.List;
import java.util.Map;

import com.fpminput.mntr.mab02.domain.Mab02VO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("mab02Mapper")
public interface Mab02Mapper {

	List<Mab02VO> selectCropInfoInput(Map<String, Object> pRequestParamMap);
	
	List<Mab02VO> selectCropInfoInputAll(Map<String, Object> pRequestParamMap);
	
	Mab02VO selectCropInfoInputSeq(Mab02VO mab02vo);

	int updateCropInfoInput(Map<String, Object> pReqParamMap);

	int insertCropInfoInput(Map<String, Object> pReqParamMap);

	int deleteCropInfoInput(Map<String, Object> pReqParamMap);

	int insertCropFile(Map<String, Object> pRequestParamMap);

	int updateCropFile(Map<String, Object> pRequestParamMap);
	
	Mab02VO selectSumNail(String seqNo);
	
	int deleteCropFile(Map<String, Object> pReqParamMap);

}
