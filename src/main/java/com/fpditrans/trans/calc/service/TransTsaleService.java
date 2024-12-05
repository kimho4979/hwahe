package com.fpditrans.trans.calc.service;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fpditrans.base.util.CSVRead;
import com.fpditrans.base.util.GlobalConstants;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fpditrans.base.mvc.BaseService;
import com.fpditrans.trans.calc.domain.CSVBean;
import com.fpditrans.trans.calc.domain.TsaleVO;
import com.fpditrans.trans.calc.mapper.TranTsaleMapper;

/**
 * @Class Name : TransTsaleService.java
 * @Description : TransTsaleService Class
 * 
 *			  @ 정산자료 서비스 테이블 @ 수정일 수정자 수정내용 @ --------- ---------
 *			  ------------------------------- @ 2016.07.28 최초생성
 *
 * @author 우림인포텍
 * @version 1.0
 * @see Copyright (C) by woorim All right reserved.
 */

@Service
public class TransTsaleService extends BaseService {

	@Autowired
	TranTsaleMapper tSaleMapper;

	/**
	 * 전체 목록 검색
	 * 
	 * @param pReqParamMap
	 * @return
	 */
	public List<?> selectTsaleListAll(Map<String, Object> pReqParamMap) {
		return tSaleMapper.selectTsaleListAll(pReqParamMap);
	}

	/**
	 * 검색한 데이터 가져오기
	 * 
	 * @param pReqParamMap
	 * @return
	 */
	public List<?> selectSearchTsaleList(Map<String, Object> pReqParamMap) {
		return tSaleMapper.selectSearchTsaleList(pReqParamMap);
	}

	/**
	 * 검색한 데이터 페이징 해서 가져오기
	 * 
	 * @param pReqParamMap
	 * @return
	 */
	public List<?> selectSearchTsaleListPageAble(
			Map<String, Object> pReqParamMap) {
		return tSaleMapper.selectSearchTsaleListPageAble(pReqParamMap);
	}

	/**
	 * 개별데이터 가져오기 saleDate chDate cmpCd
	 * 
	 * @param pReqParamMap
	 * @return
	 */
	public TsaleVO selectTsaleOne(Map<String, Object> pReqParamMap) {
		return tSaleMapper.selectTsaleOne(pReqParamMap);
	}

	/**
	 * 정산파일 전송처리 
	 * @param pRequest
	 * @param multi
	 * @return
	 */
	public Map<String, Object> saveFileProc(HttpServletRequest pRequest,
			MultipartHttpServletRequest multi)  {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		// MultipartHttpServletRequest multipartRequest =
		// (MultipartHttpServletRequest);

		System.out.println("AAAA");
		java.util.Iterator<String> fileNames = multi.getFileNames();

		CSVRead csvRead = new CSVRead();

		ArrayList<CSVBean> csvList = new ArrayList<CSVBean>();
		try {

			//this.startTx();
			
			System.out.println("BBBB");
			while (fileNames.hasNext()) {
				String fileName = fileNames.next();

				MultipartFile mFile = multi.getFile(fileName);

				String rootPath = pRequest.getSession().getServletContext()
						.getRealPath("/");
				System.out.println("CCCC");
				SimpleDateFormat sFormat = new SimpleDateFormat("yyyyMMdd");
				Date now = new Date();
				String sNow = sFormat.format(now);
				String originFileName = mFile.getOriginalFilename();
				String fileExt = originFileName.substring(
						originFileName.lastIndexOf(".") + 1,
						originFileName.length());
				String newFileName = "test" + System.currentTimeMillis() + "."
						+ fileExt;
				String path = rootPath + "upload" + File.separator + sNow
						+ File.separator;
				System.out.println("DDDDD");
				File file = new File(path + newFileName);
				if (mFile.getSize() != 0) {
					if (!file.exists()) {
						if (file.getParentFile().mkdirs()) {
							System.out.println("EEEEE");

							file.createNewFile();

							System.out.println("FFFFFF");
						}
					}

					System.out.println("GGGGGGGGGGG");
					
						mFile.transferTo(file); // 임시로 저장된 multipartFile을 실제 파일로
												// 전송
					System.out.println("HHHHHHHHHHHHHHH");
					
					System.out.println("IIIIIIIIIIIIIIIIIIII");
					resultMap.put("opCode", "REG");
					resultMap.put("orginFileName", originFileName);
					resultMap.put("storedFileName", newFileName);
					resultMap.put("fileSize", mFile.getSize());
					resultMap.put("filePath", path);

					System.out.println("JJJJJJJJJJJJJJJJJJJJJJ");

					csvList = (ArrayList<CSVBean>) csvRead.readCsv(newFileName,
							originFileName, path);

				}
				int TotCnt = 0;
				int dataCnt = 0;

				if (csvList != null) {

					System.out.println("KKKKKKKKKKKKKKKKKKKKKKKKK");

					if (csvList.size() > 0) {

						for (int i = 0; i < csvList.size(); i++) {
							CSVBean data = csvList.get(i);
							if(data.getV_cmp_cd().equals(GlobalConstants.KOREA_FLOWER)){
									//한국화훼일 경우  
									//레벨 등급 셋팅 
									String LvCd ="";
									LvCd = this.selectKoreaLvCdChage(data.getV_lv_cd());
									data.setV_lv_cd(LvCd);
									System.out.println("11111111111111 aa: " + data.getV_lv_cd());
									
							 
							 }else{
								 // 농협의 경우 메장 셋팅 
									String V_MEJANG = this.selectFlowerGubnNong(data.getV_cmp_good(),data.getV_cmp_cd());
									data.setV_mejang(V_MEJANG);
								 
							 }
							

							// for(CSVBean data :csvList){
							int iCnt = this.selectTsaleCnt(data);
							System.out.println(iCnt);
							if (iCnt > 0) {
								this.deleteTsaleLog(data);

								// this.insertTsaleDelLog(data);

								this.deleteTsaleLogFirst(data);
							}
							System.out.println("LLLLLLLLLLLLLLLLLLLLLLLLLLLL");

							this.insertTsaleLogFirst(data);

							this.updateTsaleLogFirst(data);

							// this.selectTsaleCnt(data);
							if (iCnt > 0) {

								this.deleteTsaleLogFirst(data);
							}

							this.insertTsaleFirst(data);
							System.out.println("MMMMMMMMMMMMMMMMMMMMM");
							this.updateTsaleLogLast(data);

							TotCnt++;
						}

						String saleDate = csvList.get(0).getV_sale_date();
						resultMap.put("sale_date", saleDate);
						System.out.println("NNNNNNNNNNNNNNNNNNNNN");
						Map<String, Object> getMap = new HashMap<String, Object>();
						getMap = this.selectEpisTsaleSvcLogResult(resultMap);
						System.out.println("NNNNNNNNNNNNNNNNNNNNN  getMap.toString()"+getMap.toString());
						resultMap.put("cmpCd", getMap.get("CMPCD"));	
						resultMap.put("yCNT", getMap.get("Y_CNT"));	
						resultMap.put("yCNT", getMap.get("Y_CNT"));
						resultMap.put("nCNT", getMap.get("N_CNT"));
						resultMap.put("yQTY", getMap.get("Y_QTY"));
						resultMap.put("nQTY", getMap.get("N_QTY"));
						resultMap.put("yAMT", getMap.get("Y_AMT"));
						resultMap.put("nAMT", getMap.get("N_AMT"));

					}

					dataCnt = csvList.size();

					System.out.println("OOOOOOOOOOOOOOOOOOO");

				}
				resultMap.put("dataCnt", Integer.toString(dataCnt));
				resultMap.put("totCnt", Integer.toString(TotCnt));

				System.out.println("PPPPPPPPPPPPPPPPPPPPPPPP");
				if (csvList != null) {

					for (int j = 0; j < csvList.size(); j++) {

						CSVBean data = csvList.get(j);

						deleteSaleDate(data.getV_cmp_cd(), data.getV_ch_date());

						insertSaleDate(data.getV_cmp_cd(), data.getV_ch_date());

						System.out.println("QQQQQQQQQQQQQQQQQQQQQQQQQ");

						//deleteSaleWeek(data.getV_cmp_cd(), data.getV_ch_date());

						//insertSaleWeek(data.getV_cmp_cd(), data.getV_ch_date());

						deleteSaleMonth(data.getV_cmp_cd(), data.getV_ch_date());

						insertSaleMonth(data.getV_cmp_cd(), data.getV_ch_date());

						System.out.println("RRRRRRRRRRRRRRRRRRRRRRRRRRRR");

						break;
					}
				}

			}
			
		//this.commit();

		} catch (IllegalStateException ile) {
			ile.printStackTrace();		 
		} catch (IOException ioe) {
			ioe.printStackTrace();
		} catch(SQLException sqle){
			//this.rollback();
			sqle.printStackTrace();			
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			
		}

		System.out.println("SSSSSSSSSSSSSSSSSSSSSSSS");

		return resultMap;
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
		/*
		CSVRead csvRead = new CSVRead();
		
		try{
			
			CSVBean data = csvRead.getRecordText(originFileName, recordText);
				if(data!=null){
					
					if(data.getV_cmp_cd().equals(GlobalConstants.KOREA_FLOWER)){
							//한국화훼일 경우  
							//레벨 등급 셋팅 
							String LvCd ="";
							LvCd = this.selectKoreaLvCdChage(data.getV_lv_cd());
							data.setV_lv_cd(LvCd);
							
							
					}else if(data.getV_cmp_cd().equals(GlobalConstants.AT_FLOWER)){
						String V_MEJANG = data.getV_mm();
						data.setV_mejang(V_MEJANG);
						data.setV_no2(V_MEJANG);
					 }else{
						 // 농협의 경우 메장 셋팅 
							String V_MEJANG = this.selectFlowerGubnNong(data.getV_cmp_good(),data.getV_cmp_cd());
							data.setV_mejang(V_MEJANG);
						 
					 }
					
					//this.startTx();		
				int iCnt = this.selectTsaleCnt(data);
				if (iCnt > 0) {
					this.deleteTsaleLog(data);
		
					// this.insertTsaleDelLog(data);
		
					//this.deleteTsaleLogFirst(data);
				}
				
		
				this.insertTsaleLogFirst(data);
		
				this.updateTsaleLogFirst(data);
		
				// this.selectTsaleCnt(data);
				if (iCnt > 0) {
		
					this.deleteTsaleLogFirst(data);
				}
		
				this.insertTsaleFirst(data);
			
				this.updateTsaleLogLast(data);
				
				
				
				this.deleteSaleDate(data.getV_cmp_cd(), data.getV_ch_date());

				this.insertSaleDate(data.getV_cmp_cd(), data.getV_ch_date());

				System.out.println("QQQQQQQQQQQQQQQQQQQQQQQQQ");

				this.deleteSaleWeek(data.getV_cmp_cd(), data.getV_ch_date());

				this.insertSaleWeek(data.getV_cmp_cd(), data.getV_ch_date());

				this.deleteSaleMonth(data.getV_cmp_cd(), data.getV_ch_date());

				this.insertSaleMonth(data.getV_cmp_cd(), data.getV_ch_date());
				
				//this.commit();  
				
			 }
				
				 
				
		
		} catch(SQLException sqle){
			this.rollback();
			sqle.printStackTrace();			
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			
		}
		*/
		
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
		//return tSaleMapper.deleteTsaleAllByDate(pReqParamMap);
	}


	public Map<String, Object> serviceMagam(Map<String, Object> reqMap) {
		// TODO Auto-generated method stub
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		tSaleMapper.insertMagam(reqMap);
		
		return resultMap;
	}



}
