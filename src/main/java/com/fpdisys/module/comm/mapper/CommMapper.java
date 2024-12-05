package com.fpdisys.module.comm.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("commMapper")
public interface CommMapper {
	List<EgovMap> selectComCdList(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectItemList(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectItemDtlList(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectGoodNameCmpTotal(Map<String, Object> pRequestParamMap);
}
