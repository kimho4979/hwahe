package com.fpminput.mntr.mcd01.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpminput.mntr.mcd01.domain.Mcd01VO;
import com.fpminput.mntr.mcd01.mapper.Mcd01Mapper;


@Service
public class Mcd01Service extends BaseService {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired
	Mcd01Mapper mcd01Mapper;

	public List<?> selectGongiList(Map<String, Object> pRequestParamMap){
		return mcd01Mapper.selectGongiList(pRequestParamMap);		
	}

	public Mcd01VO selectSimilarInputSeq(Map<String, Object> pRequestParamMap){
		return mcd01Mapper.selectSimilarInputSeq(pRequestParamMap);		
	}
			
	public int insertGongiInput(Map<String, Object> pRequestParamMap){	
		return mcd01Mapper.insertGongiInput(pRequestParamMap);
	}
	
	public int insertGongiFile(Map<String, Object> pRequestParamMap){	
		return mcd01Mapper.insertGongiFile(pRequestParamMap);
	}
	
	public int updateGongiInfoInput(Map<String, Object> pRequestParamMap){
		return mcd01Mapper.updateGongiInfoInput(pRequestParamMap);
	}
	
	public int updateGongiFile(Map<String, Object> pRequestParamMap){
		return mcd01Mapper.updateGongiFile(pRequestParamMap);
	}
	
	public int deleteGongiInfoInput(Map<String, Object> pRequestParamMap){
		return mcd01Mapper.deleteGongiInfoInput(pRequestParamMap);
	}
	
	public int deleteGongiFileInfoInput(Map<String, Object> pRequestParamMap){
		return mcd01Mapper.deleteGongiFileInfoInput(pRequestParamMap);
	}
	
	public Mcd01VO selectSumNail(String seqNo){
		return mcd01Mapper.selectSumNail(seqNo);		
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
