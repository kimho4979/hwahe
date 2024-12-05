package com.fpdisys.dist.preRose.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.preRose.mapper.PreRoseMapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class PreRoseService extends BaseService {

	@Autowired
	PreRoseMapper preRoseMapper;
	
	// 장미가격예측 품종 List
	public List<EgovMap> selectPreRosePumListByCmpCd(Map<String, Object> pRequestParamMap){
		return preRoseMapper.selectPreRosePumListByCmpCd(pRequestParamMap);		
	}
	
	// 장미가격예측 등급 List
		public List<EgovMap> selectPreRosePumListByLvCd(Map<String, Object> pRequestParamMap){
			return preRoseMapper.selectPreRosePumListByLvCd(pRequestParamMap);		
		}
	
	// 장미가격예측 List
	public List<EgovMap> selectPreRoseList(Map<String, Object> pRequestParamMap){
		return preRoseMapper.selectPreRoseList(pRequestParamMap);		
	}
	
	// 장미가격예측 grid List
	public List<EgovMap> selectPreRoseGridList(Map<String, Object> pRequestParamMap){
		return preRoseMapper.selectPreRoseGridList(pRequestParamMap);		
	}
	
	// 장미가격예측 평가 List
	public List<EgovMap> selectPreEstList(Map<String, Object> pRequestParamMap) {
		return preRoseMapper.selectPreEstList(pRequestParamMap);		
	}

	// 장미가격예측 평가 그리드
	public List<EgovMap> selectPreEstGridList(Map<String, Object> pRequestParamMap) {
		return preRoseMapper.selectPreEstGridList(pRequestParamMap);		
	}

	// 장미가격예측 일자 품종
	public List<EgovMap> selectPreRosePumListEst(Map<String, Object> pRequestParamMap) {
		return preRoseMapper.selectPreRosePumListEst(pRequestParamMap);
	}
	
}
