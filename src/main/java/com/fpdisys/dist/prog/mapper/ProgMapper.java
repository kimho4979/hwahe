package com.fpdisys.dist.prog.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.prog.domain.Program;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("ProgMapper")
public interface ProgMapper {
	
	 List<Program> getFindAllProg(Map<String, Object> pReqParamMap);
	
	 List<Program> getActiveProg(Map<String, Object> pReqParamMap);
	
	 int insertProg(Map<String, Object> pReqParamMap);
	 
	 int updateProg(Map<String, Object> pReqParamMap);
	 
	 Program getProg(Map<String, Object> pReqParamMap);
	 
	 List<Program> getActiveProgSearch(Map<String, Object> pReqParamMap);
	 
	 int getMergeProg(Map<String, Object> pReqParamMap);
	

}

