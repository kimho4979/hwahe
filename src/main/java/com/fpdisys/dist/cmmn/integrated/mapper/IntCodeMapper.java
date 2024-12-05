package com.fpdisys.dist.cmmn.integrated.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.cmmn.integrated.domain.ItemVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("intCodeMapper")
public interface IntCodeMapper {

	/**
	 * 품목 목록 반환
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	List<Map<String, Object>> selectIntItemList(Map<String, Object> vo) throws Exception;

	/**
	 * 품종 목록 반환
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	List<Map<String, Object>> selectIntKindList(Map<String, Object> vo) throws Exception;

}
