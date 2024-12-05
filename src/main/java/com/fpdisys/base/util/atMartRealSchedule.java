package com.fpdisys.base.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.at.domain.AtMarketVO;
import com.at.service.aTService;
import com.fpdisys.dist.customInfo.service.CustomInfoService;
import com.fpdisys.dist.real.service.RealService;
import com.fpdisys.dist.trans.service.TsaleService;

@Component
public class atMartRealSchedule {
	
	@Autowired
	CustomInfoService custionInfoService;
	@Autowired
	RealService realService;
	@Autowired
	TsaleService tsaleService;
	@Autowired
	aTService aTService;
	
	protected Log log = LogFactory.getLog(this.getClass());
				
	// 10분에 한번씩 수행 (초를 0으로 설정할 경우 10분에 실행되어야하나 9분 59초에 실행되는 경우가 간혹 발생)
	@Scheduled(cron="59 0/10 * * * *")	// TODO 주석처리  john
	//@Scheduled(cron="* * * * * *")	
	public void scheduleRun(){
	
		Date d = new Date();
		SimpleDateFormat sdfSrt = new SimpleDateFormat("yyyyMMddHHmm");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMddHH");
		
		String s = sdfSrt.format(d);
		
		String en = "";
		try{
			String curHh = s.substring(8, 10);
			String curMm = s.substring(10, 12);
			if(Integer.parseInt(curHh) >= 23 && (Integer.parseInt(curMm) >= 10 && Integer.parseInt(curMm) <= 50)){
				d.setTime(d.getTime() + ( (long) 1000 * 60 * 60 * 24));
			}
			
			s = s.substring(0, s.length()-1) + "000";
			en = sdfSrt.format(sdf.parse(s).getTime() - ( (long) 1000 * 60 * 10) +1);
		
		} catch(Exception e){
			e.printStackTrace();
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("strDate", en+"01");	 
		map.put("saleDate", s);
		map.put("panDate",  sdf1.format(d));
		
		try {
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
				  sRecode += null != rs.getSTRCODE_LOCAL()  ?  rs.getSTRCODE_LOCAL().replaceAll(" ", "") + ";" : ";";
				  sRecode += null != rs.getREGION_CODE() ? rs.getREGION_CODE().replaceAll(" ", "") + ";" : ";";
				  sRecode += null != rs.getREGION_NAME() ?  rs.getREGION_NAME().replaceAll(" ", "") + ";" : ";";
				  
				  
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
		} catch(Exception e) {
			  e.printStackTrace();
			  System.out.println("전송실패");
		} 
	}
	
	private static String getTagValue(String sTag, Element eElement) {
			NodeList nlList = eElement.getElementsByTagName(sTag).item(0).getChildNodes();
			
			Node nValue = (Node) nlList.item(0);
			
			return nValue.getNodeValue();
		}
		
	public static String BinToHex(byte [] buf) {
	  String res = "";
	  String token = "";
	  for (int ix=0; ix<buf.length; ix++) {
		token = Integer.toHexString(buf[ix]);
	//	CommonUtil.println("[" + ix + "] token value : " + token + " len : " + token.length());
		if (token.length() >= 2)
		token = token.substring(token.length()-2);
		else {
		for(int jx=0; jx<2-token.length();jx++)
		 token = "0" + token;
		}	 
		res += "%" + token;
	  }
	  
	  return res.toUpperCase();
	 }
}