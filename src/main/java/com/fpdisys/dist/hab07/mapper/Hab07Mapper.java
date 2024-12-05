package com.fpdisys.dist.hab07.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.hab07.domain.Hab07VO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("hab07Mapper")
public interface Hab07Mapper {

	List<Hab07VO> selectHab07(Map<String, Object> pRequestParamMap);
	
	List<Hab07VO> selectHab07Excel(Map<String, Object> pRequestParamMap);
	
}
