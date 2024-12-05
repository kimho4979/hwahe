package com.fpminput.mntr.research.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("researchMapper")
public interface ResearchMapper {

	void deleteReserchData1(Map<String, Object> paramMap);
	
	void deleteReserchData2(Map<String, Object> paramMap);
	
	void deleteReserchData3(Map<String, Object> paramMap);

	int insertReserchData1(List<Map<String, Object>> insertList1);

	int insertReserchData2(List<Map<String, Object>> insertList2);

	int insertReserchData2Each(Map<String, Object> insertVO);

	int insertReserchData1Each(Map<String, Object> insertVO);
	
	int insertReserchData3Each(Map<String, Object> insertVO);

	List<EgovMap> sidoList(Map<String, Object> paramMap);

	List<EgovMap> sigunList(Map<String, Object> paramMap);

	List<EgovMap> chulInfoList(Map<String, Object> paramMap);

	List<EgovMap> chulInfoList2(Map<String, Object> paramMap);

	EgovMap chulInfoEachVO(Map<String, Object> paramMap);

	EgovMap chulInfoEachVO2(Map<String, Object> paramMap);

	List<EgovMap> chulInfoEachList(Map<String, Object> paramMap);

	List<EgovMap> chulInfoEachList2(Map<String, Object> paramMap);

	List<EgovMap> chulInfoMapSidoList(Map<String, Object> paramMap);

	List<EgovMap> chulInfoMapSidoList2(Map<String, Object> paramMap);

	List<EgovMap> chulInfoChart(Map<String, Object> paramMap);

	List<EgovMap> chulInfoChart2(Map<String, Object> paramMap);

	List<EgovMap> pumMokList(Map<String, Object> paramMap);

	List<EgovMap> pumMokList2(Map<String, Object> paramMap);

	List<EgovMap> prodInfoChartArea(Map<String, Object> paramMap);

	List<EgovMap> prodInfoChartArea2(Map<String, Object> paramMap);

	List<EgovMap> prodInfoChart(Map<String, Object> paramMap);

	List<EgovMap> prodInfoChart2(Map<String, Object> paramMap);

	List<EgovMap> mainChulInfoChart(Map<String, Object> paramMap);

	List<EgovMap> mainChulInfoChart2(Map<String, Object> paramMap);

	List<EgovMap> mainPrdInfoChart(Map<String, Object> paramMap);

	List<EgovMap> mainPrdInfoChart2(Map<String, Object> paramMap);
	
	// 종류 콤보
	List<EgovMap> searchCombo(Map<String, Object> paramMap);	

}