package com.fpdisys.base.util;



import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.fpminput.mntr.codeManage.service.CodeManageService;



@Component
public class TranCodeSmsSchedule {
	
	@Autowired
	CodeManageService codeManageService;
	
	
	protected Log log = LogFactory.getLog(this.getClass());
				
	// 11시에 한번씩 수행
	//@Scheduled(cron="0 0 11 * * *")	// TODO 주석처리  john
	public void scheduleRun(){
		
		try {
			System.out.println("TRAN CODE SMS 전송데이터 문자 스케쥴 실행");
			codeManageService.procTranCodeSms();
		} catch(Exception e) {
			System.out.println("예외발생");
		} 
	}
	
	
}