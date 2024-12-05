package com.fpminput.mntr.codeMgt.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpminput.mntr.codeMgt.mapper.CodeMgtMapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class CodeMgtService extends BaseService {

	@Autowired
	CodeMgtMapper CodeMgtMapper;
	
	// 품목코드맵핑 :: List
	public List<EgovMap> selectCodeMapList(Map<String, Object> pReqParamMap){
		return CodeMgtMapper.selectCodeMapList(pReqParamMap);		
	}
	
	// 품목코드 관리 INSERT
	public int insertCodeMapList(Map<String, Object> pReqParamMap){
		return CodeMgtMapper.insertCodeMapList(pReqParamMap);
	}
	
	// 품목코드 관리 UPDATE
	public int updateCodeMapList(Map<String, Object> pReqParamMap){
		return CodeMgtMapper.updateCodeMapList(pReqParamMap);
	}
	
	// 품목코드 관리 DELETE
	public int deleteCodeMapList(Map<String, Object> pReqParamMap){
		return CodeMgtMapper.deleteCodeMapList(pReqParamMap);
	}
	
}