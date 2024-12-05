package com.fpdisys.base.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.fpdisys.dist.hab09.service.Hab09Service;
import com.fpdisys.dist.real.service.RealService;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Component
public class Hab09UploadSchedule {
	
	@Autowired
	Hab09Service hab09Service;

	@Scheduled(cron = "0 5 0 * * *")	// TODO 주석처리  john
	public void scheduleRun() {

		Calendar calendar = new GregorianCalendar();
		SimpleDateFormat SDF = new SimpleDateFormat("yyyy-MM-dd");
		calendar.add(Calendar.DATE, -1);
		String searchEndDate = SDF.format(calendar.getTime());
		calendar.add(Calendar.DATE, -5);
		String searchStrDate = SDF.format(calendar.getTime());
		
		HashMap<String, Object> dateParam = new HashMap<String, Object>();
		dateParam.put("searchStrDate", searchStrDate);
		dateParam.put("searchEndDate", searchEndDate);
		
		String title = "";
		
		try{
			HashMap<String, Object> param = new HashMap<String, Object>();

			List<EgovMap> cmpList = hab09Service.getDataCmpList(dateParam);
			
			for(EgovMap cmp : cmpList) {
				title = cmp.get("saleDate").toString().replaceAll("-", "") + " " + getCmpLocal(cmp.get("cmpCd").toString());
				param.put("title", title);
				param.put("cmpCd", cmp.get("cmpCd"));
				param.put("saleDate", cmp.get("saleDate").toString());
				
				hab09Service.insertAucBbs(param);
			}
			
			System.out.println("일자별 경매동향 업로드 성공");
			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("일자별 경매동향 업로드 실패");
		}
	}

	
	public String getCmpLocal(String cmpCd) {
		
		switch(cmpCd) {
		case "0000000001": return "양재"; 
		case "4108212335": return "광주";
		case "6068207466": return "부산강동";
		case "1508500020": return "부산엄궁";
		case "3848200087": return "음성";
		case "1288202296": return "과천";
		case "6158209828": return "김해";
		case "7368200686": return "고양";
		default: return "기타";
		}
	}
}
