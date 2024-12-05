package com.fpdisys.dist.hba03.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.hba03.domain.Hba03VO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("hba03Mapper")
public interface Hba03Mapper {

	List<Hba03VO> selectHba03(Map<String, Object> pRequestParamMap);
	
	int insertForecast (Map<String, Object> pReqParamMap);
	
	int insertForecastFile(Map<String, Object> pRequestParamMap);
			
	Map<String, String> selectFileDown(String seq);
	
	int updateForecast(Map<String, Object> pReqParamMap);
	
	int updateForecastFile(Map<String, Object> pRequestParamMap);
	
	int deleteSugeup(Map<String, Object> pRequestParamMap);
	
	int deleteSugeupFile(Map<String, Object> pRequestParamMap);

}
