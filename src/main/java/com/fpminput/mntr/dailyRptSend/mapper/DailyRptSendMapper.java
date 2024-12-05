package com.fpminput.mntr.dailyRptSend.mapper;

import java.util.List;
import java.util.Map;

import com.fpminput.mntr.dailyRptSend.domain.DailyRptSendVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("dailyRptSendMapper")
public interface DailyRptSendMapper {
	// 조회
	List<EgovMap> selectGridList(Map<String, Object> pRequestParamMap);

	// 모든 수신자 조회
	List<DailyRptSendVO> selectGridAll(Map<String, Object> pRequestParamMap);

	// 팝업 일일보고자료 발송 등록
	int insertDailtRptSend(Map<String, Object> pRequestParamMap);
	
	// 삭제	
	int deleteDailtRptSend(Map<String, Object> pRequestParamMap);
	
	// 수정
	int updateDailtRptSend(Map<String, Object> pRequestParamMap);
	
	// 팝업 조회
	List<EgovMap> selectDailtRptSendPopup(Map<String, Object> pRequestParamMap);
	
}
