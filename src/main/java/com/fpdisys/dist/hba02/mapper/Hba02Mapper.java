package com.fpdisys.dist.hba02.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.hba02.domain.Hba02VO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("hba02Mapper")
public interface Hba02Mapper {

	List<Hba02VO> selectHba02(Map<String, Object> pRequestParamMap);
	
	int insertForecast (Map<String, Object> pReqParamMap);
	
	int insertForecastFile(Map<String, Object> pRequestParamMap);
			
	Map<String, String> selectFileDown(String seq);
	
	int updateForecast(Map<String, Object> pReqParamMap);
	
	int updateForecastFile(Map<String, Object> pRequestParamMap);
	
	int deleteSugeup(Map<String, Object> pRequestParamMap);
	
	int deleteSugeupFile(Map<String, Object> pRequestParamMap);

}
