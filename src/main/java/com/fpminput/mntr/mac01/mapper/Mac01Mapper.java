package com.fpminput.mntr.mac01.mapper;

import java.util.List;
import java.util.Map;

import com.fpminput.mntr.mac01.domain.Mac01VO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("mac01Mapper")
public interface Mac01Mapper {

	List<?> selectCtvtTrendInput(Map<String, Object> pRequestParamMap);
	
	List<?> selectCtvtTrendInputAll(Map<String, Object> pRequestParamMap);
	
	Mac01VO selectCtvtTrendInputSeq(Mac01VO mac01vo);

	int insertCtvtTrendInput(Map<String, Object> pReqParamMap);

	int updateCtvtTrendInput(Map<String, Object> pReqParamMap);

	int deleteCtvtTrendInput(Map<String, Object> pReqParamMap);

}