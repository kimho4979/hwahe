package com.fpdisys.dist.haa06.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("haa06_Mapper")
public interface Haa06_Mapper {
	List<Map> selectHaa06ChartJson1(Map<String, Object> pRequestParamMap);
	
	List<Map> selectHaa06ChartJson2(Map<String, Object> pRequestParamMap);
	
	List<Map> selectHaa06ChartJson3(Map<String, Object> pRequestParamMap);
	
	List<Map> selectHaa06ChartJson4(Map<String, Object> pRequestParamMap);
}
