package com.fpdisys.dist.hab10.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.hab10.domain.Hab10VO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("hab10Mapper")
public interface Hab10Mapper {

	List<Hab10VO> selectHab10(Map<String, Object> pRequestParamMap);

	List<Hab10VO> selectHab10Chart(Map<String, Object> pRequestParamMap);
}
