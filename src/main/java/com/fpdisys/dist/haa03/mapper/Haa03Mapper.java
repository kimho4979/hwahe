package com.fpdisys.dist.haa03.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.haa03.domain.Haa03ExcelVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("haa03Mapper")
public interface Haa03Mapper {

	List<EgovMap> selectListaTFlower(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectListBuSanFlower(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectListBukyoungFlower(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectListKwangJuFlower(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectListHanKookUmFlower(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectListHanKookBonFlower(Map<String, Object> pRequestParamMap);
	
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

	List<EgovMap> selectSubSearch(Map<String, Object> pRequestParamMap);
	
	List<Haa03ExcelVO> selectListFlowerExcel(Map<String, Object> pRequestParamMap);
	
}
