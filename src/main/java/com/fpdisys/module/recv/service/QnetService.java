   package com.fpdisys.module.recv.service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.base.util.ConvertUtils;
import com.fpdisys.module.recv.domain.ExamPlanMVO;
import com.fpdisys.module.recv.domain.QualExamSchdMVO;
import com.fpdisys.module.recv.mapper.QnetMapper;
import com.fpditrans.base.util.EgovStringUtil;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.XML;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class QnetService extends BaseService {
   @Autowired
   QnetMapper qnetMapper;
   protected Log log = LogFactory.getLog(this.getClass());

   public int insertExamPlan(List<ExamPlanMVO> list) throws Exception {
      int cnt = 0;
      Iterator var3 = list.iterator();

      while(var3.hasNext()) {
         ExamPlanMVO exam = (ExamPlanMVO)var3.next();

         try {
            cnt += this.qnetMapper.insertExamPlan(exam);
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

   public int insertQualExamSchd(List<QualExamSchdMVO> list) throws Exception {
      int cnt = 0;
      Iterator var3 = list.iterator();

      while(var3.hasNext()) {
         QualExamSchdMVO exam = (QualExamSchdMVO)var3.next();

         try {
            cnt += this.qnetMapper.insertQualExamSchd(exam);
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

   public void insertExamSchd(Map<String, String> paramMap) {
      String jmCd = ((String)paramMap.get("jmCd")).toString();
      String jmNm = ((String)paramMap.get("jmNm")).toString();
      int pageNo = Integer.parseInt(((String)paramMap.get("pageNo")).toString());
      String implYy = ((String)paramMap.get("implYy")).toString();
      new HashMap();

      try {
         System.out.println(URLDecoder.decode(((String)paramMap.get("data")).toString(), "UTF-8"));
         JSONObject xmlJSONObj = XML.toJSONObject(((String)paramMap.get("data")).toString());
         String jsonPrettyPrintString = xmlJSONObj.toString(4);
         this.logger.debug(jsonPrettyPrintString);
         JSONObject rtnObj = xmlJSONObj.getJSONObject("response").getJSONObject("header");
         String resultCode = String.valueOf(rtnObj.get("resultCode"));
         String resultMsg = String.valueOf(rtnObj.get("resultMsg"));
         this.logger.debug("resultCode: {}", resultCode);
         this.logger.debug("resultMsg: {}", resultMsg);
         ArrayList examMVOList = new ArrayList();

         HashMap examMap;
         try {
            JSONArray examSchdList = xmlJSONObj.getJSONObject("response").getJSONObject("body").getJSONObject("items").getJSONArray("item");

            for(int idx = 0; idx < examSchdList.length(); ++idx) {
               examMap = new HashMap();
               JSONObject examObj = examSchdList.getJSONObject(idx);
               examMap.put("implYy", String.valueOf(examObj.get("implYy")));
               examMap.put("implSeq", String.valueOf(examObj.get("implSeq")));
               examMap.put("qualgbCd", String.valueOf(examObj.get("qualgbCd")));
               examMap.put("qualgbNm", String.valueOf(examObj.get("qualgbNm")));
               examMap.put("description", String.valueOf(examObj.get("description")));
               examMap.put("docRegStartDt", String.valueOf(examObj.get("docRegStartDt")));
               examMap.put("docRegEndDt", String.valueOf(examObj.get("docRegEndDt")));
               examMap.put("docExamStartDt", String.valueOf(examObj.get("docExamStartDt")));
               examMap.put("docExamEndDt", String.valueOf(examObj.get("docExamEndDt")));
               examMap.put("docPassDt", String.valueOf(examObj.get("docPassDt")));
               examMap.put("pracRegStartDt", String.valueOf(examObj.get("pracRegStartDt")));
               examMap.put("pracRegEndDt", String.valueOf(examObj.get("pracRegEndDt")));
               examMap.put("pracExamStartDt", String.valueOf(examObj.get("pracExamStartDt")));
               examMap.put("pracExamEndDt", String.valueOf(examObj.get("pracExamEndDt")));
               examMap.put("pracPassDt", String.valueOf(examObj.get("pracPassDt")));
               examMap.put("jmCd", jmCd);
               examMap.put("jmNm", jmNm);
               new QualExamSchdMVO();
               QualExamSchdMVO examMVO = (QualExamSchdMVO)ConvertUtils.convertToValueObject(examMap, QualExamSchdMVO.class);
               examMVOList.add(examMVO);
            }
         } catch (Exception var18) {
            JSONObject examObj = xmlJSONObj.getJSONObject("response").getJSONObject("body").getJSONObject("items").getJSONObject("item");
            examMap = new HashMap();
            examMap.put("implYy", String.valueOf(examObj.get("implYy")));
            examMap.put("implSeq", String.valueOf(examObj.get("implSeq")));
            examMap.put("qualgbCd", String.valueOf(examObj.get("qualgbCd")));
            examMap.put("qualgbNm", String.valueOf(examObj.get("qualgbNm")));
            examMap.put("description", String.valueOf(examObj.get("description")));
            examMap.put("docRegStartDt", String.valueOf(examObj.get("docRegStartDt")));
            examMap.put("docRegEndDt", String.valueOf(examObj.get("docRegEndDt")));
            examMap.put("docExamStartDt", String.valueOf(examObj.get("docExamStartDt")));
            examMap.put("docExamEndDt", String.valueOf(examObj.get("docExamEndDt")));
            examMap.put("docPassDt", String.valueOf(examObj.get("docPassDt")));
            examMap.put("pracRegStartDt", String.valueOf(examObj.get("pracRegStartDt")));
            examMap.put("pracRegEndDt", String.valueOf(examObj.get("pracRegEndDt")));
            examMap.put("pracExamStartDt", String.valueOf(examObj.get("pracExamStartDt")));
            examMap.put("pracExamEndDt", String.valueOf(examObj.get("pracExamEndDt")));
            examMap.put("pracPassDt", String.valueOf(examObj.get("pracPassDt")));
            examMap.put("jmCd", jmCd);
            examMap.put("jmNm", jmNm);
            new QualExamSchdMVO();
            QualExamSchdMVO examMVO = (QualExamSchdMVO)ConvertUtils.convertToValueObject(examMap, QualExamSchdMVO.class);
            examMVOList.add(examMVO);
         }

         this.insertQualExamSchd(examMVOList);
      } catch (Exception var19) {
         var19.printStackTrace();
      }

   }

   public Map<String, String> insertExamSchd(List<Map<String, Object>> schdList) {
      ArrayList examMVOList = new ArrayList();

      try {
         String implYy = "";
         Iterator var4 = schdList.iterator();

         while(var4.hasNext()) {
            Map<String, Object> schd = (Map)var4.next();
            new QualExamSchdMVO();
            QualExamSchdMVO examMVO = (QualExamSchdMVO)ConvertUtils.convertToValueObject(schd, QualExamSchdMVO.class);
            examMVOList.add(examMVO);
            if (EgovStringUtil.isEmpty(implYy)) {
               implYy = examMVO.getImplYy();
            }
         }

         this.insertQualExamSchd(examMVOList);
         Map<String, Object> schInfoRegMap = new HashMap();
         schInfoRegMap.put("eventGp", "50");
         schInfoRegMap.put("eventYmd", implYy);
         
         //프로시저 들어가기전
         
         //REG_DT
         this.qnetMapper.insertSchInfo(schInfoRegMap);
         
         //프로시저 들어간 후는 프로시저 자체에서 고쳐될것 같다.
         
      } catch (Exception var7) {
      }

      return null;
   }
}