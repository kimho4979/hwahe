package com.fpdisys.dist.preRose.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("preRoseMapper")
public interface PreRoseMapper {
	
	List<EgovMap>selectPreRosePumListByCmpCd(Map<String, Object> pRequestParamMap);
	
	List<EgovMap>selectPreRosePumListByLvCd(Map<String, Object> pRequestParamMap);
	
	List<EgovMap>selectPreRoseList(Map<String, Object> pRequestParamMap);
	
	List<EgovMap>selectPreRoseGridList(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectPreEstList(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectPreEstGridList(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectPreRosePumListEst(Map<String, Object> pRequestParamMap);
	
}
