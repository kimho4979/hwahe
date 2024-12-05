package com.fpdisys.dist.hab03.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.hab03.domain.Hab03VO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("hab03Mapper")
public interface Hab03Mapper {
	List<Hab03VO> selectHab03(Map<String, Object> pRequestParamMap);
	
	List<Hab03VO> selectPumJong(Map<String, Object> pRequestParamMap);
	
}
