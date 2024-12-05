package com.fpdisys.dist.haa02.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.haa02.domain.Haa02ExcelVO;
import com.fpdisys.dist.haa02.mapper.Haa02Mapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;


@Service
public class Haa02Service extends BaseService {

	@Autowired
	Haa02Mapper haa02Mapper;
	
	public List<EgovMap> selectListaTFlower(Map<String, Object> pRequestParamMap){
		return haa02Mapper.selectListaTFlower(pRequestParamMap);		
	}
	
	//aT화훼공판장	
	public List<EgovMap> selectListaTFlowerGraph(Map<String, Object> pRequestParamMap){
		return haa02Mapper.selectListaTFlowerGraph(pRequestParamMap);
	}
	
	public List<EgovMap> selectListaTFlowerMonth(Map<String, Object> pRequestParamMap){
		return haa02Mapper.selectListaTFlowerMonth(pRequestParamMap);		
	}
		
	//부산화훼공판장
	public List<EgovMap> selectListBuSanFlowerGraph(Map<String, Object> pRequestParamMap){
		return haa02Mapper.selectListBuSanFlowerGraph(pRequestParamMap);
	}
	
	public List<EgovMap> selectListBuSanFlowerMonth(Map<String, Object> pRequestParamMap){
		return haa02Mapper.selectListBuSanFlowerMonth(pRequestParamMap);
	}
	//부산경남화훼농협
	public List<EgovMap> selectListBukyoungFlowerGraph(Map<String, Object> pRequestParamMap){
		return haa02Mapper.selectListBukyoungFlowerGraph(pRequestParamMap);
	}
	
	public List<EgovMap> selectListBukyoungFlowerMonth(Map<String, Object> pRequestParamMap){
		return haa02Mapper.selectListBukyoungFlowerMonth(pRequestParamMap);
	}
	
	//광주원예농협
	public List<EgovMap> selectListKwangJuFlowerGraph(Map<String, Object> pRequestParamMap){
		return haa02Mapper.selectListKwangJuFlowerGraph(pRequestParamMap);
	}
	
	public List<EgovMap> selectListKwangJuFlowerMonth(Map<String, Object> pRequestParamMap){
		return haa02Mapper.selectListKwangJuFlowerMonth(pRequestParamMap);
	}
	
	//한국화훼농협(음성)
	public List<EgovMap> selectListHanKookUmFlowerGraph(Map<String, Object> pRequestParamMap){
		return haa02Mapper.selectListHanKookUmFlowerGraph(pRequestParamMap);
	}
	
	public List<EgovMap> selectListHanKookUmFlowerMonth(Map<String, Object> pRequestParamMap){
		return haa02Mapper.selectListHanKookUmFlowerMonth(pRequestParamMap);
	}
	
	//한국화훼농협(본점)
	public List<EgovMap> selectListHanKookBonFlowerGraph(Map<String, Object> pRequestParamMap){
		return haa02Mapper.selectListHanKookBonFlowerGraph(pRequestParamMap);
	}
	
	public List<EgovMap> selectListHanKookBonFlowerMonth(Map<String, Object> pRequestParamMap){
		return haa02Mapper.selectListHanKookBonFlowerMonth(pRequestParamMap);
	}
	
	// 품목경락가격 :: Excel
	public List<Haa02ExcelVO> selectListMonthExcel(Map<String, Object> pRequestParamMap){
		return haa02Mapper.selectListMonthExcel(pRequestParamMap);
	}
	
}
