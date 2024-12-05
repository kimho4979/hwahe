package com.fpdisys.module.comm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.module.comm.mapper.CommMapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("commService")
public class CommService extends BaseService {

	@Autowired
	CommMapper commMapper;

	public List<EgovMap> selectComCdList(Map<String, Object> pRequestParamMap) {
		return commMapper.selectComCdList(pRequestParamMap);
	}

	public List<EgovMap> selectItemList(Map<String, Object> pRequestParamMap) {
		return commMapper.selectItemList(pRequestParamMap);
	}

	public List<EgovMap> selectItemDtlList(Map<String, Object> pRequestParamMap) {
		return commMapper.selectItemDtlList(pRequestParamMap);
	}
	
	public List<EgovMap> selectGoodNameCmpTotal(Map<String, Object> pRequestParamMap) {
		return commMapper.selectGoodNameCmpTotal(pRequestParamMap);
	}
}
