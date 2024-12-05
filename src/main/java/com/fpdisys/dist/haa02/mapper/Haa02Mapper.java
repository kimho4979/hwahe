package com.fpdisys.dist.haa02.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.haa02.domain.Haa02ExcelVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("haa02Mapper")
public interface Haa02Mapper {

	List<EgovMap> selectListaTFlower(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectListaTFlowerGraph(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectListBuSanFlowerGraph(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectListBukyoungFlowerGraph(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectListKwangJuFlowerGraph(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectListHanKookUmFlowerGraph(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectListHanKookBonFlowerGraph(Map<String, Object> pRequestParamMap);
		
	List<EgovMap> selectListaTFlowerMonth(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectListBuSanFlowerMonth(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectListBukyoungFlowerMonth(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectListKwangJuFlowerMonth(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectListHanKookUmFlowerMonth(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectListHanKookBonFlowerMonth(Map<String, Object> pRequestParamMap);
	
	List<Haa02ExcelVO> selectListMonthExcel(Map<String, Object> pRequestParamMap);

}
