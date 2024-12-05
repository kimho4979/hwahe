package com.fpdisys.dist.hab10.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.hab10.domain.Hab10VO;
import com.fpdisys.dist.hab10.mapper.Hab10Mapper;

@Service
public class Hab10Service extends BaseService {

	@Autowired
	Hab10Mapper hab10Mapper;

	/**
	 * 연도별 실적 기본조회
	 * @param pRequestParamMap
	 * @return
	 */
	public List<Hab10VO> selectHab10(Map<String, Object> pRequestParamMap){
		return hab10Mapper.selectHab10(pRequestParamMap);
	}

	/**
	 * 차트
	 * @param pRequestParamMap
	 * @return
	 */
	public List<Hab10VO> selectHab10Chart(Map<String, Object> pRequestParamMap){
		return hab10Mapper.selectHab10Chart(pRequestParamMap);
	}

}
