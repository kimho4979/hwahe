package com.fpdisys.base.util;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.fpdisys.dist.customInfo.domain.CustomInfoSnsVO;
import com.fpdisys.dist.customInfo.domain.CustomInfoVO;
import com.fpdisys.dist.customInfo.service.CustomInfoService;
import com.fpdisys.dist.menu.domain.MenuVO;
import com.fpdisys.dist.menu.service.MenuService;
import com.fpdisys.dist.real.domain.RealVO;
import com.fpdisys.dist.real.service.RealService;
import com.fpdisys.dist.saleprice.service.SalePriceService;

@Component
public class CustomInfoSchedule {
	
	@Autowired
	CustomInfoService custionInfoService;
	@Autowired
	RealService realService;
	@Autowired
	SalePriceService salelService;
	@Autowired
	MenuService menuService;
	
	protected Log log = LogFactory.getLog(this.getClass());
		
		
	// 1시간에 1번씩 수행
	//@Scheduled(cron="0 0 0/1 * * *")	// TODO 주석처리  john
	//@Scheduled(cron="0 0/1 * * * *")
	public void scheduleRun(){		
		//SimpleDateFormat transFormat = new SimpleDateFormat("yyyyMMdd");
		
		SimpleDateFormat transFormat1 = new SimpleDateFormat("HH");

		//String requestURI = request.getRequestURI();
 		HashMap<String , Object> map = new HashMap<String, Object>();
 		
 		try{
 			// 아침 9시 정산가격 보내기
 			List<CustomInfoSnsVO> customInfo = custionInfoService.getSnsList(map);
 			map.put("realTime", transFormat1.format(new Date()));
 	 		// 1. 맞춤정보 요청 - 사용자 정보 가져오기
 	 		customInfo = custionInfoService.getSnsList(map);
 	 		
 	 		// 2. 맞춤정보 요청 사용자가 있을경우 realTime 시간별
 	 		if(customInfo.size() > 0){
 	 			for(int i=0; i<customInfo.size(); i++){
 	 				
 	 				CustomInfoSnsVO customInfoSns = customInfo.get(i);
 	 				
 	 				// 실시간 가격정보 
 	 				if(customInfoSns.getRealYn().equals("Y")){
 	 					sendService("화훼 유통정보 가격정보 안내", customInfoSns.getUserGubun(), customInfoSns.getUserId(), customInfoSns);
 					}
 	 			}
 	 		} 		
 		} catch(Exception e) {
 			e.printStackTrace();
 			System.out.println("getSnsList 에러 발생");
 		}
 		
 		try{
 			// menu 목록 불러오기
 			String requestURI = "/main/flowerMain.do";
 	 		menuService.setCacheMenuAliasUpdate();
 			MenuVO currentMenuVO = menuService.getCacheByUrl(requestURI);
 	 		MenuVO currentMenuInfo = this.menuService.getByMenuIdUpdate(currentMenuVO.getMenuId());
 	 		System.out.println("스케줄 처리");
 		} catch(Exception e) {
 			e.printStackTrace();
 			System.out.println("메뉴 스케줄 처리 에러 발생");
 		}
 		
 		/*
		if(transFormat1.format(new Date()).equals("09")){
			for(int i=0; i<customInfo.size(); i++){
 				
 				CustomInfoSnsVO customInfoSns = customInfo.get(i);
 				if(customInfoSns.getSaleYn().equals("Y")){
					sendSaleService("화훼 맞춤알림 정산가격정보 안내", customInfoSns.getUserGubun(), customInfoSns.getUserId(), customInfoSns);
 				}
			}
 		}*/
 		
	
  	}
	
	public void sendService(String title, String gubun, String userId, CustomInfoSnsVO customInfoSnsVO){
		
		StringBuilder result = new StringBuilder();
		StringBuilder resultBak = new StringBuilder();
		String lineEnter="\r\n";
		if(gubun.equals("email")){
			lineEnter = "<br>";
		}
		result.append("신뢰성 있는 가격정보를 제공하는 화훼유통정보 서비스입니다.");
		result.append(lineEnter);
		
		result.append("고객님께서 신청하신 실시간 가격정보입니다.");
		result.append(lineEnter);
		result.append(lineEnter);

		List<CustomInfoVO> list = customInfoSnsVO.getCustomInfoVo();
		
		HashMap<String , Object> map = new HashMap<String, Object>();
 		boolean noData=true;
 		
 		
		for(int i=0; i<list.size(); i++){
			String itemCdTxt = list.get(i).getItemCd1();
			if( list.get(i).getItemCd1() == null){
				itemCdTxt="전체";
			}
			//result.append((i+1)+"-1. "+ list.get(i).getSidoCode()+"|"+list.get(i).getItemCd()+"|"+itemCdTxt+" 경매가격");
			//result.append(lineEnter);
			
			String sidoCdStr="전체";
			if(list.get(i).getSidoCode().equals("전체")){
				map.put("sidoCd", "");
			}else{
				String sidoCd=list.get(i).getSidoCode();
				
				if(sidoCd.equals("0000000001")){
					sidoCdStr="aT화훼공판장";
				} else if(sidoCd.equals("1508500020")){
					sidoCdStr="부산화훼공판장";
				} else if(sidoCd.equals("4108212335")){
					sidoCdStr="광주원예농협";
				} else if(sidoCd.equals("3848200087")){
					sidoCdStr="한국화훼농협(음성)";
				}  else if(sidoCd.equals("1288202296")){
					sidoCdStr="한국화훼농협(본점)";
				}  else if(sidoCd.equals("6158209828")){
					sidoCdStr="영남화훼";
				}
				map.put("sidoCd", list.get(i).getSidoCode());
			}
			
			resultBak.append((i+1)+"-1. "+ sidoCdStr+"|"+list.get(i).getItemCd()+"|"+itemCdTxt+" 경매가격");
			resultBak.append(lineEnter);
			
			
			if(list.get(i).getSidoCode().equals("전체")){
				map.put("sidoCd", "");
			}else{
				map.put("sidoCd", list.get(i).getSidoCode());
			}
			
			map.put("itemCd1", list.get(i).getItemCd1());
			if(list.get(i).getItemCd1()!=null){
				if(list.get(i).getItemCd1().equals("전체")){
					map.put("itemCd1", "");
				}
			}
			
			map.put("itemCd", list.get(i).getItemCd());
			
			boolean realDatainfo = true;
			// 실시간 가격정보(경매가격)
			List<RealVO> realData = realService.selectPumAvg(map);
			if(realData.size()>0){
				//result.append("거래량 : " + realData.get(0).getTotQty() +" 속");
				//result.append(lineEnter);
				
				//result.append("평균가 : " + realData.get(0).getAvgAmt() +" 원");
				//result.append(lineEnter);
				
				//result.append("최고가 : " + realData.get(0).getMaxAmt() +" 원");
				//result.append(lineEnter);
				
				//result.append("최저가 : " + realData.get(0).getMinAmt() +" 원");
				//result.append(lineEnter);
				//result.append(lineEnter);
				
				resultBak.append("거래량 : " + realData.get(0).getTotQty() +" 속");
				resultBak.append(lineEnter);
				
				resultBak.append("평균가 : " + realData.get(0).getAvgAmt() +" 원");
				resultBak.append(lineEnter);
				
				resultBak.append("최고가 : " + realData.get(0).getMaxAmt() +" 원");
				resultBak.append(lineEnter);
				
				resultBak.append("최저가 : " + realData.get(0).getMinAmt() +" 원");
				resultBak.append(lineEnter);
				resultBak.append(lineEnter);
				noData=false;
			}else{
				//result.append("경매정보없음");
				//result.append(lineEnter);
				//result.append(lineEnter);
				
				resultBak.append("금일경매정보없음");
				resultBak.append(lineEnter);
				resultBak.append(lineEnter);
				realDatainfo = false;
			}
			
			if(realDatainfo){
				//result.append((i+1)+"-2. 등급별 거래량/평균가");
				//result.append(lineEnter);		
				
				resultBak.append((i+1)+"-2. 등급별 거래량/평균가");
				resultBak.append(lineEnter); 
				// 등급별 가격정보(경매가격)
				List<RealVO> realLvData = realService.selectLvCdAvg(map);
				if(realLvData.size()>0){
					for(int j=0;j<realLvData.size(); j++){
						//result.append(realLvData.get(j).getLvName()+ " : " + realLvData.get(j).getTotQty() +" 속 / "+realLvData.get(j).getAvgAmt() +" 원");
						//result.append(lineEnter);
						resultBak.append(realLvData.get(j).getLvName()+ " : " + realLvData.get(j).getTotQty() +" 속 / "+realLvData.get(j).getAvgAmt() +" 원");
						resultBak.append(lineEnter);
					}
					//result.append(lineEnter);
					resultBak.append(lineEnter);
				}else{
					//result.append("경매정보없음");
					//result.append(lineEnter);
					//result.append(lineEnter);
					resultBak.append("금일경매정보없음");
					resultBak.append(lineEnter);
					resultBak.append(lineEnter);
				}	
			}
			
			if(gubun.equals("kakao")){
				try {
					if(result.toString().getBytes("UTF-8").length+resultBak.toString().getBytes("UTF-8").length>1900){
						sendSms(title, userId, result.toString());
						result = new StringBuilder();
					}else{
						result.append(resultBak.toString());
						resultBak = new StringBuilder();
					}
				} catch (UnsupportedEncodingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}else{
				result.append(resultBak.toString());
				resultBak = new StringBuilder();
			}
		}
		result.append("고객님께서 신청하신 실시간 가격정보는 화훼유통정보홈페이지(https://flower.at.or.kr/)에서 확인하실 수 있습니다.");
		result.append(lineEnter);
		
		if(!noData){
			if(gubun.equals("email")){
				// email 발송
				sendMail(title, userId, result.toString());
			}else{
				// 문자발송
				sendSms(title, userId, result.toString());
			}
		}
		
	}
	
	public void sendSaleService(String title, String gubun, String userId, CustomInfoSnsVO customInfoSnsVO){
		
		String saleDate = salelService.selectTodaySale();
		StringBuilder result = new StringBuilder();
		String lineEnter="\r\n";
		if(gubun.equals("email")){
			lineEnter = "<br>";
		}
		result.append("신뢰성 있는 가격정보를 제공하는 화훼유통정보 서비스입니다.");
		result.append(lineEnter);
		
		result.append("고객님께서 신청하신 정산 가격정보입니다.");
		result.append(lineEnter);
		result.append(lineEnter);
		result.append("신규 정산가격 업데이트 : "+saleDate);
		result.append(lineEnter);
		result.append("가격정보 확인하기 : https://flower.at.or.kr/hab01/hab01.do");
		result.append(lineEnter);
		result.append("더 이상 수신을 원하지 않으시는 경우 웹사이트에서 맞춤알림 설정을 변경하십시오.");
		result.append(lineEnter);
		result.append("https://flower.at.or.kr -> 오른쪽 위 (맞춤알림정보) 클릭 -> 수신하시는 휴대폰번호/이메일와 비밀번호 입력 -> 맞춤알림 변경");
		result.append(lineEnter);

		if(saleDate!=null&&!saleDate.equals("")){
			if(gubun.equals("email")){
				// email 발송
				 sendMail(title, userId, result.toString());
			}else{
				// 문자발송
				sendSms(title, userId, result.toString());
			}
		}
		
	}
 
	public boolean sendMail(String title, String userId, String content){
		
		HashMap<String , Object> map = new HashMap<String, Object>();
		map.put("title", title);
		map.put("userId", userId);
		map.put("content", content);
		
		int sendResult = custionInfoService.sendMail(map);
		
		if(sendResult > 0){
			return true;
		}else{
			return false;
		}
	}
	
	public boolean sendSms(String title, String userId, String content){
	
		HashMap<String , Object> map = new HashMap<String, Object>();
		
		map.put("msgType", "5");
		//map.put("sms", "SMS");
		map.put("title", title);
		map.put("userId", userId);
		map.put("subject", content);
			
		int result = custionInfoService.sendKakao(map);
		
		if(result > 0){
			return true;
		}else{
			return false;
		}
		
		
	}
	
}