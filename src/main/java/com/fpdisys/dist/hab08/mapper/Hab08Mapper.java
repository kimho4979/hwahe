package com.fpdisys.dist.hab08.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.hab08.domain.Hab08VO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("hab08Mapper")
public interface Hab08Mapper {
	
	/**
	 * 물량비중 차트
	 * @param pRequestParamMap
	 * @return
	 */
	List<EgovMap> hab08Chart1(Map<String, Object> pRequestParamMap);
	
	/**
	 * 일자별 평균단가 차트
	 * @param pRequestParamMap
	 * @return
	 */
	List<EgovMap> hab08Chart2(Map<String, Object> pRequestParamMap);
	
	/**
	 * 품목리스트 조회
	 * @param pRequestParamMap
	 * @return
	 */
	List<EgovMap> hab08Button(Map<String, Object> pRequestParamMap);

}
