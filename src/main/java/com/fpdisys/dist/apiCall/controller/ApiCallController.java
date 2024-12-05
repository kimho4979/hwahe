package com.fpdisys.dist.apiCall.controller;

import java.util.ArrayList;
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
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;

import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.dist.apiCall.domain.ApiCallSaleDateVO;
import com.fpdisys.dist.apiCall.domain.ApiCallSaleResult;
import com.fpdisys.dist.apiCall.domain.ApiCallVO;
import com.fpdisys.dist.apiCall.domain.ApiCallYuchalResult;
import com.fpdisys.dist.apiCall.domain.ApiCallYuchalVO;
import com.fpdisys.dist.apiCall.service.ApiCallService;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
public class ApiCallController extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());	
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Autowired
	private ApiCallService apiCallService;
	
	@Resource(name="jsonView")
	private View jsonView;

	@Resource(name="xmlView")
	private View xmlView;
	
	// URL
	@RequestMapping(value="/api/apiCallInfo.do")
	public String apiCallInfo(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
		 
		 return "/auction/apiCallInfo";
	}
	
	// 공공데이터 URL 조회 시 Validation Check
	@RequestMapping(value="/api/selectCheckList.json")
	public String selectCheckList(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
		
		//List<EgovMap> list = null;
		List<ApiCallVO> list = null;
		try{
			list = apiCallService.selectCheckList(pRequestParamMap);
			
			String reslutCallDt = list.get(0).getResultCallDt();
			String resultCnt = list.get(0).getResultCnt();
			
			if(reslutCallDt.equals("true") && resultCnt.equals("true")){
				apiCallService.updateLogList(pRequestParamMap);
			}else if(reslutCallDt.equals("false")){
				apiCallService.insertLogList(pRequestParamMap);
			}
			
			model.addAttribute("list", list);
			
		} catch (ArithmeticException e) {
			log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
		} catch (NumberFormatException e) {
			log.error("오류발생 숫자로 변환 할 수 없습니다!!");
		} catch (ArrayIndexOutOfBoundsException e) {
			log.error("오류발생 배열인텍스에서 벗어났습니다!!");
		} catch (NegativeArraySizeException e) {
			log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
		} catch (NullPointerException e) {
			log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
		} catch (NoSuchMethodError e) {
			log.error("오류발생 메서드를 찾을수 없습니다!!");
		} catch (NoClassDefFoundError e) {
			log.error("오류발생 클래스를 찾을 수 없습니다!!");
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		
		return "jsonView";
		  	
	}
	
	// 공공데이터 URL 조회 시 Validation Check
	@RequestMapping(value="/api/selectSaleDateList.json")
	public String selectSaleDateList(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
		
		List<ApiCallSaleDateVO> list = null;
		List<ApiCallVO> checkList = null;
		
		String pServiceKey = (String)pRequestParamMap.get("serviceKey");
		String pKind = (String)pRequestParamMap.get("reqDataCd");
		
		try{
			pRequestParamMap.put("userId", pRequest.getSession().getAttribute("userId").toString());
			
			checkList = apiCallService.selectCheckList(pRequestParamMap);
			String lServiceKey = checkList.get(0).getServiceKey();
			String lResultDt = checkList.get(0).getResultDt();
			String lUseYn = checkList.get(0).getUseYn();
			String resultCnt = checkList.get(0).getResultCnt();
			String reslutCallDt = checkList.get(0).getResultCallDt();
			
			if(!pServiceKey.equals(lServiceKey)){
				// 서비스 키 Error
				model.addAttribute("result", "1");
			}else if(lResultDt.equals("false")){
				// 기간 Error
				model.addAttribute("result", "2");
			}else if(lUseYn.equals("N")){
				// 사용 여부 N 일때
				model.addAttribute("result", "3");
			}else if(resultCnt.equals("false") && reslutCallDt.equals("true")){
				// 금일 호출 건수 초과 시
				model.addAttribute("result", "4");
			}else{
				PaginationInfo paginationInfo = new PaginationInfo();  
				
				if(pRequestParamMap.get("currentPage") == null || StringUtils.isEmpty(pRequestParamMap.get("currentPage")) == true)
					pRequestParamMap.put("currentPage", "1");
				
				paginationInfo.setCurrentPageNo(Integer.parseInt(pRequestParamMap.get("currentPage").toString()));
			  
				if(pRequestParamMap.get("numOfRow") == null || StringUtils.isEmpty(pRequestParamMap.get("numOfRow")) == true){
					paginationInfo.setRecordCountPerPage(10);
				}else{
					paginationInfo.setRecordCountPerPage(Integer.parseInt(pRequestParamMap.get("numOfRow").toString()));
				}
				
				paginationInfo.setPageSize(5);
				
				int start = paginationInfo.getFirstRecordIndex();
				int end = start + paginationInfo.getRecordCountPerPage();
				pRequestParamMap.put("START",start+1);
				pRequestParamMap.put("END",end);
				
				
				if(pKind.equals("f001")){
					list = apiCallService.selectSaleDateList(pRequestParamMap);
				}else if(pKind.equals("f002")){
					//list = apiCallService.selectPassedInList(pRequestParamMap);
				}
				
				model.addAttribute("list", list);
				
				String toString = list.toString();
				model.addAttribute("toStringList", toString);
				
				model.addAttribute("result", "0");
				
				if(reslutCallDt.equals("true") && resultCnt.equals("true")){
					apiCallService.updateLogList(pRequestParamMap);
				}else if(reslutCallDt.equals("false")){
					apiCallService.insertLogList(pRequestParamMap);
				}
			}
			
		} catch (ArithmeticException e) {
			log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
		} catch (NumberFormatException e) {
			log.error("오류발생 숫자로 변환 할 수 없습니다!!");
		} catch (ArrayIndexOutOfBoundsException e) {
			log.error("오류발생 배열인텍스에서 벗어났습니다!!");
		} catch (NegativeArraySizeException e) {
			log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
		} catch (NullPointerException e) {
			log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
		} catch (NoSuchMethodError e) {
			log.error("오류발생 메서드를 찾을수 없습니다!!");
		} catch (NoClassDefFoundError e) {
			log.error("오류발생 클래스를 찾을 수 없습니다!!");
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		
		return "jsonView";
		  	
	}
	
	// 공공데이터 URL 조회 시 Validation Check
	@RequestMapping(value="/api/returnData.api", method=RequestMethod.GET, produces="text/plain;charset=UTF-8")
	@ResponseBody
	public ModelAndView loginCheck(HttpServletRequest request, @RequestParam Map<String, Object> pRequestParamMap){
		  
		ApiCallSaleResult result = new ApiCallSaleResult();
		ApiCallYuchalResult result1 = new ApiCallYuchalResult();
		ModelAndView mav = new ModelAndView();
		
		List<ApiCallVO> checkList = null;
		
		String pServiceKey = (String)pRequestParamMap.get("serviceKey");
		String pKind = (String)pRequestParamMap.get("kind"); // f001/f002
		String dataType = (String)pRequestParamMap.get("dataType");	//xml/json
		String pParam = request.getQueryString().toString();
		
		if(pServiceKey!=null&&pServiceKey.equals("sample")){
			try{
				String resultCd="0";
				String resultMsg="OK";
				
				boolean pKindChk=true;
				if(pKind==null || pKind.trim().equals("")){
					resultCd="5";
					resultMsg="파라미터 입력값이 잘못되었습니다.(kind)";
					pKindChk=false;
				}
				
				boolean pDataType=true;
				if(dataType==null || !(dataType.toLowerCase().trim().equals("xml")||dataType.toLowerCase().trim().equals("json"))){
					resultCd="5";
					resultMsg="파라미터 입력값이 잘못되었습니다.(dataType)";
					pDataType=false;
				}
				
				if(pKindChk&&pDataType){
					PaginationInfo paginationInfo = new PaginationInfo();  
					
					if(pRequestParamMap.get("currentPage") == null || StringUtils.isEmpty(pRequestParamMap.get("currentPage")) == true)
						pRequestParamMap.put("currentPage", "1");
					
					paginationInfo.setCurrentPageNo(Integer.parseInt(pRequestParamMap.get("currentPage").toString()));
				  
					if(pRequestParamMap.get("countPerPage") == null || StringUtils.isEmpty(pRequestParamMap.get("countPerPage")) == true){
						paginationInfo.setRecordCountPerPage(10);
					}else{
						paginationInfo.setRecordCountPerPage(Integer.parseInt(pRequestParamMap.get("countPerPage").toString()));
					}
					
					paginationInfo.setPageSize(5);
					
					int start = paginationInfo.getFirstRecordIndex();
					int end = start + paginationInfo.getRecordCountPerPage();
					pRequestParamMap.put("start",start+1);
					pRequestParamMap.put("end",end);
					
					List<ApiCallSaleDateVO> resultData =null;
					List<ApiCallYuchalVO> resultData1 =null;
									
				  if(pKind.equals("f001")){
					  pRequestParamMap.put("baseDate", "2018-08-16");
					  resultData = apiCallService.selectSaleDateList(pRequestParamMap);
					  result.setItems(resultData);
						result.setResultCd(resultCd);
						result.setResultMsg(resultMsg);
						String size="0";
						if(resultData.size()!=0){
							size=resultData.size()+"";
						}
						result.setNumOfRows(size);  
					
						if (dataType.equals("json")){
							mav = new ModelAndView("jsonView");
							mav.setView(jsonView); 
						}else if(dataType.equals("xml")){
							mav.setView(xmlView);
						}
						mav.addObject("response", result);
					
					}else if(pKind.equals("f002")){
						pRequestParamMap.put("baseDate", "2018-08-13");

						String yuchalFlower=(String)pRequestParamMap.get("flowerGubn");

						boolean searchGo=false;
						
						if(yuchalFlower!=null && !yuchalFlower.equals("")){
							if(yuchalFlower.equals("1")){
								pRequestParamMap.put("bunChk","N");
								searchGo=true;
							}else if(yuchalFlower.equals("3")){
								pRequestParamMap.put("bunChk","Y");
								searchGo=true;
							}else if(yuchalFlower.equals("2")){
								pRequestParamMap.put("bunChk","C");
								searchGo=true;
							}else{
								resultCd="5";
								resultMsg="파라미터 입력값이 잘못되었습니다.(flowerGubn)";
							}
						}else{
							resultCd="5";
							resultMsg="파라미터 입력값이 잘못되었습니다.(flowerGubn)";
						}
						
						if(searchGo){
							resultData1  = apiCallService.selectPassedInList(pRequestParamMap);
						}
						
						result1.setItems(resultData1);
						result1.setResultCd(resultCd);
						result1.setResultMsg(resultMsg);
						String size="0";
						if(resultData1.size()!=0){
					 		size=resultData1.size()+"";
						}
						result1.setNumOfRows(size);
						
						if (dataType.equals("json")){
								mav = new ModelAndView("jsonView");
								mav.setView(jsonView); 
							}else if(dataType.equals("xml")){
								mav.setView(xmlView);
							}
						mav.addObject("response", result1);
					}	
				}else{
					result.setResultCd(resultCd);
					result.setResultMsg(resultMsg);
					if (dataType!=null&&dataType.equals("json")){
							mav = new ModelAndView("jsonView");
							mav.setView(jsonView); 
					}else if(dataType!=null&&dataType.equals("xml")){
						  mav.setView(xmlView);
					}else{
						mav.setView(xmlView);
					}
					
					mav.addObject("response", result);
				}
				
			}catch(Exception e){
				e.printStackTrace();
			}
			
		}else{
			try{
				pRequestParamMap.put("param", pParam);
				
				checkList = apiCallService.selectCheckList(pRequestParamMap);
				String lServiceKey = checkList.get(0).getServiceKey();
				String lResultDt = checkList.get(0).getResultDt();
				String lUseYn = checkList.get(0).getUseYn();
				String resultCnt = checkList.get(0).getResultCnt();
				String reslutCallDt = checkList.get(0).getResultCallDt();
				
				String resultCd="0";
				String resultMsg="OK";
				
				boolean pKindChk=true;
				if(pKind==null || pKind.trim().equals("")){
					resultCd="5";
					resultMsg="파라미터 입력값이 잘못되었습니다.(kind)";
					pKindChk=false;
				}
				
				boolean serviceKeyChk=true;
				if(lServiceKey==null || lServiceKey.trim().equals("")){
					resultCd="5";
					resultMsg="파라미터 입력값이 잘못되었습니다.(serviceKey)";
					serviceKeyChk=false;
				}

				boolean pDataType=true;
				if(dataType==null || !(dataType.toLowerCase().trim().equals("xml")||dataType.toLowerCase().trim().equals("json"))){
					resultCd="5";
					resultMsg="파라미터 입력값이 잘못되었습니다.(dataType)";
					pDataType=false;
				}
				
				if(pKindChk&&serviceKeyChk&&pDataType){
					if(!pServiceKey.equals(lServiceKey)){
						// 서비스 키 Error
						resultCd="1";
						resultMsg="서비스 키 오류입니다.";
					}else if(lResultDt.equals("false")){
						// 기간 Error
						resultCd="2";
						resultMsg="기간을 다시 설정하여 주십시오.";
					}else if(lUseYn.equals("N")){
						// 사용 여부 N 일때
						resultCd="3";
						resultMsg="미승인된 공공데이터입니다. 관리자에게 문의하십시오.";
					}else if(resultCnt.equals("false") && reslutCallDt.equals("true")){
						// 금일 호출 건수 초과 시
						resultCd="4";
						resultMsg="금일 호출 건수가 만료 되었습니다.";
					}else{
						PaginationInfo paginationInfo = new PaginationInfo();  
						
						if(pRequestParamMap.get("currentPage") == null || StringUtils.isEmpty(pRequestParamMap.get("currentPage")) == true)
							pRequestParamMap.put("currentPage", "1");
						
						paginationInfo.setCurrentPageNo(Integer.parseInt(pRequestParamMap.get("currentPage").toString()));
					  
						if(pRequestParamMap.get("countPerPage") == null || StringUtils.isEmpty(pRequestParamMap.get("countPerPage")) == true){
							paginationInfo.setRecordCountPerPage(10);
						}else{
							paginationInfo.setRecordCountPerPage(Integer.parseInt(pRequestParamMap.get("countPerPage").toString()));
						}
						
						paginationInfo.setPageSize(5);
						
						int start = paginationInfo.getFirstRecordIndex();
						int end = start + paginationInfo.getRecordCountPerPage();
						pRequestParamMap.put("start",start+1);
						pRequestParamMap.put("end",end);
						
						List<ApiCallSaleDateVO> resultData =null;
						List<ApiCallYuchalVO> resultData1 =null;
						
					  if(pKind.equals("f001")){
						  resultData = apiCallService.selectSaleDateList(pRequestParamMap);
						  result.setItems(resultData);
							result.setResultCd(resultCd);
							result.setResultMsg(resultMsg);
							String size="0";
							if(resultData.size()!=0){
								size=resultData.size()+"";
							}
							result.setNumOfRows(size);  
						
							if (dataType.equals("json")){
								mav = new ModelAndView("jsonView");
								mav.setView(jsonView); 
							}else if(dataType.equals("xml")){
								mav.setView(xmlView);
							}
							mav.addObject("response", result);
						
						}else if(pKind.equals("f002")){

							String yuchalFlower=(String)pRequestParamMap.get("flowerGubn");

							boolean searchGo=false;
							
							if(yuchalFlower!=null && !yuchalFlower.equals("")){
								if(yuchalFlower.equals("1")){
									pRequestParamMap.put("bunChk","N");
									searchGo=true;
								}else if(yuchalFlower.equals("3")){
									pRequestParamMap.put("bunChk","Y");
									searchGo=true;
								}else if(yuchalFlower.equals("2")){
									pRequestParamMap.put("bunChk","C");
									searchGo=true;
								}else{
									resultCd="5";
									resultMsg="파라미터 입력값이 잘못되었습니다.(flowerGubn)";
								}
							}else{
								resultCd="5";
								resultMsg="파라미터 입력값이 잘못되었습니다.(flowerGubn)";
							}
							
							if(searchGo){
								resultData1  = apiCallService.selectPassedInList(pRequestParamMap);
							}
							
							result1.setItems(resultData1);
							result1.setResultCd(resultCd);
							result1.setResultMsg(resultMsg);
							String size="0";
							if(resultData1.size()!=0){
						 		size=resultData1.size()+"";
							}
							result1.setNumOfRows(size);
							
							if (dataType.equals("json")){
									mav = new ModelAndView("jsonView");
									mav.setView(jsonView); 
								}else if(dataType.equals("xml")){
									mav.setView(xmlView);
								}
							mav.addObject("response", result1);
						}
						
						if(reslutCallDt.equals("true") && resultCnt.equals("true")){
							apiCallService.updateLogList(pRequestParamMap);
						}else if(reslutCallDt.equals("false")){
							apiCallService.insertLogList(pRequestParamMap);
						}
					}
				}else{
					result.setResultCd(resultCd);
					result.setResultMsg(resultMsg);
					if (dataType!=null&&dataType.equals("json")){
							mav = new ModelAndView("jsonView");
							mav.setView(jsonView); 
					}else if(dataType!=null&&dataType.equals("xml")){
						  mav.setView(xmlView);
					}else{
						mav.setView(xmlView);
					}
					
					mav.addObject("response", result);
				}
				
			  } catch (Exception e) {
					e.printStackTrace();
			  }
		}	
		return mav;	  
	}
	
	public List<ApiCallSaleDateVO> getSaleDateToXml(List<ApiCallSaleDateVO> data) {
		
			List<ApiCallSaleDateVO> list = new ArrayList<>();
			ApiCallSaleDateVO users = new ApiCallSaleDateVO();
			
			for(int i=0; i<data.size(); i++){
				list.add(data.get(i));
			}
			
			return list;
		}
}