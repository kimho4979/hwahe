package com.fpdisys.base.util;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.fpdisys.module.recv.service.NeisService;

@Component
public class atMartDailyVerification {
	
	@Autowired
	NeisService neisService;
	
	@Scheduled(cron = "0 0 0 * * *")
	public void scheduledRun(){
		
	}

}
