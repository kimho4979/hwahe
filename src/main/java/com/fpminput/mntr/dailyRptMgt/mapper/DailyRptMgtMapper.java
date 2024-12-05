package com.fpminput.mntr.dailyRptMgt.mapper;

import java.util.List;
import java.util.Map;

import com.fpminput.mntr.dailyRptMgt.domain.DailyRptMgtVO;
import com.fpminput.mntr.dailyRptSend.domain.DailyRptSendVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("dailyRptMgtMapper")
public interface DailyRptMgtMapper {

	List<EgovMap> selectGridList(Map<String, Object> pRequestParamMap);
	List<DailyRptMgtVO> searchGridList(Map<String, Object> pRequestParamMap);
	int insertGridList(Map<String, Object> pRequestParamMap);
	int updateGridList(Map<String, Object> pRequestParamMap);
	
	DailyRptMgtVO selectSimilarInputSeq(Map<String, Object> pRequestParamMap);
		
	int insertGongiInput(Map<String, Object> pRequestParamMap);
	int insertGongiFile(Map<String, Object> pRequestParamMap);
	
	int updateGongiInfoInput(Map<String, Object> pRequestParamMap);
	int updateGongiFile(Map<String, Object> pRequestParamMap);
	
	int deleteGongiInfoInput(Map<String, Object> pRequestParamMap);
	int deleteGongiFileInfoInput(Map<String, Object> pRequestParamMap);
	
	DailyRptMgtVO selectSumNail(String seqNo);
/*	
	int updateCnsmpPcInput(Map<String, Object> pReqParamMap);

	int deleteCnsmpPcInput(Map<String, Object> pReqParamMap);
*/
}
