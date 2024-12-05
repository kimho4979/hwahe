package com.fpdisys.base.util;
import com.at.domain.AtMarketVO;
import com.at.service.aTService;
import com.fpdisys.base.util.atMartDailyrptSchedule;
import com.fpdisys.dist.customInfo.service.CustomInfoService;
import com.fpdisys.dist.real.service.RealService;
import com.fpdisys.dist.report.mapper.ReportMapper;
import com.fpdisys.dist.report.service.CommonExcel;
import com.fpdisys.dist.report.service.ReportService;
import com.fpdisys.dist.trans.service.TsaleService;
import com.fpminput.mntr.dailyRptMgt.controller.dailyRptSendexcel;
import com.fpminput.mntr.dailyRptMgt.service.DailyRptMgtService;
import com.fpminput.mntr.dailyRptSend.domain.DailyRptSendVO;
import com.fpminput.mntr.dailyRptSend.service.DailyRptSendService;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class atMartDailyrptSchedule {
  @Autowired
  CustomInfoService custionInfoService;
  
  @Autowired
  RealService realService;
  
  @Autowired
  TsaleService tsaleService;
  
  @Autowired
  aTService aTService;
  
  @Autowired
  ReportService reportService;
  
  @Autowired
  ReportMapper reportMapper;
  
  @Autowired
  CommonExcel commonExcel;
  
  @Autowired
  DailyRptSendService dailyRptSendService;
  
  @Autowired
  DailyRptMgtService dailyRptMgtService;
  
  @Autowired 
  dailyRptSendexcel dailyRptSendExcel;
  
  protected Log log = LogFactory.getLog(getClass());
  
  @Scheduled(cron = "0 45 6 * * *")
  //@Scheduled(cron = "0 0 15 * * *")
  public void scheduleRun4tsale() {
    String year = null;
    String month = null;
    String day = null;
    String deletedate = null;
    Date d = new Date();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
    String s = sdf.format(d);
    String en = sdf.format(Long.valueOf(d.getTime() - 259200000L));
    int sint = Integer.parseInt(s);
    int enint = Integer.parseInt(en);
    Map<String, Object> map = new HashMap<>();
    try {
      for (int i = enint; i <= sint; i++) {
        year = Integer.toString(i).substring(0, 4);
        month = Integer.toString(i).substring(4, 6);
        day = Integer.toString(i).substring(6, 8);
        deletedate = String.valueOf(year) + "-" + month + "-" + day;
        map.put("saleDate", deletedate);
        if (Integer.parseInt(day) < 32)
          try {
            this.tsaleService.calculateWebserviceTestDelete(map);
            System.out.println("삭제완료");
          } catch (Exception e) {
            e.printStackTrace();
            System.out.println("삭제실패");
          }  
      } 
      map.put("saleDate", sdf.format(d));
      map.put("strDate", sdf.format(Long.valueOf(d.getTime() - 259200000L)));
      List<AtMarketVO> atMarketData = this.aTService.atMarketData(map);
      int j;
      for (j = 0; j < atMarketData.size(); j++) {
        AtMarketVO rs = (AtMarketVO)atMarketData.get(j);
        String sFilename = "0000000001" + rs.getPAN_DAY() + ".txt";
        String sRecode = ";";
        sRecode = String.valueOf(sRecode) + ";";
        sRecode = String.valueOf(sRecode) + rs.getPAN_DAY() + ";";
        sRecode = String.valueOf(sRecode) + ";";
        sRecode = String.valueOf(sRecode) + "0000000001;";
        sRecode = String.valueOf(sRecode) + rs.getPAN_NO().replaceAll(" ", "") + ";";
        sRecode = String.valueOf(sRecode) + rs.getPAN_SERIAL().replaceAll(" ", "") + ";";
        sRecode = String.valueOf(sRecode) + ";";
        sRecode = String.valueOf(sRecode) + rs.getMEJANG().replaceAll(" ", "") + ";";
        sRecode = String.valueOf(sRecode) + "000000;";
        sRecode = String.valueOf(sRecode) + rs.getPUM_CODE().replaceAll(" ", "") + ";";
        sRecode = String.valueOf(sRecode) + rs.getMOK_NAME().replaceAll(" ", "") + ";";
        sRecode = String.valueOf(sRecode) + rs.getJONG_NAME().replaceAll(" ", "") + ";";
        sRecode = String.valueOf(sRecode) + "1;";
        sRecode = String.valueOf(sRecode) + "120000;";
        sRecode = String.valueOf(sRecode) + rs.getSTRCODE_LEVEL().replaceAll(" ", "") + ";";
        sRecode = String.valueOf(sRecode) + rs.getSOK_CNT().replaceAll(" ", "") + ";";
        sRecode = String.valueOf(sRecode) + rs.getKM_P_NEW().replaceAll(" ", "") + ";";
        sRecode = String.valueOf(sRecode) + ";";
        sRecode = String.valueOf(sRecode) + "3;";
        sRecode = String.valueOf(sRecode) + ";";
        sRecode = String.valueOf(sRecode) + ";";
        sRecode = String.valueOf(sRecode) + rs.getCHUL_CODE().replaceAll(" ", "") + ";";
        sRecode = String.valueOf(sRecode) + ";";
        sRecode = String.valueOf(sRecode) + ";";
        sRecode = String.valueOf(sRecode) + "5;";
        sRecode = String.valueOf(sRecode) + null != rs.getSTRCODE_LOCAL() ? rs.getSTRCODE_LOCAL().replaceAll(" ", "") + ";" : ";";
        sRecode = String.valueOf(sRecode) + null != rs.getREGION_CODE() ? rs.getREGION_CODE().replaceAll(" ", "") + ";" : ";";
        sRecode = String.valueOf(sRecode) + null != rs.getREGION_NAME() ? rs.getREGION_NAME().replaceAll(" ", "") + ";" : ";";
        sRecode = String.valueOf(sRecode) + null != rs.getF_SONGE_CNT() ? rs.getF_SONGE_CNT().replaceAll(" ", "") + ";" : ";";
        sRecode = String.valueOf(sRecode) + rs.getPAN_PRICE().replaceAll(" ", "");
        map.put("filename", sFilename);
        map.put("recode", sRecode);
        map.put("requestSn", "tsale");
        this.tsaleService.calculateWebserviceTestForm(map);
        String gb = rs.getMEJANG().replaceAll(" ", "");
        if (gb.equals("1")) {
          System.out.println("구분 : 절화 ");
        } else if (gb.equals("2")) {
          System.out.println("구분 : 관엽");
        } else if (gb.equals("3")) {
          System.out.println("구분 : 난");
        } else if (gb.equals("4")) {
          System.out.println("구분 : 춘란");
        } else {
          System.out.println("구분 : 5(기타)");
        } 
      } 
      for (j = enint; j <= sint; j++) {
        year = Integer.toString(j).substring(0, 4);
        month = Integer.toString(j).substring(4, 6);
        day = Integer.toString(j).substring(6, 8);
        deletedate = String.valueOf(year) + "-" + month + "-" + day;
        map.put("requestSn", "magam");
        if (Integer.parseInt(day) < 32) {
          this.tsaleService.deleteSaleDate("0000000001", deletedate);
          this.tsaleService.insertSaleDate("0000000001", deletedate);
        } 
      } 
      System.out.println("마감완료");
    } catch (Exception e) {
      e.printStackTrace();
      System.out.println("전송실패");
    } 
  }
  
  /*@Bean
  public String test()  {
	  try{
		  Calendar cal = Calendar.getInstance();
		  String strdate = (new SimpleDateFormat("yyyy-MM-dd")).format(cal.getTime());
		  strdate = "2023-06-05";
		  System.out.println("////////Holiday process 공휴일////////////////");
		  if(null == reportMapper.selectTsaleHoliday(strdate) || reportMapper.selectTsaleHoliday(strdate) == 0){
		    	 throw new Exception("konghyu");
	      }
		  Map<String,Object> pRequestParamMap = new HashMap<String, Object>();
		  pRequestParamMap.put("cmpCd", "0000000001");
		  pRequestParamMap.put("searchStrDate", "2023-06-05");
		  System.out.println(reportMapper.selectTsaleHolidayBefore(pRequestParamMap));
	  }catch(Exception e){
		  System.out.println(e.getMessage());
		  System.exit(-1);
	  }
	  
	  System.exit(-1);
	  return "";
  }*/
  
  
  @Scheduled(cron = "0 50 9 * * 1,3,5")
  public void scheduleRun4dailyReport() {
    Calendar cal = Calendar.getInstance();
    String strdate = (new SimpleDateFormat("yyyy-MM-dd")).format(cal.getTime());
    ArrayList<String> receiver_list = get_receiver_list();
    try {
      if(null == reportMapper.selectTsaleHoliday(strdate) || reportMapper.selectTsaleHoliday(strdate) == 0){
    	 throw new Exception("공휴일 예외처리"); 
      }
      HSSFWorkbook hSSFWorkbook = this.dailyRptSendExcel.get_dayAuc_excel(strdate);
      Workbook dayPumAuc_excel = this.dailyRptSendExcel.get_dayPumAuc_excel(strdate);
      Workbook mainFlowerAuc_excel = this.dailyRptSendExcel.get_mainFlowerAuc_excel(strdate);
      receiver_list.add("cdh@finevt.com"); // 추후에 삭제해도됨 -> 확인용 메일수신자  
      for (String receiver : receiver_list) {
        String msg = this.dailyRptSendExcel.mailSend(receiver, dayPumAuc_excel, mainFlowerAuc_excel, (Workbook)hSSFWorkbook);
        System.out.println("Mail sending:" + msg);
        Map<String, Object> pRequestParamMap = new HashMap<>();
        pRequestParamMap.put("sysGp", "1");
        if (msg.equals("success")) {
          pRequestParamMap.put("rsltGp", "S");
          pRequestParamMap.put("procMsg", String.valueOf(receiver) + "메일 발송 완료");
        } else {
          pRequestParamMap.put("rsltGp", "E");
          pRequestParamMap.put("procMsg", String.valueOf(receiver) + "메일 발송 실패");
        } 
        String searchStrDate = (new SimpleDateFormat("yyyyMMddHHmmss")).format(Calendar.getInstance().getTime());
        pRequestParamMap.put("startDate", searchStrDate);
        pRequestParamMap.put("endDate", searchStrDate);
        pRequestParamMap.put("userNm", receiver);
        this.dailyRptMgtService.insertGridList(pRequestParamMap);
      } 
    } catch (Exception e) {
      Map<String, Object> pRequestParamMap = new HashMap<>();
      pRequestParamMap.put("sysGp", "1");
      String searchStrDate = (new SimpleDateFormat("yyyyMMddHHmmss")).format(Calendar.getInstance().getTime());
      pRequestParamMap.put("rsltGp", "E");
      pRequestParamMap.put("startDate", searchStrDate);
      pRequestParamMap.put("endDate", searchStrDate);
      for (String receiver : receiver_list) {
        pRequestParamMap.put("userNm", receiver);
        pRequestParamMap.put("procMsg", String.valueOf(receiver) + "/메일 발송 실패/" + e.getMessage());
        this.dailyRptMgtService.insertGridList(pRequestParamMap);
      } 
    } 
  }
  
  public ArrayList<String> get_receiver_list() {
    Map<String, Object> pRequestParamMap = new HashMap<>();
    pRequestParamMap.put("searchNm", null);
    ArrayList<String> receiver_list = new ArrayList<>();
    List<DailyRptSendVO> resultList = this.dailyRptSendService.selectGridAll(pRequestParamMap);
    for (DailyRptSendVO vo : resultList) {
      receiver_list.add(vo.getEmailAdrs());
      System.out.println("수신자" + vo.getEmailAdrs());
    } 
    System.out.println("get_receiver_list success");
    return receiver_list;
  }
}
