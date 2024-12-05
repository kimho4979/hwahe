package com.fpdisys.dist.cmmn.integrated.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.cmmn.integrated.domain.ItemVO;
import com.fpdisys.dist.cmmn.integrated.mapper.IntCodeMapper;

@Service
public class IntCodeService extends BaseService {
	@Autowired
	IntCodeMapper intCodeMapper;
	
	/**
	 * 품목 목록 반환
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectIntItemList(Map<String, Object> vo) throws Exception {
		return intCodeMapper.selectIntItemList(vo);
	}
	
	/**
	 * 품종 목록 반환
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectIntKindList(Map<String, Object> vo) throws Exception {
		return intCodeMapper.selectIntKindList(vo);
	}
}
