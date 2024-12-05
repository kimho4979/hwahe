package com.fpdisys.dist.report.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.report.mapper.ReportMapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class ReportService extends BaseService {
	
	@Autowired 
	ReportMapper reportMapper;
	
	@Autowired
	CommonExcel commonExcel;
	
	
	public List<EgovMap> selectDayPumAucList(Map<String, Object> pRequestParamMap) {
		return reportMapper.selectDayPumAucList(pRequestParamMap);
	}
	
	public void seletInsertAvgPreYearAt(Map<String, Object> pRequestParamMap) {
		reportMapper.seletInsertAvgPreYearAt(pRequestParamMap);
	}
	
	public void selectInsertPreDayAt(Map<String, Object> pRequestParamMap) {
		reportMapper.selectInsertPreDayAt(pRequestParamMap);
	}
	
	public void selectInsertAvgDayAt(Map<String, Object> pRequestParamMap) {
		reportMapper.selectInsertAvgDayAt(pRequestParamMap);
	}
	
	public void seletInsertAvgPreYearAll(Map<String, Object> pRequestParamMap) {
		reportMapper.seletInsertAvgPreYearAll(pRequestParamMap);
	}
	
	public void seletInsertAvgYearAt(Map<String, Object> pRequestParamMap) {
		reportMapper.seletInsertAvgYearAt(pRequestParamMap);
	}
	
	public void seletInsertAvgYearAll(Map<String, Object> pRequestParamMap) {
		reportMapper.seletInsertAvgYearAll(pRequestParamMap);
	}
	
	public List<String> selectCutFlowerCmpList(){
		return reportMapper.selectCutFlowerCmpList();
	}
	
	public String selectYsDay(Map<String, Object> pRequestParamMap){
		return reportMapper.selectYsDay(pRequestParamMap);
	}
	
	public List<EgovMap> selectMainFlowerAucAt(Map<String, Object> pRequestParamMap) {
		return reportMapper.selectMainFlowerAucAt(pRequestParamMap);
	}
	
	public List<EgovMap> selectMainFlowerAucAll(Map<String, Object> pRequestParamMap) {
		return reportMapper.selectMainFlowerAucAll(pRequestParamMap);
	}
		
	public String selectYesterDay(Map<String, Object> pRequestParamMap){
		return reportMapper.selectYesterDay(pRequestParamMap);
	}
//	
//	public void selectInToToDayAvgList(Map<String, Object> pRequestParamMap) {
//		reportMapper.selectInToToDayAvgList(pRequestParamMap);
//	}
//	
	

//	
//	public List<EgovMap> selectYDayAvgList(Map<String, Object> pRequestParamMap) {
//		return reportMapper.selectYDayAvgList(pRequestParamMap);
//	}
//	
//	public void updateYDayAvg(Map<String, Object> pRequestParamMap) {
//		reportMapper.updateYDayAvg(pRequestParamMap);
//	}
//	
//	public List<EgovMap> selectSCheckAvgList(Map<String, Object> pRequestParamMap) {
//		return reportMapper.selectSCheckAvgList(pRequestParamMap);
//	}
//	
//	public void updateSCheckAvg(Map<String, Object> pRequestParamMap) {
//		reportMapper.updateSCheckAvg(pRequestParamMap);
//	}
//
//	public List<EgovMap> selectPreMonthAvgList(Map<String, Object> pRequestParamMap) {
//		return reportMapper.selectPreMonthAvgList(pRequestParamMap);
//	}
//	
//	public void updatePreMAvg(Map<String, Object> pRequestParamMap) {
//		reportMapper.updatePreMAvg(pRequestParamMap);
//	}
//	
//	public List<EgovMap> selectPreYearAvgList(Map<String, Object> pRequestParamMap) {
//		return reportMapper.selectPreYearAvgList(pRequestParamMap);
//	}
//	
//	public void updatePreYAvg(Map<String, Object> pRequestParamMap) {
//		reportMapper.updatePreYAvg(pRequestParamMap);
//	}
//	
//	public List<EgovMap> selectCommonYearAvgList(Map<String, Object> pRequestParamMap) {
//		return reportMapper.selectCommonYearAvgList(pRequestParamMap);
//	}
//	
//	public void updateCommonAvg(Map<String, Object> pRequestParamMap) {
//		reportMapper.updateCommonAvg(pRequestParamMap);
//	}
//	
		
	public List<EgovMap> selectDayAucList(Map<String, Object> pRequestParamMap) {
		return reportMapper.selectDayAucList(pRequestParamMap);
	}
	
	public void selectDayAucListExcel(Map<String, Object> pRequestParamMap, HttpServletResponse response) {
		
		String filename =  "일별 경매실적";
		String pumName = "";
		String[] pumNameList = {"절화류", "장미", "국화", "백합", "리시안사스", "카네이션", "거베라", "수국", 
								"작약", "프리지아", "튜립", "안개", "금어초", "국화(대국)", "거베라(거베라)"};
		
		HSSFWorkbook workbook = commonExcel.createWorkbook();
		
		for(int i=0; i<15; i++) {
			
			pumName = pumNameList[i];
			HSSFSheet sheet = commonExcel.createSheet(workbook, pumName);
			
			pRequestParamMap.put("searchYear", pRequestParamMap.get("searchYear"));
			pRequestParamMap.put("pumName", pumName);
			
			setSheetDayAuc(reportMapper.selectDayAucList(pRequestParamMap), workbook, sheet, pRequestParamMap);

			commonExcel.autoSizeSheet(sheet);
		}
		
		commonExcel.download(response, workbook, filename);
	}
	
	public void setSheetDayAuc(List<EgovMap> list, HSSFWorkbook workbook, HSSFSheet sheet, Map<String, Object> requestParam) {
		
		logger.info("###");
		logger.info("일별 경매실적 엑셀다운");
		logger.info("###");
		
		if(list != null) {
			if(list.size() > 0) {
				
				HSSFRow title = sheet.createRow(0);
				title.createCell(0).setCellValue("경매일자");
				title.createCell(1).setCellValue("금년출하물량");
				title.createCell(2).setCellValue("금년거래물량");
				title.createCell(3).setCellValue("금년유찰물량");
				title.createCell(4).setCellValue("금년단가");
				title.createCell(5).setCellValue("전년출하물량");
				title.createCell(6).setCellValue("전년거래물량");
				title.createCell(7).setCellValue("전년유찰물량");
				title.createCell(8).setCellValue("전년단가");
				title.createCell(9).setCellValue("출하량증감");
				title.createCell(10).setCellValue("거래량증감");
				title.createCell(11).setCellValue("유찰증감");
				title.createCell(12).setCellValue("단가증감");
				title.createCell(13).setCellValue("평년출하물량");
				title.createCell(14).setCellValue("평년거래물량");
				title.createCell(15).setCellValue("평년유찰물량");
				title.createCell(16).setCellValue("평년단가");
				title.createCell(17).setCellValue("출하량증감");
				title.createCell(18).setCellValue("거래량증감");
				title.createCell(19).setCellValue("유찰증감");
				title.createCell(20).setCellValue("단가증감");
				
				for (int i=0; i<list.size(); i++) {
					
					HSSFRow row = sheet.createRow(i+1);
					
					row.createCell(0).setCellValue(String.valueOf(list.get(i).get("mmdd")));
					row.createCell(1).setCellValue(String.valueOf(list.get(i).get("totCnt")));
					row.createCell(2).setCellValue(String.valueOf(list.get(i).get("panCnt")));
					row.createCell(3).setCellValue(String.valueOf(list.get(i).get("yuchalCnt")));
					row.createCell(4).setCellValue(String.valueOf(list.get(i).get("avgAmt")));
					row.createCell(5).setCellValue(String.valueOf(list.get(i).get("preTotCnt")));
					row.createCell(6).setCellValue(String.valueOf(list.get(i).get("prePanCnt")));
					row.createCell(7).setCellValue(String.valueOf(list.get(i).get("preYuchalCnt")));
					row.createCell(8).setCellValue(String.valueOf(list.get(i).get("preAvgAmt")));
					row.createCell(9).setCellValue(String.valueOf(list.get(i).get("preTotCntPer")));
					row.createCell(10).setCellValue(String.valueOf(list.get(i).get("prePanCntPer")));
					row.createCell(11).setCellValue(String.valueOf(list.get(i).get("preYuchalCntPer")));
					row.createCell(12).setCellValue(String.valueOf(list.get(i).get("preAvgAmtPer")));
					row.createCell(13).setCellValue(String.valueOf(list.get(i).get("avgTotCnt")));
					row.createCell(14).setCellValue(String.valueOf(list.get(i).get("avgPanCnt")));
					row.createCell(15).setCellValue(String.valueOf(list.get(i).get("avgYuchalCnt")));
					row.createCell(16).setCellValue(String.valueOf(list.get(i).get("avgAvgAmt")));
					row.createCell(17).setCellValue(String.valueOf(list.get(i).get("avgTotCntPer")));
					row.createCell(18).setCellValue(String.valueOf(list.get(i).get("avgPanCntPer")));
					row.createCell(19).setCellValue(String.valueOf(list.get(i).get("avgYuchalCntPer")));
					row.createCell(20).setCellValue(String.valueOf(list.get(i).get("avgAvgAmtPer")));
				}
			}
		}
	}
	
	public void insertMainFlowerAucAt(Map<String, Object> pRequestParamMap) {
		reportMapper.insertMainFlowerAucAt(pRequestParamMap);
	}
	
	public void insertMainFlowerAucAll(Map<String, Object> pRequestParamMap) {
		reportMapper.insertMainFlowerAucAll(pRequestParamMap);
	}
	
	public List<EgovMap> selectMainFlowerAucExcel(Map<String, Object> pRequestParamMap) {
		return reportMapper.selectMainFlowerAucExcel(pRequestParamMap);
	}
	
	public void insertDayPumAucAt(Map<String, Object> pRequestParamMap) {
		reportMapper.insertDayPumAucAt(pRequestParamMap);
	}
	
	public List<EgovMap> selectDayPumAucExcel(Map<String, Object> pRequestParamMap) {
		return reportMapper.selectDayPumAucExcel(pRequestParamMap);
	}

	public List<EgovMap> selectDayPumAucExcel2023other(
			Map<String, Object> pRequestParamMap) {
		return reportMapper.selectDayPumAucExcel2023other(pRequestParamMap);
	}

	public List<EgovMap> selectDayPumAucExcel2023(
			Map<String, Object> pRequestParamMap) {
		return reportMapper.selectDayPumAucExcel2023(pRequestParamMap);
	}
}
