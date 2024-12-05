package com.fpminput.mntr.mab01.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpminput.mntr.mab01.domain.Mab01VO;
import com.fpminput.mntr.mab01.mapper.Mab01Mapper;


@Service
public class Mab01Service extends BaseService {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired
	Mab01Mapper mab01Mapper;

	public List<?> selectCropInfoInput(Map<String, Object> pRequestParamMap){
		return mab01Mapper.selectCropInfoInput(pRequestParamMap);		
	}
	
	public List<?> selectCropInfoInputAll(Map<String, Object> pRequestParamMap){
		return mab01Mapper.selectCropInfoInputAll(pRequestParamMap);		
	}
	
	public Mab01VO selectCropInfoInputSeq(Mab01VO mab01vo){
		return mab01Mapper.selectCropInfoInputSeq(mab01vo);		
	}
	
	public int updateCropInfoInput(Map<String, Object> pReqParamMap){
		return mab01Mapper.updateCropInfoInput(pReqParamMap);
	}
	
	public int insertCropInfoInput(Map<String, Object> pReqParamMap){	
		return mab01Mapper.insertCropInfoInput(pReqParamMap);
	}
	
	public int insertCropFile(Map<String, Object> pRequestParamMap){
		return mab01Mapper.insertCropFile(pRequestParamMap);		
	}		
	
	public int updateCropFile(Map<String, Object> pRequestParamMap){
		return mab01Mapper.updateCropFile(pRequestParamMap);		
	}		
	
	public int deleteCropInfoInput(Map<String, Object> pReqParamMap){
		return mab01Mapper.deleteCropInfoInput(pReqParamMap);
	}
	
	public Map<String, String> selectSumNail(Map<String, Object> pRequestParamMap){
		return mab01Mapper.selectSumNail(pRequestParamMap);		
	}
	
	public int deleteCropFile(Map<String, Object> pRequestParamMap){
		return mab01Mapper.deleteCropFile(pRequestParamMap);		
	}
	
}
