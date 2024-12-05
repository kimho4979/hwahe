package com.fpminput.mntr.mab02.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpminput.mntr.mab02.domain.Mab02VO;
import com.fpminput.mntr.mab02.mapper.Mab02Mapper;


@Service
public class Mab02Service extends BaseService {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired
	Mab02Mapper mab02Mapper;

	public List<Mab02VO> selectCropInfoInput(Map<String, Object> pRequestParamMap){
		return mab02Mapper.selectCropInfoInput(pRequestParamMap);		
	}
	
	public List<Mab02VO> selectCropInfoInputAll(Map<String, Object> pRequestParamMap){
		return mab02Mapper.selectCropInfoInputAll(pRequestParamMap);		
	}
	
	public Mab02VO selectCropInfoInputSeq(Mab02VO mab02vo){
		return mab02Mapper.selectCropInfoInputSeq(mab02vo);		
	}
	
	public int updateCropInfoInput(Map<String, Object> pReqParamMap){
		return mab02Mapper.updateCropInfoInput(pReqParamMap);
	}
	
	public int insertCropInfoInput(Map<String, Object> pReqParamMap){	
		return mab02Mapper.insertCropInfoInput(pReqParamMap);
	}
	
	public int insertCropFile(Map<String, Object> pRequestParamMap){
		return mab02Mapper.insertCropFile(pRequestParamMap);		
	}		
	
	public int updateCropFile(Map<String, Object> pRequestParamMap){
		return mab02Mapper.updateCropFile(pRequestParamMap);		
	}		
	
	public int deleteCropInfoInput(Map<String, Object> pReqParamMap){
		return mab02Mapper.deleteCropInfoInput(pReqParamMap);
	}
	
	public Mab02VO selectSumNail(String seqNo){
		return mab02Mapper.selectSumNail(seqNo);		
	}
	
	public int deleteCropFile(Map<String, Object> pRequestParamMap){
		return mab02Mapper.deleteCropFile(pRequestParamMap);		
	}
	
}
