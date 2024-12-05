package com.fpdisys.dist.hga03.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.hga03.domain.Hga03VO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("hga03Mapper")
public interface Hga03Mapper {

	String selectGetDate(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectGetItemList(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectPlntList1(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectPlntList2(Map<String, Object> pRequestParamMap);	
	
	List<Hga03VO> selectPlntList1Excel(Map<String, Object> pRequestParamMap);
	
	List<Hga03VO> selectPlntList2Excel(Map<String, Object> pRequestParamMap);
}
