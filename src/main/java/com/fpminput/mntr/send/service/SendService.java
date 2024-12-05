package com.fpminput.mntr.send.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpminput.mntr.send.mapper.SendMapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class SendService extends BaseService {

	@Autowired
	SendMapper sendMapper;
	
	// SMS 발송 :: INSERT
	public int insertSmsTranfer(Map<String, Object> pRequestParamMap){
		return sendMapper.insertSmsTranfer(pRequestParamMap);
	}
	
	// SMS LOG :: INSERT
	public int insertSmsTranferLog(Map<String, Object> pRequestParamMap){
		return sendMapper.insertSmsTranferLog(pRequestParamMap);
	}
	
	// EMAIL 발송 :: INSERT
	public int insertEmailTranfer(Map<String, Object> pRequestParamMap){
		return sendMapper.insertEmailTranfer(pRequestParamMap);
	}
	
	// EMAIL LOG :: INSERT
	public int insertEmailTranferLog(Map<String, Object> pRequestParamMap){
		return sendMapper.insertEmailTranferLog(pRequestParamMap);
	}
	
}