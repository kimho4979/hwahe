package com.fpminput.mntr.mcd02.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpminput.mntr.mcd02.domain.Mcd02VO;
import com.fpminput.mntr.mcd02.mapper.Mcd02Mapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;


@Service
public class Mcd02Service extends BaseService {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired
	Mcd02Mapper mcd02Mapper;

	// 조회
	public List<EgovMap> selectGridList(Map<String, Object> pRequestParamMap) {
		return mcd02Mapper.selectGridList(pRequestParamMap);
	}
	
	// 팝업 시 공통코드 조회
	public List<EgovMap> selectAreaNm(Map<String, Object> pRequestParamMap) {
		return mcd02Mapper.selectAreaNm(pRequestParamMap);
	}
	
	// 팝업 행사일정 등록
	public int insertEventSch(Map<String, Object> pRequestParamMap){	
		return mcd02Mapper.insertEventSch(pRequestParamMap);
	}
	
	// 삭제
	public int deleteEventSch(Map<String, Object> pRequestParamMap){
		return mcd02Mapper.deleteEventSch(pRequestParamMap);
	}
	
	// 수정
	public int updateEventSch(Map<String, Object> pRequestParamMap){	
		return mcd02Mapper.updateEventSch(pRequestParamMap);
	}
}
