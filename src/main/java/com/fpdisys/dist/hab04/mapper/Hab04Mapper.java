package com.fpdisys.dist.hab04.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.hab04.domain.Hab04VO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("hab04Mapper")
public interface Hab04Mapper {
	
	List<Hab04VO> selectHab04(Map<String, Object> pRequestParamMap);
	
	List<Hab04VO> selectHab04Excel(Map<String, Object> pRequestParamMap);
}
