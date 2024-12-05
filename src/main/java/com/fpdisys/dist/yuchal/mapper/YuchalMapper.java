package com.fpdisys.dist.yuchal.mapper;

import java.util.List;
import java.util.Map;

import com.at.domain.AtMarketVO;
import com.fpdisys.dist.yuchal.domain.YuChalVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("yuchalMapper")
public interface YuchalMapper {

	int deleteYuchal(Map<String, Object> pRequestParamMap);

	int insertYuchal(AtMarketVO rs);

	List<EgovMap> getYuchalData(Map<String, Object> pRequestParamMap);
	
	List<YuChalVO> getYuchalDataExcel(Map<String, Object> pRequestParamMap);
	
}
