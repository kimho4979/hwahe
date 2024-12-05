package com.fpdisys.dist.hab06.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.hab06.domain.Hab06VO;
import com.fpdisys.dist.hab06.mapper.Hab06Mapper;

@Service
public class Hab06Service extends BaseService {
	
	@Autowired
	Hab06Mapper hab06Mapper;


	public List<Hab06VO> selectSeoulContractQtyList(Map<String, Object> pRequestParamMap) {
		// TODO Auto-generated method stub
		return hab06Mapper.selectSeoulContractQtyList(pRequestParamMap);
	}

	public List<Hab06VO> selectBusanContractQtyList(Map<String, Object> pRequestParamMap) {
		// TODO Auto-generated method stub
		return hab06Mapper.selectBusanContractQtyList(pRequestParamMap);
	}

	public List<Hab06VO> selectBukyoungContractQtyList(Map<String, Object> pRequestParamMap) {
		// TODO Auto-generated method stub
		return hab06Mapper.selectBukyoungContractQtyList(pRequestParamMap);
	}

	public List<Hab06VO> selectYoungNamContractQtyList(Map<String, Object> pRequestParamMap) {
		// TODO Auto-generated method stub
		return hab06Mapper.selectYoungNamContractQtyList(pRequestParamMap);
	}

	public List<Hab06VO> selectKwangJuContractQtyList(Map<String, Object> pRequestParamMap) {
		// TODO Auto-generated method stub
		return hab06Mapper.selectKwangJuContractQtyList(pRequestParamMap);
	}

	public List<Hab06VO> selectHanKookContractQtyList(Map<String, Object> pRequestParamMap) {
		// TODO Auto-generated method stub
		return hab06Mapper.selectHanKookContractQtyList(pRequestParamMap);
	}
	
	/**
	 * 월별 전년대비리스트 
	 * @param pRequestParamMap
	 * @return
	 */
	public List<Hab06VO> selectHab06(Map<String, Object> pRequestParamMap){
		return hab06Mapper.selectHab06(pRequestParamMap);
	}
	
	public List<?> selectHab06Bak(Map<String, Object> pRequestParamMap){
		return hab06Mapper.selectHab06Bak(pRequestParamMap);
	}
	
	/**
	 * 월별 전년대비 합계
	 * @param pRequestParamMap
	 * @return
	 */
	public List<Hab06VO> selectHab06Hap(Map<String, Object> pRequestParamMap){
		return hab06Mapper.selectHab06Hap(pRequestParamMap);
	}
	
	public List<?> selectHab06HapBak(Map<String, Object> pRequestParamMap){
		return hab06Mapper.selectHab06HapBak(pRequestParamMap);
	}
	/**
	 * 차트 
	 * @param pRequestParamMap
	 * @return
	 */
	public List<Hab06VO> selectHab06Chart(Map<String, Object> pRequestParamMap){
		return hab06Mapper.selectHab06Chart(pRequestParamMap);	
	}
	
	public List<?> selectHab06ChartBak(Map<String, Object> pRequestParamMap){
		return hab06Mapper.selectHab06ChartBak(pRequestParamMap);	
	}
		
	public List<Hab06VO> getSaleDate(Map<String, Object> pRequestParamMap){
		return hab06Mapper.getSaleDate(pRequestParamMap);	
	}
	
	// 월별전년대비실적 :: Excel
	public List<Hab06VO> selectHab06Excel(Map<String, Object> pRequestParamMap){
		return hab06Mapper.selectHab06Excel(pRequestParamMap);
	}
	
	// 월별전년대비실적 합계 :: Excel
	public List<Hab06VO> selectHab06HapExcel(Map<String, Object> pRequestParamMap){
		return hab06Mapper.selectHab06HapExcel(pRequestParamMap);
	}
	
}
