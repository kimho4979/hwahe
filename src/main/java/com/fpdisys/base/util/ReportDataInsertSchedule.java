package com.fpdisys.base.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.fpdisys.dist.report.service.ReportService;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Component
public class ReportDataInsertSchedule {
	
	@Autowired
	ReportService reportService;
	
	@Scheduled(cron = "0 5 7 * * 1,3,5")	// TODO 주석처리  john
	public void dayPumScheduleRun1() {
		
		Calendar strDate = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String saleDate = sdf.format(strDate.getTime());
		
		try {
			Map<String, Object> pRequestParamMap = new HashMap<String, Object>();
			pRequestParamMap.put("saleDate", saleDate);
			pRequestParamMap.put("insertTime", "7");
			
			reportService.insertDayPumAucAt(pRequestParamMap);
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("일별 품목별 경매실적 및 동향 테이블 insert 실패");
		}
				
	}
	
	@Scheduled(cron = "0 5 13 * * 1,3,5")	// TODO 주석처리  john
	public void dayPumScheduleRun2() {
		
		Calendar strDate = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String saleDate = sdf.format(strDate.getTime());
		
		try {
			Map<String, Object> pRequestParamMap = new HashMap<String, Object>();
			pRequestParamMap.put("saleDate", saleDate);
			pRequestParamMap.put("insertTime", "13");
			
			reportService.insertDayPumAucAt(pRequestParamMap);
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("일별 품목별 경매실적 및 동향 테이블 insert 실패");
		}
		
		
	}
	
	//@Scheduled(cron = "0 5 7 * * *")	// TODO 주석처리  john
	public void mainFlowerScheduleRun1() {
		
		Calendar strDate = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String searchStrDate = sdf.format(strDate.getTime());
		
		int iday = Integer.parseInt(searchStrDate.toString().substring(8,10));
		
		String check = "";
        if(iday < 11){
            check = "1";
        }else if(10 < iday && iday < 21){
            check = "2";
        }else{
            check = "3";
        }
        
		try {
			Map<String, Object> pRequestParamMap = new HashMap<String, Object>();
			pRequestParamMap.put("sCheck", check);
			pRequestParamMap.put("searchStrDate", searchStrDate);
			pRequestParamMap.put("insertTime", "7");
			
			String[] cmpCdList = {"0000000001", "4108212335", "6068207466", "1508500020", "3848200087", "1288202296", "6158209828"};
			for(String cmpCd : cmpCdList) {
				pRequestParamMap.put("cmpCd", cmpCd);
				if(cmpCd.equals("0000000001")) {
					reportService.insertMainFlowerAucAt(pRequestParamMap);
				}else {
					reportService.insertMainFlowerAucAll(pRequestParamMap);
				}
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("주요 절화류 도매가격 동향 테이블 insert 실패");
		}

        		
	}
	
	//@Scheduled(cron = "0 5 13 * * *")	// TODO 주석처리  john
	public void mainFlowerScheduleRun2() {
		
		Calendar strDate = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String searchStrDate = sdf.format(strDate.getTime());
		
		int iday = Integer.parseInt(searchStrDate.toString().substring(8,10));
		
		String check = "";
        if(iday < 11){
            check = "1";
        }else if(10 < iday && iday < 21){
            check = "2";
        }else{
            check = "3";
        }
        
		try {
			Map<String, Object> pRequestParamMap = new HashMap<String, Object>();
			pRequestParamMap.put("sCheck", check);
			pRequestParamMap.put("searchStrDate", searchStrDate);
			pRequestParamMap.put("insertTime", "13");
			
			String[] cmpCdList = {"0000000001", "4108212335", "6068207466", "1508500020", "3848200087", "1288202296", "6158209828"};
			for(String cmpCd : cmpCdList) {
				pRequestParamMap.put("cmpCd", cmpCd);
				if(cmpCd.equals("0000000001")) {
					reportService.insertMainFlowerAucAt(pRequestParamMap);
				}else {
					reportService.insertMainFlowerAucAll(pRequestParamMap);
				}
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("주요 절화류 도매가격 동향 테이블 insert 실패");
		}

	}
	
	
}
