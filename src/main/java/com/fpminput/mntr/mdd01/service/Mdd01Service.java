package com.fpminput.mntr.mdd01.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpminput.mntr.mdd01.mapper.Mdd01Mapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;


@Service
public class Mdd01Service extends BaseService {
	
	@Autowired
	Mdd01Mapper mdd01Mapper;

	/*
	 * 발송이력관리 이메일, 카카오메시지 발송이력조회(페이징) 
	 */
	public List<EgovMap> selectMdd01List(Map<String, Object> pRequestParamMap) {
		return mdd01Mapper.selectMdd01List(pRequestParamMap);
	}

	//발송이력관리 발송로그 상세내용 조회
	public Map<String, String> selectMdd01Detail(	Map<String, Object> pRequestParamMap) {
		return mdd01Mapper.selectMdd01Detail(pRequestParamMap);
	}

}
