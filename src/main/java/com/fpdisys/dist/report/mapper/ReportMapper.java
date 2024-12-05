package com.fpdisys.dist.report.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("reportMapper")
public interface ReportMapper {
	
	List<EgovMap> selectDayPumAucList(Map<String, Object> pRequestParamMap);
	
	void seletInsertAvgPreYearAt(Map<String, Object> pRequestParamMap);
	
	void selectInsertPreDayAt(Map<String, Object> pRequestParamMap);
	
	void selectInsertAvgDayAt(Map<String, Object> pRequestParamMap);

	void seletInsertAvgPreYearAll(Map<String, Object> pRequestParamMap);
	
	void seletInsertAvgYearAt(Map<String, Object> pRequestParamMap);

	void seletInsertAvgYearAll(Map<String, Object> pRequestParamMap);
	
	List<String> selectCutFlowerCmpList();
	
	String selectYsDay(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectMainFlowerAucAt(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectMainFlowerAucAll(Map<String, Object> pRequestParamMap);
	
	String selectYesterDay(Map<String, Object> pRequestParamMap);
//	
//	void selectInToToDayAvgList(Map<String, Object> pRequestParamMap);
//	

//	
//	List<EgovMap> selectYDayAvgList(Map<String, Object> pRequestParamMap);
//	
//	void updateYDayAvg(Map<String, Object> pRequestParamMap);
//	
//	List<EgovMap> selectSCheckAvgList(Map<String, Object> pRequestParamMap);
//	
//	void updateSCheckAvg(Map<String, Object> pRequestParamMap);
//	
//	List<EgovMap> selectPreMonthAvgList(Map<String, Object> pRequestParamMap);
//	
//	void updatePreMAvg(Map<String, Object> pRequestParamMap);
//	
//	List<EgovMap> selectPreYearAvgList(Map<String, Object> pRequestParamMap);
//	
//	void updatePreYAvg(Map<String, Object> pRequestParamMap);
//	
//	List<EgovMap> selectCommonYearAvgList(Map<String, Object> pRequestParamMap);
//	
//	void updateCommonAvg(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectDayAucList(Map<String, Object> pRequestParamMap);
	
	void insertMainFlowerAucAt(Map<String, Object> pRequestParamMap);

	void insertMainFlowerAucAll(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectMainFlowerAucExcel(Map<String, Object> pRequestParamMap);
	
	void insertDayPumAucAt(Map<String, Object> pRequestParamMap);	
	
	List<EgovMap> selectDayPumAucExcel(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectDayPumAucExcel2023(Map<String, Object> pRequestParamMap);

	List<EgovMap> selectDayPumAucExcel2023other(Map<String, Object> pRequestParamMap);
	
	Integer selectTsaleHoliday(String pRequestParam);
	
	String selectTsaleHolidayBefore(Map<String, Object> pRequestParamMap);
	
	
}
