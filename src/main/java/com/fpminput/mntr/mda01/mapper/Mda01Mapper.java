package com.fpminput.mntr.mda01.mapper;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("mda01Mapper")
public interface Mda01Mapper {

	List<EgovMap> selectkpiList(Map<String, Object> pRequestParamMap);

	int checkInsertBefore(Map<String, Object> pRequestParamMap);

	void insertKpiInput(Map<String, Object> pRequestParamMap);

	void deleteKpiInput(@Param("list") List<String> list);

	Map<String, String> detailKpiInput(Map<String, Object> pRequestParamMap);

	void updateKpiInput(Map<String, Object> pRequestParamMap);

	void kpiInputLog(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectKpiLogList(Map<String, Object> pRequestParamMap);


}
