package com.fpminput.mntr.mca01.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpminput.mntr.mab02.domain.Mab02VO;
import com.fpminput.mntr.mca01.domain.Mca01VO;
import com.fpminput.mntr.mca01.mapper.Mca01Mapper;


@Service
public class Mca01Service extends BaseService {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired
	Mca01Mapper mca01Mapper;

	public List<?> selectSugeupInput(Map<String, Object> pRequestParamMap){
		return mca01Mapper.selectSugeupInput(pRequestParamMap);		
	}
	
	public List<Mca01VO> selectSugeupInputSeq(Map<String, Object> pRequestParamMap){
		return mca01Mapper.selectSugeupInputSeq(pRequestParamMap);		
	}
	
	public int insertSugeupInput(Map<String, Object> pReqParamMap){	
		return mca01Mapper.insertSugeupInput(pReqParamMap);
	}
	
	public int insertSugeupFile(Map<String, Object> pReqParamMap){	
		return mca01Mapper.insertSugeupFile(pReqParamMap);
	}
	
	public int updateSugeupInfoInput(Map<String, Object> pReqParamMap){
		return mca01Mapper.updateSugeupInfoInput(pReqParamMap);
	}
	
	public int updateSugeupFile(Map<String, Object> pReqParamMap){
		return mca01Mapper.updateSugeupFile(pReqParamMap);
	}
	
	public int deleteSugeupInfoInput(Map<String, Object> pRequestParamMap){
		return mca01Mapper.deleteSugeupInfoInput(pRequestParamMap);
	}
	
	public int deleteSegeupFileInfoInput(Map<String, Object> pRequestParamMap){
		return mca01Mapper.deleteSegeupFileInfoInput(pRequestParamMap);
	}
	
	public Mca01VO selectSumNail(String seqNo){
		return mca01Mapper.selectSumNail(seqNo);		
	}
	
	/*
	public int insertCropInfoInput(Map<String, Object> pReqParamMap){	
		
		return mca01Mapper.insertCropInfoInput(pReqParamMap);
	}
	
	public int insertCropFile(Map<String, Object> pRequestParamMap){
		return mca01Mapper.insertCropFile(pRequestParamMap);		
	}		
	
	public int updateCropFile(Map<String, Object> pRequestParamMap){
		return mca01Mapper.updateCropFile(pRequestParamMap);		
	}		
	
	public int deleteCropInfoInput(Map<String, Object> pReqParamMap){
		return mca01Mapper.deleteCropInfoInput(pReqParamMap);
	}
	*/
}
