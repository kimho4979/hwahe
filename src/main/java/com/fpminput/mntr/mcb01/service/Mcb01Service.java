package com.fpminput.mntr.mcb01.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpminput.mntr.mca01.domain.Mca01VO;
import com.fpminput.mntr.mcb01.domain.Mcb01VO;
import com.fpminput.mntr.mcb01.mapper.Mcb01Mapper;


@Service
public class Mcb01Service extends BaseService {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired
	Mcb01Mapper mcb01Mapper;

	public List<?> selectMonthList(Map<String, Object> pRequestParamMap){
		return mcb01Mapper.selectMonthList(pRequestParamMap);		
	}

	public List<Mcb01VO> selectMonthInputSeq(Map<String, Object> pRequestParamMap){
		return mcb01Mapper.selectMonthInputSeq(pRequestParamMap);		
	}
			
	public int insertMonthInput(Map<String, Object> pReqParamMap){	
		return mcb01Mapper.insertMonthInput(pReqParamMap);
	}
	
	public int insertMonthFile(Map<String, Object> pReqParamMap){	
		return mcb01Mapper.insertMonthFile(pReqParamMap);
	}
	
	public int updateMonthInfoInput(Map<String, Object> pReqParamMap){
		return mcb01Mapper.updateMonthInfoInput(pReqParamMap);
	}
	
	public int updateMonthFile(Map<String, Object> pReqParamMap){
		return mcb01Mapper.updateMonthFile(pReqParamMap);
	}
	
	public int deleteMonthInfoInput(Map<String, Object> pRequestParamMap){
		return mcb01Mapper.deleteMonthInfoInput(pRequestParamMap);
	}
	public int deleteMonthFileInfoInput(Map<String, Object> pRequestParamMap){
		return mcb01Mapper.deleteMonthFileInfoInput(pRequestParamMap);
	}
	
	public Mcb01VO selectSumNail(String seqNo){
		return mcb01Mapper.selectSumNail(seqNo);		
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
