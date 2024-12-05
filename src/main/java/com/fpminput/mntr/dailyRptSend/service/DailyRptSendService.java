package com.fpminput.mntr.dailyRptSend.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpminput.mntr.dailyRptSend.domain.DailyRptSendVO;
import com.fpminput.mntr.dailyRptSend.mapper.DailyRptSendMapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;


@Service
public class DailyRptSendService extends BaseService {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired
	DailyRptSendMapper dailyRptSendMapper;

	// 조회
	public List<EgovMap> selectGridList(Map<String, Object> pRequestParamMap) {
		return dailyRptSendMapper.selectGridList(pRequestParamMap);
	}
	
	// 조회
	public List<DailyRptSendVO> selectGridAll(Map<String, Object> pRequestParamMap) {
		return dailyRptSendMapper.selectGridAll(pRequestParamMap);
	}
	
	// 팝업 조회
	public List<EgovMap> selectDailtRptSendPopup(Map<String, Object> pRequestParamMap) {
		return dailyRptSendMapper.selectDailtRptSendPopup(pRequestParamMap);
	}
	
	// 팝업 일일보고자료발송 등록
	public int insertDailtRptSend(Map<String, Object> pRequestParamMap){	
		return dailyRptSendMapper.insertDailtRptSend(pRequestParamMap);
	}
	
	// 삭제	
	public int deleteDailtRptSend(Map<String, Object> pRequestParamMap){
		return dailyRptSendMapper.deleteDailtRptSend(pRequestParamMap);
	}
	
	// 수정
	public int updateDailtRptSend(Map<String, Object> pRequestParamMap){
		return dailyRptSendMapper.updateDailtRptSend(pRequestParamMap);
	}
}
