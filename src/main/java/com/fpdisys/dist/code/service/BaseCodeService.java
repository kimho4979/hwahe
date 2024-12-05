package com.fpdisys.dist.code.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.dist.code.mapper.BasicCodeMapper;
import com.fpdisys.base.mvc.BaseService;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class BaseCodeService extends BaseService {

	@Autowired
	BasicCodeMapper basicCodeMapper;

	public List<?> findByBasicCd(Map<String, Object> pReqParamMap) {

		List<EgovMap> resultList = (List<EgovMap>) basicCodeMapper.findByBasicCd(pReqParamMap);

		return resultList;
	}

	public List<?> findByBasicCdOrderBySortAsc(Map<String, Object> pReqParamMap) {

		List<EgovMap> resultList = (List<EgovMap>) basicCodeMapper.findByBasicCdOrderBySortAsc(pReqParamMap);

		return resultList;
	}

	public List<?> findByPosUseYn(Map<String, Object> pReqParamMap) {

		List<EgovMap> resultList = (List<EgovMap>) basicCodeMapper.findByPosUseYn(pReqParamMap);

		return resultList;
	}

	public List<?> findByBasicCdContainingOrBasicNmContaining(Map<String, Object> pReqParamMap) {

		List<EgovMap> resultList = (List<EgovMap>) basicCodeMapper.findByBasicCdContainingOrBasicNmContaining(pReqParamMap);

		return resultList;
	}
	
	public List<?> findByBasicCdContainingOrBasicNmContainingPageAble(Map<String, Object> pReqParamMap) {

		List<EgovMap> resultList = (List<EgovMap>) basicCodeMapper.findByBasicCdContainingOrBasicNmContainingPageAble(pReqParamMap);

		return resultList;
	}
	
	public List<?> findAll(Map<String, Object> pReqParamMap) {

		List<EgovMap> resultList = (List<EgovMap>) basicCodeMapper.findAll(pReqParamMap);

		return resultList;
	}
	
	public List<?> findAllPageAble(Map<String, Object> pReqParamMap) {

		List<EgovMap> resultList = (List<EgovMap>) basicCodeMapper.findAllPageAble(pReqParamMap);

		return resultList;
	}
	
	 public int insertBasicCode(Map<String, Object> pReqParamMap){
		 return basicCodeMapper.insertBasicCode(pReqParamMap);
	 }
	 
	 public int updateBasicCode(Map<String, Object> pReqParamMap){
		 return basicCodeMapper.updateBasicCode(pReqParamMap);
	 }
	 
	 public int mergeBasicCode(Map<String, Object> pReqParamMap){
		 return basicCodeMapper.mergeBasicCode(pReqParamMap);
	 }
	 
	 public  Map<String, Object> basicCodeProc(Map<String, Object> pRequestParamMap){
		 Map<String, Object> resultMap = new HashMap<String, Object>();
		 resultMap.put("opCode", pRequestParamMap.get("opCode"));
		 resultMap.put("basicCd", pRequestParamMap.get("basicCd"));
		 resultMap.put("code", pRequestParamMap.get("code"));		 
		 resultMap.put("basicNm", pRequestParamMap.get("basicNm"));
		 resultMap.put("name", pRequestParamMap.get("name"));
		 resultMap.put("sort", pRequestParamMap.get("sort"));		
		 resultMap.put("data1", pRequestParamMap.get("data1"));
		 resultMap.put("data2", pRequestParamMap.get("data2"));
		 resultMap.put("data3", pRequestParamMap.get("data3"));
		 resultMap.put("data4", pRequestParamMap.get("data4"));
		 resultMap.put("data5", pRequestParamMap.get("data5"));
		 resultMap.put("posUseYn", pRequestParamMap.get("posUseYn"));
		 resultMap.put("remark", pRequestParamMap.get("remark"));
		 resultMap.put("useYn", pRequestParamMap.get("useYn"));
		 resultMap.put("userId", pRequestParamMap.get("userId"));
			 
		 resultMap.put("oRetCode","" );
		 resultMap.put("oRetMsg","" );
		
		 insertBasicCode(resultMap); 
		 
		 return resultMap;
	 }
	 
	public List<?> findComboBoxBaseCodeList(Map<String, Object> pReqParamMap){
		return basicCodeMapper.getBasicCodeList(pReqParamMap);
	}
	
}
