package com.fpdisys.module.recv.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.module.recv.domain.SchoolEventMVO;
import com.fpdisys.module.recv.domain.SchoolInfoMVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("neisMapper")
public interface NeisMapper {

	List<EgovMap> selectSchoolList(Map<String, Object> pRequestParamMap);

	int insertSchoolInfo(SchoolInfoMVO schoolMVO);
	int insertSchoolEventInfo(SchoolEventMVO eventVO);
	
	void insertSchInfo(Map<String, Object> paramMap);
	void deleteEventList(Map<String, Object> paramMap);
	
	int getDataCount_T_EVENT_SCH(String loadDtm);
	
	void logInsertCall(Map<String, String> map);
}
