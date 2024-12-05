package com.fpminput.mntr.dailyRptMgt.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpminput.mntr.dailyRptMgt.domain.DailyRptMgtVO;
import com.fpminput.mntr.dailyRptMgt.mapper.DailyRptMgtMapper;
import com.fpminput.mntr.dailyRptSend.domain.DailyRptSendVO;

import egovframework.rte.psl.dataaccess.util.EgovMap;


@Service
public class DailyRptMgtService extends BaseService {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired
	DailyRptMgtMapper dailyRptMgtMapper;

	public List<EgovMap> selectGridList(Map<String, Object> pRequestParamMap) {
		return dailyRptMgtMapper.selectGridList(pRequestParamMap);
	}
	
	public List<DailyRptMgtVO> searchGridList(Map<String, Object> pRequestParamMap) {
		return dailyRptMgtMapper.searchGridList(pRequestParamMap);
	}
	
	public int insertGridList(Map<String, Object> pRequestParamMap) {
		return dailyRptMgtMapper.insertGridList(pRequestParamMap);
	}
	public int updateGridList(Map<String, Object> pRequestParamMap) {
		return dailyRptMgtMapper.updateGridList(pRequestParamMap);
	}
	
	public DailyRptMgtVO selectSimilarInputSeq(Map<String, Object> pRequestParamMap){
		return dailyRptMgtMapper.selectSimilarInputSeq(pRequestParamMap);		
	}
			
	public int insertGongiInput(Map<String, Object> pRequestParamMap){	
		return dailyRptMgtMapper.insertGongiInput(pRequestParamMap);
	}
	
	public int insertGongiFile(Map<String, Object> pRequestParamMap){	
		return dailyRptMgtMapper.insertGongiFile(pRequestParamMap);
	}
	
	public int updateGongiInfoInput(Map<String, Object> pRequestParamMap){
		return dailyRptMgtMapper.updateGongiInfoInput(pRequestParamMap);
	}
	
	public int updateGongiFile(Map<String, Object> pRequestParamMap){
		return dailyRptMgtMapper.updateGongiFile(pRequestParamMap);
	}
	
	public int deleteGongiInfoInput(Map<String, Object> pRequestParamMap){
		return dailyRptMgtMapper.deleteGongiInfoInput(pRequestParamMap);
	}
	
	public int deleteGongiFileInfoInput(Map<String, Object> pRequestParamMap){
		return dailyRptMgtMapper.deleteGongiFileInfoInput(pRequestParamMap);
	}
	
	public DailyRptMgtVO selectSumNail(String seqNo){
		return dailyRptMgtMapper.selectSumNail(seqNo);		
	}
}
