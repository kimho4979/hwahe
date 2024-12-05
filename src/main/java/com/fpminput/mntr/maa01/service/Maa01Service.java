package com.fpminput.mntr.maa01.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpminput.mntr.maa01.mapper.Maa01Mapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class Maa01Service extends BaseService {

	@Autowired
	Maa01Mapper maa01Mapper;
	
	public List<?> selectShipmntPrearngeVolm(Map<String, Object> pRequestParamMap){
		return maa01Mapper.selectShipmntPrearngeVolm(pRequestParamMap);		
	}	
	
	public int insertShipmntPrearngeVolm(Map<String, Object> pReqParamMap){
		return maa01Mapper.insertShipmntPrearngeVolm(pReqParamMap);
	}
	
	public int updateShipmntPrearngeVolm(Map<String, Object> pReqParamMap){
		return maa01Mapper.updateShipmntPrearngeVolm(pReqParamMap);
	}
	
	public int updateShipmntPrearngeVolmMobile(Map<String, Object> pReqParamMap){
		return maa01Mapper.updateShipmntPrearngeVolmMobile(pReqParamMap);
	}
	
	public int deleteShipmntPrearngeVolm(Map<String, Object> pReqParamMap){
		return maa01Mapper.deleteShipmntPrearngeVolm(pReqParamMap);
	}

	public List<?> selectShipmntPrearngeVolm2(Map<String, Object> pRequestParamMap){
		return maa01Mapper.selectShipmntPrearngeVolm2(pRequestParamMap);		
	}	
	
	public int insertShipmntPrearngeVolm2(Map<String, Object> pReqParamMap){
		return maa01Mapper.insertShipmntPrearngeVolm2(pReqParamMap);
	}
	
	public List<?> selectTotalVolm(Map<String, Object> pRequestParamMap){
		return maa01Mapper.selectTotalVolm(pRequestParamMap);		
	}	
	
	public List<?> selectTotalVolm2(Map<String, Object> pRequestParamMap){
		return maa01Mapper.selectTotalVolm2(pRequestParamMap);		
	}	
	
}
