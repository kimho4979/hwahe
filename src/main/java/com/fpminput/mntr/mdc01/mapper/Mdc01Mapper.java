package com.fpminput.mntr.mdc01.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("mdc01Mapper")
public interface Mdc01Mapper {

	List<EgovMap> selectMdc01List(Map<String, Object> pRequestParamMap);

	Map<String, String> selectUserInfo(Map<String, Object> pRequestParamMap);

	List<Map<String, String>> mdc01ShipmntExOfUser(Map<String, Object> pRequestParamMap);

	List<Map<String, String>> mdc01ShipmntOfUser(Map<String, Object> pRequestParamMap);

	List<Map<String, String>> mdc01TypeCropOfUser(	Map<String, Object> pRequestParamMap);

	List<Map<String, String>> mdc01TypeCultOfUser(	Map<String, Object> pRequestParamMap);

	List<Map<String, String>> mdc01TypeConsTrendOfUser(Map<String, Object> pRequestParamMap);

	List<Map<String, String>> mdc01TypeConsPriceOfUser(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectMdc01FullList(Map<String, Object> pRequestParamMap);

	EgovMap deadLineManage(Map<String, Object> pRequestParamMap);

	int updateDeadLineDate(Map<String, Object> pRequestParamMap);


}
