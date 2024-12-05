package com.fpdisys.dist.auth.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.auth.mapper.AuthGroupMapper;
import com.fpdisys.dist.auth.mapper.AuthGroupMenuMapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class AuthGroupService extends BaseService {
	@Autowired
	AuthGroupMapper authGroupMapper;
	@Autowired
	AuthGroupMenuMapper authGroupMenuMapper;
	
	
	public List<?> findAll(Map<String, Object> pReqParamMap) {
		
		List<EgovMap> resultList =  (List<EgovMap>)authGroupMapper.findAll(pReqParamMap);
		
		return resultList;
	}
	
	public List<?> findByGrpAuthCd(Map<String, Object> pReqParamMap) {
		
		List<EgovMap> resultList =  (List<EgovMap>)authGroupMapper.findByGrpAuthCd(pReqParamMap);
		
		return resultList;
	}
	
	 public int insertAuthGroup(Map<String, Object> pReqParamMap){
		 return authGroupMapper.insertAuthGroup(pReqParamMap);
	 }
	 
	 public int updateAuthGroup(Map<String, Object> pReqParamMap){
		 return authGroupMapper.updateAuthGroup(pReqParamMap);
	 }
	 
	 
	 public  Map<String, Object> AuthGrouproc(Map<String, Object> pRequestParamMap){
		 Map<String, Object> resultMap = new HashMap<String, Object>();
		 resultMap.put("opCode", pRequestParamMap.get("opCode"));
		
		 resultMap.put("grpAuthCd", pRequestParamMap.get("grpAuthCd"));
		 resultMap.put("grpAuthNm", pRequestParamMap.get("grpAuthNm"));
		 resultMap.put("userId", pRequestParamMap.get("userId"));
		 resultMap.put("grpFg", pRequestParamMap.get("grpFg"));
		 resultMap.put("useYn", pRequestParamMap.get("useYn"));
		 resultMap.put("remark", pRequestParamMap.get("remark"));
		 
		 
		 resultMap.put("oRetCode","" );
		 resultMap.put("oRetMsg","" );
		 
		 insertAuthGroup(resultMap);
		 
		 return resultMap;
	 }
	 
	 public int getMergeAuthGroup(Map<String, Object> pReqParamMap){
		 return authGroupMapper.getMergeAuthGroup(pReqParamMap);
	 }
	 
	 public int deleteAuthGroup(Map<String, Object> pReqParamMap){
		 return authGroupMapper.deleteAuthGroup(pReqParamMap);
	 }
	 
	 public void deleteAuthGroupMenuByGrpAuthCd(Map<String, Object> pReqParamMap){
		 authGroupMenuMapper.deleteByGrpAuthCd(pReqParamMap);
	 }
	 
	 
	 
	 public void deleteAuthGroupProc(Map<String, Object> pReqParamMap){
		 
		 deleteAuthGroup(pReqParamMap);
		 
		 deleteAuthGroupMenuByGrpAuthCd(pReqParamMap);
		 
	 }
	 
	 public void deleteAuthGroupMenuProc(Map<String, Object> pReqParamMap){
		 
		 authGroupMenuMapper.deleteByGrpAuthCdAndMnuCd(pReqParamMap);
	 }
	 
	 public List<?> findByGrpUserId(Map<String, Object> pReqParamMap) {
			
			List<EgovMap> resultList =  (List<EgovMap>)authGroupMapper.findByGrpUserId(pReqParamMap);
			
			return resultList;
		}
	
}
