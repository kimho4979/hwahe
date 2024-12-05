package com.fpdisys.dist.trans.service;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.at.domain.AtMntVO;
import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.base.util.GlobalConstants;
import com.fpdisys.dist.trans.domain.CSVBean;
import com.fpdisys.dist.trans.mapper.TsaleMapper;

/**
 * @Class Name : TsaleService.java
 * @Description : TsaleService Class
 * 
 *			  @ 정산자료 서비스 테이블 @ 수정일 수정자 수정내용 @ --------- ---------
 *			  ------------------------------- @ 2016.07.28 최초생성
 *
 * @author 우림인포텍
 * @version 1.0
 * @see Copyright (C) by woorim All right reserved.
 */

@Service
public class TsaleService extends BaseService {

	@Autowired
	TsaleMapper tSaleMapper;
	
	protected Log log = LogFactory.getLog(this.getClass());

	/**
		* 정산파일 삭제처리 
		* @param v_cmp_cd
		* @param v_ch_date
		* @throws SQLException
		*/
	public void deleteNonghyup(Map<String, Object> pRequestParamMap) throws SQLException{
		// TODO Auto-generated method stub
		/*
		4108212335	광주원예농협
		6068207466	부산경남화훼농협
		1508500020	부산화훼공판장
		1288202296	한국화훼농협(본점)
		3848200087	한국화훼농협(음성)
		6158209828     영남화훼
		*/
		
		try{
			String chDate = addMinusChar((String) pRequestParamMap.get("chDate"));
			String cmpCd[] = {"4108212335","6068207466","1508500020","3848200087","1288202296","6158209828" };
			
			for(int i=0; i<cmpCd.length; i++){
				deleteSale(cmpCd[i], chDate);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	/**
	 * 정산파일 전송처리 
	 * @param pRequest
	 * @param multi
	 */
	
	public void saveSaleNonghyup(Map<String, Object> pRequestParamMap)  {
		String filename = (String) pRequestParamMap.get("filename");
		String recordBase = (String) pRequestParamMap.get("recode");
		
		String recode="";
		
		try {
			recode = URLDecoder.decode(recordBase,"utf-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		CSVBean cbData = new CSVBean();
		  
		//String chDate = filename.substring(8,16); 
		String[] data = recode.split(";");
				
		 cbData.setV_file_name(filename);  
		 cbData.setV_ch_date(addMinusChar(data[1]));
		 cbData.setV_sale_date(addMinusChar(data[1]));
		 cbData.setV_cmp_cd(data[2]);
		 cbData.setV_seq(data[3]);
		 cbData.setV_no1(data[4]);
		 cbData.setV_no2(data[4]);
		 if(!StringUtils.isEmpty(data[5])){
			 cbData.setV_mm(data[5]);
		 }else{
			 cbData.setV_mm("1");
		 }
		 
		 cbData.setV_good(data[6]);
		 cbData.setV_cmp_good(data[7]);
		 
		 String pumNameTemp=data[8];
		 String pumName0=data[8];
			
		int pumNameNum=pumNameTemp.indexOf("FTE110000000");
		if(pumNameNum>0){
			pumName0=pumNameTemp.substring(0,pumNameNum-4)+pumNameTemp.substring(pumNameNum+39);
		}
		 cbData.setV_pum_name(pumName0.trim());
		 
		 String goodNameTemp=data[9];
		 String goodName0=data[9];
		 int goodNameNum=goodNameTemp.indexOf("FTE110000000");
		 if(goodNameNum>0){
			 goodName0=goodNameTemp.substring(0,goodNameNum-4)+goodNameTemp.substring(goodNameNum+39);
		 }
		 cbData.setV_good_name(goodName0.trim());
		 
		float f = Float.parseFloat(data[10]);
		String str = String.format("%.0f", f);
		String danQ = str;	// 총물량에서 사용		
		cbData.setV_danq(danQ);		 
		
		String groupCode = data[11];
		
		 cbData.setV_dan_cd(groupCode.substring(0, 2));
		 cbData.setV_poj_cd(groupCode.substring(0, 1) + groupCode.substring(2, 4));
		 cbData.setV_size_cd(groupCode.substring(0, 1)+ groupCode.substring(4, 6));
		 cbData.setV_lv_cd(data[12]);
		 
		 cbData.setV_qty(new Integer(data[13]).intValue());
		 cbData.setV_cost(new Integer(data[14]).intValue());

		 cbData.setV_amer_cd(null);
		 cbData.setV_ch_cd(data[15]);
		 cbData.setV_sman_cd(null);
		 cbData.setV_chul_no(null);
		 cbData.setV_chul_cd(data[16]);
		 cbData.setV_chul_name(data[17]);
		 cbData.setV_farm_name(null);
		 
		 cbData.setV_tot_qty(new Integer(data[13]).intValue()* new Integer(danQ).intValue());
		 cbData.setV_tot_amt(new Integer(data[13]).intValue()* new Integer(data[14]).intValue());
		 cbData.setV_gubn("5");	
		 
		 cbData.setV_san_cd(data[18]);
		 cbData.setV_cmp_san(data[18]);
		 
		 if(data.length>19){
			 cbData.setV_san_name(data[19]);
		 }		 
		 if(data.length>20){
			 cbData.setV_lv_etc_cd(data[20]);
		 }		 
		 if(data.length>21){
			 cbData.setV_lv_etc_nm(data[21]);
		 }

		if(cbData.getV_cmp_cd().equals(GlobalConstants.KOREA_FLOWER)){
			 //레벨 등급 셋팅 
			if(cbData.getV_lv_cd() != null){
				String LvCd =this.selectKoreaLvCdChage(cbData.getV_lv_cd());
				cbData.setV_lv_cd(LvCd);
			}else{
				cbData.setV_lv_cd("10");
			}
			
			String V_MEJANG =GlobalConstants.FLOWER_GUBN_ONE;
			if(cbData.getV_good().substring(0,2).equals(GlobalConstants.KOREA_FLOWER_MEJANG_ONE)){
				V_MEJANG = GlobalConstants.FLOWER_GUBN_THREE;
			}else if(cbData.getV_good().substring(0,2).equals(GlobalConstants.KOREA_FLOWER_MEJANG_TWO)){
				V_MEJANG = GlobalConstants.FLOWER_GUBN_TWO;
			}else if(cbData.getV_cmp_good().substring(0,6).equals("100010")){
				// 2019.05.30 구분코드 난 추가
				V_MEJANG = GlobalConstants.FLOWER_GUBN_THREE;
			}
			cbData.setV_mejang(V_MEJANG);
			
		}else{			
			String mejang =this.selectFlowerGubnNong(cbData.getV_cmp_good() ,cbData.getV_cmp_cd());
			cbData.setV_mejang(mejang);  
		}
		
		int iCnt;
		try {
			if(!StringUtils.isEmpty(data[12])){
				cbData.setV_lv_cd(data[12]);
			}else{
				cbData.setV_lv_cd("10");
			}		
			
			iCnt = this.selectTsaleCnt(cbData);
			
			if (iCnt > 0) {
				this.deleteTsaleLogFirst(cbData);
			}

			this.insertTsaleFirst(cbData);
				
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
		* 정산마감 
		* @param v_cmp_cd
		* @param v_ch_date
		* @throws SQLException
		*/
	public void endNonghyup(Map<String, Object> pRequestParamMap) throws SQLException{
		// TODO Auto-generated method stub
		/*
		4108212335	광주원예농협
		6068207466	부산경남화훼농협
		1508500020	부산화훼공판장
		1288202296	한국화훼농협(본점)
		3848200087	한국화훼농협(음성)
		6158209828     영남화훼
		*/
		
		try{
			String chDate = addMinusChar((String) pRequestParamMap.get("chDate"));
			//"1288202296" 과천 제외  및 고양시 추가  
			String cmpCd[] = {"4108212335","6068207466","1508500020","3848200087","6158209828","7368200686" };
			
			for(int i=0; i<cmpCd.length; i++){
				deleteSaleDate(cmpCd[i], chDate);

				insertSaleDate(cmpCd[i], chDate);

				deleteSaleMonth(cmpCd[i], chDate);

				insertSaleMonth(cmpCd[i], chDate);
				
				deleteSaleRaw(cmpCd[i], chDate);
				
		        insertSaleRaw(cmpCd[i], chDate);
				
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	* 월별 정산처리 
	* @param v_cmp_cd
	* @param v_ch_date
	* @throws SQLException
	*/
	public void insertSaleMonth(String v_cmp_cd, String v_ch_date) throws SQLException{
		// TODO Auto-generated method stub
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("v_cmp_cd", v_cmp_cd);
		resultMap.put("v_ch_date", v_ch_date);

		tSaleMapper.insertSaleMonth(resultMap);
	}
	 
	/**
	 * 월별 정산 삭제 처리 
	 * @param v_cmp_cd
	 * @param v_ch_date
	 * @throws SQLException
	 */
	public void deleteSaleMonth(String v_cmp_cd, String v_ch_date) throws SQLException{
		// TODO Auto-generated method stub

		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("v_cmp_cd", v_cmp_cd);
		resultMap.put("v_ch_date", v_ch_date);

		tSaleMapper.deleteSaleMonth(resultMap);

	}

	/**
	 * 주별 정산처리 
	 * @param v_cmp_cd
	 * @param v_ch_date
	 * @throws SQLException
	 */
	public void insertSaleWeek(String v_cmp_cd, String v_ch_date) throws SQLException{
		// TODO Auto-generated method stub

		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("v_cmp_cd", v_cmp_cd);
		resultMap.put("v_ch_date", v_ch_date);

		tSaleMapper.insertSaleWeek(resultMap);
	}

	/**
	 * 주별 정산삭제 
	 * @param v_cmp_cd
	 * @param v_ch_date
	 * @throws SQLException
	 */
	public void deleteSaleWeek(String v_cmp_cd, String v_ch_date) throws SQLException{
		// TODO Auto-generated method stub

		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("v_cmp_cd", v_cmp_cd);
		resultMap.put("v_ch_date", v_ch_date);

		tSaleMapper.deleteSaleWeek(resultMap);
	}

	/**
	 * 일별 정산 처리 
	 * @param v_cmp_cd
	 * @param v_ch_date
	 * @throws SQLException
	 */
	public void insertSaleDate(String v_cmp_cd, String v_ch_date) throws SQLException{
		// TODO Auto-generated method stub
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("v_cmp_cd", v_cmp_cd);
		resultMap.put("v_ch_date", v_ch_date);

		tSaleMapper.insertSaleDate(resultMap);
	}

	/**
	 * 일별정산 row table 삭제 처리 
	 * @param v_cmp_cd
	 * @param v_ch_date
	 * @throws SQLException
	 */
	public void deleteSale(String v_cmp_cd, String v_ch_date) throws SQLException{
		// TODO Auto-generated method stub
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("v_cmp_cd", v_cmp_cd);
		resultMap.put("v_ch_date", v_ch_date);

		tSaleMapper.deleteSale(resultMap);
	}
	
	/**
	 * 일별정산 삭제 처리 
	 * @param v_cmp_cd
	 * @param v_ch_date
	 * @throws SQLException
	 */
	public void deleteSaleDate(String v_cmp_cd, String v_ch_date) throws SQLException{
		// TODO Auto-generated method stub
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("v_cmp_cd", v_cmp_cd);
		resultMap.put("v_ch_date", v_ch_date);

		tSaleMapper.deleteSaleDate(resultMap);
	}
	/**
	 * 공판장 통합 원장 삭제
	 * @param cmpCd
	 * @param chDate
	 * @throws Exception
	 */
	public void deleteSaleRaw(String cmpCd, String chDate) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("cmpCd", cmpCd);
		resultMap.put("chDate", chDate);
		
		tSaleMapper.deleteSaleRaw(resultMap);
	}

	public void insertSaleRaw(String cmpCd, String chDate) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("cmpCd", cmpCd);
		resultMap.put("chDate", chDate);
		
		tSaleMapper.insertSaleRaw(resultMap);
	}
	
	/**
	 * 정산 로그 등록처리 
	 * @param data
	 * @return
	 * @throws SQLException
	 */

	public int insertTsaleLogFirst(CSVBean data) throws SQLException{

		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("v_sale_date", data.getV_sale_date());
		resultMap.put("v_ch_date", data.getV_ch_date());
		resultMap.put("v_cmp_cd", data.getV_cmp_cd());
		resultMap.put("v_seq", data.getV_seq());
		resultMap.put("v_no1", data.getV_no1());
		resultMap.put("v_no2", data.getV_no2());
		resultMap.put("v_filename", data.getV_file_name());
		resultMap.put("v_recordtext", data.toString());

		return tSaleMapper.insertTsaleLogFirst(resultMap);

	}

  /**
	* 삭제 로그 등록처리  	
  * @param data
  * @return
  * @throws SQLException
  */
	public int insertTsaleDelLog(CSVBean data) throws SQLException{
		Map<String, Object> resultMap = new HashMap<String, Object>();

		int iCnt = this.selectTsaleCnt(data);

		resultMap.put("cnt", iCnt);
		resultMap.put("v_sale_date", data.getV_sale_date());
		resultMap.put("v_ch_date", data.getV_ch_date());
		resultMap.put("v_cmp_cd", data.getV_cmp_cd());
		resultMap.put("v_seq", data.getV_seq());
		resultMap.put("v_no1", data.getV_no1());
		resultMap.put("v_no2", data.getV_no2());
		resultMap.put("v_filename", data.getV_file_name());
		resultMap.put("v_recordtext", data.toString());

		return tSaleMapper.insertTsaleDelLog(resultMap);
	}

	/**
	 * 정산로그 삭제 처리 
	 * @param data
	 * @return
	 * @throws SQLException
	 */

	public int deleteTsaleLog(CSVBean data) throws SQLException{

		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("v_sale_date", data.getV_sale_date());
		resultMap.put("v_ch_date", data.getV_ch_date());
		resultMap.put("v_cmp_cd", data.getV_cmp_cd());
		resultMap.put("v_seq", data.getV_seq());
		resultMap.put("v_no1", data.getV_no1());
		resultMap.put("v_no2", data.getV_no2());
		resultMap.put("v_filename", data.getV_file_name());
		resultMap.put("v_recordtext", data.toString());

		return tSaleMapper.deleteTsaleLog(resultMap);
	}

	/**
	 * 정산로그 수정처리 
	 * @param data
	 * @return
	 * @throws SQLException
	 */

	public int updateTsaleLogFirst(CSVBean data) throws SQLException{

		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("v_sale_date", data.getV_sale_date());
		resultMap.put("v_ch_date", data.getV_ch_date());
		resultMap.put("v_cmp_cd", data.getV_cmp_cd());
		resultMap.put("v_seq", data.getV_seq());
		resultMap.put("v_no1", data.getV_no1());
		resultMap.put("v_no2", data.getV_no2());
		resultMap.put("v_filename", data.getV_file_name());
		resultMap.put("v_recordtext", data.toString());

		return tSaleMapper.updateTsaleLogFirst(resultMap);
	}

	/**
	 * 로그 갯수 조회
	 * @param data
	 * @return
	 * @throws SQLException
	 */

	public int selectTsaleCnt(CSVBean data) throws SQLException{

		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("v_sale_date", data.getV_sale_date());
		resultMap.put("v_ch_date", data.getV_ch_date());
		resultMap.put("v_cmp_cd", data.getV_cmp_cd());
		resultMap.put("v_seq", data.getV_seq());
		resultMap.put("v_no1", data.getV_no1());
		resultMap.put("v_no2", data.getV_no2());

		return tSaleMapper.selectTsaleCnt(resultMap);
	}

	public int deleteTsaleLogFirst(CSVBean data) throws SQLException{

		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("v_sale_date", data.getV_sale_date());
		resultMap.put("v_ch_date", data.getV_ch_date());
		resultMap.put("v_cmp_cd", data.getV_cmp_cd());
		resultMap.put("v_seq", data.getV_seq());
		resultMap.put("v_no1", data.getV_no1());
		resultMap.put("v_no2", data.getV_no2());

		return tSaleMapper.deleteTsaleLogFirst(resultMap);
	}

	/**
	 * 정산 등록 처리 
	 * @param data
	 * @return
	 * @throws SQLException
	 */

	public int insertTsaleFirst(CSVBean data) throws SQLException{

		return tSaleMapper.insertTsaleFirst(data);

	}

	/**
	 * 로그 마지막 등록처리 
	 * @param data
	 * @return
	 * @throws SQLException
	 */

	public int updateTsaleLogLast(CSVBean data) throws SQLException{

		return tSaleMapper.updateTsaleLogLast(data);

	}

	/**
	 * 정산 로그 전체 조회
	 * @param pReqParamMap
	 * @return
	 * @throws SQLException
	 */
	
	public List<?> selectEpisTsaleSvcLogAll(Map<String, Object> pReqParamMap) throws SQLException{

		return tSaleMapper.selectEpisTsaleSvcLogAll(pReqParamMap);

	}

	/**
	 * 정산로그 검색조회
	 * @param pReqParamMap
	 * @return
	 * @throws SQLException
	 */
	public List<?> selectEpisTsaleSvcLogSearch(Map<String, Object> pReqParamMap) throws SQLException{

		return tSaleMapper.selectEpisTsaleSvcLogSearch(pReqParamMap);
	}
	
	/**
	 * 정산로그 페이징 처리 
	 * @param pReqParamMap
	 * @return
	 * @throws SQLException
	 */
	public List<?> selectEpisTsaleSvcLogSearchPageAble  (
			Map<String, Object> pReqParamMap) throws SQLException {

		return tSaleMapper.selectEpisTsaleSvcLogSearchPageAble(pReqParamMap);
	}

	/**
	 *  로그 통계 화면 출력  
	 * @param pReqParamMap
	 * @return
	 * @throws SQLException
	 */
	public Map<String, Object> selectEpisTsaleSvcLogResult (
			Map<String, Object> pReqParamMap) throws SQLException{

		return tSaleMapper.selectEpisTsaleSvcLogResult(pReqParamMap);
	}

	/**
	 *  로그 조회 검색조건 조회
	 * @param pReqParamMap
	 * @return
	 * @throws SQLException
	 */
	public List<?> selectEpisTsaleSvcLogResultListSearch(
			Map<String, Object> pReqParamMap)  throws SQLException{
		return tSaleMapper.selectEpisTsaleSvcLogResultListSearch(pReqParamMap);
	}

	/**
	 * 로그 조회 검색조회 페이징 처리 
	 * @param pReqParamMap
	 * @return
	 * @throws SQLException
	 */
	public List<?> selectEpisTsaleSvcLogResultListSearchPageAble(
			Map<String, Object> pReqParamMap) throws SQLException{
		return tSaleMapper.selectEpisTsaleSvcLogResultListSearchPageAble(pReqParamMap);
	}
	
	
	/**
	 * 화훼 공판장 처리 
	 * @param originFileName
	 * @param recordText
	 * @return
	 */
	
	public Map<String, Object> serviceProc(String originFileName, String recordText){
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("originFileName", originFileName);
		paramMap.put("recordText", recordText);
		paramMap.put("retMessage", "");
		paramMap.put("intprocesscnt", "");
		
		tSaleMapper.insertTsaleAt(paramMap);
		
		return resultMap;
	}
	
	public Map<String, Object> serviceRealProc(String originFileName, String recordText){
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("originFileName", originFileName);
		paramMap.put("recordText", recordText);
		paramMap.put("retMessage", "");
		paramMap.put("intprocesscnt", "");
		
		tSaleMapper.insertRealAt(paramMap);
		
		return resultMap;
	}
	
	
	public String selectKoreaLvCdChage(String lvCd){
		return tSaleMapper.selectKoreaLvCdChage(lvCd);
	}
	
	public String selectFlowerGubn(String cmpGood){
		return tSaleMapper.selectFlowerGubn(cmpGood);
	}
	
	public String selectFlowerGubnAt(String cmpGood){
		return tSaleMapper.selectFlowerGubnAt(cmpGood);
	}
	
	public String selectFlowerGubnNong(String cmpGood,String marketCd){
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("cmpGood", cmpGood);
		resultMap.put("marketCd", marketCd);

		return tSaleMapper.selectFlowerGubnNong(resultMap);
	}
	
	public int deleteTsaleAllByDate(Map<String, Object> pReqParamMap) throws SQLException{
		return tSaleMapper.deleteTsaleAt(pReqParamMap);
	}


	public Map<String, Object> serviceMagam(Map<String, Object> reqMap) {
		// TODO Auto-generated method stub
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		tSaleMapper.insertMagam(reqMap);
		
		return resultMap;
	}
	
	public static String addMinusChar(String date) {
		if (date.length() == 8) {
			return date.substring(0, 4).concat("-").concat(date.substring(4, 6)).concat("-").concat(date.substring(6, 8));
		} else {
			return "";
		}
	}
	
	public String calculateWebserviceTestDelete( Map<String, Object> pRequestParamMap) throws Exception {		

		  	log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
		  	log.info("===========================================");

		  	String saleDate = pRequestParamMap.get("saleDate").toString();
			String compCode ="0000000001";
			
			pRequestParamMap.put("originFileName", ""+compCode+saleDate+".txt");
			pRequestParamMap.put("v_sale_date", saleDate);
			pRequestParamMap.put("v_cmp_code", compCode);
			pRequestParamMap.put("retMessage", "");
			pRequestParamMap.put("intprocesscnt", "");
			
			tSaleMapper.deleteTsaleAllByDate(pRequestParamMap);
 			
		  	return "/mem01/test";	
 	}
	
	public String calculateWebserviceTestForm(Map<String, Object> pRequestParamMap) throws Exception {		

			Map<String, Object> reqMap = new HashMap<String, Object>();	 


				if(pRequestParamMap.get("requestSn").toString().equals("magam")){
					reqMap =	serviceMagam(pRequestParamMap);
				}else{
					
			  	String filename = pRequestParamMap.get("filename").toString();
				String recode = pRequestParamMap.get("recode").toString();

				pRequestParamMap.put("filename", filename);
				pRequestParamMap.put("recode", recode);
					
					reqMap.put("filename", filename);
					reqMap.put("recode", recode);
				reqMap =	serviceProc(filename,recode);
				
				}
		  	 return "/mem01/test";
	 }
	
	public String calculateWebservice(Map<String, Object> pRequestParamMap) throws Exception {		

		Map<String, Object> reqMap = new HashMap<String, Object>();	 

	  	String filename = pRequestParamMap.get("filename").toString();
		String recode = pRequestParamMap.get("recode").toString();

		pRequestParamMap.put("filename", filename);
		pRequestParamMap.put("recode", recode);
			
			reqMap.put("filename", filename);
			reqMap.put("recode", recode);
		reqMap =	serviceRealProc(filename,recode);
			
	  	 return "/mem01/test";
 }
	
	public String calculateAtMntDelete( Map<String, Object> pRequestParamMap) throws Exception {		

	  	log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
	  	log.info("===========================================");

	  	String saleDate = pRequestParamMap.get("saleDate").toString();
		String compCode ="0000000001";
		
		pRequestParamMap.put("originFileName", ""+compCode+saleDate+".txt");
		pRequestParamMap.put("v_sale_date", saleDate);
		pRequestParamMap.put("v_cmp_code", compCode);
		pRequestParamMap.put("retMessage", "");
		pRequestParamMap.put("intprocesscnt", "");
		
		tSaleMapper.deleteAtMnt(pRequestParamMap);
			
	  	return "/mem01/test";	
	}
	
	public void calculateAtMntSave(AtMntVO data){
		tSaleMapper.insertAtMnt(data);
	}
	
	
}
