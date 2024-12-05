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
import com.fpdisys.dist.yuchal.service.copy.YuchalService;

@Component
public class atMartYuchalSchedule {
	
	@Autowired
	CustomInfoService custionInfoService;
	@Autowired
	RealService realService;
	@Autowired
	YuchalService yuchalService;
	@Autowired
	aTService aTService;	
	
	protected Log log = LogFactory.getLog(this.getClass());
				
	// 1시간에 1번씩 수행
	// @Scheduled(cron="0 10 10 * * *")	// TODO 주석처리  john
	//@Scheduled(cron="0 8 18 * * *")
	//@Scheduled(cron="0 20 * * * *")
	public void scheduleRun(){
		String year = null;
		String month = null;
		String day = null;
		String deletedate = null;
		  
		Date d = new Date();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
		
		String s = sdf.format(d);
		String en = sdf.format(d.getTime() - ( (long) 1000 * 60 * 60 * 24 * 3) );
		
		int sint = Integer.parseInt(s);
		int enint = Integer.parseInt(en);
		Map<String, Object> map = new HashMap<String, Object>();
		
					
		map.put("saleDate", sdf.format(d));
		map.put("strDate", sdf.format(d.getTime() - ( (long) 1000 * 60 * 60 * 24 * 3) ));
		// 유찰데이터 삭제
		yuchalService.deleteYuchal(map);
		
		try {				
			List<AtMarketVO> atMarketData = aTService.atMarketYuchalData(map);		  
			 for(int i=0; i<atMarketData.size(); i++){				 
				 AtMarketVO rs = atMarketData.get(i);
				  yuchalService.insertYuchal(rs);
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