package com.fpdisys.dist.trans.controller;


import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.at.domain.AtMarketVO;
import com.at.domain.AtMntVO;
import com.at.service.aTService;
import com.egovapi.service.CommonApiLogService;
import com.egovapi.util.CommonApiUtil;
import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.dist.trans.service.TsaleService;

import egovframework.rte.fdl.property.EgovPropertyService;
/**
 * @Class Name : CalculateController.java
 * @Description : CalculateController Class
 *	 
 * @정산자료 콘트롤러
 * @  수정일	  수정자			  수정내용
 * @ ---------	---------	-------------------------------
 * @ 2016.07.28			최초생성
 *
 * @author 우림인포텍
 * @version 1.0
 * @see
 *
 *  Copyright (C) by woorim All right reserved.
 */
@Controller
public class CalculateController extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());	
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	

	@Autowired
	TsaleService calService;
	
	@Autowired
	TsaleService tsaleService;
	@Autowired
	aTService aTService;	
	@Autowired
	CommonApiLogService commonApiLogService;

	/*정산 row table 데이터 삭제*/
	@RequestMapping(value="/real/delSaleNonghyup.json")
	public String delSaleNonghyup(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {	
		//chDate 가져와야대
		try {
			calService.deleteNonghyup(pRequestParamMap);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "jsonView";
	 }
	
	/*데이터 적재*/
	@RequestMapping(value="/real/saveSaleNonghyup.json")
	public String svaeSaleNonghyup(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {	
		//chDate 가져와야대
		calService.saveSaleNonghyup(pRequestParamMap);
		
		return "jsonView";
	 }
	
	/*정산 마감*/
	@RequestMapping(value="/real/endSaleNonghyup.json")
	public String endNonghyup(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {	
		//chDate 가져와야대
		String logStat="1";
		String errorDetail="성공";
		String jobId="5";
		String logGubun="1";
		Map<String, String> mapLog = new HashMap<String, String>();
		
		try {
			mapLog.put("jobId", jobId);
			mapLog.put("logGubun",logGubun);
			mapLog.put("logSeq", "");
			
			// 스케쥴러 로그 등록 및 로그 순번 조회
			commonApiLogService.startJobLog(mapLog);
			calService.endNonghyup(pRequestParamMap);
			// 자동마감 insert
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			logStat = "2";
			errorDetail = CommonApiUtil.getSqlErrorMessage(e.toString());
			commonApiLogService.insertFailLog("적재실패", mapLog, "5", mapLog.get("logSeq"));
		}
		
//	 	결과 반영
			if(!"1".equals(logStat)) commonApiLogService.updateResultLog(logStat, errorDetail, jobId, mapLog.get("logSeq"));
			
			// 최종갱신결과 업데이트
			commonApiLogService.updateJobList(jobId, logStat);
		
		return "jsonView";
	 }
	
	/*at 정산 데이터 적재*/
	@RequestMapping(value="/real/saveSaleAt.json")
	public String saveSaleAt(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {	
		
			try {
			pRequestParamMap.put("saleDate", pRequestParamMap.get("saleDate"));
			tsaleService.calculateWebserviceTestDelete(pRequestParamMap);		
						
			pRequestParamMap.put("panDay", pRequestParamMap.get("saleDate").toString().replaceAll("-", ""));						
			List<AtMarketVO> atMarketData = aTService.atMarketDataManual(pRequestParamMap);		  
						
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
					  sRecode += rs.getREGION_NAME().replaceAll(" ", "");
		
					  pRequestParamMap.put("filename", sFilename);
					  pRequestParamMap.put("recode", sRecode);
					  pRequestParamMap.put("requestSn", "tsale");
					  tsaleService.calculateWebserviceTestForm(pRequestParamMap);
					  
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
			 
				tsaleService.deleteSaleDate("0000000001", pRequestParamMap.get("saleDate").toString());
				tsaleService.insertSaleDate("0000000001", pRequestParamMap.get("saleDate").toString());	
	  			tsaleService.deleteSaleMonth("0000000001", pRequestParamMap.get("saleDate").toString());	
	  			tsaleService.insertSaleMonth("0000000001", pRequestParamMap.get("saleDate").toString());
	  			tsaleService.deleteSaleRaw("0000000001", pRequestParamMap.get("saleDate").toString());
	  			tsaleService.insertSaleRaw("0000000001", pRequestParamMap.get("saleDate").toString());
	  			
	  			
	  			model.addAttribute("result", "true");
	  			
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
		return "jsonView";
	 }
	
	/*at 실시간 데이터 적재*/
	@RequestMapping(value="/real/saveRealAt.json")
	public String saveRealAt(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {	

			try {
				List<AtMarketVO> atMarketData = aTService.atMarketRealDataDate(pRequestParamMap);
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
					  
					  
					  pRequestParamMap.put("filename", sFilename);
					  pRequestParamMap.put("recode", sRecode);
					  tsaleService.calculateWebservice(pRequestParamMap);
					  
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
		
		return "jsonView";
	 }
	
	/*at 현황판 정산 데이터 적재*/
	@RequestMapping(value="/real/saveSaleAtMnt.json")
	public String saveSaleAtMnt(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {	
		  
		 SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
			
			Date d = new Date();
			
			String s = sdf.format(d);
			String en = sdf.format(d.getTime() - ( (long) 1000 * 60 * 60 * 24 * 400) );
			String hipenS = sdf1.format(d);
			
			int sint = Integer.parseInt(s);
			int enint = Integer.parseInt(en);
			
					try {
						for(int i = enint; i<=sint; i++){
							String year = Integer.toString(i).substring(0,4);
							String month = Integer.toString(i).substring(4,6);
							String day = Integer.toString(i).substring(6,8);
							String deletedate = year + month + day ;
							Map<String, Object> map = new HashMap<String, Object>();
							map.put("panDate", deletedate);	 
							
							List<AtMntVO> atMntData = aTService.atMntData(map);
							
							for(int j=0; j<atMntData.size(); j++){				 
								 AtMntVO rs = atMntData.get(j);
								 tsaleService.calculateAtMntSave(rs);
							}
						}
		} catch(Exception e) {
			  e.printStackTrace();
			  System.out.println("전송실패");
		} 
		return "jsonView";
	 }

}
