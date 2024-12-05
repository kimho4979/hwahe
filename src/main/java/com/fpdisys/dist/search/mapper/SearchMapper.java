package com.fpdisys.dist.search.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("searchMapper")
public interface SearchMapper {

	List<EgovMap> selectSaleDate(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectSaleMonth(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectSaleYear(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectSaleDateReal(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectSaleDateYuchal(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectPumNameDate(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectGoodNameDate(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectPumNameMonth(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectGoodNameMonth(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectPumNameReal(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectGoodNameReal(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectPumNameYuchal(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectGoodNameYuchal(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectSaleDateWeekday(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectPumNameCmpDate(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectPumNameCmpMonth(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectPumNameCmpYear(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectGoodNameCmpDate(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectGoodNameCmpMonth(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectGoodNameCmpYear(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectPumNameCmpTotal(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectGoodNameCmpTotal(Map<String, Object> pRequestParamMap);



	/*List<Hab07VO> getPumName(Map<String, Object> pRequestParamMap);*/

}
