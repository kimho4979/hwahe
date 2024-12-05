package com.fpminput.mntr.mcc01.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpminput.mntr.mcb01.domain.Mcb01VO;
import com.fpminput.mntr.mcc01.domain.Mcc01VO;
import com.fpminput.mntr.mcc01.mapper.Mcc01Mapper;


@Service
public class Mcc01Service extends BaseService {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired
	Mcc01Mapper mcc01Mapper;

	public List<?> selectSimilarList(Map<String, Object> pRequestParamMap){
		return mcc01Mapper.selectSimilarList(pRequestParamMap);		
	}

	public List<Mcc01VO> selectSimilarInputSeq(Map<String, Object> pRequestParamMap){
		return mcc01Mapper.selectSimilarInputSeq(pRequestParamMap);		
	}
			
	public int insertSimilarInput(Map<String, Object> pRequestParamMap){	
		return mcc01Mapper.insertSimilarInput(pRequestParamMap);
	}
	
	public int insertSimilarFile(Map<String, Object> pRequestParamMap){	
		return mcc01Mapper.insertSimilarFile(pRequestParamMap);
	}
	
	public int updateSimilarInfoInput(Map<String, Object> pRequestParamMap){
		return mcc01Mapper.updateSimilarInfoInput(pRequestParamMap);
	}
	
	public int updateSimilarFile(Map<String, Object> pRequestParamMap){
		return mcc01Mapper.updateSimilarFile(pRequestParamMap);
	}
	
	public int deleteSimilarInfoInput(Map<String, Object> pRequestParamMap){
		return mcc01Mapper.deleteSimilarInfoInput(pRequestParamMap);
	}
	
	public int deleteSimilarFileInfoInput(Map<String, Object> pRequestParamMap){
		return mcc01Mapper.deleteSimilarFileInfoInput(pRequestParamMap);
	}
	
	public Mcc01VO selectSumNail(String seqNo){
		return mcc01Mapper.selectSumNail(seqNo);		
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
