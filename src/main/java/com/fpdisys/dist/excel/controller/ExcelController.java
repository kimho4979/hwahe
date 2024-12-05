package com.fpdisys.dist.excel.controller;

import java.math.BigDecimal;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRichTextString;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.dist.apiCall.service.ApiCallService;
import com.fpdisys.dist.haa00.service.Haa00Service;
import com.fpdisys.dist.haa00_new.service.Haa00_newService;
import com.fpdisys.dist.haa01.domain.Haa01VO;
import com.fpdisys.dist.haa01.service.Haa01Service;
import com.fpdisys.dist.haa02.domain.Haa02ExcelVO;
import com.fpdisys.dist.haa02.service.Haa02Service;
import com.fpdisys.dist.haa03.domain.Haa03ExcelVO;
import com.fpdisys.dist.haa03.service.Haa03Service;
import com.fpdisys.dist.haa05.service.Haa05_Service;
import com.fpdisys.dist.hab01.domain.Hab01VO;
import com.fpdisys.dist.hab01.service.Hab01Service;
import com.fpdisys.dist.hab02.domain.Hab02VO;
import com.fpdisys.dist.hab02.service.Hab02Service;
import com.fpdisys.dist.hab03.domain.Hab03VO;
import com.fpdisys.dist.hab03.service.Hab03Service;
import com.fpdisys.dist.hab04.domain.Hab04VO;
import com.fpdisys.dist.hab04.service.Hab04Service;
import com.fpdisys.dist.hab05.domain.Hab05VO;
import com.fpdisys.dist.hab05.service.Hab05Service;
import com.fpdisys.dist.hab06.domain.Hab06VO;
import com.fpdisys.dist.hab06.service.Hab06Service;
import com.fpdisys.dist.hab07.domain.Hab07VO;
import com.fpdisys.dist.hab07.service.Hab07Service;
import com.fpdisys.dist.hab09.service.Hab09Service;
import com.fpdisys.dist.hab10.domain.Hab10VO;
import com.fpdisys.dist.hab10.service.Hab10Service;
import com.fpdisys.dist.hab11.service.Hab11Service;
import com.fpdisys.dist.hca01.domain.Hca01ExcelVO;
import com.fpdisys.dist.hca01.service.Hca01Service;
import com.fpdisys.dist.hca02.domain.Hca02ExcelVO;
import com.fpdisys.dist.hca02.service.Hca02Service;
import com.fpdisys.dist.hca03.domain.Hca03ExcelVO;
import com.fpdisys.dist.hca03.service.Hca03Service;
import com.fpdisys.dist.hdb01.domain.Hdb01VO;
import com.fpdisys.dist.hdb01.service.Hdb01Service;
import com.fpdisys.dist.hga01.domain.Hga01VO;
import com.fpdisys.dist.hga01.service.Hga01Service;
import com.fpdisys.dist.hga02.domain.Hga02VO;
import com.fpdisys.dist.hga02.service.Hga02Service;
import com.fpdisys.dist.hga03.domain.Hga03VO;
import com.fpdisys.dist.hga03.service.Hga03Service;
import com.fpdisys.dist.hga04.service.Hga04Service;
import com.fpdisys.dist.hga06_new.service.Hga06_newService;
import com.fpdisys.dist.hga08.service.Hga08_Service;
import com.fpdisys.dist.item.domain.AuctionItemVO;
import com.fpdisys.dist.item.service.AuctionItemService;
import com.fpdisys.dist.kind.domain.AuctionKindVO;
import com.fpdisys.dist.kind.service.AuctionKindService;
import com.fpdisys.dist.real.domain.RealVO;
import com.fpdisys.dist.real.service.RealService;
import com.fpdisys.dist.report.service.ReportService;
import com.fpdisys.dist.saleprice.domain.SalePriceVO;
import com.fpdisys.dist.saleprice.service.SalePriceService;
import com.fpdisys.dist.yuchal.domain.YuChalVO;
import com.fpdisys.dist.yuchal.service.copy.YuchalService;
import com.fpditrans.base.service.ExcelService;
import com.kati.service.KatiDataService;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;


@Controller
public class ExcelController extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());

	@Autowired
	protected MessageSource messageSource;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Autowired
	private ApiCallService apiCallService;

	@Autowired
	private RealService realService;

	@Autowired
	private Hab01Service hab01Service;

	@Autowired
	private YuchalService yuchalService;

	@Autowired
	Hab02Service hab02Service;

	@Autowired
	Hab03Service hab03Service;

	@Autowired
	Hab04Service hab04Service;

	@Autowired
	Hab05Service hab05Service;

	@Autowired
	Hab06Service hab06Service;

	@Autowired
	Hab07Service hab07Service;

	@Autowired
	Haa00Service haa00Service;	
	
	@Autowired
	Haa01Service haa01Service;

	@Autowired
	Haa02Service haa02Service;

	@Autowired
	Haa03Service haa03Service;

	@Autowired
	Hca01Service hca01Service;

	@Autowired
	Hca02Service hca02Service;

	@Autowired
	Hca03Service hca03Service;

	@Autowired
	SalePriceService salePriceService;

	@Autowired
	Hdb01Service hdb01Service;

	@Autowired
	Hga02Service hga02Service;

	@Autowired
	Hga01Service hga01Service;

	@Autowired
	Hga03Service hga03Service;
	
	@Autowired
	Hga04Service hga04Service;

	@Autowired
	AuctionItemService auctionItemService;

	@Autowired
	AuctionKindService auctionKindService;
	
	@Autowired
	Hab09Service hab09Service;
	
	@Autowired
	ReportService reportService;
	
	@Autowired
	KatiDataService katiDataService;
	
	@Autowired
	Hab10Service hab10Service;
	
	@Autowired
	Hga06_newService hga06_newService;
	
	@Autowired
	Hab11Service hab11Service;
	
	@Autowired
	Haa00_newService haa00_newService;
	
	@Autowired
	Haa05_Service haa05_Service;

	@Autowired
	private Hga08_Service hga08_Service;
	
	@Autowired
	ExcelService excelService;
	
	// URL
	@RequestMapping(value="/excel/excelDownLoad.do")
	public void excelDownLoad(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){

		String excelNm = (String)pRequestParamMap.get("excelNm");
		System.out.println("======================================================== "+excelNm);

		try {
			 // 워크북 생성
			Workbook wb = new HSSFWorkbook();
			Sheet sheet = wb.createSheet(excelNm);
			Row row = null;
			Cell cell = null;
			int rowNo = 0;

			//1.셀 스타일 및 폰트 설정
			CellStyle style = wb.createCellStyle();
			style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			CellStyle LineBreakStyle = wb.createCellStyle();
			LineBreakStyle.setWrapText(true);
			
			CellStyle blueStyle = wb.createCellStyle();
			blueStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			CellStyle redStyle = wb.createCellStyle();
			redStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			//폰트 색상 설정			
			HSSFFont blueFont = (HSSFFont) wb.createFont();
			blueFont.setColor(HSSFColor.BLUE.index);
			blueStyle.setFont(blueFont);
			
			
			HSSFFont RedFont = (HSSFFont) wb.createFont();
			RedFont.setColor(HSSFColor.RED.index);
			redStyle.setFont(RedFont);

			// 게시판 목록조회
			if(excelNm.equals("실시간경매정보")){
				List<RealVO> list = realService.getRealDataExcel(pRequestParamMap);

				// 헤더 생성
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue("품목");
				cell = row.createCell(1);
				cell.setCellValue("품종");
				cell = row.createCell(2);
				cell.setCellValue("등급");
				cell = row.createCell(3);
				cell.setCellValue("속수량");
				cell = row.createCell(4);
				cell.setCellValue("낙찰금액");
				cell = row.createCell(5);
				cell.setCellValue("낙찰시간");
				cell = row.createCell(6);
				cell.setCellValue("지역");

				// 데이터 부분 생성
				for(RealVO vo : list) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue(vo.getPumName());
					cell = row.createCell(1);
					cell.setCellValue(vo.getGoodName());
					cell = row.createCell(2);
					cell.setCellValue(vo.getLvName());
					cell = row.createCell(3);
					cell.setCellValue(vo.getQty());
					cell = row.createCell(4);
					cell.setCellValue(vo.getCost());
					cell = row.createCell(5);
					cell.setCellValue(vo.getNakTime());
					cell = row.createCell(6);
					cell.setCellValue(vo.getSanName());
				}

				// 컨텐츠 타입과 파일명 지정
				pResponse.setContentType("ms-vnd/excel");
				pResponse.setHeader("Content-Disposition", "attachment;filename="+new String((excelNm).getBytes("KSC5601"),"8859_1")+".xls");

			}else if(excelNm.equals("일자별경매정보")){
				List<Hab01VO> list = hab01Service.selectHab01Excel(pRequestParamMap);
				
				String cmpCd  = (String)pRequestParamMap.get("cmpCd");
				
				// 헤더 생성
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue("품목");
				cell = row.createCell(1);
				cell.setCellValue("품종");
				cell = row.createCell(2);
				cell.setCellValue("등급");
							
				
				if("0000000001".equals(cmpCd)){					
					cell = row.createCell(3);
					cell.setCellValue("속수량");
					cell = row.createCell(4);
					cell.setCellValue("최저단가");
					cell = row.createCell(5);
					cell.setCellValue("최고단가");
					cell = row.createCell(6);
					cell.setCellValue("평균단가");										
				}else if("1288202296".equals(cmpCd)){
					cell = row.createCell(3);
					cell.setCellValue("속수량");
					cell = row.createCell(4);
					cell.setCellValue("최저단가");
					cell = row.createCell(5);
					cell.setCellValue("최고단가");
					cell = row.createCell(6);
					cell.setCellValue("평균단가");
				}else{
					cell = row.createCell(3);
					cell.setCellValue("등급상세");
					cell = row.createCell(4);
					cell.setCellValue("속수량");
					cell = row.createCell(5);
					cell.setCellValue("최저단가");
					cell = row.createCell(6);
					cell.setCellValue("최고단가");
					cell = row.createCell(7);
					cell.setCellValue("평균단가");
				}			

				// 데이터 부분 생성
				for(Hab01VO vo : list) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue(vo.getPumName());
					cell = row.createCell(1);
					cell.setCellValue(vo.getGoodName());
					cell = row.createCell(2);
					cell.setCellValue(vo.getLvName());
					
					if("0000000001".equals(cmpCd)){						
						cell = row.createCell(3);
						cell.setCellValue(vo.getTotQty());
						cell = row.createCell(4);
						cell.setCellValue(vo.getMinAmt());
						cell = row.createCell(5);
						cell.setCellValue(vo.getMaxAmt());
						cell = row.createCell(6);
						cell.setCellValue(vo.getAvgAmt());											
					}else if("1288202296".equals(cmpCd)){
						cell = row.createCell(3);
						cell.setCellValue(vo.getTotQty());
						cell = row.createCell(4);
						cell.setCellValue(vo.getMinAmt());
						cell = row.createCell(5);
						cell.setCellValue(vo.getMaxAmt());
						cell = row.createCell(6);
						cell.setCellValue(vo.getAvgAmt());
					}else{
						cell = row.createCell(3);
						cell.setCellValue(vo.getLvEtcNm());
						cell = row.createCell(4);
						cell.setCellValue(vo.getTotQty());
						cell = row.createCell(5);
						cell.setCellValue(vo.getMinAmt());
						cell = row.createCell(6);
						cell.setCellValue(vo.getMaxAmt());
						cell = row.createCell(7);
						cell.setCellValue(vo.getAvgAmt());
					}					
				}

				// 컨텐츠 타입과 파일명 지정
				pResponse.setContentType("ms-vnd/excel");
				pResponse.setHeader("Content-Disposition", "attachment;filename="+new String((excelNm).getBytes("KSC5601"),"8859_1")+".xls");

			}else if(excelNm.equals("일자별유찰현황")){
				List<YuChalVO> list = yuchalService.getYuchalDataExcel(pRequestParamMap);

				// 헤더 생성
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue("품목");
				cell = row.createCell(1);
				cell.setCellValue("속수량");
				cell = row.createCell(2);
				cell.setCellValue("유찰량");
				cell = row.createCell(3);
				cell.setCellValue("유찰률(%)");

				// 데이터 부분 생성
				for(YuChalVO vo : list) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue(vo.getMokName());
					cell = row.createCell(1);
					cell.setCellValue(vo.getTotCnt());
					cell = row.createCell(2);
					cell.setCellValue(vo.getYuchalCnt());
					cell = row.createCell(3);
					cell.setCellValue(vo.getYuchalPer());
				}

				// 컨텐츠 타입과 파일명 지정
				pResponse.setContentType("ms-vnd/excel");
				pResponse.setHeader("Content-Disposition", "attachment;filename="+new String((excelNm).getBytes("KSC5601"),"8859_1")+".xls");

			}else if(excelNm.equals("월별경매정보")){
				List<Hab02VO> list = hab02Service.selectHab02Excel(pRequestParamMap);

				// 헤더 생성
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue("품목");
				cell = row.createCell(1);
				cell.setCellValue("품종");
				cell = row.createCell(2);
				cell.setCellValue("등급");
				cell = row.createCell(3);
				cell.setCellValue("속수량");
				cell = row.createCell(4);
				cell.setCellValue("최저단가");
				cell = row.createCell(5);
				cell.setCellValue("최고단가");
				cell = row.createCell(6);
				cell.setCellValue("평균단가");

				// 데이터 부분 생성
				for(Hab02VO vo : list) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue(vo.getPumName());
					cell = row.createCell(1);
					cell.setCellValue(vo.getGoodName());
					cell = row.createCell(2);
					cell.setCellValue(vo.getLvName());
					cell = row.createCell(3);
					cell.setCellValue(vo.getTotQty());
					cell = row.createCell(4);
					cell.setCellValue(vo.getMinAmt());
					cell = row.createCell(5);
					cell.setCellValue(vo.getMaxAmt());
					cell = row.createCell(6);
					cell.setCellValue(vo.getAvgAmt());
				}

				// 컨텐츠 타입과 파일명 지정
				pResponse.setContentType("ms-vnd/excel");
				pResponse.setHeader("Content-Disposition", "attachment;filename="+new String((excelNm).getBytes("KSC5601"),"8859_1")+".xls");

			}else if(excelNm.equals("경락단가내역")){
				String choose  = (String)pRequestParamMap.get("choose");
				
				List<Hab03VO> list;
								
				if("1".equals(choose)){
					list = hab03Service.selectHab03(pRequestParamMap);
				}else{
					list = hab03Service.selectPumJong(pRequestParamMap);					
				}
				
				// 헤더 생성
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue("품목");
				cell = row.createCell(1);
				cell.setCellValue("구분");
				cell = row.createCell(2);
				cell.setCellValue("1월");
				cell = row.createCell(3);
				cell.setCellValue("2월");
				cell = row.createCell(4);
				cell.setCellValue("3월");
				cell = row.createCell(5);
				cell.setCellValue("4월");
				cell = row.createCell(6);
				cell.setCellValue("5월");
				cell = row.createCell(7);
				cell.setCellValue("6월");
				cell = row.createCell(8);
				cell.setCellValue("7월");
				cell = row.createCell(9);
				cell.setCellValue("8월");
				cell = row.createCell(10);
				cell.setCellValue("9월");
				cell = row.createCell(11);
				cell.setCellValue("10월");
				cell = row.createCell(12);
				cell.setCellValue("11월");
				cell = row.createCell(13);
				cell.setCellValue("12월");

				// 데이터 부분 생성
				for(Hab03VO vo : list) {
					for(int i=0; i<3; i++){
						// 나머지가 0, 1, 2 = 최고, 최저, 평균

						row = sheet.createRow(rowNo);

						if(i%3==0){
							cell = row.createCell(0);
							if("1".equals(choose)){
								cell.setCellValue(vo.getPumName());
							}else{
								cell.setCellStyle(LineBreakStyle);
								cell.setCellValue(vo.getPumName()+"\n("+vo.getGoodName()+")");
							}
							
							cell = row.createCell(1);
							cell.setCellValue("최고");
							cell = row.createCell(2);
							cell.setCellValue(vo.getMaxamt1());
							cell = row.createCell(3);
							cell.setCellValue(vo.getMaxamt2());
							cell = row.createCell(4);
							cell.setCellValue(vo.getMaxamt3());
							cell = row.createCell(5);
							cell.setCellValue(vo.getMaxamt4());
							cell = row.createCell(6);
							cell.setCellValue(vo.getMaxamt5());
							cell = row.createCell(7);
							cell.setCellValue(vo.getMaxamt6());
							cell = row.createCell(8);
							cell.setCellValue(vo.getMaxamt7());
							cell = row.createCell(9);
							cell.setCellValue(vo.getMaxamt8());
							cell = row.createCell(10);
							cell.setCellValue(vo.getMaxamt9());
							cell = row.createCell(11);
							cell.setCellValue(vo.getMaxamt10());
							cell = row.createCell(12);
							cell.setCellValue(vo.getMaxamt11());
							cell = row.createCell(13);
							cell.setCellValue(vo.getMaxamt12());

							sheet.addMergedRegion(new CellRangeAddress(rowNo,rowNo+2,0,0));
						}else if(i%3==1){
							cell = row.createCell(0);
							if("1".equals(choose)){								
								cell.setCellValue(vo.getPumName());
							}else{
								cell.setCellStyle(LineBreakStyle);
								cell.setCellValue(vo.getPumName()+"\n("+vo.getGoodName()+")");
							}
							
							cell = row.createCell(1);
							cell.setCellValue("최저");
							cell = row.createCell(2);
							cell.setCellValue(vo.getMinamt1());
							cell = row.createCell(3);
							cell.setCellValue(vo.getMinamt2());
							cell = row.createCell(4);
							cell.setCellValue(vo.getMinamt3());
							cell = row.createCell(5);
							cell.setCellValue(vo.getMinamt4());
							cell = row.createCell(6);
							cell.setCellValue(vo.getMinamt5());
							cell = row.createCell(7);
							cell.setCellValue(vo.getMinamt6());
							cell = row.createCell(8);
							cell.setCellValue(vo.getMinamt7());
							cell = row.createCell(9);
							cell.setCellValue(vo.getMinamt8());
							cell = row.createCell(10);
							cell.setCellValue(vo.getMinamt9());
							cell = row.createCell(11);
							cell.setCellValue(vo.getMinamt10());
							cell = row.createCell(12);
							cell.setCellValue(vo.getMinamt11());
							cell = row.createCell(13);
							cell.setCellValue(vo.getMinamt12());
						}else if(i%3==2){
							cell = row.createCell(0);
							if("1".equals(choose)){								
								cell.setCellValue(vo.getPumName());
							}else{
								cell.setCellStyle(LineBreakStyle);
								cell.setCellValue(vo.getPumName()+"\n("+vo.getGoodName()+")");
							}							
							
							cell = row.createCell(1);
							cell.setCellValue("평균");
							cell = row.createCell(2);
							cell.setCellValue(vo.getAvgamt1());
							cell = row.createCell(3);
							cell.setCellValue(vo.getAvgamt2());
							cell = row.createCell(4);
							cell.setCellValue(vo.getAvgamt3());
							cell = row.createCell(5);
							cell.setCellValue(vo.getAvgamt4());
							cell = row.createCell(6);
							cell.setCellValue(vo.getAvgamt5());
							cell = row.createCell(7);
							cell.setCellValue(vo.getAvgamt6());
							cell = row.createCell(8);
							cell.setCellValue(vo.getAvgamt7());
							cell = row.createCell(9);
							cell.setCellValue(vo.getAvgamt8());
							cell = row.createCell(10);
							cell.setCellValue(vo.getAvgamt9());
							cell = row.createCell(11);
							cell.setCellValue(vo.getAvgamt10());
							cell = row.createCell(12);
							cell.setCellValue(vo.getAvgamt11());
							cell = row.createCell(13);
							cell.setCellValue(vo.getAvgamt12());
						}
						rowNo++;
					}
				}

				// 컨텐츠 타입과 파일명 지정
				pResponse.setContentType("ms-vnd/excel");
				pResponse.setHeader("Content-Disposition", "attachment;filename="+new String((excelNm).getBytes("KSC5601"),"8859_1")+".xls");

			}else if(excelNm.equals("품목별총거래정보")){
				List<Hab04VO> list = hab04Service.selectHab04Excel(pRequestParamMap);

				// 헤더 생성
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue("품목명");
				cell = row.createCell(1);
				cell.setCellValue("거래량");
				cell = row.createCell(2);
				cell.setCellValue("최저단가");
				cell = row.createCell(3);
				cell.setCellValue("최고단가");
				cell = row.createCell(4);
				cell.setCellValue("평균단가");

				// 데이터 부분 생성
				for(Hab04VO vo : list) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue(vo.getPumName());
					cell = row.createCell(1);
					cell.setCellValue(vo.getTotQty());
					cell = row.createCell(2);
					cell.setCellValue(vo.getMinAmt());
					cell = row.createCell(3);
					cell.setCellValue(vo.getMaxAmt());
					cell = row.createCell(4);
					cell.setCellValue(vo.getAvgAmt());
				}

				// 컨텐츠 타입과 파일명 지정
				pResponse.setContentType("ms-vnd/excel");
				pResponse.setHeader("Content-Disposition", "attachment;filename="+new String((excelNm).getBytes("KSC5601"),"8859_1")+".xls");

			}else if(excelNm.equals("품종별총거래정보")){
				List<Hab05VO> list = hab05Service.selectHab05Excel(pRequestParamMap);

				// 헤더 생성
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue("품목명");
				cell = row.createCell(1);
				cell.setCellValue("품종명");
				cell = row.createCell(2);
				cell.setCellValue("거래량");
				cell = row.createCell(3);
				cell.setCellValue("최저단가");
				cell = row.createCell(4);
				cell.setCellValue("최고단가");
				cell = row.createCell(5);
				cell.setCellValue("평균단가");

				// 데이터 부분 생성
				for(Hab05VO vo : list) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue(vo.getPumName());
					cell = row.createCell(1);
					cell.setCellValue(vo.getGoodName());
					cell = row.createCell(2);
					cell.setCellValue(vo.getTotQty());
					cell = row.createCell(3);
					cell.setCellValue(vo.getMinAmt());
					cell = row.createCell(4);
					cell.setCellValue(vo.getMaxAmt());
					cell = row.createCell(5);
					cell.setCellValue(vo.getAvgAmt());
				}

				// 컨텐츠 타입과 파일명 지정
				pResponse.setContentType("ms-vnd/excel");
				pResponse.setHeader("Content-Disposition", "attachment;filename="+new String((excelNm).getBytes("KSC5601"),"8859_1")+".xls");

			}else if(excelNm.equals("월별전년대비실적")){
				List<Hab06VO> list = hab06Service.selectHab06Excel(pRequestParamMap);
				List<Hab06VO> listHap = hab06Service.selectHab06HapExcel(pRequestParamMap);

				// 헤더 생성
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue("월별일자");
				cell = row.createCell(1);
				cell.setCellValue("전년(거래량)");
				cell = row.createCell(2);
				cell.setCellValue("금년(거래량)");
				cell = row.createCell(3);
				cell.setCellValue("작년대비(거래량)");
				cell = row.createCell(4);
				cell.setCellValue("전년(거래금액)");
				cell = row.createCell(5);
				cell.setCellValue("금년(거래금액)");
				cell = row.createCell(6);
				cell.setCellValue("작년대비(거래금액)");

								
				// 데이터 부분 생성
				for(Hab06VO vo : list) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue(vo.getSaleMonth());
					cell = row.createCell(1);
					cell.setCellValue(vo.getOldTotQty());					
					cell = row.createCell(2);
					cell.setCellValue(vo.getTotQty());
					
					cell = row.createCell(3);
					
					if("blue".equals(vo.getPerQtyCol())){						
						cell.setCellStyle(blueStyle);
						cell.setCellValue(vo.getPerTotQty()+"% ▼");
					}else if("red".equals(vo.getPerQtyCol())){
						cell.setCellStyle(redStyle);
						cell.setCellValue(vo.getPerTotQty()+"% ▲");
					}else{
						cell.setCellValue(vo.getPerTotQty()+"% ");
					}					
					
					cell = row.createCell(4);
					cell.setCellValue(vo.getOldTotAmt());					
					cell = row.createCell(5);
					cell.setCellValue(vo.getTotAmt());
					
					cell = row.createCell(6);
					
					if("blue".equals(vo.getPerAmtCol())){
						cell.setCellStyle(blueStyle);
						cell.setCellValue(vo.getPerTotAmt()+"% ▼");
					}else if("red".equals(vo.getPerAmtCol())){
						cell.setCellStyle(redStyle);
						cell.setCellValue(vo.getPerTotAmt()+"% ▲");
					}else{
						cell.setCellValue(vo.getPerTotAmt()+"% ");
					}	
					
				}

				for(Hab06VO vo : listHap) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue("합계");
					cell = row.createCell(1);
					cell.setCellValue(vo.getOldTotQty());
					cell = row.createCell(2);
					cell.setCellValue(vo.getTotQty());
					
					cell = row.createCell(3);
					
					if("blue".equals(vo.getPerQtyCol())){
						cell.setCellStyle(blueStyle);
						cell.setCellValue(vo.getPerTotQty()+"% ▼");
					}else if("red".equals(vo.getPerQtyCol())){
						cell.setCellStyle(redStyle);
						cell.setCellValue(vo.getPerTotQty()+"% ▲");
					}else{
						cell.setCellValue(vo.getPerTotQty()+"% ");
					}	
					
					cell = row.createCell(4);
					cell.setCellValue(vo.getOldTotAmt());
					cell = row.createCell(5);
					cell.setCellValue(vo.getTotAmt());
					
					cell = row.createCell(6);
					
					if("blue".equals(vo.getPerAmtCol())){
						cell.setCellStyle(blueStyle);
						cell.setCellValue(vo.getPerTotAmt()+"% ▼");
					}else if("red".equals(vo.getPerAmtCol())){
						cell.setCellStyle(redStyle);
						cell.setCellValue(vo.getPerTotAmt()+"% ▲");
					}else{
						cell.setCellValue(vo.getPerTotAmt()+"% ");
					}
				}


				// 컨텐츠 타입과 파일명 지정
				pResponse.setContentType("ms-vnd/excel");
				pResponse.setHeader("Content-Disposition", "attachment;filename="+new String((excelNm).getBytes("KSC5601"),"8859_1")+".xls");

			}else if(excelNm.equals("지역별월별출하실적")){
				List<Hab07VO> list = hab07Service.selectHab07Excel(pRequestParamMap);

				// 헤더 생성
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue("지역");
				cell = row.createCell(1);
				cell.setCellValue("품목명");
				cell = row.createCell(2);
				cell.setCellValue("출하금액");
				cell = row.createCell(3);
				cell.setCellValue("출하물량");

				// 데이터 부분 생성
				for(Hab07VO vo : list) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue(vo.getSanCdNm());
					cell = row.createCell(1);
					cell.setCellValue(vo.getPumName());
					cell = row.createCell(2);
					cell.setCellValue(vo.getTotAmt());
					cell = row.createCell(3);
					cell.setCellValue(vo.getTotQty());
				}

				// 컨텐츠 타입과 파일명 지정
				pResponse.setContentType("ms-vnd/excel");
				pResponse.setHeader("Content-Disposition", "attachment;filename="+new String((excelNm).getBytes("KSC5601"),"8859_1")+".xls");

			}else if(excelNm.equals("경매기록부")){
				List<Haa01VO> list = null;

				// 헤더 생성
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue("구분");
				cell = row.createCell(1);
				cell.setCellValue("주요품목");
				cell = row.createCell(2);
				cell.setCellValue("주요품종");
				cell = row.createCell(3);
				cell.setCellValue("거래량");
				cell = row.createCell(4);
				cell.setCellValue("평균단가");
				cell = row.createCell(5);
				cell.setCellValue("최저단가");
				cell = row.createCell(6);
				cell.setCellValue("최고단가");

				// 절화
				pRequestParamMap.put("flowerGubun", "1");
				String strText = "시베리아,비탈,백선,포드,카시오피아,거베라,거베라1";
				String[] flowerText = strText.split(",");
				pRequestParamMap.put("flowerText", flowerText);
				list = haa01Service.selectListFlowerExcel(pRequestParamMap);
				// 데이터 부분 생성
				for(Haa01VO vo : list) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue("절화");
					cell = row.createCell(1);
					cell.setCellValue(vo.getPumName());
					cell = row.createCell(2);
					cell.setCellValue(vo.getGoodName());
					cell = row.createCell(3);
					cell.setCellValue(vo.getTotQty());
					cell = row.createCell(4);
					cell.setCellValue(vo.getAvgAmt());
					cell = row.createCell(5);
					cell.setCellValue(vo.getMinAmt());
					cell = row.createCell(6);
					cell.setCellValue(vo.getMaxAmt());
				}

				// 난
				pRequestParamMap.put("flowerGubun", "3");
				strText = "만천홍,엘사쿨,골드스타,철골소심,청금";
				flowerText = strText.split(",");
				pRequestParamMap.put("flowerText", flowerText);
				list = haa01Service.selectListFlowerExcel(pRequestParamMap);
				// 데이터 부분 생성
				for(Haa01VO vo : list) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue("난");
					cell = row.createCell(1);
					cell.setCellValue(vo.getPumName());
					cell = row.createCell(2);
					cell.setCellValue(vo.getGoodName());
					cell = row.createCell(3);
					cell.setCellValue(vo.getTotQty());
					cell = row.createCell(4);
					cell.setCellValue(vo.getAvgAmt());
					cell = row.createCell(5);
					cell.setCellValue(vo.getMinAmt());
					cell = row.createCell(6);
					cell.setCellValue(vo.getMaxAmt());
				}

				// 관엽
				pRequestParamMap.put("flowerGubun", "2");
				strText = "카랑코에3.5\", 베고니아6\",시클라멘5\",알라바마6\",미니장미3.5\",미니아이비3.5\",카랑코에(일반),아이비(일반),카랑코에,베고니아,안스륨(알라바마),미니장미,아이비(드림캣츠)";
				flowerText = strText.split(",");
				pRequestParamMap.put("flowerText", flowerText);
				list = haa01Service.selectListFlowerExcel(pRequestParamMap);
				// 데이터 부분 생성
				for(Haa01VO vo : list) {
					row = sheet.createRow(rowNo++);
					//sheet.addMergedRegion(new CellRangeAddress(14,6,0,0)); //열시작, 열종료, 행시작, 행종료 (자바배열과 같이 0부터 시작)
					cell = row.createCell(0);
					cell.setCellValue("관엽");
					cell = row.createCell(1);
					cell.setCellValue(vo.getPumName());
					cell = row.createCell(2);
					cell.setCellValue(vo.getGoodName());
					cell = row.createCell(3);
					cell.setCellValue(vo.getTotQty());
					cell = row.createCell(4);
					cell.setCellValue(vo.getAvgAmt());
					cell = row.createCell(5);
					cell.setCellValue(vo.getMinAmt());
					cell = row.createCell(6);
					cell.setCellValue(vo.getMaxAmt());
				}

				// 춘란
				pRequestParamMap.put("flowerGubun", "4");
				pRequestParamMap.put("flowerText", "");
				list = haa01Service.selectListFlowerExcel(pRequestParamMap);
				// 데이터 부분 생성
				for(Haa01VO vo : list) {
					row = sheet.createRow(rowNo++);
					//sheet.addMergedRegion(new CellRangeAddress(20,6,0,0)); //열시작, 열종료, 행시작, 행종료 (자바배열과 같이 0부터 시작)
					cell = row.createCell(0);
					cell.setCellValue("춘란");
					cell = row.createCell(1);
					cell.setCellValue(vo.getPumName());
					cell = row.createCell(2);
					cell.setCellValue(vo.getGoodName());
					cell = row.createCell(3);
					cell.setCellValue(vo.getTotQty());
					cell = row.createCell(4);
					cell.setCellValue(vo.getAvgAmt());
					cell = row.createCell(5);
					cell.setCellValue(vo.getMinAmt());
					cell = row.createCell(6);
					cell.setCellValue(vo.getMaxAmt());
				}

				// 컨텐츠 타입과 파일명 지정
				pResponse.setContentType("ms-vnd/excel");
				pResponse.setHeader("Content-Disposition", "attachment;filename="+new String((excelNm).getBytes("KSC5601"),"8859_1")+".xls");

			}else if(excelNm.equals("품목경락가격")){
				List<Haa02ExcelVO> list = null;

				// 헤더 생성
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue("구분");
				cell = row.createCell(1);
				cell.setCellValue("날짜");
				cell = row.createCell(2);
				cell.setCellValue("품목명");
				cell = row.createCell(3);
				cell.setCellValue("속수량");
				cell = row.createCell(4);
				cell.setCellValue("최저단가");
				cell = row.createCell(5);
				cell.setCellValue("최고단가");
				cell = row.createCell(6);
				cell.setCellValue("평균단가");

				// aT화훼공판장
				String searchProductGubun =pRequestParamMap.get("flowerCd").toString();
				pRequestParamMap.put("searchProductGubun", searchProductGubun);
				String searchDateGubun =pRequestParamMap.get("dateGubn").toString();
				pRequestParamMap.put("cmpCd", "0000000001");

			 	//날짜검색구분 (1 : 경매일자 1개월  2: 경매일자 6개월 3: 경매일자 1년)
			 	if(pRequestParamMap.get("dateGubn")!= null){
			 		if("1".equals(searchDateGubun)){
			 			int searchRegDtStart = -1;
			 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
			 		}else if("6".equals(searchDateGubun)){
			 			int searchRegDtStart = -6;

			 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
			 		}else if("12".equals(searchDateGubun)){
			 			int searchRegDtStart = -12;

			 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
			 		}
				}else{
					int searchRegDtStart = -1;
					pRequestParamMap.put("searchRegDt", searchRegDtStart);
					pRequestParamMap.put("searchDateGubun", "1");
				}
				list = haa02Service.selectListMonthExcel(pRequestParamMap);
				// 데이터 부분 생성
				for(Haa02ExcelVO vo : list) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue("aT화훼공판장");
					cell = row.createCell(1);
					cell.setCellValue(vo.getSaleDate());
					cell = row.createCell(2);
					cell.setCellValue(vo.getPumName());
					cell = row.createCell(3);
					cell.setCellValue(vo.getTotQty());
					cell = row.createCell(4);
					cell.setCellValue(vo.getMinAmt());
					cell = row.createCell(5);
					cell.setCellValue(vo.getMaxAmt());
					cell = row.createCell(6);
					cell.setCellValue(vo.getAvgAmt());
				}

				// 부산화훼공판장
				pRequestParamMap.put("cmpCd", "1508500020");

			 	//날짜검색구분 (1 : 경매일자 1개월  2: 경매일자 6개월 3: 경매일자 1년)
			 	if(pRequestParamMap.get("dateGubn")!= null){
			 		if("1".equals(searchDateGubun)){
			 			int searchRegDtStart = -1;
			 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
			 		}else if("6".equals(searchDateGubun)){
			 			int searchRegDtStart = -6;

			 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
			 		}else if("12".equals(searchDateGubun)){
			 			int searchRegDtStart = -12;

			 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
			 		}
				}else{
					int searchRegDtStart = -1;
					pRequestParamMap.put("searchRegDt", searchRegDtStart);
					pRequestParamMap.put("searchDateGubun", "1");
				}
				list = haa02Service.selectListMonthExcel(pRequestParamMap);
				// 데이터 부분 생성
				for(Haa02ExcelVO vo : list) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue("부산화훼공판장");
					cell = row.createCell(1);
					cell.setCellValue(vo.getSaleDate());
					cell = row.createCell(2);
					cell.setCellValue(vo.getPumName());
					cell = row.createCell(3);
					cell.setCellValue(vo.getTotQty());
					cell = row.createCell(4);
					cell.setCellValue(vo.getMinAmt());
					cell = row.createCell(5);
					cell.setCellValue(vo.getMaxAmt());
					cell = row.createCell(6);
					cell.setCellValue(vo.getAvgAmt());
				}

				// 부산경남화훼공판장
				pRequestParamMap.put("cmpCd", "6068207466");

			 	//날짜검색구분 (1 : 경매일자 1개월  2: 경매일자 6개월 3: 경매일자 1년)
			 	if(pRequestParamMap.get("dateGubn")!= null){
			 		if("1".equals(searchDateGubun)){
			 			int searchRegDtStart = -1;
			 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
			 		}else if("6".equals(searchDateGubun)){
			 			int searchRegDtStart = -6;

			 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
			 		}else if("12".equals(searchDateGubun)){
			 			int searchRegDtStart = -12;

			 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
			 		}
				}else{
					int searchRegDtStart = -1;
					pRequestParamMap.put("searchRegDt", searchRegDtStart);
					pRequestParamMap.put("searchDateGubun", "1");
				}
				list = haa02Service.selectListMonthExcel(pRequestParamMap);
				// 데이터 부분 생성
				for(Haa02ExcelVO vo : list) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue("부산경남화훼공판장");
					cell = row.createCell(1);
					cell.setCellValue(vo.getSaleDate());
					cell = row.createCell(2);
					cell.setCellValue(vo.getPumName());
					cell = row.createCell(3);
					cell.setCellValue(vo.getTotQty());
					cell = row.createCell(4);
					cell.setCellValue(vo.getMinAmt());
					cell = row.createCell(5);
					cell.setCellValue(vo.getMaxAmt());
					cell = row.createCell(6);
					cell.setCellValue(vo.getAvgAmt());
				}

				// 광주원예농협
				pRequestParamMap.put("cmpCd", "4108212335");

			 	//날짜검색구분 (1 : 경매일자 1개월  2: 경매일자 6개월 3: 경매일자 1년)
			 	if(pRequestParamMap.get("dateGubn")!= null){
			 		if("1".equals(searchDateGubun)){
			 			int searchRegDtStart = -1;
			 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
			 		}else if("6".equals(searchDateGubun)){
			 			int searchRegDtStart = -6;

			 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
			 		}else if("12".equals(searchDateGubun)){
			 			int searchRegDtStart = -12;

			 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
			 		}
				}else{
					int searchRegDtStart = -1;
					pRequestParamMap.put("searchRegDt", searchRegDtStart);
					pRequestParamMap.put("searchDateGubun", "1");
				}
				list = haa02Service.selectListMonthExcel(pRequestParamMap);
				// 데이터 부분 생성
				for(Haa02ExcelVO vo : list) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue("광주원예농협");
					cell = row.createCell(1);
					cell.setCellValue(vo.getSaleDate());
					cell = row.createCell(2);
					cell.setCellValue(vo.getPumName());
					cell = row.createCell(3);
					cell.setCellValue(vo.getTotQty());
					cell = row.createCell(4);
					cell.setCellValue(vo.getMinAmt());
					cell = row.createCell(5);
					cell.setCellValue(vo.getMaxAmt());
					cell = row.createCell(6);
					cell.setCellValue(vo.getAvgAmt());
				}

				// 한국화훼농협(음성)
				pRequestParamMap.put("cmpCd", "3848200087");

			 	//날짜검색구분 (1 : 경매일자 1개월  2: 경매일자 6개월 3: 경매일자 1년)
			 	if(pRequestParamMap.get("dateGubn")!= null){
			 		if("1".equals(searchDateGubun)){
			 			int searchRegDtStart = -1;
			 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
			 		}else if("6".equals(searchDateGubun)){
			 			int searchRegDtStart = -6;

			 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
			 		}else if("12".equals(searchDateGubun)){
			 			int searchRegDtStart = -12;

			 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
			 		}
				}else{
					int searchRegDtStart = -1;
					pRequestParamMap.put("searchRegDt", searchRegDtStart);
					pRequestParamMap.put("searchDateGubun", "1");
				}
				list = haa02Service.selectListMonthExcel(pRequestParamMap);
				// 데이터 부분 생성
				for(Haa02ExcelVO vo : list) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue("한국화훼농협(음성)");
					cell = row.createCell(1);
					cell.setCellValue(vo.getSaleDate());
					cell = row.createCell(2);
					cell.setCellValue(vo.getPumName());
					cell = row.createCell(3);
					cell.setCellValue(vo.getTotQty());
					cell = row.createCell(4);
					cell.setCellValue(vo.getMinAmt());
					cell = row.createCell(5);
					cell.setCellValue(vo.getMaxAmt());
					cell = row.createCell(6);
					cell.setCellValue(vo.getAvgAmt());
				}

				// 한국화훼농협(본점)
				pRequestParamMap.put("cmpCd", "1288202296");

			 	//날짜검색구분 (1 : 경매일자 1개월  2: 경매일자 6개월 3: 경매일자 1년)
			 	if(pRequestParamMap.get("dateGubn")!= null){
			 		if("1".equals(searchDateGubun)){
			 			int searchRegDtStart = -1;
			 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
			 		}else if("6".equals(searchDateGubun)){
			 			int searchRegDtStart = -6;

			 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
			 		}else if("12".equals(searchDateGubun)){
			 			int searchRegDtStart = -12;

			 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
			 		}
				}else{
					int searchRegDtStart = -1;
					pRequestParamMap.put("searchRegDt", searchRegDtStart);
					pRequestParamMap.put("searchDateGubun", "1");
				}
				list = haa02Service.selectListMonthExcel(pRequestParamMap);
				// 데이터 부분 생성
				for(Haa02ExcelVO vo : list) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue("한국화훼농협(본점)");
					cell = row.createCell(1);
					cell.setCellValue(vo.getSaleDate());
					cell = row.createCell(2);
					cell.setCellValue(vo.getPumName());
					cell = row.createCell(3);
					cell.setCellValue(vo.getTotQty());
					cell = row.createCell(4);
					cell.setCellValue(vo.getMinAmt());
					cell = row.createCell(5);
					cell.setCellValue(vo.getMaxAmt());
					cell = row.createCell(6);
					cell.setCellValue(vo.getAvgAmt());
				}

				// 컨텐츠 타입과 파일명 지정
				pResponse.setContentType("ms-vnd/excel");
				pResponse.setHeader("Content-Disposition", "attachment;filename="+new String((excelNm).getBytes("KSC5601"),"8859_1")+".xls");

			}else if(excelNm.equals("품종경락가격")){
				List<Haa03ExcelVO> list = null;

				// 헤더 생성
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue("구분");
				cell = row.createCell(1);
				cell.setCellValue("날짜");
				cell = row.createCell(2);
				cell.setCellValue("품목명");
				cell = row.createCell(3);
				cell.setCellValue("품종명");
				cell = row.createCell(4);
				cell.setCellValue("속수량");
				cell = row.createCell(5);
				cell.setCellValue("최저단가");
				cell = row.createCell(6);
				cell.setCellValue("최고단가");
				cell = row.createCell(7);
				cell.setCellValue("평균단가");

				// aT화훼공판장
				String searchProductGubun =pRequestParamMap.get("flowerCd").toString();
				pRequestParamMap.put("searchProductGubun", searchProductGubun);
				String searchDateGubun =pRequestParamMap.get("dateGubn").toString();
				pRequestParamMap.put("cmpCd", "0000000001");

			 	//날짜검색구분 (1 : 경매일자 1개월  2: 경매일자 6개월 3: 경매일자 1년)
			 	if(pRequestParamMap.get("dateGubn")!= null){
			 		if("1".equals(searchDateGubun)){
			 			int searchRegDtStart = -1;
			 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
			 		}else if("6".equals(searchDateGubun)){
			 			int searchRegDtStart = -6;

			 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
			 		}else if("12".equals(searchDateGubun)){
			 			int searchRegDtStart = -12;

			 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
			 		}
				}else{
					int searchRegDtStart = -1;
					pRequestParamMap.put("searchRegDt", searchRegDtStart);
					pRequestParamMap.put("searchDateGubun", "1");
				}
				list = haa03Service.selectListFlowerExcel(pRequestParamMap);
				// 데이터 부분 생성
				for(Haa03ExcelVO vo : list) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue("aT화훼공판장");
					cell = row.createCell(1);
					cell.setCellValue(vo.getSaleDate());
					cell = row.createCell(2);
					cell.setCellValue(vo.getPumName());
					cell = row.createCell(3);
					cell.setCellValue(vo.getGoodName());
					cell = row.createCell(4);
					cell.setCellValue(vo.getTotQty());
					cell = row.createCell(5);
					cell.setCellValue(vo.getMinAmt());
					cell = row.createCell(6);
					cell.setCellValue(vo.getMaxAmt());
					cell = row.createCell(7);
					cell.setCellValue(vo.getAvgAmt());
				}

				// 부산화훼공판장
				pRequestParamMap.put("cmpCd", "1508500020");

			 	//날짜검색구분 (1 : 경매일자 1개월  2: 경매일자 6개월 3: 경매일자 1년)
			 	if(pRequestParamMap.get("dateGubn")!= null){
			 		if("1".equals(searchDateGubun)){
			 			int searchRegDtStart = -1;
			 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
			 		}else if("6".equals(searchDateGubun)){
			 			int searchRegDtStart = -6;

			 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
			 		}else if("12".equals(searchDateGubun)){
			 			int searchRegDtStart = -12;

			 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
			 		}
				}else{
					int searchRegDtStart = -1;
					pRequestParamMap.put("searchRegDt", searchRegDtStart);
					pRequestParamMap.put("searchDateGubun", "1");
				}
			 	list = haa03Service.selectListFlowerExcel(pRequestParamMap);
				// 데이터 부분 생성
				for(Haa03ExcelVO vo : list) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue("부산화훼공판장");
					cell = row.createCell(1);
					cell.setCellValue(vo.getSaleDate());
					cell = row.createCell(2);
					cell.setCellValue(vo.getPumName());
					cell = row.createCell(3);
					cell.setCellValue(vo.getGoodName());
					cell = row.createCell(4);
					cell.setCellValue(vo.getTotQty());
					cell = row.createCell(5);
					cell.setCellValue(vo.getMinAmt());
					cell = row.createCell(6);
					cell.setCellValue(vo.getMaxAmt());
					cell = row.createCell(7);
					cell.setCellValue(vo.getAvgAmt());
				}

				// 부산경남화훼공판장
				pRequestParamMap.put("cmpCd", "6068207466");

			 	//날짜검색구분 (1 : 경매일자 1개월  2: 경매일자 6개월 3: 경매일자 1년)
			 	if(pRequestParamMap.get("dateGubn")!= null){
			 		if("1".equals(searchDateGubun)){
			 			int searchRegDtStart = -1;
			 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
			 		}else if("6".equals(searchDateGubun)){
			 			int searchRegDtStart = -6;

			 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
			 		}else if("12".equals(searchDateGubun)){
			 			int searchRegDtStart = -12;

			 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
			 		}
				}else{
					int searchRegDtStart = -1;
					pRequestParamMap.put("searchRegDt", searchRegDtStart);
					pRequestParamMap.put("searchDateGubun", "1");
				}
			 	list = haa03Service.selectListFlowerExcel(pRequestParamMap);
				// 데이터 부분 생성
				for(Haa03ExcelVO vo : list) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue("부산경남화훼공판장");
					cell = row.createCell(1);
					cell.setCellValue(vo.getSaleDate());
					cell = row.createCell(2);
					cell.setCellValue(vo.getPumName());
					cell = row.createCell(3);
					cell.setCellValue(vo.getGoodName());
					cell = row.createCell(4);
					cell.setCellValue(vo.getTotQty());
					cell = row.createCell(5);
					cell.setCellValue(vo.getMinAmt());
					cell = row.createCell(6);
					cell.setCellValue(vo.getMaxAmt());
					cell = row.createCell(7);
					cell.setCellValue(vo.getAvgAmt());
				}

				// 광주원예농협
				pRequestParamMap.put("cmpCd", "4108212335");

			 	//날짜검색구분 (1 : 경매일자 1개월  2: 경매일자 6개월 3: 경매일자 1년)
			 	if(pRequestParamMap.get("dateGubn")!= null){
			 		if("1".equals(searchDateGubun)){
			 			int searchRegDtStart = -1;
			 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
			 		}else if("6".equals(searchDateGubun)){
			 			int searchRegDtStart = -6;

			 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
			 		}else if("12".equals(searchDateGubun)){
			 			int searchRegDtStart = -12;

			 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
			 		}
				}else{
					int searchRegDtStart = -1;
					pRequestParamMap.put("searchRegDt", searchRegDtStart);
					pRequestParamMap.put("searchDateGubun", "1");
				}
			 	list = haa03Service.selectListFlowerExcel(pRequestParamMap);
				// 데이터 부분 생성
				for(Haa03ExcelVO vo : list) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue("광주원예농협");
					cell = row.createCell(1);
					cell.setCellValue(vo.getSaleDate());
					cell = row.createCell(2);
					cell.setCellValue(vo.getPumName());
					cell = row.createCell(3);
					cell.setCellValue(vo.getGoodName());
					cell = row.createCell(4);
					cell.setCellValue(vo.getTotQty());
					cell = row.createCell(5);
					cell.setCellValue(vo.getMinAmt());
					cell = row.createCell(6);
					cell.setCellValue(vo.getMaxAmt());
					cell = row.createCell(7);
					cell.setCellValue(vo.getAvgAmt());
				}

				// 한국화훼농협(음성)
				pRequestParamMap.put("cmpCd", "3848200087");

			 	//날짜검색구분 (1 : 경매일자 1개월  2: 경매일자 6개월 3: 경매일자 1년)
			 	if(pRequestParamMap.get("dateGubn")!= null){
			 		if("1".equals(searchDateGubun)){
			 			int searchRegDtStart = -1;
			 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
			 		}else if("6".equals(searchDateGubun)){
			 			int searchRegDtStart = -6;

			 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
			 		}else if("12".equals(searchDateGubun)){
			 			int searchRegDtStart = -12;

			 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
			 		}
				}else{
					int searchRegDtStart = -1;
					pRequestParamMap.put("searchRegDt", searchRegDtStart);
					pRequestParamMap.put("searchDateGubun", "1");
				}
			 	list = haa03Service.selectListFlowerExcel(pRequestParamMap);
				// 데이터 부분 생성
				for(Haa03ExcelVO vo : list) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue("한국화훼농협(음성)");
					cell = row.createCell(1);
					cell.setCellValue(vo.getSaleDate());
					cell = row.createCell(2);
					cell.setCellValue(vo.getPumName());
					cell = row.createCell(3);
					cell.setCellValue(vo.getGoodName());
					cell = row.createCell(4);
					cell.setCellValue(vo.getTotQty());
					cell = row.createCell(5);
					cell.setCellValue(vo.getMinAmt());
					cell = row.createCell(6);
					cell.setCellValue(vo.getMaxAmt());
					cell = row.createCell(7);
					cell.setCellValue(vo.getAvgAmt());
				}

				// 한국화훼농협(본점)
				pRequestParamMap.put("cmpCd", "1288202296");

			 	//날짜검색구분 (1 : 경매일자 1개월  2: 경매일자 6개월 3: 경매일자 1년)
			 	if(pRequestParamMap.get("dateGubn")!= null){
			 		if("1".equals(searchDateGubun)){
			 			int searchRegDtStart = -1;
			 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
			 		}else if("6".equals(searchDateGubun)){
			 			int searchRegDtStart = -6;

			 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
			 		}else if("12".equals(searchDateGubun)){
			 			int searchRegDtStart = -12;

			 			pRequestParamMap.put("searchRegDt", searchRegDtStart);
			 		}
				}else{
					int searchRegDtStart = -1;
					pRequestParamMap.put("searchRegDt", searchRegDtStart);
					pRequestParamMap.put("searchDateGubun", "1");
				}
			 	list = haa03Service.selectListFlowerExcel(pRequestParamMap);
				// 데이터 부분 생성
				for(Haa03ExcelVO vo : list) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue("한국화훼농협(본점)");
					cell = row.createCell(1);
					cell.setCellValue(vo.getSaleDate());
					cell = row.createCell(2);
					cell.setCellValue(vo.getPumName());
					cell = row.createCell(3);
					cell.setCellValue(vo.getGoodName());
					cell = row.createCell(4);
					cell.setCellValue(vo.getTotQty());
					cell = row.createCell(5);
					cell.setCellValue(vo.getMinAmt());
					cell = row.createCell(6);
					cell.setCellValue(vo.getMaxAmt());
					cell = row.createCell(7);
					cell.setCellValue(vo.getAvgAmt());
				}

				// 컨텐츠 타입과 파일명 지정
				pResponse.setContentType("ms-vnd/excel");
				pResponse.setHeader("Content-Disposition", "attachment;filename="+new String((excelNm).getBytes("KSC5601"),"8859_1")+".xls");

			}else if(excelNm.equals("출하및예정물량")){
				List<Hca01ExcelVO> list = null;
				
				// cell width
				sheet.setColumnWidth(0, 4000);
				sheet.setColumnWidth(1, 2200);
				sheet.setColumnWidth(2, 4700);
				sheet.setColumnWidth(3, 4700);
				
				// 헤더 생성
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue("◎ 출하물량");

				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue("공판장");
				cell = row.createCell(1);
				cell.setCellValue("순");
				cell = row.createCell(2);
				cell.setCellValue("순별 출하물량(속)");
				cell = row.createCell(3);
				cell.setCellValue("총 출하물량(속)");

				pRequestParamMap.put("GUBN", "2");
				list = hca01Service.selectTopExcel(pRequestParamMap);
				// 데이터 부분 생성
				for(Hca01ExcelVO vo : list) {
					for(int i=0; i<3; i++){
						// 나머지가 0, 1, 2 = 최고, 최저, 평균

						row = sheet.createRow(rowNo);

						if(i%3==0){
							cell = row.createCell(0);
							cell.setCellValue(vo.getMarketName());
							cell = row.createCell(1);
							cell.setCellValue("초순");
							cell = row.createCell(2);
							cell.setCellValue(vo.getQty1());
							cell = row.createCell(3);
							cell.setCellValue(vo.getTotQty());

							sheet.addMergedRegion(new CellRangeAddress(rowNo,rowNo+2,0,0));
							sheet.addMergedRegion(new CellRangeAddress(rowNo,rowNo+2,3,3));
						}else if(i%3==1){
							cell = row.createCell(0);
							cell.setCellValue(vo.getMarketName());
							cell = row.createCell(1);
							cell.setCellValue("중순");
							cell = row.createCell(2);
							cell.setCellValue(vo.getQty2());
						}else if(i%3==2){
							cell = row.createCell(0);
							cell.setCellValue(vo.getMarketName());
							cell = row.createCell(1);
							cell.setCellValue("하순");
							cell = row.createCell(2);
							cell.setCellValue(vo.getQty3());
						}
						rowNo++;
					}
				}

				row = sheet.createRow(rowNo++);
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue("◎ 출하예정물량");

				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue("공판장");
				cell = row.createCell(1);
				cell.setCellValue("순");
				cell = row.createCell(2);
				cell.setCellValue("순별 출하예정물량(속)");
				cell = row.createCell(3);
				cell.setCellValue("총 출하예정물량(속)");

				pRequestParamMap.put("GUBN", "1");
				list = hca01Service.selectTopExcel(pRequestParamMap);
				// 데이터 부분 생성
				for(Hca01ExcelVO vo : list) {
					for(int i=0; i<3; i++){
						// 나머지가 0, 1, 2 = 최고, 최저, 평균

						row = sheet.createRow(rowNo);

						if(i%3==0){
							cell = row.createCell(0);
							cell.setCellValue(vo.getMarketName());
							cell = row.createCell(1);
							cell.setCellValue("초순");
							cell = row.createCell(2);
							cell.setCellValue(vo.getQty1());
							cell = row.createCell(3);
							cell.setCellValue(vo.getTotQty());

							sheet.addMergedRegion(new CellRangeAddress(rowNo,rowNo+2,0,0));
							sheet.addMergedRegion(new CellRangeAddress(rowNo,rowNo+2,3,3));
						}else if(i%3==1){
							cell = row.createCell(0);
							cell.setCellValue(vo.getMarketName());
							cell = row.createCell(1);
							cell.setCellValue("중순");
							cell = row.createCell(2);
							cell.setCellValue(vo.getQty2());
						}else if(i%3==2){
							cell = row.createCell(0);
							cell.setCellValue(vo.getMarketName());
							cell = row.createCell(1);
							cell.setCellValue("하순");
							cell = row.createCell(2);
							cell.setCellValue(vo.getQty3());
						}
						rowNo++;
					}
				}

				// 컨텐츠 타입과 파일명 지정
				pResponse.setContentType("ms-vnd/excel");
				pResponse.setHeader("Content-Disposition", "attachment;filename="+new String((excelNm).getBytes("KSC5601"),"8859_1")+".xls");

			}else if(excelNm.equals("재배동향")){
				List<Hca02ExcelVO> list = null;

				// 헤더 생성
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue("작성일자");
				cell = row.createCell(1);
				cell.setCellValue("품목");
				cell = row.createCell(2);
				cell.setCellValue("품종");
				cell = row.createCell(3);
				cell.setCellValue("재배면적");
				cell = row.createCell(4);
				cell.setCellValue("재배면적내용");
				cell = row.createCell(5);
				cell.setCellValue("전년대비");
				cell = row.createCell(6);
				cell.setCellValue("지역");

				String sanList = pRequestParamMap.get("san_list").toString();
				String[] sanListAtrr = sanList.split(",");
				pRequestParamMap.put("san_list", sanListAtrr);

				pRequestParamMap.put("initFlag", "P");
				list = hca02Service.selectHca02Excel(pRequestParamMap);
				// 데이터 부분 생성
				for(Hca02ExcelVO vo : list) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue(vo.getRegDate());
					cell = row.createCell(1);
					cell.setCellValue(vo.getPumName());
					cell = row.createCell(2);
					cell.setCellValue(vo.getGoodName());
					cell = row.createCell(3);
					cell.setCellValue(vo.getArea());
					cell = row.createCell(4);
					cell.setCellValue(vo.getBigo());
					cell = row.createCell(5);
					cell.setCellValue(vo.getStatus());
					cell = row.createCell(6);
					cell.setCellValue(vo.getSido());
				}

				// 컨텐츠 타입과 파일명 지정
				pResponse.setContentType("ms-vnd/excel");
				pResponse.setHeader("Content-Disposition", "attachment;filename="+new String((excelNm).getBytes("KSC5601"),"8859_1")+".xls");

			}else if(excelNm.equals("작황정보")){
				List<Hca03ExcelVO> list = null;

				// 헤더 생성
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue("품목명");
				cell = row.createCell(1);
				cell.setCellValue("품종명");
				cell = row.createCell(2);
				cell.setCellValue("꽃의 고유색");
				cell = row.createCell(3);
				cell.setCellValue("작황정보");
				cell = row.createCell(4);
				cell.setCellValue("일조량");
				cell = row.createCell(5);
				cell.setCellValue("기후");
				cell = row.createCell(6);
				cell.setCellValue("꽃의 크기");
				cell = row.createCell(7);
				cell.setCellValue("꽃의 굵기");
				cell = row.createCell(8);
				cell.setCellValue("색택의 선명함");
				cell = row.createCell(9);
				cell.setCellValue("꽃의 길이");
				cell = row.createCell(10);
				cell.setCellValue("병충해 유무");
				cell = row.createCell(11);
				cell.setCellValue("작황내용");
				cell = row.createCell(12);
				cell.setCellValue("등록일");

				pRequestParamMap.put("initFlag", "P");
				String sanList = pRequestParamMap.get("san_list").toString();
				String[] sanListAtrr = sanList.split(",");
				pRequestParamMap.put("san_list", sanListAtrr);

				list = hca03Service.selectHca03Excel(pRequestParamMap);
				// 데이터 부분 생성
				for(Hca03ExcelVO vo : list) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue(vo.getPumName());
					cell = row.createCell(1);
					cell.setCellValue(vo.getGoodName());
					cell = row.createCell(2);
					cell.setCellValue(vo.getUniqueColor());
					cell = row.createCell(3);
					cell.setCellValue(vo.getStatus());
					cell = row.createCell(4);
					cell.setCellValue(vo.getStatSun());
					cell = row.createCell(5);
					cell.setCellValue(vo.getStatClimate());
					cell = row.createCell(6);
					cell.setCellValue(vo.getStatSize());
					cell = row.createCell(7);
					cell.setCellValue(vo.getStatThick());
					cell = row.createCell(8);
					cell.setCellValue(vo.getStatDefinition());
					cell = row.createCell(9);
					cell.setCellValue(vo.getStatLength());
					cell = row.createCell(10);
					cell.setCellValue(vo.getStatInsectYn());
					cell = row.createCell(11);
					cell.setCellValue(vo.getBigo());
					cell = row.createCell(12);
					cell.setCellValue(vo.getRegDate());
				}

				// 컨텐츠 타입과 파일명 지정
				pResponse.setContentType("ms-vnd/excel");
				pResponse.setHeader("Content-Disposition", "attachment;filename="+new String((excelNm).getBytes("KSC5601"),"8859_1")+".xls");

			}else if(excelNm.equals("소비동향")){
				List<SalePriceVO> list = null;

				// 헤더 생성
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue("일자");
				cell = row.createCell(1);
				cell.setCellValue("품목");
				cell = row.createCell(2);
				cell.setCellValue("품종");
				cell = row.createCell(3);
				cell.setCellValue("내용");
				cell = row.createCell(4);
				cell.setCellValue("지역");

				list = salePriceService.selectPointSalePriceExcel(pRequestParamMap);
				// 데이터 부분 생성
				for(SalePriceVO vo : list) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue(vo.getRegDate());
					cell = row.createCell(1);
					cell.setCellValue(vo.getPumName());
					cell = row.createCell(2);
					cell.setCellValue(vo.getGoodName());
					cell = row.createCell(3);
					cell.setCellValue(vo.getBigo());
					cell = row.createCell(4);
					cell.setCellValue(vo.getChulNo());
				}

				// 컨텐츠 타입과 파일명 지정
				pResponse.setContentType("ms-vnd/excel");
				pResponse.setHeader("Content-Disposition", "attachment;filename="+new String((excelNm).getBytes("KSC5601"),"8859_1")+".xls");

			}else if(excelNm.equals("소매가격동향")){
				List<Hdb01VO> list = null;

				// 헤더 생성
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue("날짜");
				cell = row.createCell(1);
				cell.setCellValue("지역명");
				cell = row.createCell(2);
				cell.setCellValue("소매가격(원)");

				list = hdb01Service.selectChartListExcel(pRequestParamMap);
				// 데이터 부분 생성
				for(Hdb01VO vo : list) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue(vo.getRegMonth());
					cell = row.createCell(1);
					cell.setCellValue(vo.getSanName());
					cell = row.createCell(2);
					cell.setCellValue(vo.getRealPrice());
				}

				// 컨텐츠 타입과 파일명 지정
				pResponse.setContentType("ms-vnd/excel");
				pResponse.setHeader("Content-Disposition", "attachment;filename="+new String((excelNm).getBytes("KSC5601"),"8859_1")+".xls");

			}else if(excelNm.equals("기상동향분석")){
				List<Hga02VO> list = null;

				// 헤더 생성
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue("날짜");
				cell = row.createCell(1);
				cell.setCellValue("지역");
				cell = row.createCell(2);
				cell.setCellValue("최저기온(℃)");
				cell = row.createCell(3);
				cell.setCellValue("최고기온(℃)");
				cell = row.createCell(4);
				cell.setCellValue("강수량");

				list = hga02Service.selectGetItemListExcel(pRequestParamMap);
				// 데이터 부분 생성
				for(Hga02VO vo : list) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue(vo.getFcstDate());
					cell = row.createCell(1);
					cell.setCellValue(vo.getSidoNm());
					cell = row.createCell(2);
					cell.setCellValue(vo.getMinT3h());
					cell = row.createCell(3);
					cell.setCellValue(vo.getMaxT3h());
					cell = row.createCell(4);
					cell.setCellValue(vo.getR06());
				}

				// 컨텐츠 타입과 파일명 지정
				pResponse.setContentType("ms-vnd/excel");
				pResponse.setHeader("Content-Disposition", "attachment;filename="+new String((excelNm).getBytes("KSC5601"),"8859_1")+".xls");

			}else if(excelNm.equals("월간화훼수출입현황")){
				List<Hga01VO> list = null;

				// 헤더 생성
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue("월");
				cell = row.createCell(1);
				cell.setCellValue("총수출물량(톤)");
				cell = row.createCell(2);
				cell.setCellValue("총수입물량(톤)");
				cell = row.createCell(3);
				cell.setCellValue("총수출금액(천원)");
				cell = row.createCell(4);
				cell.setCellValue("총수입금액(천원)");
				cell = row.createCell(5);
				cell.setCellValue("무역수지(천원)");

				list = hga01Service.selectTrendAnalysisListExcel(pRequestParamMap);
				// 데이터 부분 생성
				for(Hga01VO vo : list) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue(vo.getDtNew());
					cell = row.createCell(1);
					cell.setCellValue(vo.getExpWgt1());
					cell = row.createCell(2);
					cell.setCellValue(vo.getImpWgt3());
					cell = row.createCell(3);
					cell.setCellValue(vo.getExpPrc2());
					cell = row.createCell(4);
					cell.setCellValue(vo.getImpPrc4());
					cell = row.createCell(5);
					cell.setCellValue(vo.getBalPay());

				}
				row = sheet.createRow(rowNo++);

				// 컨텐츠 타입과 파일명 지정
				pResponse.setContentType("ms-vnd/excel");
				pResponse.setHeader("Content-Disposition", "attachment;filename="+new String((excelNm).getBytes("KSC5601"),"8859_1")+".xls");

			}else if(excelNm.equals("식물검역정보")){
				List<Hga03VO> list = hga03Service.selectPlntList1Excel(pRequestParamMap);

				// 헤더 생성
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue("수출현황");
				cell = row.createCell(1);
				cell.setCellValue("국가");
				cell = row.createCell(2);
				cell.setCellValue("단위");
				cell = row.createCell(3);
				cell.setCellValue("수출량");

				// 데이터 부분 생성
				for(Hga03VO vo : list) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(1);
					cell.setCellValue(vo.getNatNm());
					cell = row.createCell(2);
					cell.setCellValue(vo.getQumNm());
					cell = row.createCell(3);
					cell.setCellValue(vo.getInsQty());
				}

				list = hga03Service.selectPlntList2Excel(pRequestParamMap);
				// 헤더 생성
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue("수입현황");
				cell = row.createCell(1);
				cell.setCellValue("국가");
				cell = row.createCell(2);
				cell.setCellValue("수송구분");
				cell = row.createCell(3);
				cell.setCellValue("단위");
				cell = row.createCell(4);
				cell.setCellValue("수입량");
				cell = row.createCell(5);
				cell.setCellValue("소득량");
				cell = row.createCell(6);
				cell.setCellValue("폐기량");

				// 데이터 부분 생성
				for(Hga03VO vo : list) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(1);
					cell.setCellValue(vo.getNatNm());
					cell = row.createCell(2);
					cell.setCellValue(vo.getMatNm());
					cell = row.createCell(3);
					cell.setCellValue(vo.getQumNm());
					cell = row.createCell(4);
					cell.setCellValue(vo.getInsQty());
					cell = row.createCell(5);
					cell.setCellValue(vo.getAntQty());
					cell = row.createCell(6);
					cell.setCellValue(vo.getWasQty());
				}

				// 컨텐츠 타입과 파일명 지정
				pResponse.setContentType("ms-vnd/excel");
				pResponse.setHeader("Content-Disposition", "attachment;filename="+new String((excelNm).getBytes("KSC5601"),"8859_1")+".xls");

			} else if(excelNm.equals("일자별품목경매정보")) {
				List<AuctionItemVO> list = auctionItemService.selectDailyItemExcel(pRequestParamMap);

				//헤더 생성
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue("공판장");
				cell = row.createCell(1);
				cell.setCellValue("품목명");
				cell = row.createCell(2);
				cell.setCellValue("거래량");
				cell = row.createCell(3);
				cell.setCellValue("최고단가");
				cell = row.createCell(4);
				cell.setCellValue("최저단가");
				cell = row.createCell(5);
				cell.setCellValue("평균단가");


				//데이터
				for(AuctionItemVO vo : list) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue(vo.getMarketName());
					cell = row.createCell(1);
					cell.setCellValue(vo.getItemNm());
					cell = row.createCell(2);
					cell.setCellValue(vo.getTotQty());
					cell = row.createCell(3);
					cell.setCellValue(vo.getMaxAmt());
					cell = row.createCell(4);
					cell.setCellValue(vo.getMinAmt());
					cell = row.createCell(5);
					cell.setCellValue(vo.getAvgAmt());
				}
				//컨텐츠 타입과 파일명 지정
				pResponse.setContentType("ms-vnd/excel");
				pResponse.setHeader("Content-Disposition", "attachment;filename="+new String((excelNm).getBytes("KSC5601"),"8859_1")+".xls");

			} else if(excelNm.equals("일자별품종경매정보")) {
				List<AuctionKindVO> list = auctionKindService.selectDailyKindExcel(pRequestParamMap);

				//헤더 생성
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue("공판장");
				cell = row.createCell(1);
				cell.setCellValue("품목명");
				cell = row.createCell(2);
				cell.setCellValue("품종명");
				cell = row.createCell(3);
;				cell.setCellValue("거래량");
				cell = row.createCell(4);
				cell.setCellValue("최고단가");
				cell = row.createCell(5);
				cell.setCellValue("최저단가");
				cell = row.createCell(6);
				cell.setCellValue("평균단가");

				//데이터
				for(AuctionKindVO vo : list) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue(vo.getMarketName());
					cell = row.createCell(1);
					cell.setCellValue(vo.getItemNm());
					cell = row.createCell(2);
					cell.setCellValue(vo.getKindNm());
					cell = row.createCell(3);
					cell.setCellValue(vo.getTotQty());
					cell = row.createCell(4);
					cell.setCellValue(vo.getMaxAmt());
					cell = row.createCell(5);
					cell.setCellValue(vo.getMinAmt());
					cell = row.createCell(6);
					cell.setCellValue(vo.getAvgAmt());
				}
				//컨텐츠 타입과 파일명 지정
				pResponse.setContentType("ms-vnd/excel");
				pResponse.setHeader("Content-Disposition", "attachment;filename="+new String((excelNm).getBytes("KSC5601"),"8859_1")+".xls");

			}else if(excelNm.equals("월별품목경매정보")) {
				List<AuctionItemVO> list = auctionItemService.selectMonthlyItemExcel(pRequestParamMap);

				//헤더 생성
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue("공판장");
				cell = row.createCell(1);
				cell.setCellValue("품목명");
				cell = row.createCell(2);
				cell.setCellValue("거래량");
				cell = row.createCell(3);
				cell.setCellValue("최고단가");
				cell = row.createCell(4);
				cell.setCellValue("최저단가");
				cell = row.createCell(5);
				cell.setCellValue("평균단가");

				//데이터
				for(AuctionItemVO vo : list) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue(vo.getMarketName());
					cell = row.createCell(1);
					cell.setCellValue(vo.getItemNm());
					cell = row.createCell(2);
					cell.setCellValue(vo.getTotQty());
					cell = row.createCell(3);
					cell.setCellValue(vo.getMaxAmt());
					cell = row.createCell(4);
					cell.setCellValue(vo.getMinAmt());
					cell = row.createCell(5);
					cell.setCellValue(vo.getAvgAmt());
				}
				//컨텐츠 타입과 파일명 지정
				pResponse.setContentType("ms-vnd/excel");
				pResponse.setHeader("Content-Disposition", "attachment;filename="+new String((excelNm).getBytes("KSC5601"),"8859_1")+".xls");

			}else if(excelNm.equals("월별품종경매정보")) {
				List<AuctionKindVO> list = auctionKindService.selectMonthlyKindExcel(pRequestParamMap);

				//헤더 생성
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue("공판장");
				cell = row.createCell(1);
				cell.setCellValue("품목명");
				cell = row.createCell(2);
				cell.setCellValue("품종명");
				cell = row.createCell(3);
;				cell.setCellValue("거래량");
				cell = row.createCell(4);
				cell.setCellValue("최고단가");
				cell = row.createCell(5);
				cell.setCellValue("최저단가");
				cell = row.createCell(6);
				cell.setCellValue("평균단가");

				//데이터
				for(AuctionKindVO vo : list) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue(vo.getMarketName());
					cell = row.createCell(1);
					cell.setCellValue(vo.getItemNm());
					cell = row.createCell(2);
					cell.setCellValue(vo.getKindNm());
					cell = row.createCell(3);
					cell.setCellValue(vo.getTotQty());
					cell = row.createCell(4);
					cell.setCellValue(vo.getMaxAmt());
					cell = row.createCell(5);
					cell.setCellValue(vo.getMinAmt());
					cell = row.createCell(6);
					cell.setCellValue(vo.getAvgAmt());
				}
				//컨텐츠 타입과 파일명 지정
				pResponse.setContentType("ms-vnd/excel");
				pResponse.setHeader("Content-Disposition", "attachment;filename="+new String((excelNm).getBytes("KSC5601"),"8859_1")+".xls");

			}else if(excelNm.equals("일자별 경매동향")) {
				List<EgovMap> list = hab09Service.selectAucExcel(pRequestParamMap);
				
				//헤더 생성
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue("품목명");
				cell = row.createCell(1);
				cell.setCellValue("품종명");
				cell = row.createCell(2);
				cell.setCellValue("등급");
				cell = row.createCell(3);
				cell.setCellValue("속수량");
				cell = row.createCell(4);
				cell.setCellValue("최저단가");
				cell = row.createCell(5);
				cell.setCellValue("최고단가");
				cell = row.createCell(6);
				cell.setCellValue("평균단가");

				//데이터
				for(EgovMap vo : list) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue(vo.get("pumName").toString());
					cell = row.createCell(1);
					cell.setCellValue(vo.get("goodName").toString());
					cell = row.createCell(2);
					cell.setCellValue(vo.get("lvName").toString());
					cell = row.createCell(3);
					cell.setCellValue(vo.get("totQty").toString());
					cell = row.createCell(4);
					cell.setCellValue(vo.get("minAmt").toString());
					cell = row.createCell(5);
					cell.setCellValue(vo.get("maxAmt").toString());
					cell = row.createCell(6);
					cell.setCellValue(vo.get("avgAmt").toString());
				}
				
				//컨텐츠 타입과 파일명 지정
				pResponse.setContentType("ms-vnd/excel");
				pResponse.setHeader("Content-Disposition", "attachment;filename="+new String((excelNm).getBytes("KSC5601"),"8859_1")+".xls");
			
			}else if(excelNm.equals("일별 품목별 경매실적 및 동향")) {
				List<EgovMap> list = reportService.selectDayPumAucExcel(pRequestParamMap);
				
				//헤더 생성
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue("연");
				cell = row.createCell(1);
				cell.setCellValue("월");
				cell = row.createCell(2);
				cell.setCellValue("일");
				cell = row.createCell(3);
				cell.setCellValue("품목");
				cell = row.createCell(4);
				cell.setCellValue("출하물량");
				cell = row.createCell(5);
				cell.setCellValue("판매물량");
				cell = row.createCell(6);
				cell.setCellValue("유찰물량");
				cell = row.createCell(7);
				cell.setCellValue("판매금액");
				cell = row.createCell(8);
				cell.setCellValue("평균단가");

				//데이터
				for(EgovMap vo : list) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue(vo.get("year").toString());
					cell = row.createCell(1);
					cell.setCellValue(vo.get("month").toString());
					cell = row.createCell(2);
					cell.setCellValue(vo.get("day").toString());
					cell = row.createCell(3);
					cell.setCellValue(vo.get("pumName").toString());
					cell = row.createCell(4);
					cell.setCellValue(vo.get("totCnt").toString());
					cell = row.createCell(5);
					cell.setCellValue(vo.get("panCnt").toString());
					cell = row.createCell(6);
					cell.setCellValue(vo.get("yuchalCnt").toString());
					cell = row.createCell(7);
					cell.setCellValue(vo.get("totAmt").toString());
					cell = row.createCell(8);
					cell.setCellValue(vo.get("avgAmt").toString());
				}
				
				//컨텐츠 타입과 파일명 지정
				pResponse.setContentType("ms-vnd/excel");
				pResponse.setHeader("Content-Disposition", "attachment;filename="+new String((excelNm).getBytes("KSC5601"),"8859_1")+".xls");
			}else if(excelNm.equals("주요절화류도매가격동향")){
				Calendar strDate = Calendar.getInstance();
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				String searchDate = pRequestParamMap.get("searchStrDate").toString();
				Date to = sdf.parse(searchDate);
				int iday = Integer.parseInt(pRequestParamMap.get("searchStrDate").toString().substring(8,10));

				String check = "";
				String sun = "";
		        if(iday < 11){
		            check = "1";
		            sun = "상순";
		        }else if(10 < iday && iday < 21){
		            check = "2";
		            sun = "중순";
		        }else{
		            check = "3";
		            sun = "하순";
		        }
		        pRequestParamMap.put("sCheck", check);
				
				List<EgovMap> list = reportService.selectMainFlowerAucExcel(pRequestParamMap);
					
				strDate.setTime(to);
				strDate.add(Calendar.YEAR, -1);
				strDate.add(Calendar.MONTH, -1);
				String preYear = sdf.format(strDate.getTime()).substring(0,4);
				String preMonth = sdf.format(strDate.getTime()).substring(5,7);
				
				//헤더 생성
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue("품목");
				cell = row.createCell(1);
				cell.setCellValue("단위");
				cell = row.createCell(2);
				cell.setCellValue("평년 "+searchDate.substring(5,7)+sun+"(A)");
				cell = row.createCell(3);
				cell.setCellValue(preYear.substring(2,4)+"년"+searchDate.substring(5,7)+"월"+sun+"(B)");
				cell = row.createCell(4);
				cell.setCellValue(searchDate.substring(2,4)+"년"+preMonth+"월"+sun+"(C)");
				cell = row.createCell(5);
				if(check.equals("1")){
					cell.setCellValue(searchDate.substring(2,4)+"년"+preMonth+"월"+"하순 (D)");
				}else if(check.equals("2")){
					cell.setCellValue(searchDate.substring(2,4)+"년"+searchDate.substring(5,7)+"월"+"상순(D)");
				}else{
					cell.setCellValue(searchDate.substring(2,4)+"년"+searchDate.substring(5,7)+"월"+"중순(D)");
				}
				cell = row.createCell(6);
				cell.setCellValue("(전일)");
				cell = row.createCell(7);
				cell.setCellValue(searchDate+"(E)");
				cell = row.createCell(8);
				cell.setCellValue("평년(E/A)");
				cell = row.createCell(9);
				cell.setCellValue("전년(E/B)");
				cell = row.createCell(10);
				cell.setCellValue("전월(E/C)");
				cell = row.createCell(11);
				cell.setCellValue("전순(E/D)");
				
				//데이터
				for(EgovMap vo : list) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue(vo.get("pumName").toString());
					cell = row.createCell(1);
					cell.setCellValue(vo.get("danName").toString());
					cell = row.createCell(2);
					cell.setCellValue(vo.get("cyAvg").toString());
					cell = row.createCell(3);
					cell.setCellValue(vo.get("preyAvg").toString());
					cell = row.createCell(4);
					cell.setCellValue(vo.get("premAvg").toString());
					cell = row.createCell(5);
					cell.setCellValue(vo.get("sdayAvg").toString());
					cell = row.createCell(6);
					cell.setCellValue(vo.get("ydayAvg").toString());
					cell = row.createCell(7);
					cell.setCellValue(vo.get("todayAvg").toString());
					cell = row.createCell(8);
					cell.setCellValue(vo.get("cyPer").toString());
					cell = row.createCell(9);
					cell.setCellValue(vo.get("preyPer").toString());
					cell = row.createCell(10);
					cell.setCellValue(vo.get("premPer").toString());
					cell = row.createCell(11);
					cell.setCellValue(vo.get("sdayPer").toString());
				}
				
				//컨텐츠 타입과 파일명 지정
				pResponse.setContentType("ms-vnd/excel");
				pResponse.setHeader("Content-Disposition", "attachment;filename="+new String((excelNm).getBytes("KSC5601"),"8859_1")+".xls");
				
			}else if(excelNm.equals("월간화훼수출입")){
				List<EgovMap> resultList = (List<EgovMap>) katiDataService.selectImportList(pRequestParamMap);
				
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue("검색조건 ");
				cell = row.createCell(1);
				if(pRequestParamMap.get("gubn").equals("I")){
					cell.setCellValue("구분:수입");
				}else{
					cell.setCellValue("구분:수출");
				}
				cell = row.createCell(2);
				cell.setCellValue("기간:"+pRequestParamMap.get("searchStrDate").toString()+"~"+pRequestParamMap.get("searchEndDate").toString());
				cell = row.createCell(3);
				if(pRequestParamMap.get("hsCode") != null){
					cell.setCellValue("품목코드:"+pRequestParamMap.get("hsCode").toString());
				}else{
					cell.setCellValue("품목코드: 전체");
				}
				cell = row.createCell(4);
				if(pRequestParamMap.get("natCode") != null){
					cell.setCellValue("국가코드:"+pRequestParamMap.get("natCode").toString());
				}else{
					cell.setCellValue("국가코드: 전체");
				}
				
				
				
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue("국가");
				cell = row.createCell(1);
				cell.setCellValue("품목");
				cell = row.createCell(2);
				cell.setCellValue("금액(달러)");
				cell = row.createCell(3);
				cell.setCellValue("물량(kg)");
				cell = row.createCell(4);
				cell.setCellValue("날짜");
				
				for(Map<String,Object> vo : resultList) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue(vo.get("NATCD").toString());
					cell = row.createCell(1);
					cell.setCellValue(vo.get("NAME").toString());
					cell = row.createCell(2);
					cell.setCellValue(vo.get("TOT_AMT").toString());
					cell = row.createCell(3);
					cell.setCellValue(vo.get("TOT_WGT").toString());
					cell = row.createCell(4);
					if(vo.get("BASIS_YYMM") != null){
						cell.setCellValue(vo.get("BASIS_YYMM").toString());
					}
					
				}
				
				//컨텐츠 타입과 파일명 지정
				pResponse.setContentType("ms-vnd/excel");
				pResponse.setHeader("Content-Disposition", "attachment;filename="+new String((excelNm).getBytes("KSC5601"),"8859_1")+".xls");
			}else if(excelNm.equals("연도별실적")){
				logger.error("테스트!!!!");
				List<Hab10VO> resultList = (List<Hab10VO>)hab10Service.selectHab10(pRequestParamMap);
				
				String searchYear = pRequestParamMap.get("searchYear").toString();
				String searchProductGubunNm = "";
				String searchCmpCdNm = "";
				
				if(!"".equals(pRequestParamMap.get("searchProductGubun"))){
					switch ((String) pRequestParamMap.get("searchProductGubun")) {
						case "1":
							searchProductGubunNm = "절화";
							break;
						case "3":
							searchProductGubunNm = "난";
							break;
						case "2":
							searchProductGubunNm = "관엽";
							break;
						case "4":
							searchProductGubunNm = "춘란";
							break;
					}
				}
				
				if(!"".equals(pRequestParamMap.get("searchCmpCd"))){
					switch ((String) pRequestParamMap.get("searchCmpCd")) {
						case "0000000001":
							searchCmpCdNm = "aT화훼공판장(양재동)";
							break;
						case "1508500020":
							searchCmpCdNm = "부산화훼공판장(엄궁동)";
							break;
						case "6068207466":
							searchCmpCdNm = "부산경남화훼농협(강동동)";
							break;
						case "4108212335":
							searchCmpCdNm = "광주원예농협(풍암)";
							break;
						case "3848200087":
							searchCmpCdNm = "한국화훼농협(음성)";
							break;
						case "1288202296":
							searchCmpCdNm = "한국화훼농협(과천)";
							break;
						case "6158209828":
							searchCmpCdNm = "영남화훼농협(김해)";
							break;
					}
				}

				
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue("검색조건 ");
				cell = row.createCell(1);
				cell.setCellValue("기준년도:"+searchYear);
				cell = row.createCell(2);
				cell.setCellValue("경매장:"+searchCmpCdNm);
				cell = row.createCell(3);
				cell.setCellValue("부류:"+searchProductGubunNm);

				

				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue("기준년도");
				cell = row.createCell(1);
				cell.setCellValue("거래량(만단)");
				cell = row.createCell(2);
				cell.setCellValue("경매금액(백만원)");
				
				for(Hab10VO vo : resultList) {
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue(vo.getSaleYear());
					cell = row.createCell(1);
					cell.setCellValue(vo.getTotQty());
					cell = row.createCell(2);
					cell.setCellValue(vo.getTotAmt());
				}
				
				//컨텐츠 타입과 파일명 지정
				pResponse.setContentType("ms-vnd/excel");
				pResponse.setHeader("Content-Disposition", "attachment;filename="+new String((excelNm).getBytes("KSC5601"),"8859_1")+".xls");
			}

			// 엑셀 출력
			wb.write(pResponse.getOutputStream());
			wb.close();

		} catch (ArithmeticException e) {
			log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
		} catch (NumberFormatException e) {
			log.error("오류발생 숫자로 변환 할 수 없습니다!!");
		} catch (ArrayIndexOutOfBoundsException e) {
			log.error("오류발생 배열인텍스에서 벗어났습니다!!");
		} catch (NegativeArraySizeException e) {
			log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
		} catch (NullPointerException e) {
			log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
		} catch (NoSuchMethodError e) {
			log.error("오류발생 메서드를 찾을수 없습니다!!");
		} catch (NoClassDefFoundError e) {
			log.error("오류발생 클래스를 찾을 수 없습니다!!");
		} catch (Exception e) {
			log.error(e.getMessage());
		}
	}
	
	@RequestMapping(value="/excel/excelDownLoadHaa00.do")
	public void excelDownLoadHaa00(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam(value="flowerCd") List<String> flowerCd
			,@RequestParam(value="cmpCd") String cmpCd
			,@RequestParam(value="searchStrDate") String searchStrDate
			,@RequestParam(value="searchEndDate") String searchEndDate
			,@RequestParam(value="type") String type
			,@RequestParam(value="itemCd") String itemCd
			,@RequestParam(value="itemCd2") String itemCd2
			,@RequestParam(value="gubn") List<String> gubn
			,@RequestParam(value="excelNm") String excelNm
			, ModelMap model){
		
		System.out.println("======================================================== "+excelNm);

		try {
			 // 워크북 생성
			Workbook wb = new HSSFWorkbook();
			Sheet sheet = wb.createSheet(excelNm);
			Row row = null;
			Cell cell = null;
			int rowNo = 0;

			//1.셀 스타일 및 폰트 설정
			CellStyle style = wb.createCellStyle();
			style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			CellStyle LineBreakStyle = wb.createCellStyle();
			LineBreakStyle.setWrapText(true);
			
			CellStyle blueStyle = wb.createCellStyle();
			blueStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			CellStyle redStyle = wb.createCellStyle();
			redStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			//폰트 색상 설정			
			HSSFFont blueFont = (HSSFFont) wb.createFont();
			blueFont.setColor(HSSFColor.BLUE.index);
			blueStyle.setFont(blueFont);
			
			
			HSSFFont RedFont = (HSSFFont) wb.createFont();
			RedFont.setColor(HSSFColor.RED.index);
			redStyle.setFont(RedFont);

			Map<String, Object> paramMap = new HashMap<String, Object>();
			List<EgovMap> list;
			
			paramMap.put("flowerCd", flowerCd);
			paramMap.put("cmpCd", cmpCd);
			paramMap.put("itemCd", itemCd);
			paramMap.put("itemCd2", itemCd2);
			paramMap.put("searchStrDate", searchStrDate);
			paramMap.put("searchEndDate", searchEndDate);
			paramMap.put("type", type);
			paramMap.put("gubn", gubn);

			if(type.equals("day")){
				list = haa00Service.selectAuctionDayList(paramMap);
			}else if(type.equals("month")){
				list = haa00Service.selectAuctionMonthList(paramMap);
			}else{
				searchStrDate += "-01";
				searchEndDate += "-12";
				paramMap.put("searchStrDate", searchStrDate);
				paramMap.put("searchEndDate", searchEndDate);
				list = haa00Service.selectAuctionYearList(paramMap);
			}
			//검색조건 생성
			row = sheet.createRow(rowNo++);
			cell = row.createCell(0);
			cell.setCellValue("검색조건");
			cell = row.createCell(1);
			String searchFlower = "";
			if(flowerCd != null){
				for(String flowerCode : flowerCd){
					if(flowerCode.equals("1")){
						searchFlower += "절화 ";
					}else if(flowerCode.equals("2")){
						searchFlower += "관엽 ";
					}else if(flowerCode.equals("3")){
						searchFlower += "난 ";
					}else if(flowerCode.equals("4")){
						searchFlower += "춘란 ";
					}
				}
				
				cell.setCellValue("부류:"+searchFlower);
			}else{
				cell.setCellValue("부류:선택없음");
			}
			cell = row.createCell(2);
			
			String searchCmp = "";
			if(cmpCd != null && cmpCd != ""){
				if(cmpCd.equals("0000000001")){
					searchCmp = "aT화훼(양재) ";
				}else if(cmpCd.equals("1508500020")){
					searchCmp = "부산화훼(엄궁) ";
				}else if(cmpCd.equals("6068207466")){
					searchCmp = "부경화훼(강동) ";
				}else if(cmpCd.equals("4108212335")){
					searchCmp = "광주원예(풍암) ";
				}else if(cmpCd.equals("3848200087")){
					searchCmp = "한국화훼(음성) ";
				}else if(cmpCd.equals("1288202296")){
					searchCmp = "한국화훼(과천) ";
				}else if(cmpCd.equals("6158209828")){
					searchCmp = "영남화훼(김해) ";
				}
				
				cell.setCellValue("공판장:"+searchCmp);
			}else{
				cell.setCellValue("공판장:선택없음");
			}
			cell = row.createCell(3);
			if(searchStrDate != null && searchEndDate != null){
				cell.setCellValue("시작일:"+searchStrDate+",종료일:"+ searchEndDate);
			}else{
				cell.setCellValue("날짜:선택없음");
			}
			
			cell = row.createCell(4);
			String searchGubn = "";
			if(gubn != null){
				for(String gubnCode : gubn){
					if(gubnCode.equals("1")){
						searchGubn += "부류 ";
					}else if(gubnCode.equals("2")){
						searchGubn += "품목 ";
					}else if(gubnCode.equals("3")){
						searchGubn += "품종 ";
					}
				}
				cell.setCellValue("표시단위:"+searchGubn);
			}else{
				cell.setCellValue("표시단위:선택없음");
			}
			cell = row.createCell(5);
			if(itemCd != null && itemCd != ""){
				cell.setCellValue("품목명:"+itemCd);
			}else{
				cell.setCellValue("품목명:전체");
			}
			
			cell = row.createCell(6);
			if(itemCd2 != null && itemCd2 != ""){
				cell.setCellValue("품종명:"+itemCd2);
			}else{
				cell.setCellValue("품종명:품목미선택");
			}
			
			
			
			// 헤더 생성
			row = sheet.createRow(rowNo++);
			cell = row.createCell(0);
			cell.setCellValue("부류");
			cell = row.createCell(1);
			cell.setCellValue("품목");
			cell = row.createCell(2);
			cell.setCellValue("품종");
			cell = row.createCell(3);
			cell.setCellValue("총수량");
			cell = row.createCell(4);
			cell.setCellValue("총금액");
			cell = row.createCell(5);
			cell.setCellValue("최대금액");
			cell = row.createCell(6);
			cell.setCellValue("최저금액");
			cell = row.createCell(7);
			cell.setCellValue("평균금액");
			cell = row.createCell(8);
			cell.setCellValue("날짜");
			cell = row.createCell(9);
			cell.setCellValue("공판장");

			// 데이터 부분 생성
			for(Map<String,Object> vo : list) {
					
					row = sheet.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue(vo.get("FLOWERNAME").toString());
					cell = row.createCell(1);
					if(vo.get("PUMNAME") != null){
						cell.setCellValue(vo.get("PUMNAME").toString());
					}
					cell = row.createCell(2);
					if(vo.get("GOODNAME") != null){
						cell.setCellValue(vo.get("GOODNAME").toString());
					}
					cell = row.createCell(3);
					if(vo.get("TOTQTY") != null){
						cell.setCellValue(Double.parseDouble(vo.get("TOTQTY").toString()));
					}
					cell = row.createCell(4);
					if(vo.get("TOTAMT") != null){
						cell.setCellValue(Double.parseDouble(vo.get("TOTAMT").toString()));
					}
					cell = row.createCell(5);
					if(vo.get("MAXAMT") != null){
						cell.setCellValue(Double.parseDouble(vo.get("MAXAMT").toString()));
					}
					cell = row.createCell(6);
					if(vo.get("MINAMT") != null){
						cell.setCellValue(Double.parseDouble(vo.get("MINAMT").toString()));
					}
					cell = row.createCell(7);
					if(vo.get("AVGAMT") != null){
						cell.setCellValue(Double.parseDouble(vo.get("AVGAMT").toString()));
					}
					cell = row.createCell(8);
					if(vo.get("SALEDATE") != null){
						cell.setCellValue(vo.get("SALEDATE").toString());
					}
					cell = row.createCell(9);
					if(vo.get("MARKETNAME") != null){
						cell.setCellValue(vo.get("MARKETNAME").toString());
					}
				
				//검색조건 생성
				//cell = row.createCell(10);
					
				/*if(rowNo == 2){
					String searchFlower = "";
					if(flowerCd != null){
						for(String flowerCode : flowerCd){
							if(flowerCode.equals("1")){
								searchFlower += "절화 ";
							}else if(flowerCode.equals("2")){
								searchFlower += "관엽 ";
							}else if(flowerCode.equals("3")){
								searchFlower += "난 ";
							}else if(flowerCode.equals("4")){
								searchFlower += "춘란 ";
							}
						}
						
						cell.setCellValue("부류:"+searchFlower);
					}else{
						cell.setCellValue("부류:선택없음");
					}
					continue;
				}
				if(rowNo == 3){
					String searchCmp = "";
					if(cmpCd != null && cmpCd != ""){
						if(cmpCd.equals("0000000001")){
							searchCmp = "aT화훼(양재) ";
						}else if(cmpCd.equals("1508500020")){
							searchCmp = "부산화훼(엄궁) ";
						}else if(cmpCd.equals("6068207466")){
							searchCmp = "부경화훼(강동) ";
						}else if(cmpCd.equals("4108212335")){
							searchCmp = "광주원예(풍암) ";
						}else if(cmpCd.equals("3848200087")){
							searchCmp = "한국화훼(음성) ";
						}else if(cmpCd.equals("1288202296")){
							searchCmp = "한국화훼(과천) ";
						}else if(cmpCd.equals("6158209828")){
							searchCmp = "영남화훼(김해) ";
						}
						
						cell.setCellValue("공판장:"+searchCmp);
					}else{
						cell.setCellValue("공판장:선택없음");
					}
					continue;
				}
				if(rowNo == 4){
					String searchDate = "";
					if(searchStrDate != null && searchEndDate != null){
						cell.setCellValue("시작일:"+searchStrDate+",종료일:"+ searchEndDate);
					}else{
						cell.setCellValue("날짜:선택없음");
					}
					continue;
				}
				
				if(rowNo == 5){
					String searchGubn = "";
					if(gubn != null){
						for(String gubnCode : gubn){
							if(gubnCode.equals("1")){
								searchGubn += "부류 ";
							}else if(gubnCode.equals("2")){
								searchGubn += "품목 ";
							}else if(gubnCode.equals("3")){
								searchGubn += "품종 ";
							}
						}
						cell.setCellValue("표시단위:"+searchGubn);
					}else{
						cell.setCellValue("표시단위:선택없음");
					}
					continue;
				}
				if(rowNo == 6){
					if(itemCd != null && itemCd != ""){
						cell.setCellValue("품목명:"+itemCd);
					}else{
						cell.setCellValue("품목명:전체");
					}
					continue;
				}
				if(rowNo == 7){
					if(itemCd2 != null && itemCd2 != ""){
						cell.setCellValue("품종명:"+itemCd2);
					}else{
						cell.setCellValue("품종명:품목미선택");
					}
					continue;
				}*/
			}
			
			

			// 컨텐츠 타입과 파일명 지정
			pResponse.setContentType("ms-vnd/excel");
			pResponse.setHeader("Content-Disposition", "attachment;filename="+new String((excelNm).getBytes("KSC5601"),"8859_1")+".xls");
		
			// 엑셀 출력
			wb.write(pResponse.getOutputStream());
			wb.close();
	
		} catch (ArithmeticException e) {
			log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
		} catch (NumberFormatException e) {
			log.error("오류발생 숫자로 변환 할 수 없습니다!!");
		} catch (ArrayIndexOutOfBoundsException e) {
			log.error("오류발생 배열인텍스에서 벗어났습니다!!");
		} catch (NegativeArraySizeException e) {
			log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
		} catch (NullPointerException e) {
			log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
		} catch (NoSuchMethodError e) {
			log.error("오류발생 메서드를 찾을수 없습니다!!");
		} catch (NoClassDefFoundError e) {
			log.error("오류발생 클래스를 찾을 수 없습니다!!");
		} catch (Exception e) {
			log.error(e.getMessage());
		}
	}
	
	@RequestMapping(value="/excel/excelDownLoadHaaTotal00.do")
	public void excelDownLoadHaaTotal00(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam(value="flowerCd") List<String> flowerCd
			,@RequestParam(value="cmpCd") List<String> cmpCd
			,@RequestParam(value="searchStrDate") String searchStrDate
			,@RequestParam(value="searchEndDate") String searchEndDate
			,@RequestParam(value="type") String type
			,@RequestParam(value="itemCd") String itemCd
			,@RequestParam(value="itemCd2") String itemCd2
			,@RequestParam(value="gubn") List<String> gubn
			,@RequestParam(value="excelNm") String excelNm
			,@RequestParam(value="pumName") String pumName
			,@RequestParam(value="goodName") String goodName
			, ModelMap model){
		
		System.out.println("======================================================== "+excelNm);

		try {
			 // 워크북 생성
			Workbook wb = new HSSFWorkbook();
			Sheet sheet = wb.createSheet(excelNm);
			Row row = null;
			Cell cell = null;
			int rowNo = 0;

			//1.셀 스타일 및 폰트 설정
			CellStyle style = wb.createCellStyle();
			style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			CellStyle LineBreakStyle = wb.createCellStyle();
			LineBreakStyle.setWrapText(true);
			
			CellStyle blueStyle = wb.createCellStyle();
			blueStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			CellStyle redStyle = wb.createCellStyle();
			redStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			//폰트 색상 설정			
			HSSFFont blueFont = (HSSFFont) wb.createFont();
			blueFont.setColor(HSSFColor.BLUE.index);
			blueStyle.setFont(blueFont);
			
			
			HSSFFont RedFont = (HSSFFont) wb.createFont();
			RedFont.setColor(HSSFColor.RED.index);
			redStyle.setFont(RedFont);

			Map<String, Object> paramMap = new HashMap<String, Object>();
			List<EgovMap> list;
			
			paramMap.put("flowerCd", flowerCd);
			paramMap.put("cmpCd", cmpCd);
			paramMap.put("itemCd", itemCd);
			paramMap.put("itemCd2", itemCd2);
			paramMap.put("searchStrDate", searchStrDate);
			paramMap.put("searchEndDate", searchEndDate);
			paramMap.put("type", type);
			paramMap.put("gubn", gubn);

			list = haa00Service.selectAuctionListTotal(paramMap);
			
			//검색조건 생성
			row = sheet.createRow(rowNo++);
			cell = row.createCell(0);
			cell.setCellValue("검색조건");
			cell = row.createCell(1);
			String searchFlower = "";
			if(flowerCd != null){
				for(String flowerCode : flowerCd){
					if(flowerCode.equals("1")){
						searchFlower += "절화 ";
					}else if(flowerCode.equals("2")){
						searchFlower += "관엽 ";
					}else if(flowerCode.equals("3")){
						searchFlower += "난 ";
					}else if(flowerCode.equals("4")){
						searchFlower += "춘란 ";
					}
				}
				
				cell.setCellValue("부류:"+searchFlower);
			}else{
				cell.setCellValue("부류:선택없음");
			}
			cell = row.createCell(2);
			
			String searchCmp = "";
			if(cmpCd != null){
				for(String cmpCode : cmpCd){
					if(cmpCode.equals("0000000001")){
						searchCmp += "aT화훼(양재) ";
					}else if(cmpCode.equals("1508500020")){
						searchCmp += "부산화훼(엄궁) ";
					}else if(cmpCode.equals("6068207466")){
						searchCmp += "부경화훼(강동) ";
					}else if(cmpCode.equals("4108212335")){
						searchCmp += "광주원예(풍암) ";
					}else if(cmpCode.equals("3848200087")){
						searchCmp += "한국화훼(음성) ";
					}else if(cmpCode.equals("1288202296")){
						searchCmp += "한국화훼(과천) ";
					}else if(cmpCode.equals("6158209828")){
						searchCmp += "영남화훼(김해) ";
					}
				}
				
				cell.setCellValue("공판장:"+searchCmp);
			}else{
				cell.setCellValue("공판장:선택없음");
			}
			cell = row.createCell(3);
			if(searchStrDate != null && searchEndDate != null){
				cell.setCellValue("시작일:"+searchStrDate+",종료일:"+ searchEndDate);
			}else{
				cell.setCellValue("날짜:선택없음");
			}
			
			cell = row.createCell(4);
			String searchGubn = "";
			if(gubn != null){
				for(String gubnCode : gubn){
					if(gubnCode.equals("1")){
						searchGubn += "부류 ";
					}else if(gubnCode.equals("2")){
						searchGubn += "품목 ";
					}else if(gubnCode.equals("3")){
						searchGubn += "품종 ";
					}
				}
				cell.setCellValue("표시단위:"+searchGubn);
			}else{
				cell.setCellValue("표시단위:선택없음");
			}
			cell = row.createCell(5);
			if(itemCd != null && itemCd != ""){
				cell.setCellValue("품목명:"+pumName);
			}else{
				cell.setCellValue("품목명:전체");
			}
			
			cell = row.createCell(6);
			if(itemCd2 != null && itemCd2 != ""){
				cell.setCellValue("품종명:"+goodName);
			}else{
				cell.setCellValue("품종명:품목미선택");
			}
			
			
			
			
			
			// 헤더 생성
			row = sheet.createRow(rowNo++);
			cell = row.createCell(0);
			cell.setCellValue("부류");
			cell = row.createCell(1);
			cell.setCellValue("품목");
			cell = row.createCell(2);
			cell.setCellValue("품종");
			cell = row.createCell(3);
			cell.setCellValue("총수량");
			cell = row.createCell(4);
			cell.setCellValue("총금액");
			cell = row.createCell(5);
			cell.setCellValue("최대금액");
			cell = row.createCell(6);
			cell.setCellValue("최저금액");
			cell = row.createCell(7);
			cell.setCellValue("평균금액");
			cell = row.createCell(8);
			cell.setCellValue("날짜");
			cell = row.createCell(9);
			cell.setCellValue("공판장");
						
			
			// 데이터 부분 생성
			for(Map<String,Object> vo : list) {
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue(vo.get("FLOWERNAME").toString());
				cell = row.createCell(1);
				if(vo.get("PUMNAME") != null){
					cell.setCellValue(vo.get("PUMNAME").toString());
				}
				cell = row.createCell(2);
				if(vo.get("GOODNAME") != null){
					cell.setCellValue(vo.get("GOODNAME").toString());
				}
				cell = row.createCell(3);
				if(vo.get("TOTQTY") != null){
					cell.setCellValue(Double.parseDouble(vo.get("TOTQTY").toString()));
				}
				cell = row.createCell(4);
				if(vo.get("TOTAMT") != null){
					cell.setCellValue(Double.parseDouble(vo.get("TOTAMT").toString()));
				}
				cell = row.createCell(5);
				if(vo.get("MAXAMT") != null){
					cell.setCellValue(Double.parseDouble(vo.get("MAXAMT").toString()));
				}
				cell = row.createCell(6);
				if(vo.get("MINAMT") != null){
					cell.setCellValue(Double.parseDouble(vo.get("MINAMT").toString()));
				}
				cell = row.createCell(7);
				if(vo.get("AVGAMT") != null){
					cell.setCellValue(Double.parseDouble(vo.get("AVGAMT").toString()));
				}
				cell = row.createCell(8);
				if(vo.get("SALEDATE") != null){
					cell.setCellValue(vo.get("SALEDATE").toString());
				}
				cell = row.createCell(9);
				if(vo.get("MARKETNAME") != null){
					cell.setCellValue(vo.get("MARKETNAME").toString());
				}

			}
			
			

			// 컨텐츠 타입과 파일명 지정
			pResponse.setContentType("ms-vnd/excel");
			pResponse.setHeader("Content-Disposition", "attachment;filename="+new String((excelNm).getBytes("KSC5601"),"8859_1")+".xls");
		
			// 엑셀 출력
			wb.write(pResponse.getOutputStream());
			wb.close();
	
		} catch (ArithmeticException e) {
			log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
		} catch (NumberFormatException e) {
			log.error("오류발생 숫자로 변환 할 수 없습니다!!");
		} catch (ArrayIndexOutOfBoundsException e) {
			log.error("오류발생 배열인텍스에서 벗어났습니다!!");
		} catch (NegativeArraySizeException e) {
			log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
		} catch (NullPointerException e) {
			log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
		} catch (NoSuchMethodError e) {
			log.error("오류발생 메서드를 찾을수 없습니다!!");
		} catch (NoClassDefFoundError e) {
			log.error("오류발생 클래스를 찾을 수 없습니다!!");
		} catch (Exception e) {
			log.error(e.getMessage());
		}
	}
	
	// 개별 주출하지별출고현황
	@RequestMapping(value="/excel/excelDownLoadHga04Each.do")
	public void excelDownLoadHga04Each(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam(value="excelNm") String excelNm
			,@RequestParam(value="dateType") String dateType
			,@RequestParam(value="searchStrDate") String searchStrDate
			,@RequestParam(value="searchEndDate") String searchEndDate
			,@RequestParam(value="itemCd") String itemCd
			,@RequestParam(value="itemNm") String itemNm
			,@RequestParam(value="kindCd") String kindCd
			,@RequestParam(value="kindNm") String kindNm
			,@RequestParam(value="cmpCd2") String cmpCd2
			,@RequestParam(value="cmpNm2") String cmpNm2
			,@RequestParam(value="flowerCd") List<String> flowerCd
			,@RequestParam(value="flowerNm") List<String> flowerNm
			,@RequestParam(value="searchStrYear") String searchStrYear
			, ModelMap model){
		System.out.println("===excelDownLoadHga04Each===================================================== excelNm : "+excelNm);		
		
		try{
			// 워크북 생성
			// 65536건 이상인 경우 XSSFWorkbook 사용
			Workbook wb = new XSSFWorkbook();//HSSFWorkbook();			
			
			Sheet sheet = wb.createSheet("개별 주출하지별 출고형황");
			
			Row row = null;
			Cell cell = null;
			int rowNo = 0;
			
			//1.셀 스타일 및 폰트 설정
			CellStyle style = wb.createCellStyle();
			style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			CellStyle LineBreakStyle = wb.createCellStyle();
			LineBreakStyle.setWrapText(true);
			
			CellStyle blueStyle = wb.createCellStyle();
			blueStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			CellStyle redStyle = wb.createCellStyle();
			redStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			//폰트 색상 설정			
			XSSFFont blueFont = (XSSFFont) wb.createFont();
			blueFont.setColor(IndexedColors.BLUE.index);
			//blueFont.setColor(HSSFColor.BLUE.index);
			blueStyle.setFont(blueFont);			
			
			XSSFFont RedFont = (XSSFFont) wb.createFont();
			RedFont.setColor(IndexedColors.RED.index);
			//RedFont.setColor(HSSFColor.RED.index);
			redStyle.setFont(RedFont);

			Map<String, Object> paramMap = new HashMap<String, Object>();
			// 조회조건
			paramMap.put("dateType", dateType);
			paramMap.put("searchStrDate", searchStrDate);
			paramMap.put("searchEndDate", searchEndDate);
			paramMap.put("itemCd", itemCd);
			paramMap.put("itemNm", itemNm);
			paramMap.put("kindCd", kindCd);
			paramMap.put("kindNm", kindNm);
			paramMap.put("cmpCd2", cmpCd2);
			paramMap.put("flowerCd", flowerCd);
			paramMap.put("searchStrYear", searchStrYear);
			
			List<EgovMap> list = hga04Service.selectExcelSearchEach(paramMap);	// 엑셀다운 (개별) list

			// 엑셀다운 (개별) list 조회조건
			// dateType, searchStrDate, searchEndDate, itemCd, itemNm, kindCd, kindNm, cmpCd2, flowerCd, searchStrYear

			String sDate = searchStrDate+"~"+searchEndDate;
			
			String sPram = "조회기간 : " + sDate +
					        " / 품목명 : " + itemNm +					        
					        " / 품종명 : " + kindNm +					        
					        " / 경매장명 : " + cmpNm2 +					        
					        " / 부류명 : " +  flowerNm					        
					        ;
			row = sheet.createRow(rowNo++);
			cell = row.createCell(0);
			cell.setCellValue(sPram);
			
			// 공백 row 추가
			row = sheet.createRow(rowNo++);
			
			// 엑셀다운 (개별) list 헤더 생성
			// PUM_NAME, GOOD_NAME, MARKET_NAME, MARKET_CD, SAN_BIGO_SI, SAN_BIGO_GUN, TOT_QTY, TOT_AMT
			// 품목명, 품종명, 경재장명, 경재장코드, 시, 군, 총수량, 총금액
			row = sheet.createRow(rowNo++);
			cell = row.createCell(0);
			cell.setCellValue("일자");
			cell = row.createCell(1);
			cell.setCellValue("품목명");
			cell = row.createCell(2);
			cell.setCellValue("품종명");
			cell = row.createCell(3);
			cell.setCellValue("경매장명");			
			cell = row.createCell(4);
			cell.setCellValue("경매장코드");
			cell = row.createCell(5);
			cell.setCellValue("시");
			cell = row.createCell(6);
			cell.setCellValue("군");
			cell = row.createCell(7);
			cell.setCellValue("총수량");
			cell = row.createCell(8);
			cell.setCellValue("총금액");
			
			// 엑셀다운 (개별) list 데이터 부분 생성
			// PUM_NAME, GOOD_NAME, MARKET_NAME, MARKET_CD, SAN_BIGO_SI, SAN_BIGO_GUN, TOT_QTY, TOT_AMT
			// 품목명, 품종명, 경재장명, 경재장코드, 시, 군, 총수량, 총금액
			for(EgovMap vo : list) {
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);		// 일자
				cell.setCellValue(vo.get("saleDate").toString());
				cell = row.createCell(1);		// 품목명
				cell.setCellValue(vo.get("pumName").toString());
				cell = row.createCell(2);		// 품종명
				cell.setCellValue(vo.get("goodName").toString());
				cell = row.createCell(3);		// 공판장명
				cell.setCellValue(vo.get("marketName").toString());
				cell = row.createCell(4);		// 공판장코드
				cell.setCellValue(vo.get("marketCd").toString());
				cell = row.createCell(5);		// 시
				cell.setCellValue(vo.get("sanBigoSi").toString());				
				cell = row.createCell(6);		// 군
				cell.setCellValue(vo.get("sanBigoGun").toString());
				cell = row.createCell(7);		// 총수량
				cell.setCellValue(vo.get("totQty").toString());
				cell = row.createCell(8);		// 총금액
				cell.setCellValue(vo.get("totAmt").toString());
			}
			
			// 컨텐츠 타입과 파일명 지정
			pResponse.setContentType("ms-vnd/excel");
			
			// jsp get방식 한글 파일명 깨짐으로 파일명 지정
			String excelNm1 = "개별 주출하지별출고현황";
			String encodedFilename = new String((excelNm1).getBytes("KSC5601"),"8859_1");
			pResponse.setHeader("Content-Disposition", "attachment; fileName=\"" + encodedFilename + ".xlsx" + "\""); 
		
			// 엑셀 출력
			wb.write(pResponse.getOutputStream());
			wb.close();
			
		} catch (ArithmeticException e) {
			log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
		} catch (NumberFormatException e) {
			log.error("오류발생 숫자로 변환 할 수 없습니다!!");
		} catch (ArrayIndexOutOfBoundsException e) {
			log.error("오류발생 배열인텍스에서 벗어났습니다!!");
		} catch (NegativeArraySizeException e) {
			log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
		} catch (NullPointerException e) {
			log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
		} catch (NoSuchMethodError e) {
			log.error("오류발생 메서드를 찾을수 없습니다!!");
		} catch (NoClassDefFoundError e) {
			log.error("오류발생 클래스를 찾을 수 없습니다!!");
		} catch (Exception e) {
			log.error(e.getMessage());
		}
	}
	
	// 통합 주출하지별출고현황
	@RequestMapping(value="/excel/excelDownLoadHga04Tot.do")
	public void excelDownLoadHga04Tot(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam(value="excelNm") String excelNm
			,@RequestParam(value="dateType") String dateType
			,@RequestParam(value="searchStrDate") String searchStrDate
			,@RequestParam(value="searchEndDate") String searchEndDate
			,@RequestParam(value="itemCd") String itemCd
			,@RequestParam(value="itemNm") String itemNm
			,@RequestParam(value="kindCd") String kindCd
			,@RequestParam(value="kindNm") String kindNm
			,@RequestParam(value="cmpCd") List<String> cmpCd
			,@RequestParam(value="cmpNm") List<String> cmpNm
			,@RequestParam(value="flowerCd") List<String> flowerCd
			,@RequestParam(value="flowerNm") List<String> flowerNm
			,@RequestParam(value="searchStrYear") String searchStrYear
			, ModelMap model){

		System.out.println("===excelDownLoadHga04Tot====================================================== excelNm : "+excelNm);
		
		try {
			// 워크북 생성
			// 65536건 이상인 경우 XSSFWorkbook 사용
			Workbook wb = new XSSFWorkbook();//HSSFWorkbook();
			
			Sheet sheet = wb.createSheet("통합 주출하지별 출고현황");		// 좌측 지도 (통합)
			
			Row row = null;
			Cell cell = null;
			int rowNo = 0;

			//1.셀 스타일 및 폰트 설정
			CellStyle style = wb.createCellStyle();
			style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			CellStyle LineBreakStyle = wb.createCellStyle();
			LineBreakStyle.setWrapText(true);
			
			CellStyle blueStyle = wb.createCellStyle();
			blueStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			CellStyle redStyle = wb.createCellStyle();
			redStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			//폰트 색상 설정			
			XSSFFont blueFont = (XSSFFont) wb.createFont();
			blueFont.setColor(IndexedColors.BLUE.index);
			//blueFont.setColor(HSSFColor.BLUE.index);
			blueStyle.setFont(blueFont);			
			
			XSSFFont RedFont = (XSSFFont) wb.createFont();
			RedFont.setColor(IndexedColors.RED.index);
			//RedFont.setColor(HSSFColor.RED.index);
			redStyle.setFont(RedFont);

			Map<String, Object> paramMap = new HashMap<String, Object>();
			// 조회조건
			paramMap.put("dateType", dateType);
			paramMap.put("searchStrDate", searchStrDate);
			paramMap.put("searchEndDate", searchEndDate);
			paramMap.put("itemCd", itemCd);
			paramMap.put("itemNm", itemNm);
			paramMap.put("kindCd", kindCd);
			paramMap.put("kindNm", kindNm);
			paramMap.put("cmpCd", cmpCd);
			paramMap.put("flowerCd", flowerCd);
			paramMap.put("searchStrYear", searchStrYear);
			
			List<EgovMap> list = hga04Service.selectExcelSearchTot(paramMap);	// 엑셀다운 (통합) list

			// 엑셀다운 (통합) list 조회조건
			// dateType, searchStrDate, searchEndDate, itemCd, itemNm, kindCd, kindNm, cmpCd, cmpNm, flowerCd, flowerNm searchStrYear

			String sDate = searchStrDate+"~"+searchEndDate;
			
			String sPram = "조회기간 : " + sDate +
					        " / 품목명 : " + itemNm +					        
					        " / 품종명 : " + kindNm +					        
					        " / 경매장명 : " + cmpNm +					        
					        " / 부류명 : " +  flowerNm					        
					        ;
			row = sheet.createRow(rowNo++);
			cell = row.createCell(0);
			cell.setCellValue(sPram);
			
			// 공백 row 추가
			row = sheet.createRow(rowNo++);
			
			// 엑셀다운 (통합) list 헤더 생성
			// ITEM_NM, KIND_NM, MARKET_NAME, MARKET_CD, SAN_NAME, SAN_BIGO_SI, SAN_BIGO_GUN, QTY, AMT
			// 품목명, 품종명, 경매장명, 경매장코드, 시도코드, 시, 군, 총수량, 총금액
			row = sheet.createRow(rowNo++);
			cell = row.createCell(0);
			cell.setCellValue("일자");
			cell = row.createCell(1);
			cell.setCellValue("품목명");
			cell = row.createCell(2);
			cell.setCellValue("품종명");
			cell = row.createCell(3);
			cell.setCellValue("경매장명");			
			cell = row.createCell(4);
			cell.setCellValue("경매장코드");			
			cell = row.createCell(5);		
			cell.setCellValue("시도코드");			
			cell = row.createCell(6);	
			cell.setCellValue("시");			
			cell = row.createCell(7);			
			cell.setCellValue("군");
			cell = row.createCell(8);
			cell.setCellValue("총수량");
			cell = row.createCell(9);
			cell.setCellValue("총금액");
			
			// 엑셀다운 (통합) list 데이터 부분 생성
			// ITEM_NM, KIND_NM, MARKET_NAME, MARKET_CD, SAN_NAME, SAN_BIGO, QTY, AMT
			// 품목명, 품종명, 경재장명, 경재장코드, 비고, 총수량, 총금액
			for(EgovMap vo : list) {
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);		// 일자
				cell.setCellValue(vo.get("saleDate").toString());
				cell = row.createCell(1);		// 품목명
				cell.setCellValue(vo.get("itemNm").toString());
				cell = row.createCell(2);		// 품종명
				cell.setCellValue(vo.get("kindNm").toString());
				cell = row.createCell(3);		// 경매장명
				cell.setCellValue(vo.get("marketName").toString());
				cell = row.createCell(4);		// 경매장코드
				cell.setCellValue(vo.get("sanName").toString());
				cell = row.createCell(5);		// 시도코드
				cell.setCellValue(vo.get("marketCd").toString());
				cell = row.createCell(6);		// 시
				cell.setCellValue(vo.get("sanBigoSi").toString());
				cell = row.createCell(7);		// 군
				cell.setCellValue(vo.get("sanBigoGun").toString());
				cell = row.createCell(8);		// 총수량
				cell.setCellValue(vo.get("qty").toString());
				cell = row.createCell(9);		// 총금액
				cell.setCellValue(vo.get("amt").toString());
			}
			
			// 컨텐츠 타입과 파일명 지정
			pResponse.setContentType("ms-vnd/excel");
			
			// jsp get방식 한글 파일명 깨짐으로 파일명 지정
			String excelNm1 = "통합 주출하지별출고현황";
			String encodedFilename = new String((excelNm1).getBytes("KSC5601"),"8859_1");
			pResponse.setHeader("Content-Disposition", "attachment; fileName=\"" + encodedFilename + ".xlsx" + "\""); 
		
			// 엑셀 출력
			wb.write(pResponse.getOutputStream());
			wb.close();		
						
		} catch (ArithmeticException e) {
			log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
		} catch (NumberFormatException e) {
			log.error("오류발생 숫자로 변환 할 수 없습니다!!");
		} catch (ArrayIndexOutOfBoundsException e) {
			log.error("오류발생 배열인텍스에서 벗어났습니다!!");
		} catch (NegativeArraySizeException e) {
			log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
		} catch (NullPointerException e) {
			log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
		} catch (NoSuchMethodError e) {
			log.error("오류발생 메서드를 찾을수 없습니다!!");
		} catch (NoClassDefFoundError e) {
			log.error("오류발생 클래스를 찾을 수 없습니다!!");
		} catch (Exception e) {
			log.error(e.getMessage());
		}
	}
	
	@RequestMapping(value="/excel/excelDownLoadHab10.do")
	public void excelDownLoadHab10(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam(value="searchProductGubun") String searchProductGubun
			,@RequestParam(value="searchCmpCd") String searchCmpCd
			,@RequestParam(value="searchYear") String searchYear
			,@RequestParam(value="excelNm") String excelNm
			, ModelMap model){
		
		System.out.println("======================================================== "+excelNm);

		try {
			 // 워크북 생성
			Workbook wb = new HSSFWorkbook();
			Sheet sheet = wb.createSheet(excelNm);
			Row row = null;
			Cell cell = null;
			int rowNo = 0;

			//1.셀 스타일 및 폰트 설정
			CellStyle style = wb.createCellStyle();
			style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			CellStyle LineBreakStyle = wb.createCellStyle();
			LineBreakStyle.setWrapText(true);
			
			CellStyle blueStyle = wb.createCellStyle();
			blueStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			CellStyle redStyle = wb.createCellStyle();
			redStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			//폰트 색상 설정			
			HSSFFont blueFont = (HSSFFont) wb.createFont();
			blueFont.setColor(HSSFColor.BLUE.index);
			blueStyle.setFont(blueFont);
			
			
			HSSFFont RedFont = (HSSFFont) wb.createFont();
			RedFont.setColor(HSSFColor.RED.index);
			redStyle.setFont(RedFont);

			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("searchProductGubun", searchProductGubun);
			paramMap.put("searchCmpCd", searchCmpCd);
			paramMap.put("searchYear", searchYear);
			
			List<Hab10VO> resultList = (List<Hab10VO>)hab10Service.selectHab10(paramMap);
			
			String searchProductGubunNm = "";
			String searchCmpCdNm = "";
			
			if(!"".equals(searchProductGubun)){
				switch (searchProductGubun) {
					case "1":
						searchProductGubunNm = "절화";
						break;
					case "3":
						searchProductGubunNm = "난";
						break;
					case "2":
						searchProductGubunNm = "관엽";
						break;
					case "4":
						searchProductGubunNm = "춘란";
						break;
				}
			}
			
			if(!"".equals(searchCmpCd)){
				switch (searchCmpCd) {
					case "0000000001":
						searchCmpCdNm = "aT화훼공판장(양재동)";
						break;
					case "1508500020":
						searchCmpCdNm = "부산화훼공판장(엄궁동)";
						break;
					case "6068207466":
						searchCmpCdNm = "부산경남화훼농협(강동동)";
						break;
					case "4108212335":
						searchCmpCdNm = "광주원예농협(풍암)";
						break;
					case "3848200087":
						searchCmpCdNm = "한국화훼농협(음성)";
						break;
					case "1288202296":
						searchCmpCdNm = "한국화훼농협(과천)";
						break;
					case "6158209828":
						searchCmpCdNm = "영남화훼농협(김해)";
						break;
				}
			}

			
			row = sheet.createRow(rowNo++);
			cell = row.createCell(0);
			cell.setCellValue("검색조건 ");
			cell = row.createCell(1);
			cell.setCellValue("기준년도:"+searchYear);
			cell = row.createCell(2);
			cell.setCellValue("경매장:"+searchCmpCdNm);
			cell = row.createCell(3);
			cell.setCellValue("부류:"+searchProductGubunNm);

			

			row = sheet.createRow(rowNo++);
			cell = row.createCell(0);
			cell.setCellValue("기준년도");
			cell = row.createCell(1);
			cell.setCellValue("거래량(만단)");
			cell = row.createCell(2);
			cell.setCellValue("경매금액(백만원)");
			
			for(Hab10VO vo : resultList) {
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue(vo.getSaleYear());
				cell = row.createCell(1);
				cell.setCellValue(vo.getTotQty());
				cell = row.createCell(2);
				cell.setCellValue(vo.getTotAmt());
			}
			
			//컨텐츠 타입과 파일명 지정
			pResponse.setContentType("ms-vnd/excel");
			pResponse.setHeader("Content-Disposition", "attachment;filename="+new String((excelNm).getBytes("KSC5601"),"8859_1")+".xls");
		
			// 엑셀 출력
			wb.write(pResponse.getOutputStream());
			wb.close();
	
		} catch (ArithmeticException e) {
			log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
		} catch (NumberFormatException e) {
			log.error("오류발생 숫자로 변환 할 수 없습니다!!");
		} catch (ArrayIndexOutOfBoundsException e) {
			log.error("오류발생 배열인텍스에서 벗어났습니다!!");
		} catch (NegativeArraySizeException e) {
			log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
		} catch (NullPointerException e) {
			log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
		} catch (NoSuchMethodError e) {
			log.error("오류발생 메서드를 찾을수 없습니다!!");
		} catch (NoClassDefFoundError e) {
			log.error("오류발생 클래스를 찾을 수 없습니다!!");
		} catch (Exception e) {
			log.error(e.getMessage());
		}
	}
	
	@RequestMapping(value="/excel/excelDownLoadHga06_new.do")
	public void excelDownLoadHga06_new(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam(value="searchDate") String searchDate
			,@RequestParam(value="type") String type
			,@RequestParam(value="type2") String type2
			,@RequestParam(value="excelNm") String excelNm
			,@RequestParam(value="itemCd") String itemCd
			, ModelMap model){
		
		System.out.println("======================================================== "+excelNm);
		
		try {
			 // 워크북 생성
			Workbook wb = new HSSFWorkbook();
			Sheet sheet = wb.createSheet(excelNm);
			Row row = null;
			Cell cell = null;
			int rowNo = 0;

			//1.셀 스타일 및 폰트 설정
			CellStyle style = wb.createCellStyle();
			style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			CellStyle LineBreakStyle = wb.createCellStyle();
			LineBreakStyle.setWrapText(true);
			
			CellStyle blueStyle = wb.createCellStyle();
			blueStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			CellStyle redStyle = wb.createCellStyle();
			redStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			//폰트 색상 설정			
			HSSFFont blueFont = (HSSFFont) wb.createFont();
			blueFont.setColor(HSSFColor.BLUE.index);
			blueStyle.setFont(blueFont);
			
			
			HSSFFont RedFont = (HSSFFont) wb.createFont();
			RedFont.setColor(HSSFColor.RED.index);
			redStyle.setFont(RedFont);

			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("type", type);
			paramMap.put("itemCd", itemCd);
			paramMap.put("type2", type2);
			paramMap.put("searchDateM", searchDate);
			
			
			List<EgovMap> resultList = null;
			List<EgovMap> resultList2 = null;
			if("sExp".equals(type)) {
				// 수출 월별 국가 수
				resultList = hga06_newService.selectExpNatCnt(paramMap);
				resultList2 = hga06_newService.selectExp(paramMap);
			}
			else if("sImp".equals(type)) {
				// 수입 월별 국가 수
				resultList = hga06_newService.selectImpNatCnt(paramMap);
				resultList2 = hga06_newService.selectImp(paramMap);
			}
			
			String typeNm = "수출";
			String type2Nm = "금액";
			
			if("sImp".equals(type)){
				typeNm = "수입";
			}
			if("sQty".equals(type)){
				type2Nm = "물량";
			}
			
			row = sheet.createRow(rowNo++);
			cell = row.createCell(0);
			cell.setCellValue("검색조건 ");
			cell = row.createCell(1);
			cell.setCellValue("수출입기준:"+typeNm);
			cell = row.createCell(2);
			cell.setCellValue("표시단위:"+type2Nm);
			cell = row.createCell(3);
			cell.setCellValue("기준년월:"+searchDate);

			
			int cellNo = 0;
			row = sheet.createRow(rowNo++);
			cell = row.createCell(cellNo++);
			cell.setCellValue("국가");
			cell = row.createCell(cellNo++);
			cell.setCellValue("구분");
			for(EgovMap vo : resultList) {
				cell = row.createCell(cellNo++);
				cell.setCellValue((String) vo.get("yyyymm"));
			}
			
			
			for(EgovMap vo : resultList2) {
				cellNo = 0;
				row = sheet.createRow(rowNo++);
				cell = row.createCell(cellNo++);
				cell.setCellValue((String) vo.get("natNm"));
				cell = row.createCell(cellNo++);
				cell.setCellValue((String) vo.get("impexpGubun"));
				
				if("sExp".equals(type)){
					if("sPrc".equals(type2)){
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("expPrc1"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("expPrc2"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("expPrc3"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("expPrc4"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("expPrc5"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("expPrc6"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("expPrc7"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("expPrc8"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("expPrc9"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("expPrc10"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("expPrc11"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("expPrc12"));
					}else if("sQty".equals(type2)){
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("expQty1"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("expQty2"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("expQty3"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("expQty4"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("expQty5"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("expQty6"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("expQty7"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("expQty8"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("expQty9"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("expQty10"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("expQty11"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("expQty12"));
					}
				}else if("sImp".equals(type)){
					if("sPrc".equals(type2)){
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("impPrc1"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("impPrc2"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("impPrc3"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("impPrc4"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("impPrc5"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("impPrc6"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("impPrc7"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("impPrc8"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("impPrc9"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("impPrc10"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("impPrc11"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("impPrc12"));
					}else if("sQty".equals(type2)){
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("impQty1"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("impQty2"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("impQty3"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("impQty4"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("impQty5"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("impQty6"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("impQty7"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("impQty8"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("impQty9"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("impQty10"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("impQty11"));
						cell = row.createCell(cellNo++);
						cell.setCellValue((String) vo.get("impQty12"));
					}
				}

			}
			
			//컨텐츠 타입과 파일명 지정
			pResponse.setContentType("ms-vnd/excel");
			pResponse.setHeader("Content-Disposition", "attachment;filename="+new String((excelNm).getBytes("KSC5601"),"8859_1")+".xls");
		
			// 엑셀 출력
			wb.write(pResponse.getOutputStream());
			wb.close();
	
		} catch (ArithmeticException e) {
			log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
		} catch (NumberFormatException e) {
			log.error("오류발생 숫자로 변환 할 수 없습니다!!");
		} catch (ArrayIndexOutOfBoundsException e) {
			log.error("오류발생 배열인텍스에서 벗어났습니다!!");
		} catch (NegativeArraySizeException e) {
			log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
		} catch (NullPointerException e) {
			log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
		} catch (NoSuchMethodError e) {
			log.error("오류발생 메서드를 찾을수 없습니다!!");
		} catch (NoClassDefFoundError e) {
			log.error("오류발생 클래스를 찾을 수 없습니다!!");
		} catch (Exception e) {
			log.error(e.getMessage());
		}
	}
	
	@RequestMapping(value="/excel/excelDownLoadHab11.do")
	public void excelDownLoadHab11(HttpServletRequest pRequest, HttpServletResponse pResponse, 
			@RequestParam(value="excelNm") String excelNm, 
			@RequestParam(value="saleDate1From") String saleDate1From,
			@RequestParam(value="saleDate1To") String saleDate1To,
			@RequestParam(value="saleDate2From") String saleDate2From,
			@RequestParam(value="saleDate2To") String saleDate2To,
			@RequestParam(value="flower1Str", required=false) String flower1Str,
			@RequestParam(value="market1Str", required=false) String market1Str,
			@RequestParam(value="item1Str", required=false) String item1Str,
			@RequestParam(value="itemDtl1Str", required=false) String itemDtl1Str,
			@RequestParam(value="flower2Str", required=false) String flower2Str,
			@RequestParam(value="market2Str", required=false) String market2Str,
			@RequestParam(value="item2Str", required=false) String item2Str,
			@RequestParam(value="itemDtl2Str", required=false) String itemDtl2Str,
			ModelMap model){
		
		System.out.println("======================================================== "+excelNm);
		
		try {
			 // 워크북 생성
			Workbook wb = new HSSFWorkbook();
			Sheet sheet = wb.createSheet(excelNm);
			Row row = null;
			Cell cell = null;
			int rowNo = 0;

			//1.셀 스타일 및 폰트 설정
			CellStyle style = wb.createCellStyle();
			style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			CellStyle LineBreakStyle = wb.createCellStyle();
			LineBreakStyle.setWrapText(true);
			
			CellStyle blueStyle = wb.createCellStyle();
			blueStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			CellStyle redStyle = wb.createCellStyle();
			redStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			//폰트 색상 설정			
			HSSFFont blueFont = (HSSFFont) wb.createFont();
			blueFont.setColor(HSSFColor.BLUE.index);
			blueStyle.setFont(blueFont);
			
			
			HSSFFont RedFont = (HSSFFont) wb.createFont();
			RedFont.setColor(HSSFColor.RED.index);
			redStyle.setFont(RedFont);
			
			List<String> flowerCtgrList1 = null;
			List<String> marketList1 = null;
			List<String> itemList1 = null;
			List<String> itemDtlList1 = null;
			List<String> flowerCtgrList2 = null;
			List<String> marketList2 = null;
			List<String> itemList2 = null;
			List<String> itemDtlList2 = null;
			
			if(flower1Str != null && !"".equals(flower1Str)){
				flowerCtgrList1 = Arrays.asList(flower1Str.split(","));
			}
			if(market1Str != null && !"".equals(market1Str)){
				marketList1 = Arrays.asList(market1Str.split(","));
			}
			if(item1Str != null && !"".equals(item1Str)){
				itemList1 = Arrays.asList(item1Str.split(","));
			}
			if(itemDtl1Str != null && !"".equals(itemDtl1Str)){
				itemDtlList1 = Arrays.asList(itemDtl1Str.split(","));
			}
			if(flower2Str != null && !"".equals(flower2Str)){
				flowerCtgrList2 = Arrays.asList(flower2Str.split(","));
			}
			if(market2Str != null && !"".equals(market2Str)){
				marketList2 = Arrays.asList(market2Str.split(","));
			}
			if(item2Str != null && !"".equals(item2Str)){
				itemList2 = Arrays.asList(item2Str.split(","));
			}
			if(itemDtl2Str != null && !"".equals(itemDtl2Str)){
				itemDtlList2 = Arrays.asList(itemDtl2Str.split(","));
			}
			
			
			
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("saleDate1From", saleDate1From);
			paramMap.put("saleDate1To", saleDate1To);
			paramMap.put("saleDate2From", saleDate2From);
			paramMap.put("saleDate2To", saleDate2To);
			paramMap.put("flowerCtgrList1", flowerCtgrList1);
			paramMap.put("marketList1", marketList1);
			paramMap.put("itemList1", itemList1);
			paramMap.put("itemDtlList1", itemDtlList1);
			paramMap.put("flowerCtgrList2", flowerCtgrList2);
			paramMap.put("marketList2", marketList2);
			paramMap.put("itemList2", itemList2);
			paramMap.put("itemDtlList2", itemDtlList2);
			List<EgovMap> list = hab11Service.selectList(paramMap);
			
			
			String flower1Nm = "";
			String market1Nm = "";
			String flower2Nm = "";
			String market2Nm = "";
			
			if(flowerCtgrList1 != null && flowerCtgrList1.size() > 0){
				for(int i=0;i<flowerCtgrList1.size();i++){
					String flowerNm = "";
					switch (flowerCtgrList1.get(i)) {
						case "1":
							flowerNm = "절화";
							break;
						case "3":
							flowerNm = "난";
							break;
						case "2":
							flowerNm = "관엽";
							break;
						case "4":
							flowerNm = "춘란";
							break;
					}
					
					if(!"".equals(flowerNm)){
						if(i == 0){
							flower1Nm = flowerNm;
						}else{
							flower1Nm += ", " + flowerNm;
						}
					}
				}
			}
			
			if(flowerCtgrList2 != null && flowerCtgrList2.size() > 0){
				for(int i=0;i<flowerCtgrList2.size();i++){
					String flowerNm = "";
					switch (flowerCtgrList2.get(i)) {
						case "1":
							flowerNm = "절화";
							break;
						case "3":
							flowerNm = "난";
							break;
						case "2":
							flowerNm = "관엽";
							break;
						case "4":
							flowerNm = "춘란";
							break;
					}
					
					if(!"".equals(flowerNm)){
						if(i == 0){
							flower2Nm = flowerNm;
						}else{
							flower2Nm += ", " + flowerNm;
						}
					}
				}
			}
			
			if(marketList1 != null && marketList1.size() > 0){
				for(int i=0;i<marketList1.size();i++){
					String marketNm = "";
					switch (marketList1.get(i)) {
						case "0000000001":
							marketNm = "aT화훼공판장(양재동)";
							break;
						case "1508500020":
							marketNm = "부산화훼공판장(엄궁동)";
							break;
						case "6068207466":
							marketNm = "부산경남화훼농협(강동동)";
							break;
						case "4108212335":
							marketNm = "광주원예농협(풍암)";
							break;
						case "3848200087":
							marketNm = "한국화훼농협(음성)";
							break;
						case "1288202296":
							marketNm = "한국화훼농협(과천)";
							break;
						case "6158209828":
							marketNm = "영남화훼농협(김해)";
							break;
					}
					
					if(!"".equals(marketNm)){
						if(i == 0){
							market1Nm = marketNm;
						}else{
							market1Nm += ", " + marketNm;
						}
					}
				}
			}
			
			if(marketList2 != null && marketList2.size() > 0){
				for(int i=0;i<marketList2.size();i++){
					String marketNm = "";
					switch (marketList2.get(i)) {
						case "0000000001":
							marketNm = "aT화훼공판장(양재동)";
							break;
						case "1508500020":
							marketNm = "부산화훼공판장(엄궁동)";
							break;
						case "6068207466":
							marketNm = "부산경남화훼농협(강동동)";
							break;
						case "4108212335":
							marketNm = "광주원예농협(풍암)";
							break;
						case "3848200087":
							marketNm = "한국화훼농협(음성)";
							break;
						case "1288202296":
							marketNm = "한국화훼농협(과천)";
							break;
						case "6158209828":
							marketNm = "영남화훼농협(김해)";
							break;
					}
					
					if(!"".equals(marketNm)){
						if(i == 0){
							market2Nm = marketNm;
						}else{
							market2Nm += ", " + marketNm;
						}
					}
				}
			}
			
			
			
			row = sheet.createRow(rowNo++);
			cell = row.createCell(0);
			cell.setCellValue("검색조건 ");
			cell = row.createCell(1);
			cell.setCellValue("조건1");
			cell = row.createCell(2);
			cell.setCellValue("기간:" + saleDate1From + " ~ " + saleDate1To);
			cell = row.createCell(3);
			cell.setCellValue("부류:"+flower1Nm);
			cell = row.createCell(4);
			cell.setCellValue("경매장:"+market1Nm);
			cell = row.createCell(5);
			cell.setCellValue("품목:"+item1Str);
			cell = row.createCell(6);
			cell.setCellValue("품종:"+itemDtl1Str);
			cell = row.createCell(7);
			cell.setCellValue("조건2");
			cell = row.createCell(8);
			cell.setCellValue("기간:" + saleDate2From + " ~ " + saleDate2To);
			cell = row.createCell(9);
			cell.setCellValue("부류:"+flower2Nm);
			cell = row.createCell(10);
			cell.setCellValue("경매장:"+market2Nm);
			cell = row.createCell(11);
			cell.setCellValue("품목:"+item2Str);
			cell = row.createCell(12);
			cell.setCellValue("품종:"+itemDtl2Str);
			
			row = sheet.createRow(rowNo++);
			cell = row.createCell(0);
			cell.setCellValue("비교");
			cell = row.createCell(1);
			cell.setCellValue("총금액");
			cell = row.createCell(2);
			cell.setCellValue("최대금액");
			cell = row.createCell(3);
			cell.setCellValue("최저금액");
			cell = row.createCell(4);
			cell.setCellValue("평균금액");
			cell = row.createCell(5);
			cell.setCellValue("수량");
			
//			int diffTotAmt  = 0;
//			int diffMaxAmt  = 0;
//			int diffMinAmt  = 0;
//			int diffAvgAmt  = 0;
//			int diffTotQty  = 0;
			
			
			for(int i=0;i<list.size();i++) {
				Map vo = list.get(i); 
				
				
				long totAmt = ((BigDecimal) vo.get("totAmt")).longValue();
				long maxAmt = ((BigDecimal) vo.get("maxAmt")).longValue();
				long minAmt = ((BigDecimal) vo.get("minAmt")).longValue();
				long avgAmt = ((BigDecimal) vo.get("avgAmt")).longValue();
				long totQty = ((BigDecimal) vo.get("totQty")).longValue();
				
//				if(i == 0){
//					diffTotAmt = totAmt;
//					diffMaxAmt = maxAmt;
//					diffMinAmt = minAmt;
//					diffAvgAmt = avgAmt;
//					diffTotQty = totQty;
//				}else{
//					diffTotAmt -= totAmt;
//					diffMaxAmt -= maxAmt;
//					diffMinAmt -= minAmt;
//					diffAvgAmt -= avgAmt;
//					diffTotQty -= totQty;
//				}
				
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue((String) vo.get("cdNm"));
				cell = row.createCell(1);
				cell.setCellValue(totAmt);
				cell = row.createCell(2);
				cell.setCellValue(maxAmt);
				cell = row.createCell(3);
				cell.setCellValue(minAmt);
				cell = row.createCell(4);
				cell.setCellValue(avgAmt);
				cell = row.createCell(5);
				cell.setCellValue(totQty);
			}
			
//			row = sheet.createRow(rowNo++);
//			cell = row.createCell(0);
//			cell.setCellValue("차이");
//			cell = row.createCell(1);
//			cell.setCellValue(Math.abs(diffTotAmt));
//			cell = row.createCell(2);
//			cell.setCellValue(Math.abs(diffMaxAmt));
//			cell = row.createCell(3);
//			cell.setCellValue(Math.abs(diffMinAmt));
//			cell = row.createCell(4);
//			cell.setCellValue(Math.abs(diffAvgAmt));
//			cell = row.createCell(5);
//			cell.setCellValue(Math.abs(diffTotQty));
			
			
			
			//컨텐츠 타입과 파일명 지정
			pResponse.setContentType("ms-vnd/excel");
			pResponse.setHeader("Content-Disposition", "attachment;filename="+new String((excelNm).getBytes("KSC5601"),"8859_1")+".xls");
		
			// 엑셀 출력
			wb.write(pResponse.getOutputStream());
			wb.close();
	
		} catch (ArithmeticException e) {
			log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
		} catch (NumberFormatException e) {
			log.error("오류발생 숫자로 변환 할 수 없습니다!!");
		} catch (ArrayIndexOutOfBoundsException e) {
			log.error("오류발생 배열인텍스에서 벗어났습니다!!");
		} catch (NegativeArraySizeException e) {
			log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
		} catch (NullPointerException e) {
			log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
		} catch (NoSuchMethodError e) {
			log.error("오류발생 메서드를 찾을수 없습니다!!");
		} catch (NoClassDefFoundError e) {
			log.error("오류발생 클래스를 찾을 수 없습니다!!");
		} catch (Exception e) {
			log.error(e.getMessage());
		}
	}
	
	@RequestMapping(value="/excel/excelDownLoadHaa00_new.do")
	public void excelDownLoadHaa00_new(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam(value="searchStrDate") String searchStrDate
			,@RequestParam(value="searchEndDate") String searchEndDate
			,@RequestParam(value="type") String type
			,@RequestParam(value="gubn[]") List<String> gubn
			,@RequestParam(value="flower[]", required=false) List<String> flowerCtgrList
			,@RequestParam(value="market[]", required=false) List<String> marketList
			,@RequestParam(value="item[]", required=false) List<String> itemList
			,@RequestParam(value="itemDtl[]", required=false) List<String> itemDtlList
			,@RequestParam(value="excelNm") String excelNm
			, ModelMap model){
		
		System.out.println("======================================================== "+excelNm);

		try {
			 // 워크북 생성
			Workbook wb = new XSSFWorkbook();
			Sheet sheet = wb.createSheet(excelNm);
			Row row = null;
			Cell cell = null;
			int rowNo = 0;

			//1.셀 스타일 및 폰트 설정
			CellStyle style = wb.createCellStyle();
			style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			CellStyle LineBreakStyle = wb.createCellStyle();
			LineBreakStyle.setWrapText(true);
			
			CellStyle blueStyle = wb.createCellStyle();
			blueStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			CellStyle redStyle = wb.createCellStyle();
			redStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			//폰트 색상 설정			
			XSSFFont blueFont = (XSSFFont) wb.createFont();
			blueFont.setColor(IndexedColors.BLUE.index);
			blueStyle.setFont(blueFont);
			
			
			XSSFFont RedFont = (XSSFFont) wb.createFont();
			RedFont.setColor(IndexedColors.RED.index);
			redStyle.setFont(RedFont);

			Map<String, Object> paramMap = new HashMap<String, Object>();
			List<EgovMap> list;
			
			paramMap.put("searchStrDate", searchStrDate);
			paramMap.put("searchEndDate", searchEndDate);
			paramMap.put("type", type);
			paramMap.put("gubn", gubn);
			paramMap.put("flowerCtgrList", flowerCtgrList);
			paramMap.put("marketList", marketList);
			paramMap.put("itemList", itemList);
			paramMap.put("itemDtlList", itemDtlList);

			if("day".equals(type)){
				list = haa00_newService.selectAuctionDayList(paramMap);
			}else if("month".equals(type)){
				list = haa00_newService.selectAuctionMonthList(paramMap);
			}else{
				searchStrDate += "-01";
				searchEndDate += "-12";
				paramMap.put("searchStrDate", searchStrDate);
				paramMap.put("searchEndDate", searchEndDate);
				list = haa00_newService.selectAuctionYearList(paramMap);
			}
			//검색조건 생성
			row = sheet.createRow(rowNo++);
			cell = row.createCell(0);
			cell.setCellValue("검색조건");
			cell = row.createCell(1);
			String searchFlower = "";
			if(flowerCtgrList != null){
				for(String flowerCode : flowerCtgrList){
					if(flowerCode.equals("1")){
						searchFlower += "절화 ";
					}else if(flowerCode.equals("2")){
						searchFlower += "관엽 ";
					}else if(flowerCode.equals("3")){
						searchFlower += "난 ";
					}else if(flowerCode.equals("4")){
						searchFlower += "춘란 ";
					}
				}
				
				cell.setCellValue("부류:"+searchFlower);
			}else{
				cell.setCellValue("부류:선택없음");
			}
			cell = row.createCell(2);
			
			String searchCmp = "";
			if(marketList != null && marketList.size() > 0){
				for(String cmpCd: marketList){
					if(cmpCd.equals("0000000001")){
						searchCmp += "aT화훼(양재) ";
					}else if(cmpCd.equals("1508500020")){
						searchCmp += "부산화훼(엄궁) ";
					}else if(cmpCd.equals("6068207466")){
						searchCmp += "부경화훼(강동) ";
					}else if(cmpCd.equals("4108212335")){
						searchCmp += "광주원예(풍암) ";
					}else if(cmpCd.equals("3848200087")){
						searchCmp += "한국화훼(음성) ";
					}else if(cmpCd.equals("1288202296")){
						searchCmp += "한국화훼(과천) ";
					}else if(cmpCd.equals("6158209828")){
						searchCmp += "영남화훼(김해) ";
					}
				}
				
				cell.setCellValue("공판장:"+searchCmp);
			}else{
				cell.setCellValue("공판장:선택없음");
			}
			cell = row.createCell(3);
			if(searchStrDate != null && searchEndDate != null){
				cell.setCellValue("시작일:"+searchStrDate+",종료일:"+ searchEndDate);
			}else{
				cell.setCellValue("날짜:선택없음");
			}
			
			cell = row.createCell(4);
			String searchGubn = "";
			if(gubn != null){
				for(String gubnCode : gubn){
					if(gubnCode.equals("1")){
						searchGubn += "부류 ";
					}else if(gubnCode.equals("2")){
						searchGubn += "품목 ";
					}else if(gubnCode.equals("3")){
						searchGubn += "품종 ";
					}
				}
				cell.setCellValue("표시단위:"+searchGubn);
			}else{
				cell.setCellValue("표시단위:선택없음");
			}
			cell = row.createCell(5);
			String searchItem = "";
			if(itemList != null && itemList.size() > 0){
				for(String item : itemList){
					searchItem += item + " ";
				}
				cell.setCellValue("품목명:"+searchItem);
			}else{
				cell.setCellValue("품목명:전체");
			}
			
			cell = row.createCell(6);
			String searchItemDtl = "";
			if(itemDtlList != null && itemDtlList.size() > 0){
				for(String itemDtl : itemDtlList){
					searchItemDtl += itemDtl + " ";
				}
				cell.setCellValue("품종명:"+searchItemDtl);
			}else{
				cell.setCellValue("품종명:품목미선택");
			}
			
			
			
			// 헤더 생성
			row = sheet.createRow(rowNo++);
			cell = row.createCell(0);
			cell.setCellValue("부류");
			cell = row.createCell(1);
			cell.setCellValue("품목");
			cell = row.createCell(2);
			cell.setCellValue("품종");
			cell = row.createCell(3);
			cell.setCellValue("총수량");
			cell = row.createCell(4);
			cell.setCellValue("총금액");
			cell = row.createCell(5);
			cell.setCellValue("최대금액");
			cell = row.createCell(6);
			cell.setCellValue("최저금액");
			cell = row.createCell(7);
			cell.setCellValue("평균금액");
			cell = row.createCell(8);
			cell.setCellValue("날짜");
			cell = row.createCell(9);
			cell.setCellValue("공판장");

			// 데이터 부분 생성
			for(Map<String,Object> vo : list) {
					
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue(vo.get("FLOWERNAME").toString());
				cell = row.createCell(1);
				if(vo.get("PUMNAME") != null){
					cell.setCellValue(vo.get("PUMNAME").toString());
				}
				cell = row.createCell(2);
				if(vo.get("GOODNAME") != null){
					cell.setCellValue(vo.get("GOODNAME").toString());
				}
				cell = row.createCell(3);
				if(vo.get("TOTQTY") != null){
					cell.setCellValue(Double.parseDouble(vo.get("TOTQTY").toString()));
				}
				cell = row.createCell(4);
				if(vo.get("TOTAMT") != null){
					cell.setCellValue(Double.parseDouble(vo.get("TOTAMT").toString()));
				}
				cell = row.createCell(5);
				if(vo.get("MAXAMT") != null){
					cell.setCellValue(Double.parseDouble(vo.get("MAXAMT").toString()));
				}
				cell = row.createCell(6);
				if(vo.get("MINAMT") != null){
					cell.setCellValue(Double.parseDouble(vo.get("MINAMT").toString()));
				}
				cell = row.createCell(7);
				if(vo.get("AVGAMT") != null){
					cell.setCellValue(Double.parseDouble(vo.get("AVGAMT").toString()));
				}
				cell = row.createCell(8);
				if(vo.get("SALEDATE") != null){
					cell.setCellValue(vo.get("SALEDATE").toString());
				}
				cell = row.createCell(9);
				if(vo.get("MARKETNAME") != null){
					cell.setCellValue(vo.get("MARKETNAME").toString());
				}
			}
			
			

			// 컨텐츠 타입과 파일명 지정
			pResponse.setContentType("ms-vnd/excel");
			pResponse.setHeader("Content-Disposition", "attachment;filename="+new String((excelNm).getBytes("KSC5601"),"8859_1")+".xls");
		
			// 엑셀 출력
			wb.write(pResponse.getOutputStream());
			wb.close();
	
		} catch (ArithmeticException e) {
			log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
		} catch (NumberFormatException e) {
			log.error("오류발생 숫자로 변환 할 수 없습니다!!");
		} catch (ArrayIndexOutOfBoundsException e) {
			log.error("오류발생 배열인텍스에서 벗어났습니다!!");
		} catch (NegativeArraySizeException e) {
			log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
		} catch (NullPointerException e) {
			log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
		} catch (NoSuchMethodError e) {
			log.error("오류발생 메서드를 찾을수 없습니다!!");
		} catch (NoClassDefFoundError e) {
			log.error("오류발생 클래스를 찾을 수 없습니다!!");
		} catch (Exception e) {
			log.error(e.getMessage());
		}
	}
	
	@RequestMapping(value="/excel/selectHaa00ChartJson2.json")
//	public String selectHaa00ChartJson2(HttpServletRequest pRequest, HttpServletResponse pResponse
	public void selectHaa00ChartJson2(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam(value="searchStrDate") String searchStrDate
			,@RequestParam(value="searchEndDate") String searchEndDate
			,@RequestParam(value="flower[]", required=false) List<String> flowerCtgrList
			,@RequestParam(value="item[]", required=false) List<String> itemList
			,@RequestParam(value="itemDtl[]", required=false) List<String> itemDtlList
			,@RequestParam(value="excelNm") String excelNm
			, ModelMap model) {
		System.out.println("======================================================== "+excelNm);
		System.out.println(pRequest.getHeader("User-Agent"));
		try {
			// 워크북 생성
			XSSFWorkbook  wb = new XSSFWorkbook();
			XSSFSheet sheet = wb.createSheet(excelNm);
			XSSFRow row = null;
			int rowNo = 0;
			
			//1.셀 스타일 및 폰트 설정
			CellStyle style = wb.createCellStyle();
			style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			CellStyle LineBreakStyle = wb.createCellStyle();
			LineBreakStyle.setWrapText(true);
			
			CellStyle blueStyle = wb.createCellStyle();
			blueStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			CellStyle redStyle = wb.createCellStyle();
			redStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			//폰트 색상 설정			
			XSSFFont blueFont = (XSSFFont) wb.createFont();
			blueFont.setColor(IndexedColors.BLUE.index);
			blueStyle.setFont(blueFont);
			
			
			XSSFFont RedFont = (XSSFFont) wb.createFont();
			RedFont.setColor(IndexedColors.RED.index);
			redStyle.setFont(RedFont);
			
			Map<String, Object> paramMap = new HashMap<String, Object>();

		
			paramMap.put("searchStrDate", searchStrDate);
			paramMap.put("searchEndDate", searchEndDate);
			paramMap.put("flowerCtgrList", flowerCtgrList);
			paramMap.put("itemList", itemList);
//			paramMap.put("itemList", Arrays.asList("개나리"));
			paramMap.put("itemDtlList", itemDtlList);
			

			List<EgovMap> list = haa05_Service.selectHaaChartYear002(paramMap);


			//검색조건 생성
			for(int i=0; i<38; i++){
				row = sheet.createRow(rowNo++);
				for(int j=0; j<9; j++){
					XSSFCell cell = row.createCell(j);
					cell.setCellValue("0");
				}
			}

			List<String> eArr = Arrays.asList("판매물량", "평균단가");
			row = sheet.getRow(1);
			for(int j=0; j<9; j++){
				XSSFCell cell = row.getCell(j);
				if (j==0) {
					cell.setCellValue("");
					continue;
				}
				cell.setCellValue(eArr.get((j-1)%2));
			}
			
			Map<String, String> firstSaleDate = new HashMap<>();
			for(EgovMap e : list){
				int i = (Integer.parseInt(e.get("mm").toString())-1)*3+(Integer.parseInt(e.get("sun").toString()))-1+2;
				int j = 1+(Integer.parseInt(e.get("yyyy").toString()) - Integer.parseInt(searchStrDate.substring(0, 4)))*2;
				
				sheet.getRow(i).getCell(j).setCellValue(e.get("totqty").toString());
				sheet.getRow(i).getCell(j+1).setCellValue(e.get("avgamt").toString());
				
				// 최초출하시기 계산
				if (firstSaleDate.containsKey(e.get("yyyy").toString()) == false){
					firstSaleDate.put(e.get("yyyy").toString(), " (최초출하: " + Integer.parseInt(e.get("mm").toString()) + "월 " + Integer.parseInt(e.get("dd").toString()) + "일)");
				}
			}
			
			sheet.getRow(0).getCell(0).setCellValue("");
			
			XSSFFont fontRed = (XSSFFont) sheet.getWorkbook().createFont();
			fontRed.setColor(IndexedColors.BLUE.index);
			
			for(int i=0; i<4; i++){
				sheet.addMergedRegion(new CellRangeAddress(0, 0, i*2+1, i*2+2));
				String year = Integer.toString(Integer.parseInt(searchStrDate.substring(0, 4))+i);
				
				row = sheet.getRow(0);
				XSSFCell cell = row.getCell(i*2+1);
				XSSFCellStyle defaultStyle = cell.getCellStyle();
				
				
				String data = year + firstSaleDate.get(year);
				XSSFRichTextString dataRich = new XSSFRichTextString(data);
				String keyword = firstSaleDate.get(year);
				int index = data.indexOf(keyword);
				dataRich.applyFont(index, index + keyword.length(), fontRed);
				
				cell.setCellValue(dataRich);
				cell.setCellStyle(defaultStyle);
				
				sheet.setColumnWidth((short) i*2+1, (short)3600);
				sheet.setColumnWidth((short) i*2+2, (short)3600);
			}
			
			List<String> sunArr = Arrays.asList("상순", "중순", "하순");
			for(int j=2; j<38; j++){
				String month = Integer.toString((j+1)/3);
				String sun = sunArr.get((j+1)%3);
				String val = month+"월-"+sun;
				sheet.getRow(j).getCell(0).setCellValue(val);
			}

			// 컨텐츠 타입과 파일명 지정
			pResponse.setContentType("ms-vnd/excel");
			//Chrome
			if(pRequest.getHeader("User-Agent").contains("Firefox")) {
				pResponse.setHeader("Content-Disposition", "attachment;filename=" + new String((excelNm).getBytes("KSC5601"), "8859_1") + ".xlsx");
			} else {
				pResponse.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(excelNm, "utf-8") + ".xlsx");
			}
			// 엑셀 출력
			wb.write(pResponse.getOutputStream());
			wb.close();
// 			model.addAttribute("list", list);
		} catch (ArithmeticException e) {
			log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
		} catch (NumberFormatException e) {
			log.error("오류발생 숫자로 변환 할 수 없습니다!!");
		} catch (ArrayIndexOutOfBoundsException e) {
			log.error("오류발생 배열인텍스에서 벗어났습니다!!");
		} catch (NegativeArraySizeException e) {
			log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
		} catch (NullPointerException e) {
			log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
		} catch (NoSuchMethodError e) {
			log.error("오류발생 메서드를 찾을수 없습니다!!");
		} catch (NoClassDefFoundError e) {
			log.error("오류발생 클래스를 찾을 수 없습니다!!");
		} catch (Exception e) {
			log.error(e.getMessage());
		}
//		return "jsonView";
	}
	
	@RequestMapping(value="/excel/selectHga08ChartJson2.json")
//	public String selectHaa00ChartJson2(HttpServletRequest pRequest, HttpServletResponse pResponse
	public void selectHga08ChartJson1(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam(value="searchEndDate") String searchEndDate
			,@RequestParam(value="location") String location
			,@RequestParam(value="excelNm") String excelNm
			, ModelMap model) {
		System.out.println("======================================================== "+excelNm);
		
		try {
			// 워크북 생성
			XSSFWorkbook  wb = new XSSFWorkbook();
			XSSFSheet sheet = wb.createSheet(excelNm);
			XSSFRow row = null;
			int rowNo = 0;
			
			//1.셀 스타일 및 폰트 설정
			CellStyle style = wb.createCellStyle();
			style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			CellStyle LineBreakStyle = wb.createCellStyle();
			LineBreakStyle.setWrapText(true);
			
			CellStyle blueStyle = wb.createCellStyle();
			blueStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			CellStyle redStyle = wb.createCellStyle();
			redStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			//폰트 색상 설정			
			XSSFFont blueFont = (XSSFFont) wb.createFont();
			blueFont.setColor(IndexedColors.BLUE.index);
			blueStyle.setFont(blueFont);
			
			
			XSSFFont RedFont = (XSSFFont) wb.createFont();
			RedFont.setColor(IndexedColors.RED.index);
			redStyle.setFont(RedFont);
			
			Map<String, Object> paramMap = new HashMap<String, Object>();
			
			paramMap.put("searchEndDate", searchEndDate);
			
			paramMap.put("location", URLDecoder.decode(location, "utf-8"));

			
			List<EgovMap> list = hga08_Service.selectHga08ChartJson2(paramMap);
			
			List<String> keyArr = Arrays.asList("yyyy", "location", "val1", "val2", "totQty");
			
			row = sheet.createRow(rowNo++);
			row.createCell(0).setCellValue("연도");
			row.createCell(1).setCellValue("지역");
			row.createCell(2).setCellValue("전업");
			row.createCell(3).setCellValue("겸업");
			row.createCell(4).setCellValue("합계");
			
 			for(int i=0; i<list.size(); i++){
 				if(list.get(i).get("location").toString().equals("전국")){
 					EgovMap etc = new EgovMap();
 					for(Object k : list.get(i).keySet()){
 						etc.put(k.toString(), list.get(i).get(k));
 					}
 					list.remove(i);
 					list.add(0, etc);
 					break;
 				}
 			}
 			
//			//검색조건 생성
			for(EgovMap e : list){
				row = sheet.createRow(rowNo++);
				for(int j=0; j<5; j++){
					XSSFCell cell = row.createCell(j);
					cell.setCellValue(e.get(keyArr.get(j)).toString());
				}
			}
			
			// 컨텐츠 타입과 파일명 지정
			pResponse.setContentType("ms-vnd/excel");
			pResponse.setHeader("Content-Disposition", "attachment;filename="+new String((excelNm).getBytes("KSC5601"),"8859_1")+".xlsx");
			
			// 엑셀 출력
			wb.write(pResponse.getOutputStream());
			wb.close();
// 			model.addAttribute("list", list);
		} catch (ArithmeticException e) {
			log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
		} catch (NumberFormatException e) {
			log.error("오류발생 숫자로 변환 할 수 없습니다!!");
		} catch (ArrayIndexOutOfBoundsException e) {
			log.error("오류발생 배열인텍스에서 벗어났습니다!!");
		} catch (NegativeArraySizeException e) {
			log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
		} catch (NullPointerException e) {
			log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
		} catch (NoSuchMethodError e) {
			log.error("오류발생 메서드를 찾을수 없습니다!!");
		} catch (NoClassDefFoundError e) {
			log.error("오류발생 클래스를 찾을 수 없습니다!!");
		} catch (Exception e) {
			log.error(e.getMessage());
		}
//		return "jsonView";
	}
	
	@RequestMapping(value="/excel/selectHga07excel.json")
//	public String selectHaa00ChartJson2(HttpServletRequest pRequest, HttpServletResponse pResponse
	public void selectHga07excel(HttpServletRequest pRequest, HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
		System.out.println("======================================================== "+pRequestParamMap.get("excelNm").toString());
		
		try {
			
			List<String> chkoptArr = new ArrayList<>();
			for(String e : Arrays.asList(pRequestParamMap.get("chkopt").toString().split(","))){
				chkoptArr.add(e);
			}
			pRequestParamMap.put("chkopt", chkoptArr);
			
			// 워크북 생성
			XSSFWorkbook  wb = new XSSFWorkbook();
			XSSFSheet sheet = wb.createSheet(pRequestParamMap.get("excelNm").toString());
			XSSFRow row = null;
			int rowNo = 0;
			
			//1.셀 스타일 및 폰트 설정
			CellStyle style = wb.createCellStyle();
			style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			CellStyle LineBreakStyle = wb.createCellStyle();
			LineBreakStyle.setWrapText(true);
			
			CellStyle blueStyle = wb.createCellStyle();
			blueStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			CellStyle redStyle = wb.createCellStyle();
			redStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			//폰트 색상 설정			
			XSSFFont blueFont = (XSSFFont) wb.createFont();
			blueFont.setColor(IndexedColors.BLUE.index);
			blueStyle.setFont(blueFont);
			
			
			XSSFFont RedFont = (XSSFFont) wb.createFont();
			RedFont.setColor(IndexedColors.RED.index);
			redStyle.setFont(RedFont);
			
			
			Map<String,Object> map = null;

			System.out.println("지역별 :파람: "+pRequestParamMap);
			excelService.callKosisData(pRequestParamMap);
			List<Map<String,String>> rmate = excelService.getRmateLocation();
			// System.out.println(new JSONObject(pmap).toString(2));
			List<Map<String,Object>> mmap = new ArrayList<Map<String, Object>>();
			List<Map<String,Object>> rmap = new ArrayList<Map<String, Object>>();
			mmap = (List<Map<String,Object>>)pRequestParamMap.get("o_cursor");
			System.out.println("지역 : "+pRequestParamMap.get("locDo"));
			for (Map<String,Object> o : mmap) {
				String[] _oo = new String[]{"채소, 화훼 및 과실작물 시설 재배업","채소, 화훼작물 및 종묘 재배업","화훼류 및 식물 도매업","화훼작물 재배업"};
				o.put("loc2", pRequestParamMap.get("location"));
				o.put("loc", pRequestParamMap.get("locDo"));
				
				// 100 / 32 강원도
				// 200 / 31 경기도
				// 300 / 38 경상남도
				// 400 / 37 경상북도
				// 500 / 24 광주
				// 600 / 22 대구
				// 700 / 25 대전
				// 800 / 21 부산
				// 900 / 11 서울
				// 1000 / 26 울산
				// 1100 / 23 인천
				// 1200 / 36 전라남도
				// 1300 / 35 전라북도
				// 1400 / 39 제주
				// 1500 / 34 충청남도
				// 1600 / 33 충청북도
				// 1700 / 29 세종
				//switch (pmap.get("locDo").toString())
				for (Map<String, String> rmateo : rmate) {	
					if(rmateo.get("CODE2").equals(pRequestParamMap.get("locDo").toString()) 
						&& rmateo.get("LABEL").equals(o.get("CPNM1").toString())) {
						o.put("code", rmateo.get("CODE"));
						o.put("id", rmateo.get("CODE"));
					}else if(pRequestParamMap.get("locDo").toString().equals("al") && rmateo.get("LABEL").equals(o.get("CPNM1").toString())) {
						o.put("code", rmateo.get("CODE"));
						o.put("id", rmateo.get("CODE"));
					}
				}
				//지역별 코드 추출 (알메이트, KOSIS)
				/*for (Map<String, String> rmateo : rmate) {
					//System.out.println("지역부분 짜름 :: "+o.get("CPNM1").toString().substring(0, 2));
					//System.out.println("지역부분 짜름 :: "+rmateo.get("LABEL"));
					if(rmateo.get("LABEL").equals(o.get("CPNM1"))) {
						o.put("code", rmateo.get("CODE"));
						o.put("id", rmateo.get("CODE"));
					}
				}*/
				
				// 화훼관련 조건분류1
				List<String>_o = (List<String>)pRequestParamMap.get("chkopt");
				if (_o.size() == 0) {
					if(!o.get("INDST_NM").toString().equals(_oo[0])
						&& !o.get("INDST_NM").toString().equals(_oo[1])
						&& !o.get("INDST_NM").toString().equals(_oo[2])
						&& !o.get("INDST_NM").toString().equals(_oo[3])
						) {
						rmap.add(o);
					}
				}
				//화훼관련 조건분류2
				for(String oo : (List<String>)pRequestParamMap.get("chkopt")) {
					if(oo.equals("1") && o.get("INDST_NM").toString().equals("채소, 화훼 및 과실작물 시설 재배업")){
						rmap.add(o);
					} else if(oo.equals("2") && o.get("INDST_NM").toString().equals("채소, 화훼작물 및 종묘 재배업")) {
						rmap.add(o);
					} else if(oo.equals("3") && o.get("INDST_NM").toString().equals("화훼류 및 식물 도매업")) {
						rmap.add(o);
					} else if(oo.equals("4") && o.get("INDST_NM").toString().equals("화훼작물 재배업")) {
						rmap.add(o);
					} else {
						
					}  
					
				}
				
			}
			// 합계 summary 구하기 
			int c=0;
			for(Map<String,Object> o : rmap) {
				c += Integer.parseInt(o.get("VAL").toString());
			}
			Map<String,Object> _m = new HashMap<>();
			_m.put("INDST_NM", "-");
			_m.put("CPNM1", "합계");
			_m.put("GUBUN1", "-");
			_m.put("GUBUN2", "-");
			_m.put("GUBUN3", "-");
			_m.put("VAL", c);
			
			rmap.add(0, _m);
			
			List<Map<String, Object>> list = rmap;

			//INDST_NM=채소, 화훼 및 과실작물 시설 재배업, CPNM1=강원도, GUBUN2=전체, VAL=231, loc2=, GUBUN1=전체, loc=al, GUBUN3=전체, code=100, id=100
//			List<EgovMap> list = hga08_Service.selectHga08ChartJson2(pRequestParamMap);
			
			List<String> keyArr = Arrays.asList("CPNM1", "INDST_NM", "GUBUN1", "GUBUN2", "GUBUN3", "VAL");
			
			row = sheet.createRow(rowNo++);
			row.createCell(0).setCellValue("행정구역 명칭");
			row.createCell(1).setCellValue("산업분류 명칭");
			row.createCell(2).setCellValue("구분1");
			row.createCell(3).setCellValue("구분2");
			row.createCell(4).setCellValue("구분3");
			row.createCell(5).setCellValue("값");
			
			
//			//검색조건 생성
			for(Map<String, Object> e : list){
				row = sheet.createRow(rowNo++);
				for(int j=0; j<6; j++){
					XSSFCell cell = row.createCell(j);
					cell.setCellValue(e.get(keyArr.get(j)).toString());
				}
			}
			
			// 컨텐츠 타입과 파일명 지정
			pResponse.setContentType("ms-vnd/excel");
			pResponse.setHeader("Content-Disposition", "attachment;filename="+new String((pRequestParamMap.get("excelNm").toString()).getBytes("KSC5601"),"8859_1")+".xlsx");
			
			// 엑셀 출력
			wb.write(pResponse.getOutputStream());
			wb.close();
// 			model.addAttribute("list", list);
		} catch (ArithmeticException e) {
			log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
		} catch (NumberFormatException e) {
			log.error("오류발생 숫자로 변환 할 수 없습니다!!");
		} catch (ArrayIndexOutOfBoundsException e) {
			log.error("오류발생 배열인텍스에서 벗어났습니다!!");
		} catch (NegativeArraySizeException e) {
			log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
		} catch (NullPointerException e) {
			log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
		} catch (NoSuchMethodError e) {
			log.error("오류발생 메서드를 찾을수 없습니다!!");
		} catch (NoClassDefFoundError e) {
			log.error("오류발생 클래스를 찾을 수 없습니다!!");
		} catch (Exception e) {
			log.error(e.getMessage());
		}
//		return "jsonView";
	}
	
	@RequestMapping(value="/excel/excelDownLoadHaaTotal00_new.do")
	public void excelDownLoadHaaTotal00_new(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam(value="searchStrDate") String searchStrDate
			,@RequestParam(value="searchEndDate") String searchEndDate
			,@RequestParam(value="type") String type
			,@RequestParam(value="gubn[]") List<String> gubn
			,@RequestParam(value="flower[]", required=false) List<String> flowerCtgrList
			,@RequestParam(value="market[]", required=false) List<String> marketList
			,@RequestParam(value="item[]", required=false) List<String> itemList
			,@RequestParam(value="itemDtl[]", required=false) List<String> itemDtlList
			,@RequestParam(value="excelNm") String excelNm
			, ModelMap model){
		
		System.out.println("======================================================== "+excelNm);

		try {
			 // 워크북 생성
			Workbook wb = new HSSFWorkbook();
			Sheet sheet = wb.createSheet(excelNm);
			Row row = null;
			Cell cell = null;
			int rowNo = 0;

			//1.셀 스타일 및 폰트 설정
			CellStyle style = wb.createCellStyle();
			style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			CellStyle LineBreakStyle = wb.createCellStyle();
			LineBreakStyle.setWrapText(true);
			
			CellStyle blueStyle = wb.createCellStyle();
			blueStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			CellStyle redStyle = wb.createCellStyle();
			redStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
			
			//폰트 색상 설정			
			HSSFFont blueFont = (HSSFFont) wb.createFont();
			blueFont.setColor(HSSFColor.BLUE.index);
			blueStyle.setFont(blueFont);
			
			
			HSSFFont RedFont = (HSSFFont) wb.createFont();
			RedFont.setColor(HSSFColor.RED.index);
			redStyle.setFont(RedFont);

			Map<String, Object> paramMap = new HashMap<String, Object>();
			List<EgovMap> list;
			
			if(itemList != null && itemList.size() > 0 && itemList.indexOf("6043") > -1){
				itemList.add("6002");
			}

			paramMap.put("searchStrDate", searchStrDate);
			paramMap.put("searchEndDate", searchEndDate);
			paramMap.put("type", type);
			paramMap.put("gubn", gubn);
			paramMap.put("flowerCtgrList", flowerCtgrList);
			paramMap.put("marketList", marketList);
			paramMap.put("itemList", itemList);
			paramMap.put("itemDtlList", itemDtlList);

			list = haa00_newService.selectAuctionListTotal(paramMap);
			
			//검색조건 생성
			row = sheet.createRow(rowNo++);
			cell = row.createCell(0);
			cell.setCellValue("검색조건");
			cell = row.createCell(1);
			String searchFlower = "";
			if(flowerCtgrList != null){
				for(String flowerCode : flowerCtgrList){
					if(flowerCode.equals("1")){
						searchFlower += "절화 ";
					}else if(flowerCode.equals("2")){
						searchFlower += "관엽 ";
					}else if(flowerCode.equals("3")){
						searchFlower += "난 ";
					}else if(flowerCode.equals("4")){
						searchFlower += "춘란 ";
					}
				}
				
				cell.setCellValue("부류:"+searchFlower);
			}else{
				cell.setCellValue("부류:선택없음");
			}
			cell = row.createCell(2);
			
			String searchCmp = "";
			if(marketList != null){
				for(String cmpCode : marketList){
					if(cmpCode.equals("0000000001")){
						searchCmp += "aT화훼(양재) ";
					}else if(cmpCode.equals("1508500020")){
						searchCmp += "부산화훼(엄궁) ";
					}else if(cmpCode.equals("6068207466")){
						searchCmp += "부경화훼(강동) ";
					}else if(cmpCode.equals("4108212335")){
						searchCmp += "광주원예(풍암) ";
					}else if(cmpCode.equals("3848200087")){
						searchCmp += "한국화훼(음성) ";
					}else if(cmpCode.equals("1288202296")){
						searchCmp += "한국화훼(과천) ";
					}else if(cmpCode.equals("6158209828")){
						searchCmp += "영남화훼(김해) ";
					}
				}
				
				cell.setCellValue("공판장:"+searchCmp);
			}else{
				cell.setCellValue("공판장:선택없음");
			}
			cell = row.createCell(3);
			if(searchStrDate != null && searchEndDate != null){
				cell.setCellValue("시작일:"+searchStrDate+",종료일:"+ searchEndDate);
			}else{
				cell.setCellValue("날짜:선택없음");
			}
			
			cell = row.createCell(4);
			String searchGubn = "";
			if(gubn != null){
				for(String gubnCode : gubn){
					if(gubnCode.equals("1")){
						searchGubn += "부류 ";
					}else if(gubnCode.equals("2")){
						searchGubn += "품목 ";
					}else if(gubnCode.equals("3")){
						searchGubn += "품종 ";
					}
				}
				cell.setCellValue("표시단위:"+searchGubn);
			}else{
				cell.setCellValue("표시단위:선택없음");
			}
			cell = row.createCell(5);
			String searchItem = "";
			if(itemList != null){
				for(String item : itemList){
					searchItem += item+" ";
				}
				cell.setCellValue("품목명:"+searchItem);
			}else{
				cell.setCellValue("품목명:전체");
			}
			
			cell = row.createCell(6);
			String searchItemDtl = "";
			if(itemList != null){
				for(String itemDtl : itemDtlList){
					searchItemDtl += itemDtl+" ";
				}
				cell.setCellValue("품종명:"+searchItemDtl);
			}else{
				cell.setCellValue("품종명:품목미선택");
			}
			
			
			// 헤더 생성
			row = sheet.createRow(rowNo++);
			cell = row.createCell(0);
			cell.setCellValue("부류");
			cell = row.createCell(1);
			cell.setCellValue("품목");
			cell = row.createCell(2);
			cell.setCellValue("품종");
			cell = row.createCell(3);
			cell.setCellValue("총수량");
			cell = row.createCell(4);
			cell.setCellValue("총금액");
			cell = row.createCell(5);
			cell.setCellValue("최대금액");
			cell = row.createCell(6);
			cell.setCellValue("최저금액");
			cell = row.createCell(7);
			cell.setCellValue("평균금액");
			cell = row.createCell(8);
			cell.setCellValue("날짜");
			cell = row.createCell(9);
			cell.setCellValue("공판장");
						
			
			// 데이터 부분 생성
			for(Map<String,Object> vo : list) {
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue(vo.get("FLOWERNAME").toString());
				cell = row.createCell(1);
				if(vo.get("PUMNAME") != null){
					cell.setCellValue(vo.get("PUMNAME").toString());
				}
				cell = row.createCell(2);
				if(vo.get("GOODNAME") != null){
					cell.setCellValue(vo.get("GOODNAME").toString());
				}
				cell = row.createCell(3);
				if(vo.get("TOTQTY") != null){
					cell.setCellValue(Double.parseDouble(vo.get("TOTQTY").toString()));
				}
				cell = row.createCell(4);
				if(vo.get("TOTAMT") != null){
					cell.setCellValue(Double.parseDouble(vo.get("TOTAMT").toString()));
				}
				cell = row.createCell(5);
				if(vo.get("MAXAMT") != null){
					cell.setCellValue(Double.parseDouble(vo.get("MAXAMT").toString()));
				}
				cell = row.createCell(6);
				if(vo.get("MINAMT") != null){
					cell.setCellValue(Double.parseDouble(vo.get("MINAMT").toString()));
				}
				cell = row.createCell(7);
				if(vo.get("AVGAMT") != null){
					cell.setCellValue(Double.parseDouble(vo.get("AVGAMT").toString()));
				}
				cell = row.createCell(8);
				if(vo.get("SALEDATE") != null){
					cell.setCellValue(vo.get("SALEDATE").toString());
				}
				cell = row.createCell(9);
				if(vo.get("MARKETNAME") != null){
					cell.setCellValue(vo.get("MARKETNAME").toString());
				}

			}
			

			// 컨텐츠 타입과 파일명 지정
			pResponse.setContentType("ms-vnd/excel");
			pResponse.setHeader("Content-Disposition", "attachment;filename="+new String((excelNm).getBytes("KSC5601"),"8859_1")+".xls");
		
			// 엑셀 출력
			wb.write(pResponse.getOutputStream());
			wb.close();
	
		} catch (ArithmeticException e) {
			log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
		} catch (NumberFormatException e) {
			log.error("오류발생 숫자로 변환 할 수 없습니다!!");
		} catch (ArrayIndexOutOfBoundsException e) {
			log.error("오류발생 배열인텍스에서 벗어났습니다!!");
		} catch (NegativeArraySizeException e) {
			log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
		} catch (NullPointerException e) {
			log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
		} catch (NoSuchMethodError e) {
			log.error("오류발생 메서드를 찾을수 없습니다!!");
		} catch (NoClassDefFoundError e) {
			log.error("오류발생 클래스를 찾을 수 없습니다!!");
		} catch (Exception e) {
			log.error(e.getMessage());
		}
	}
	
		

}