package com.fpminput.mntr.mce01.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpminput.mntr.mce01.mapper.Mce01Mapper;

@Service
public class Mce01Service extends BaseService{
	
	@Autowired
	Mce01Mapper mce01Mapper;

	// 게시판관리 행상일정관리 등록처리
	public void inputEventProc(Map<String, Object> pRequestParamMap) {
		mce01Mapper.inputEventProc(pRequestParamMap);
	}

	// 게시판관리 행상일정관리 행사달력 데이터 조회
	public List<Map<String, String>> selectEventCalendarList(Map<String, Object> pRequestParamMap) {
		return mce01Mapper.selectEventCalendarList(pRequestParamMap);
	}

	// 게시판관리 행상일정관리 행사상세 내용 조회
	public Map<String, String> selectEventDetail(Map<String, Object> pRequestParamMap) {
		return mce01Mapper.selectEventDetail(pRequestParamMap);
	}

	// 게시판관리 행상일정관리 수정처리
	public void updateEventProc(Map<String, Object> pRequestParamMap) {
		mce01Mapper.updateEventProc(pRequestParamMap);
	}

	// 게시판관리 행상일정관리 삭제정처리
	public void deleteEventProc(Map<String, Object> pRequestParamMap) {
		mce01Mapper.deleteEventProc(pRequestParamMap);
	}

}
