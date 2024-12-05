package com.fpdisys.base.util;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.fpdisys.dist.report.service.ReportService;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Component
public class MafraAvgSchedule {
	
protected Log log = LogFactory.getLog(this.getClass());	
	
	@Autowired  
	ReportService reportService;
	
	//@Scheduled(cron = "0 56 0 1 1 *")	// TODO 주석처리  john
	public void mfraScheduleRun(){
		
		Map<String, Object> paramMap = new HashMap<String, Object>(); 
	
        List<String> cmpList = reportService.selectCutFlowerCmpList();
		for(String cmpCd :cmpList){
			paramMap.put("cmpCd", cmpCd);
			
			String yesterDay = reportService.selectYsDay(paramMap);
			if(yesterDay != null){
				//양재 at 구분
				if(cmpCd.equals("0000000001")){
					//전년도 평균 입력
					reportService.seletInsertAvgPreYearAt(paramMap);
					//평년 평균 입력
					reportService.seletInsertAvgYearAt(paramMap);
					//전년도 물량, 유찰물량, 평균가
					reportService.selectInsertPreDayAt(paramMap);
					//평년 물량, 유찰물량, 평균가
					reportService.selectInsertAvgDayAt(paramMap);
					
					
					
				}else{
					//전년도 평균 입력
					reportService.seletInsertAvgPreYearAll(paramMap);
					//평년 평균 입력
					reportService.seletInsertAvgYearAll(paramMap);
				}
				
				
			}
			
		}
	}
}
