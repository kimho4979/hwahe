package com.fpdisys.dist.haa01.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.haa01.domain.Haa01VO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("haa01Mapper")
public interface Haa01Mapper {

	List<EgovMap> selectListFlower(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectListCombineGraph(Map<String, Object> pRequestParamMap);
	
	List<Haa01VO> selectListFlowerExcel(Map<String, Object> pRequestParamMap);

}
