package com.fpminput.mntr.mcc02.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpminput.mntr.mcc02.domain.Mcc02VO;
import com.fpminput.mntr.mcc02.mapper.Mcc02Mapper;


@Service
public class Mcc02Service extends BaseService {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired
	Mcc02Mapper mcc02Mapper;

	public List<?> selectSimilarList(Map<String, Object> pRequestParamMap){
		return mcc02Mapper.selectSimilarList(pRequestParamMap);		
	}

	public List<Mcc02VO> selectSimilarInputSeq(Map<String, Object> pRequestParamMap){
		return mcc02Mapper.selectSimilarInputSeq(pRequestParamMap);		
	}
			
	public int insertSimilarInput(Map<String, Object> pRequestParamMap){	
		return mcc02Mapper.insertSimilarInput(pRequestParamMap);
	}
	
	public int insertSimilarFile(Map<String, Object> pRequestParamMap){	
		return mcc02Mapper.insertSimilarFile(pRequestParamMap);
	}
	
	public int updateSimilarInfoInput(Map<String, Object> pRequestParamMap){
		return mcc02Mapper.updateSimilarInfoInput(pRequestParamMap);
	}
	
	public int updateSimilarFile(Map<String, Object> pRequestParamMap){
		return mcc02Mapper.updateSimilarFile(pRequestParamMap);
	}
	
	public int deleteSimilarInfoInput(Map<String, Object> pRequestParamMap){
		return mcc02Mapper.deleteSimilarInfoInput(pRequestParamMap);
	}
	
	public int deleteSimilarFileInfoInput(Map<String, Object> pRequestParamMap){
		return mcc02Mapper.deleteSimilarFileInfoInput(pRequestParamMap);
	}
	
	public Mcc02VO selectSumNail(String seqNo){
		return mcc02Mapper.selectSumNail(seqNo);		
	}
}
