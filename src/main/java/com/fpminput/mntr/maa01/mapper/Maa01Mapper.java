package com.fpminput.mntr.maa01.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("maa01Mapper")
public interface Maa01Mapper {

	List<?> selectShipmntPrearngeVolm(Map<String, Object> pRequestParamMap);

	int insertShipmntPrearngeVolm(Map<String, Object> pReqParamMap);

	int updateShipmntPrearngeVolm(Map<String, Object> pReqParamMap);
	
	int updateShipmntPrearngeVolmMobile(Map<String, Object> pReqParamMap);

	int deleteShipmntPrearngeVolm(Map<String, Object> pReqParamMap);

	List<?> selectShipmntPrearngeVolm2(Map<String, Object> pRequestParamMap);

	int insertShipmntPrearngeVolm2(Map<String, Object> pReqParamMap);

	List<?> selectTotalVolm(Map<String, Object> pRequestParamMap);

	List<?> selectTotalVolm2(Map<String, Object> pRequestParamMap);
	
}
