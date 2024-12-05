package com.fpdisys.base.util;

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

import com.fpdisys.dist.customInfo.service.CustomInfoService;
import com.fpdisys.dist.real.service.RealService;
import com.fpminput.mntr.login.service.LoginMntService;

@Component
public class CustomMntSchedule {
	
	@Autowired
	CustomInfoService custionInfoService;
	@Autowired
	RealService realService;
	
	@Autowired
	LoginMntService  loginService;
		
	protected Log log = LogFactory.getLog(this.getClass());
			
	// 1시간에 1번씩 수행
	//@Scheduled(cron="0 0 14 1,14,24 * *")//1 4 9 14 19 24 29	// TODO 주석처리  john
	//@Scheduled(cron="0 50 21 1,23 * *")
	public void scheduleRun(){		
		//SimpleDateFormat transFormat = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat transFormat = new SimpleDateFormat("dd");
		
		String day = transFormat.format(new Date());
		HashMap<String , Object> map = new HashMap<String, Object>();
		if(day.equals("01")){
			// sso 생성
			loginService.deleteSso(new HashMap<String, Object>());
			loginService.insertSso(new HashMap<String, Object>());
			
			// 개인 url 생성 및 카톡 insert
			List result = loginService.selectSso(map);
		
			for(int i=0; i<result.size(); i++){
				sendService("모니터요원 자료입력 ",day, (Map<String, String>) result.get(i));
			}
			
		}else if(day.equals("29")){
			// 개인 url 생성 및 카톡 insert
			List result = loginService.selectSso(map);
		
			for(int i=0; i<result.size(); i++){
				sendService("모니터요원 자료입력 ",day, (Map<String, String>) result.get(i));
			}
		}else{
			// 개인 url 생성 및 카톡 insert
			List result = loginService.selectSso(map);
		
			for(int i=0; i<result.size(); i++){
				sendService("모니터요원 자료입력 ",day, (Map<String, String>) result.get(i));
			}
		}
  	}
	
	public void sendService(String title,String  day, Map<String, String> resultTemp){
		SimpleDateFormat yearFormat = new SimpleDateFormat("YYYY");
		SimpleDateFormat transFormat = new SimpleDateFormat("MM");
		
		String ssoKey = resultTemp.get("SSO_KEY");
		String mob = resultTemp.get("MOB");
		String monitorType = resultTemp.get("MONITOR_TYPE");
		
		StringBuilder result = new StringBuilder();
		String lineEnter="\r\n";
		
		result.append("화훼유통정보시스템 모니터요원 자료 입력 안내");
		result.append(lineEnter);
		
		String cropInfo = "";
		
		if(monitorType.equals("A")){
			cropInfo="출하물량&출하예정물량&작황동향&재배동향";
		}else if(monitorType.equals("P")){
			cropInfo="출하물량&출하예정물량";
		}else if(monitorType.equals("C")){
			cropInfo="소비동향&소매가격";
		}
		result.append(transFormat.format(new Date())+"월 "+cropInfo+" 자료 입력기간입니다.");
		result.append(lineEnter);
		
		int lastDay = 0;										//마지막 날짜 변수
		Calendar cal = Calendar.getInstance();
		cal.set(Integer.parseInt(yearFormat.format(new Date())),Integer.parseInt(transFormat.format(new Date()))-1,1);
		lastDay = cal.getActualMaximum(Calendar.DATE);
		
		String endDate="";
		if(monitorType.equals("A")){
			if(Integer.parseInt(day)<10){
				endDate="10";
			}else if(Integer.parseInt(day)<20){
				endDate="20";
			}else if(Integer.parseInt(day)<32){
				endDate=lastDay+"";				
			}
		}else if(monitorType.equals("P")){
			if(Integer.parseInt(day)<10){
				endDate="10";
			}else if(Integer.parseInt(day)<20){
				endDate="20";
			}else if(Integer.parseInt(day)<32){
				endDate=lastDay+"";				
			}
		}else if(monitorType.equals("C")){
			endDate=lastDay+"";
		}
		result.append(transFormat.format(new Date())+"월 "+endDate+"까지 아래 링크에서 자료를 입력하여 주시면 감사하겠습니다.");
		result.append(lineEnter);
		
		result.append("https://flower.at.or.kr/login/loginSso.do?sso="+ssoKey);
		result.append(lineEnter);
		
		result.append("입력해주신 자료는 화훼농가 소득증대와 화훼산업 발전을 위한 소중한 자료로 활용됩니다.");
		result.append(lineEnter);
		
		sendSms(title, mob, result.toString());		
	}
	
	public boolean sendSms(String title, String userId, String content){
		
		HashMap<String , Object> map = new HashMap<String, Object>();
		
		map.put("userId", userId);
		map.put("msgType", "6");
		map.put("sms", "LMS");
		map.put("template", "bizp_2017081816055910619873794");
		map.put("title", "모니터요원자료입력");
		map.put("subject", content);
			
		int result = custionInfoService.sendKakao(map);
		
		if(result > 0){
			return true;
		}else{
			return false;
		}
		
		
	}
}