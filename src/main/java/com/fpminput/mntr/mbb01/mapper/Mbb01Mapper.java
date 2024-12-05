package com.fpminput.mntr.mbb01.mapper;

import java.util.List;
import java.util.Map;

import com.fpminput.mntr.mbb01.domain.Mbb01VO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("mbb01Mapper")
public interface Mbb01Mapper {

	List<?> selectCnsmpPcInput(Map<String, Object> pRequestParamMap);
	
	List<?> selectCnsmpPcInputAll(Map<String, Object> pRequestParamMap);
	
	Mbb01VO selectCnsmpPcInputSeq(Mbb01VO mbb01vo);

	int insertCnsmpPcInput(Map<String, Object> pReqParamMap);

	int updateCnsmpPcInput(Map<String, Object> pReqParamMap);

	int deleteCnsmpPcInput(Map<String, Object> pReqParamMap);

}
