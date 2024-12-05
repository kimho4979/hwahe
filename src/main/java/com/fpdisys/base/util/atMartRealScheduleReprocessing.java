package com.fpdisys.base.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.at.domain.AtMarketVO;
import com.at.service.aTService;
import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.dist.customInfo.service.CustomInfoService;
import com.fpdisys.dist.real.service.RealService;
import com.fpdisys.dist.trans.service.TsaleService;

@Controller
public class atMartRealScheduleReprocessing extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired
	CustomInfoService custionInfoService;
	@Autowired
	RealService realService;
	@Autowired
	TsaleService tsaleService;
	@Autowired
	aTService aTService;
	
	@RequestMapping(value="/util/insertTReal.json", method=RequestMethod.POST)
	public void tRealReprocessing(HttpServletRequest header, @RequestBody Map<String, Object> requestMap){
		
		try{
			String strTime = requestMap.get("strTime").toString(); // yyyyMMdd24MISS
			String endTime = requestMap.get("endTime").toString();
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			
			Date strTimeDate = sdf.parse(strTime);
			Date endTimeDate = sdf.parse(endTime);
	
			Calendar strTimeCal = Calendar.getInstance();
			strTimeCal.setTime(strTimeDate);
			Calendar endTimeCal = Calendar.getInstance();
			endTimeCal.setTime(endTimeDate);
			
			SimpleDateFormat sdfSrt = new SimpleDateFormat("yyyyMMddHHmm");
			SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMdd");
			
			while(strTimeCal.before(endTimeCal)){
				strTimeCal.add(Calendar.MINUTE, 10);
				Date d = strTimeCal.getTime();
				
				String s = sdfSrt.format(d);
				
				String en = "";
		
				String curHh = s.substring(8, 10);
				String curMm = s.substring(10, 12);
				if(Integer.parseInt(curHh) >= 23 && (Integer.parseInt(curMm) >= 10 && Integer.parseInt(curMm) <= 50))
					d.setTime(d.getTime() + ( (long) 1000 * 60 * 60 * 24));
				
				
				s = s.substring(0, s.length()-1) + "000";
				en = sdfSrt.format(sdf.parse(s).getTime() - ( (long) 1000 * 60 * 10) +1);
				
		
				
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("strDate", en+"01");	 
				map.put("saleDate", s);
				map.put("panDate",  sdf1.format(d));
				
				System.out.println("strDate: "+en+"01"+"  saleDate: "+s+"  panDate: "+ sdf1.format(d));
		
				List<AtMarketVO> atMarketData = aTService.atMarketRealData(map);
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
