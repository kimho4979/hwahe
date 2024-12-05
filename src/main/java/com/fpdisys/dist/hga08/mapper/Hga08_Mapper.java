package com.fpdisys.dist.hga08.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("hga08_Mapper")
public interface Hga08_Mapper {
	
	List<EgovMap> selectHga08ChartJson1(Map<String, Object> pRequestParamMap);
	List<EgovMap> selectHga08ChartJson2(Map<String, Object> pRequestParamMap);
	
}
