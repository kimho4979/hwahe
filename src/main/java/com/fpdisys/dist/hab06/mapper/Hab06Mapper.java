package com.fpdisys.dist.hab06.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.hab06.domain.Hab06VO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("hab06Mapper")
public interface Hab06Mapper {

	
	List<Hab06VO> selectSeoulContractQtyList(Map<String, Object> pRequestParamMap);

	List<Hab06VO> selectBusanContractQtyList(Map<String, Object> pRequestParamMap);

	List<Hab06VO> selectBukyoungContractQtyList(Map<String, Object> pRequestParamMap);

	List<Hab06VO> selectYoungNamContractQtyList(Map<String, Object> pRequestParamMap);

	List<Hab06VO> selectKwangJuContractQtyList(Map<String, Object> pRequestParamMap);

	List<Hab06VO> selectHanKookContractQtyList(Map<String, Object> pRequestParamMap);

	List<Hab06VO> selectHab06(Map<String, Object> pRequestParamMap);
	
	List<?> selectHab06Bak(Map<String, Object> pRequestParamMap);
	
	List<Hab06VO> selectHab06Hap(Map<String, Object> pRequestParamMap);
	
	List<?> selectHab06HapBak(Map<String, Object> pRequestParamMap);
	
	List<Hab06VO> selectHab06Chart(Map<String, Object> pRequestParamMap);
	
	List<?> selectHab06ChartBak(Map<String, Object> pRequestParamMap);
	
	List<Hab06VO> getSaleDate(Map<String, Object> pRequestParamMap);
	
	List<Hab06VO> selectHab06Excel(Map<String, Object> pRequestParamMap);
	
	List<Hab06VO> selectHab06HapExcel(Map<String, Object> pRequestParamMap);
	
}
