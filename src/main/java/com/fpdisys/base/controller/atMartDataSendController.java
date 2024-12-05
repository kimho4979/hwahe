package com.fpdisys.base.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.at.domain.AtMarketVO;
import com.at.service.aTService;
import com.egovapi.service.CommonApiLogService;
import com.egovapi.util.CommonApiUtil;
import com.fpdisys.dist.customInfo.service.CustomInfoService;
import com.fpdisys.dist.real.service.RealService;
import com.fpdisys.dist.trans.service.TsaleService;


@Controller
public class atMartDataSendController {
	@Autowired
	CustomInfoService custionInfoService;
	@Autowired
	RealService realService;
	@Autowired
	TsaleService tsaleService;
	@Autowired
	aTService aTService;	
	@Autowired
	CommonApiLogService commonApiLogService;
	
	protected Log log = LogFactory.getLog(this.getClass());	
	
	
	@RequestMapping(value="/admin/atMartDataSend.do")
	public void selectShippedInput(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) throws Exception {			  			  				
		
		HttpSession httpSession = pRequest.getSession();
			
//		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
//			log.info("접속 권한이 없습니다.");
//		}else{

			String today = pRequestParamMap.get("saleDate").toString();
			String year = null;
			String month = null;
			String day = null;
			String deletedate = null;
			  			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
			
			Date d = sdf1.parse(today);
			
			String s = sdf.format(d);
			String en = sdf.format(d.getTime() - ( (long) 1000 * 60 * 60 * 24 * 3) );
			String hipenS = sdf1.format(d);
			
			int sint = Integer.parseInt(s);
			int enint = Integer.parseInt(en);
			Map<String, Object> map = new HashMap<String, Object>();
			
			String logStat="1";
			String errorDetail="";
			
			Map<String, String> mapLog = new HashMap<String, String>();
			mapLog.put("jobId", "4");
			mapLog.put("logGubun", "1");
			mapLog.put("logSeq", "");
			
			// 스케쥴러 로그 등록 및 로그 순번 조회
			 commonApiLogService.startJobLog(mapLog);
			
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
						
					try {				
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
					} catch(Exception e) {
						  e.printStackTrace();
						  System.out.println("전송실패");
					} 
	
				try {
					for(int i = enint; i<=sint; i++){
						year = Integer.toString(i).substring(0,4);
						month = Integer.toString(i).substring(4,6);
						day = Integer.toString(i).substring(6,8);
						deletedate = year + "-" + month + "-" + day ;
	
						map.put("requestSn", "magam");
						
						if(Integer.parseInt(day)<32){
			  	  			tsaleService.deleteSaleDate("0000000001", deletedate);	
			  	  			tsaleService.insertSaleDate("0000000001", deletedate);	
			  	  			tsaleService.deleteSaleMonth("0000000001", deletedate);	
			  	  			tsaleService.insertSaleMonth("0000000001", deletedate);
		  					  
		  					System.out.println("마감완료");
						}
					}
					System.out.println("마감완료");
					
				} catch(Exception e) {
					e.printStackTrace();
					System.out.println("마감실패");
					logStat = "2";
					errorDetail = CommonApiUtil.getSqlErrorMessage(e.toString());
					commonApiLogService.insertFailLog("전송실패", mapLog, "5", mapLog.get("logSeq"));
			 } 	
				
			// 	결과 반영
				if(!"1".equals(logStat)) commonApiLogService.updateResultLog(logStat, errorDetail, "4", mapLog.get("logSeq"));
				
				// 최종갱신결과 업데이트
				commonApiLogService.updateJobList("4", logStat);
		  	}catch(Exception e){
		  		e.printStackTrace();
		  	}
		
			//}
	}
	
	// 10분에 한번씩 수행
	@RequestMapping(value="/admin/atMartRealDataSend.do")
	public void scheduleRun2(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		  
		HttpSession httpSession = pRequest.getSession();
		
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			log.info("접속 권한이 없습니다.");
		}else{
		
		Date d = new Date();
		SimpleDateFormat sdfSrt = new SimpleDateFormat("yyyyMMdd");
		
		String en = sdfSrt.format(d);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("strDate", en);	 
		
		try {
			
			int totATCnt = aTService.atMarketTotCnt(map);
			int totRealCnt = realService.atMarketRealTotCnt(map);
		
			//총물량 비교후 삭제 정재
			if(totATCnt != totRealCnt){
				realService.deleteAtRealData(map);
				List<AtMarketVO> atMarketData = aTService.atMarketRealData2(map);
				
				
				 for(int i=0; i<atMarketData.size(); i++){				 
					 AtMarketVO rs = atMarketData.get(i);
					// 테스트 요망
					String sFilename = "0000000001" + rs.getPAN_DAY() + ".txt";
					String sRecode = ";";
					sRecode += rs.getFIRST_IN_DATE().replaceAll(" ", "");
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
					  sRecode += rs.getREGION_NAME().replaceAll(" ", "");
					  
					  
					  map.put("filename", sFilename);
					  map.put("recode", sRecode);
					  tsaleService.calculateWebservice(map);
					  
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
			}
		} catch(Exception e) {
			  e.printStackTrace();
			  System.out.println("전송실패");
		} 
	}
	
	}
}
