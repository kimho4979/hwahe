package com.fpdisys.dist.hab11.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("hab11Mapper")
public interface Hab11Mapper {

	List<EgovMap> selectList(Map<String, Object> pRequestParamMap);


}
