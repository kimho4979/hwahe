package com.fpdisys.dist.hdb01.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.hdb01.domain.Hdb01VO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("hdb01Mapper")
public interface Hdb01Mapper {

	List<?> selectChartList(Map<String, Object> pRequestParamMap);

	String selectFastDay();
	
	List<Hdb01VO> selectChartListExcel(Map<String, Object> pRequestParamMap);

}
