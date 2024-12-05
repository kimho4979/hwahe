package com.fpminput.mntr.mcd02.mapper;

import java.util.List;
import java.util.Map;

import com.fpminput.mntr.mcd02.domain.Mcd02VO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("mcd02Mapper")
public interface Mcd02Mapper {

	// 조회
	List<EgovMap> selectGridList(Map<String, Object> pRequestParamMap);
	
	// 팝업 시 공통코드 조회
	List<EgovMap> selectAreaNm(Map<String, Object> pRequestParamMap);
	
	// 팝업 행사일정 등록
	int insertEventSch(Map<String, Object> pRequestParamMap);
	
	// 삭제
	int deleteEventSch(Map<String, Object> pRequestParamMap);
	
	// 수정
	int updateEventSch(Map<String, Object> pRequestParamMap);
}
