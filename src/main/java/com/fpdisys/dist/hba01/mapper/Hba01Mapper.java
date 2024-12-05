package com.fpdisys.dist.hba01.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.hba01.domain.Hba01VO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("hba01Mapper")
public interface Hba01Mapper {

	List<Hba01VO> selectHba01(Map<String, Object> pRequestParamMap);
	
	List<Hba01VO> selectHba02(Map<String, Object> pRequestParamMap);
	
	List<Hba01VO> selectSugup(Hba01VO hba01vo);

	int insertForecast (Map<String, Object> pReqParamMap);
	
	int insertForecastFile(Map<String, Object> pRequestParamMap);
			
	Map<String, String> selectFileDown(String seq);
	
	int updateForecast(Map<String, Object> pReqParamMap);
	
	int updateForecastFile(Map<String, Object> pRequestParamMap);
	
	int deleteSugeup(Map<String, Object> pRequestParamMap);
	
	int deleteSugeupFile(Map<String, Object> pRequestParamMap);

	void updateForecastClickCnt(Map<String, Object> pRequestParamMap);

	
}
