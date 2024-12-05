package com.fpdisys.base.util;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import com.at.domain.AtMarketVO;
import com.at.service.aTService;
import com.fpdisys.dist.customInfo.service.CustomInfoService;
import com.fpdisys.dist.real.service.RealService;
import com.fpdisys.dist.report.service.ReportService;
import com.fpdisys.dist.report.mapper.ReportMapper;
import com.fpdisys.dist.report.service.CommonExcel;
import com.fpdisys.dist.trans.service.TsaleService;

import org.apache.poi.ss.usermodel.Workbook;
import com.fpminput.mntr.dailyRptMgt.controller.dailyRptSendexcel;
import com.fpminput.mntr.dailyRptMgt.service.DailyRptMgtService;
import com.fpminput.mntr.dailyRptSend.domain.DailyRptSendVO;
import com.fpminput.mntr.dailyRptSend.service.DailyRptSendService;


@Component
public class atMartDailyrptScheduleCopy {

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
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	@Scheduled(cron="0 45 6 * * *")
	public void scheduleRun4tsale(){
		String year = null;
		String month = null;
		String day = null;
		String deletedate = null;
		
		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

		String s = sdf.format(d);
		String en = sdf.format(d.getTime() - ( (long) 1000 * 60 * 60 * 24 * 3) );
		
		int sint = Integer.parseInt(s);
		int enint = Integer.parseInt(en);
		
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			
			for(int i = enint; i<=sint; i++){
				year = Integer.toString(i).substring(0,4);
				month = Integer.toString(i).substring(4,6);
				day = Integer.toString(i).substring(6,8);
				deletedate = year + "-" + month + "-" + day ;
				map.put("saleDate", deletedate);	 
				
				if(Integer.parseInt(day)<32){
					try {
	  					  tsaleService.calculateWebserviceTestDelete(map);
	  					  System.out.println("삭제완료");
	  				} catch(Exception e) {
	  					  e.printStackTrace();
	  					  System.out.println("삭제실패");
	  				}
				}
			}			
			map.put("saleDate", sdf.format(d));
			map.put("strDate", sdf.format(d.getTime() - ( (long) 1000 * 60 * 60 * 24 * 3) ));
			
			List<AtMarketVO> atMarketData = aTService.atMarketData(map);		  
	
			for(int i=0; i<atMarketData.size(); i++){				 
				 AtMarketVO rs = atMarketData.get(i);
				// 테스트 요망
				String sFilename = "0000000001" + rs.getPAN_DAY() + ".txt";
				String sRecode = ";";
				  sRecode += ";";
				  sRecode += rs.getPAN_DAY() + ";";
				  sRecode += ";";
				  sRecode += "0000000001" + ";";
				  sRecode += rs.getPAN_NO().replaceAll(" ", "") + ";";
				  sRecode += rs.getPAN_SERIAL().replaceAll(" ", "") + ";";
				  sRecode += ";";
				  sRecode += rs.getMEJANG().replaceAll(" ", "") + ";";
				  sRecode += "000000" + ";";
				  sRecode += rs.getPUM_CODE().replaceAll(" ", "") + ";";
				  sRecode += rs.getMOK_NAME().replaceAll(" ", "") + ";";
				  sRecode += rs.getJONG_NAME().replaceAll(" ", "") + ";";
				  sRecode += "1" + ";";
				  sRecode += "120000" + ";";
				  sRecode += rs.getSTRCODE_LEVEL().replaceAll(" ", "") + ";";
				  sRecode += rs.getSOK_CNT().replaceAll(" ", "") + ";";
				  sRecode += rs.getKM_P_NEW().replaceAll(" ", "") + ";";
				  sRecode += ";";
				  sRecode += "3" + ";";
				  sRecode += ";";
				  sRecode += ";";
				  sRecode += rs.getCHUL_CODE().replaceAll(" ", "") + ";";
				  sRecode += ";";
				  sRecode += ";";
				  sRecode += "5" + ";";
				  sRecode += rs.getSTRCODE_LOCAL().replaceAll(" ", "") + ";";
				  sRecode += rs.getREGION_CODE().replaceAll(" ", "") + ";";
				  sRecode += rs.getREGION_NAME().replaceAll(" ", "")+ ";";
				  sRecode += rs.getF_SONGE_CNT().replaceAll(" ", "")+ ";";
				  sRecode += rs.getPAN_PRICE().replaceAll(" ", "");
				  
				  map.put("filename", sFilename);
				  map.put("recode", sRecode);
				  map.put("requestSn", "tsale");
				  tsaleService.calculateWebserviceTestForm(map);
				  
					String gb = rs.getMEJANG().replaceAll(" ", "");
							
					if(gb.equals("1")){
						System.out.println("구분 : 절화");
					}else if(gb.equals("2")){
						System.out.println("구분 : 관엽");
					}else if(gb.equals("3")){
						System.out.println("구분 : 난");
					}else if(gb.equals("4")){
						System.out.println("구분 : 춘란");
					}else{
						System.out.println("구분 : 5(기타)");
					}
			}
			for(int i = enint; i<=sint; i++){
				year = Integer.toString(i).substring(0,4);
				month = Integer.toString(i).substring(4,6);
				day = Integer.toString(i).substring(6,8);
				deletedate = year + "-" + month + "-" + day ;

				map.put("requestSn", "magam");
				
				if(Integer.parseInt(day)<32){
	  	  			tsaleService.deleteSaleDate("0000000001", deletedate);	
	  	  			tsaleService.insertSaleDate("0000000001", deletedate);	
				}
			}
			System.out.println("마감완료");
		} catch(Exception e) {
			  e.printStackTrace();
			  System.out.println("전송실패");
		}
	}
	//@Scheduled(cron="0 10 7 * * 1,3,5")	// TODO 주석처리  john
	//@Scheduled(cron="* * * * * *")
	public void scheduleRun4dailyReport(){
		Calendar cal = Calendar.getInstance();
		//String strdate = new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
		String strdate = "2022-10-28";
		
		ArrayList<String> receiver_list = get_receiver_list();
		try{
			Workbook dayAuc_excel = dailyRptSendExcel.get_dayAuc_excel(strdate);
			Workbook dayPumAuc_excel = dailyRptSendExcel.get_dayPumAuc_excel(strdate);
			Workbook mainFlowerAuc_excel = dailyRptSendExcel.get_mainFlowerAuc_excel(strdate);
			for(String receiver : receiver_list){
				String msg = dailyRptSendExcel.mailSend(receiver, dayPumAuc_excel, mainFlowerAuc_excel, dayAuc_excel);
				System.out.println("Mail sending:"+msg);
				
				Map<String, Object> pRequestParamMap = new HashMap<String, Object>();
				pRequestParamMap.put("sysGp", "1");
				if(msg.equals("success")){
					pRequestParamMap.put("rsltGp", "S");
					pRequestParamMap.put("procMsg", receiver + "메일 발송 완료");
				}
				else{
					pRequestParamMap.put("rsltGp", "E");
					pRequestParamMap.put("procMsg", receiver + "메일 발송 실패");
				}
	
				String searchStrDate = new SimpleDateFormat("yyyyMMddHHmmss").format(Calendar.getInstance().getTime());
	
				pRequestParamMap.put("startDate", searchStrDate);
				pRequestParamMap.put("endDate", searchStrDate);
				pRequestParamMap.put("userNm", receiver);
				
				dailyRptMgtService.insertGridList(pRequestParamMap);
			}
		}catch(Exception e){
			Map<String, Object> pRequestParamMap = new HashMap<String, Object>();
			pRequestParamMap.put("sysGp", "1");
			String searchStrDate = new SimpleDateFormat("yyyyMMddHHmmss").format(Calendar.getInstance().getTime());
			pRequestParamMap.put("rsltGp", "E");
			pRequestParamMap.put("startDate", searchStrDate);
			pRequestParamMap.put("endDate", searchStrDate);
			for(String receiver : receiver_list){
				pRequestParamMap.put("userNm", receiver);
				pRequestParamMap.put("procMsg", receiver + "메일 발송 실패");
				dailyRptMgtService.insertGridList(pRequestParamMap);
			}
		}
	}
	

	// 일일 보고자료 발송 관리에 등록된 메일 주소 리스트 가져옴.
	public ArrayList<String> get_receiver_list(){
		
		Map<String, Object> pRequestParamMap = new HashMap<String, Object>();


		pRequestParamMap.put("searchNm", null);
		
		ArrayList<String> receiver_list = new ArrayList<String>();
		List<DailyRptSendVO> resultList = dailyRptSendService.selectGridAll(pRequestParamMap);
		
		for(DailyRptSendVO vo : resultList) {
			receiver_list.add(vo.getEmailAdrs());
			System.out.println("수신자" + vo.getEmailAdrs());
		}
		System.out.println("get_receiver_list success");
		
		
		return receiver_list;
	}
}