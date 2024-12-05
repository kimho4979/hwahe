package com.fpminput.mntr.mdd01.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("mdd01Mapper")
public interface Mdd01Mapper {

	List<EgovMap> selectMdd01List(Map<String, Object> pRequestParamMap);

	Map<String, String> selectMdd01Detail(Map<String, Object> pRequestParamMap);

}
