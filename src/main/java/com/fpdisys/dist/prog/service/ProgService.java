package com.fpdisys.dist.prog.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.prog.domain.Program;
import com.fpdisys.dist.prog.mapper.ProgMapper;

@Service
public class ProgService extends BaseService{
	
	@Autowired
	ProgMapper progMapper;
	
	/**
	 * 전체 프로그램리스트 조회
	 * @param pReqParamMap
	 * @return
	 */
	public List<Program> getFindAllProg(Map<String, Object> pReqParamMap){
		
		List<Program> resultList = progMapper.getFindAllProg(pReqParamMap);
		return  resultList;
	}
	
	/**
	 * 사용프로그램리스트 조회
	 * @param pReqParamMap
	 * @return
	 */
	public List<Program> getActiveProg(Map<String, Object> pReqParamMap){
		List<Program> resultList = progMapper.getActiveProg(pReqParamMap);
		return  resultList;
	}
	
	public  int insertProg(Map<String, Object> pReqParamMap){
		
		return progMapper.insertProg(pReqParamMap);
	}
	
	public  int updateProg(Map<String, Object> pReqParamMap){
		
		return progMapper.updateProg(pReqParamMap);
	}
	
	public  Program getProg(Map<String, Object> pReqParamMap){
		return progMapper.getProg(pReqParamMap);
	}
	
 /**
  * 팝업검색용 
  * @param pReqParamMap
  * @return
  */
	public List<Program> getActiveProgSearch(Map<String, Object> pReqParamMap){
		List<Program> resultList = progMapper.getActiveProgSearch(pReqParamMap);
		return  resultList;
	}
	
	public  int getMergeProg(Map<String, Object> pReqParamMap){
		return progMapper.getMergeProg(pReqParamMap);
	}
	
}

