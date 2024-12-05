package com.fpdisys.dist.hca01.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.hca01.domain.Hca01ExcelVO;
import com.fpdisys.dist.hca01.domain.Hca01VO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("hca01Mapper")
public interface Hca01Mapper {
	
	List<Hca01VO> selectTop(Map<String, Object> pRequestParamMap);
	
	List<Hca01VO> selectBottom(Map<String, Object> pRequestParamMap);
	
	String selectFastDay();

	List<Hca01VO> selectMainChulChart(Map<String, Object> pRequestParamMap);

	List<Hca01ExcelVO> selectTopExcel(Map<String, Object> pRequestParamMap);
	
}
