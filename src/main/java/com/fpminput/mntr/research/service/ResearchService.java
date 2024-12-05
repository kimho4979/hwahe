package com.fpminput.mntr.research.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpminput.mntr.menumgt.mapper.MenuMgtMapper;
import com.fpminput.mntr.research.mapper.ResearchMapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class ResearchService extends BaseService {

	@Autowired
	ResearchMapper researchMapper;

	public void deleteReserchData(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		researchMapper.deleteReserchData1(paramMap);
		researchMapper.deleteReserchData2(paramMap);
	}

	// 난 데이터 초기화(DB 테이블 delete)
	public void deleteReserchData2(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		researchMapper.deleteReserchData3(paramMap);
	}
	
	// 종류 콤보 조회
	public List<EgovMap> searchCombo(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return researchMapper.searchCombo(paramMap);
	}
	
	public int insertReserchData1(List<Map<String, Object>> insertList1) {
		// TODO Auto-generated method stub
		return researchMapper.insertReserchData1(insertList1);
	}

	public int insertReserchData2(List<Map<String, Object>> insertList2) {
		// TODO Auto-generated method stub
		return researchMapper.insertReserchData2(insertList2);
	}

	public int insertReserchData2Each(Map<String, Object> insertVO) {
		// TODO Auto-generated method stub
		return researchMapper.insertReserchData2Each(insertVO);
	}

	public int insertReserchData1Each(Map<String, Object> insertVO) {
		// TODO Auto-generated method stub
		return researchMapper.insertReserchData1Each(insertVO);
	}

	// 난 데이터 저장(DB 테이블 insert)
	public int insertReserchData3Each(Map<String, Object> insertVO) {
		// TODO Auto-generated method stub
		return researchMapper.insertReserchData3Each(insertVO);
	}
		
	public List<EgovMap> sidoList(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return researchMapper.sidoList(paramMap);
	}
	
	public List<EgovMap> sigunList(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return researchMapper.sigunList(paramMap);
	}

	public List<EgovMap> chulInfoList(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return researchMapper.chulInfoList(paramMap);
	}
	public List<EgovMap> chulInfoList2(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return researchMapper.chulInfoList2(paramMap);
	}

	public EgovMap chulInfoEachVO(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return researchMapper.chulInfoEachVO(paramMap);
	}

	public EgovMap chulInfoEachVO2(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return researchMapper.chulInfoEachVO2(paramMap);
	}

	public List<EgovMap> chulInfoEachList(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return researchMapper.chulInfoEachList(paramMap);
	}

	public List<EgovMap> chulInfoEachList2(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return researchMapper.chulInfoEachList2(paramMap);
	}

	public List<EgovMap> chulInfoMapSidoList(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return researchMapper.chulInfoMapSidoList(paramMap);
	}

	public List<EgovMap> chulInfoMapSidoList2(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return researchMapper.chulInfoMapSidoList2(paramMap);
	}

	public List<EgovMap> chulInfoChart(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return researchMapper.chulInfoChart(paramMap);
	}

	public List<EgovMap> chulInfoChart2(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return researchMapper.chulInfoChart2(paramMap);
	}

	public List<EgovMap> pumMokList(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return researchMapper.pumMokList(paramMap);
	}

	public List<EgovMap> pumMokList2(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return researchMapper.pumMokList2(paramMap);
	}

	public List<EgovMap> prodInfoChartArea(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return researchMapper.prodInfoChartArea(paramMap);
	}

	public List<EgovMap> prodInfoChartArea2(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return researchMapper.prodInfoChartArea2(paramMap);
	}

	public List<EgovMap> prodInfoChart(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return researchMapper.prodInfoChart(paramMap);
	}

	public List<EgovMap> prodInfoChart2(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return researchMapper.prodInfoChart2(paramMap);
	}

	public List<EgovMap> mainChulInfoChart(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return researchMapper.mainChulInfoChart(paramMap);
	}

	public List<EgovMap> mainChulInfoChart2(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return researchMapper.mainChulInfoChart2(paramMap);
	}

	public List<EgovMap> mainPrdInfoChart(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return researchMapper.mainPrdInfoChart(paramMap);
	}

	public List<EgovMap> mainPrdInfoChart2(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return researchMapper.mainPrdInfoChart2(paramMap);
	}

	
	
	/*// 메뉴관리 List
	public List<EgovMap> selectMenuMgtList(){
		return menuMgtMapper.selectMenuMgtList();		
	}*/
	
	
	
}