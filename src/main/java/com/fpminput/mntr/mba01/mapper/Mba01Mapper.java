package com.fpminput.mntr.mba01.mapper;

import java.util.List;
import java.util.Map;

import com.fpminput.mntr.mba01.domain.Mba01VO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("mba01Mapper")
public interface Mba01Mapper {

	List<?> selectCnsmpTrendInput(Map<String, Object> pRequestParamMap);
	
	List<?> selectCnsmpTrendInputAll(Map<String, Object> pRequestParamMap);
	
	Mba01VO selectCnsmpTrendInputSeq(Mba01VO mba01vo);

	int insertCnsmpTrendInput(Map<String, Object> pReqParamMap);

	int updateCnsmpTrendInput(Map<String, Object> pReqParamMap);

	int deleteCnsmpTrendInput(Map<String, Object> pReqParamMap);

}
