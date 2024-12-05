package com.fpdisys.dist.haa03.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.haa03.domain.Haa03ExcelVO;
import com.fpdisys.dist.haa03.mapper.Haa03Mapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class Haa03Service extends BaseService {

	@Autowired
	Haa03Mapper haa03Mapper;
	
	//aT화훼공판장
		public List<EgovMap> selectListaTFlower(Map<String, Object> pRequestParamMap){
			return haa03Mapper.selectListaTFlower(pRequestParamMap);		
		}
		
		public List<EgovMap> selectListaTFlowerGraph(Map<String, Object> pRequestParamMap){
			return haa03Mapper.selectListaTFlowerGraph(pRequestParamMap);
		}
		
		public List<EgovMap> selectListaTFlowerMonth(Map<String, Object> pRequestParamMap){
			return haa03Mapper.selectListaTFlowerMonth(pRequestParamMap);		
		}
			
		//부산화훼공판장
		public List<EgovMap> selectListBuSanFlower(Map<String, Object> pRequestParamMap){
			return haa03Mapper.selectListBuSanFlower(pRequestParamMap);
		}
		
		public List<EgovMap> selectListBuSanFlowerGraph(Map<String, Object> pRequestParamMap){
			return haa03Mapper.selectListBuSanFlowerGraph(pRequestParamMap);
		}
		
		public List<EgovMap> selectListBuSanFlowerMonth(Map<String, Object> pRequestParamMap){
			return haa03Mapper.selectListBuSanFlowerMonth(pRequestParamMap);
		}
		//부산경남화훼농협
		public List<EgovMap> selectListBukyoungFlower(Map<String, Object> pRequestParamMap){
			return haa03Mapper.selectListBukyoungFlower(pRequestParamMap);
		}
		
		public List<EgovMap> selectListBukyoungFlowerGraph(Map<String, Object> pRequestParamMap){
			return haa03Mapper.selectListBukyoungFlowerGraph(pRequestParamMap);
		}
		
		public List<EgovMap> selectListBukyoungFlowerMonth(Map<String, Object> pRequestParamMap){
			return haa03Mapper.selectListBukyoungFlowerMonth(pRequestParamMap);
		}
		
		//광주원예농협
		public List<EgovMap> selectListKwangJuFlower(Map<String, Object> pRequestParamMap){
			return haa03Mapper.selectListKwangJuFlower(pRequestParamMap);
		}
		
		public List<EgovMap> selectListKwangJuFlowerGraph(Map<String, Object> pRequestParamMap){
			return haa03Mapper.selectListKwangJuFlowerGraph(pRequestParamMap);
		}
		
		public List<EgovMap> selectListKwangJuFlowerMonth(Map<String, Object> pRequestParamMap){
			return haa03Mapper.selectListKwangJuFlowerMonth(pRequestParamMap);
		}
		
		//한국화훼농협(음성)
		public List<EgovMap> selectListHanKookUmFlower(Map<String, Object> pRequestParamMap){
			return haa03Mapper.selectListHanKookUmFlower(pRequestParamMap);
		}
		
		public List<EgovMap> selectListHanKookUmFlowerGraph(Map<String, Object> pRequestParamMap){
			return haa03Mapper.selectListHanKookUmFlowerGraph(pRequestParamMap);
		}
		
		public List<EgovMap> selectListHanKookUmFlowerMonth(Map<String, Object> pRequestParamMap){
			return haa03Mapper.selectListHanKookUmFlowerMonth(pRequestParamMap);
		}
		
		//한국화훼농협(본점)
		public List<EgovMap> selectListHanKookBonFlower(Map<String, Object> pRequestParamMap){
			return haa03Mapper.selectListHanKookBonFlower(pRequestParamMap);
		}
		
		public List<EgovMap> selectListHanKookBonFlowerGraph(Map<String, Object> pRequestParamMap){
			return haa03Mapper.selectListHanKookBonFlowerGraph(pRequestParamMap);
		}
		
		public List<EgovMap> selectListHanKookBonFlowerMonth(Map<String, Object> pRequestParamMap){
			return haa03Mapper.selectListHanKookBonFlowerMonth(pRequestParamMap);
		}
	 
		public List<EgovMap> selectSubSearch(Map<String, Object> pRequestParamMap){
			return haa03Mapper.selectSubSearch(pRequestParamMap);
		}
		
		// 품종경락가격 :: Excel
		public List<Haa03ExcelVO> selectListFlowerExcel(Map<String, Object> pRequestParamMap){
			return haa03Mapper.selectListFlowerExcel(pRequestParamMap);
		}

}
