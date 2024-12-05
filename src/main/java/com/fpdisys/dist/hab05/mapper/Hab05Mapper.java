package com.fpdisys.dist.hab05.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.hab05.domain.Hab05VO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("hab05Mapper")
public interface Hab05Mapper {
	
	List<Hab05VO> selectHab05(Map<String, Object> pRequestParamMap);
	
	List<Hab05VO> selectHab05Excel(Map<String, Object> pRequestParamMap);
	
}
