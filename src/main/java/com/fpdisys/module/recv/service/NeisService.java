package com.fpdisys.module.recv.service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.base.util.ConvertUtils;
import com.fpdisys.module.recv.domain.SchoolEventMVO;
import com.fpdisys.module.recv.domain.SchoolInfoMVO;
import com.fpdisys.module.recv.mapper.NeisMapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class NeisService extends BaseService {
   @Autowired
   NeisMapper neisMapper;
   protected Log log = LogFactory.getLog(this.getClass());

   public int insertSchoolInfo(List<SchoolInfoMVO> list) throws Exception {
      int cnt = 0;
      Iterator var3 = list.iterator();

      while(var3.hasNext()) {
         SchoolInfoMVO school = (SchoolInfoMVO)var3.next();

         try {
            cnt += this.neisMapper.insertSchoolInfo(school);
         } catch (ArithmeticException var6) {
            this.log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
         } catch (NumberFormatException var7) {
            this.log.error("오류발생 숫자로 변환 할 수 없습니다!!");
         } catch (ArrayIndexOutOfBoundsException var8) {
            this.log.error("오류발생 배열인텍스에서 벗어났습니다!!");
         } catch (NegativeArraySizeException var9) {
            this.log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
         } catch (NullPointerException var10) {
            this.log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
         } catch (NoSuchMethodError var11) {
            this.log.error("오류발생 메서드를 찾을수 없습니다!!");
         } catch (NoClassDefFoundError var12) {
            this.log.error("오류발생 클래스를 찾을 수 없습니다!!");
         } catch (RuntimeException var13) {
            this.log.error("오류발생 런타임!!");
            this.log.error(var13.getMessage());
         } catch (Exception var14) {
            this.log.error("오류발생!!");
         }
      }

      return cnt;
   }

   public int insertSchoolEventInfo(List<SchoolEventMVO> list) throws Exception {
      int cnt = 0;
      Iterator var3 = list.iterator();

      while(var3.hasNext()) {
         SchoolEventMVO event = (SchoolEventMVO)var3.next();

         try {
            cnt += this.neisMapper.insertSchoolEventInfo(event);
         } catch (ArithmeticException var6) {
            this.log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
         } catch (NumberFormatException var7) {
            this.log.error("오류발생 숫자로 변환 할 수 없습니다!!");
         } catch (ArrayIndexOutOfBoundsException var8) {
            this.log.error("오류발생 배열인텍스에서 벗어났습니다!!");
         } catch (NegativeArraySizeException var9) {
            this.log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
         } catch (NullPointerException var10) {
            this.log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
         } catch (NoSuchMethodError var11) {
            this.log.error("오류발생 메서드를 찾을수 없습니다!!");
         } catch (NoClassDefFoundError var12) {
            this.log.error("오류발생 클래스를 찾을 수 없습니다!!");
         } catch (RuntimeException var13) {
            this.log.error("오류발생 런타임!!");
            this.log.error(var13.getMessage());
         } catch (Exception var14) {
            this.log.error("오류발생!!");
         }
      }

      return cnt;
   }

   public List<EgovMap> selectSchoolList(Map<String, Object> pReqParamMap) {
      return this.neisMapper.selectSchoolList(pReqParamMap);
   }


	public void insertSchoolScheduleBatch(List<Map<String, Object>> PreEventList){
		try{
			int graduation_Count = 0; 
			List<SchoolEventMVO> eventList = new ArrayList<>();
			
			int preEventListCount = PreEventList.size();
			boolean gradCheck = false;
			
			String loadDtm = ""; // loadDtm 값을 저장할 변수
			
			System.out.println("학교행사일정 전체 건수(Insert 되기전): " + preEventListCount);
			log.info("학교행사일정 전체 건수(Insert 되기전): " + preEventListCount);
			
		  	 // loadDtm 값을 한번만 추출
	        if (!PreEventList.isEmpty()) {
	            Map<String, Object> firstEventMap = PreEventList.get(0);
	            if (firstEventMap.containsKey("loadDtm")&& firstEventMap.get("EVENT_NM").toString().contains("졸업")) {
	                loadDtm = firstEventMap.get("loadDtm").toString(); // 첫 번째 항목에서 loadDtm 추출
	                gradCheck = true;
	            }
	        }
			
	    	for(Map<String, Object> eventMap : PreEventList){
		    	SchoolEventMVO eventMVO = new SchoolEventMVO();
		    	eventMVO = ConvertUtils.convertToValueObject(eventMap, SchoolEventMVO.class);
		
		    	eventList.add(eventMVO);
		    	
		    	 if (eventMap.containsKey("EVENT_NM") && eventMap.get("EVENT_NM").toString().contains("졸업")) {
		    		 graduation_Count++; // 포함되면 count 증가
		    	  }
	    	}
	    	
		    	int BF_InsertData = neisMapper.getDataCount_T_EVENT_SCH(loadDtm);
		    	System.out.println("T_EVENT_SCH(Insert 되기전) 테이블 건수: " + BF_InsertData);
				log.info("T_EVENT_SCH(Insert 되기전)): " + BF_InsertData);
		    	
		    	insertSchoolEventInfo(eventList);
		    	
		    	int AF_InsertData = neisMapper.getDataCount_T_EVENT_SCH(loadDtm);
		    	System.out.println("T_EVENT_SCH(Insert 후) 테이블 건수: " + AF_InsertData);
				log.info("T_EVENT_SCH(Insert 후) 테이블 건수: " + AF_InsertData);
				
			    Map<String, String> map = new HashMap();
			   
				map.put("sysGp", "3"); // logSeq
				map.put("rsltGp", "S"); // rsltGp: 성공 상태
				map.put("startDate", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"))); // 현재 시간
				map.put("pgmId", "SchoolEvent"); // 프로그램 ID
				
				if(!gradCheck) {
			    	System.out.println("졸업식 일정 전체 건수(Insert 되기전): " + graduation_Count);
					log.info("졸업식 일정 전체 건수(Insert 되기전): " + graduation_Count);
					
					map.put("pgmNm", "학교행사일정(졸업식)"); // 프로그램 이름
					map.put("procMsg", loadDtm + "졸업식 Insert 건수 : " + graduation_Count + " Insert 완료 전: " + BF_InsertData + ", Insert 완료 후  건수: " + AF_InsertData); // procMsg: url
				} else {
					map.put("pgmNm", "학교행사일정"); // 프로그램 이름
					map.put("procMsg", loadDtm + " Insert 완료 전: " + BF_InsertData + ", Insert 완료 후  건수: " + AF_InsertData); // procMsg: url
				}
				
	            logInsertCall(map);
	    	
		} catch(Exception e){
			e.printStackTrace();
		}
   }

   public void deleteEventList(Map<String, Object> pReqParamMap) {
	   
      this.neisMapper.deleteEventList(pReqParamMap);
   }
   
   public void logInsertCall(Map<String, String> map){
		neisMapper.logInsertCall(map);
	}
}