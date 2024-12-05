package com.fpditrans.base.util;


import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.fpdisys.base.util.GlobalConstants;
import com.fpditrans.trans.calc.domain.CSVBean;
import com.opencsv.CSVReader;
/**
 * @Class Name : GlobalConstants.java
 * @Description : GlobalConstants Class
 *	 
 *  파일업로드 파싱  클래스
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
public class CSVRead {
	

	
	public CSVRead() {}
	
	@SuppressWarnings("resource")
	public List<CSVBean> readCsv(String csvFile, String originFileName,String path) throws IOException {
		
		List<CSVBean> beanList = new ArrayList<CSVBean>(); 
		char seprator =';';
		CSVReader csvReader = null;
		String[] data = null;
		
		try {
			
			// UTF-8
			
			//csvReader = new CSVReader(new FileReader(csvFile), seprator);
			csvReader = new CSVReader(new InputStreamReader(new FileInputStream(path+File.separator+csvFile), "MS949"), seprator);		
			 
			
			while ((data = csvReader.readNext()) != null) {
				
				if(data != null && data.length>20){
					CSVBean cbData = new CSVBean();
				
				  // for (String str : data) {
					  int cntChar = originFileName.indexOf(".");
					  String xFileName =originFileName.substring(0,cntChar);	
					  
					String chDate = xFileName.substring(1,9); 
					  
					
					 cbData.setV_file_name(originFileName);  
					 cbData.setV_ch_date(EgovStringUtil.addMinusChar(chDate));
					 cbData.setV_sale_date(EgovStringUtil.addMinusChar(data[2]));
					 cbData.setV_cmp_cd(data[4]);
					 cbData.setV_seq(data[5]);
					 cbData.setV_no1(data[6]);
					 if(!StringUtils.isEmpty(data[7])){
					 cbData.setV_no2(data[7]);
					 }else{
						 cbData.setV_no2(data[6]);
					 }
					
					 cbData.setV_mm(data[8]);
					 if(!StringUtils.isEmpty(data[9])){
						 cbData.setV_good(data[9]);
					 }else{
						 cbData.setV_good("000000");
					 }
					 cbData.setV_cmp_good(data[10]);
					 cbData.setV_pum_name(data[11]);
					 cbData.setV_good_name(data[12]);
					 
					 
					if(cbData.getV_cmp_cd().equals(GlobalConstants.KOREA_FLOWER)){
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
						//농협의 경우 
						String V_MEJANG =GlobalConstants.FLOWER_GUBN_ONE;
							
								cbData.setV_mejang(V_MEJANG);
								
					}
					 
					 
					 
					
					 cbData.setV_danq(new BigDecimal(data[13]));
					 cbData.setV_dan_cd("12");
					 cbData.setV_poj_cd("100");
					 cbData.setV_size_cd("100");
					 cbData.setV_lv_cd(data[15]);
					 
					 
					 cbData.setV_qty(new Integer(data[16]).intValue());
					 cbData.setV_tot_qty(new Integer(data[16]).intValue());
					 cbData.setV_cost(new Integer(data[17]).intValue());
					 cbData.setV_tot_amt(new Integer(data[16]).intValue()* new Integer(data[17]).intValue());
					 cbData.setV_amer_cd(data[18]);
					 cbData.setV_ch_cd(data[19]);
					 cbData.setV_sman_cd(data[20]);
					 cbData.setV_chul_no(data[21]);
					 cbData.setV_chul_cd(data[22]);
					 cbData.setV_chul_name(data[23]);
					 cbData.setV_farm_name(null);
					 if(StringUtils.isNotBlank(data[25])){
		 		 		cbData.setV_gubn(data[25]);
		 		 	}else{
		 		 		cbData.setV_gubn("5");	
		 		 	}
					 cbData.setV_san_cd(data[26]);
					 cbData.setV_cmp_san(data[27]);
					 cbData.setV_san_name(data[28]);
					 
					 beanList.add(cbData);
					 
				 // }
				
				}
			}
		} catch (FileNotFoundException e) {
			System.out.println(data.toString());
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println(data.toString());
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(data.toString());
		}finally {
 
			csvReader.close();
		}

		return beanList;
	}
	
	/**
	 *  화훼공판장 데이터 처리 
	 * @param originFileName  (파일명)
	 * @param recordText	  (레코드내용)
	 * @return
	 */
	@SuppressWarnings("resource")
	public CSVBean getRecordText(String originFileName,String recordText){
		CSVBean cbData = new CSVBean();  
		if(StringUtils.isNotBlank(recordText)){
			int cntChar = originFileName.indexOf(".");
	 		String xFileName =originFileName.substring(0,cntChar);	
	 		String chDate = xFileName.substring(10); 
	 	 	String[] data = recordText.split(";");
	 	 	  
	 	 	cbData.setV_file_name(originFileName);  
	 	 	cbData.setV_ch_date(EgovStringUtil.addMinusChar(chDate));
				cbData.setV_sale_date(EgovStringUtil.addMinusChar(data[2]));
				cbData.setV_cmp_cd(data[4]);
				cbData.setV_seq(data[5]);
				cbData.setV_no1(data[6]);
				if(StringUtils.isNotBlank(data[7])){
					cbData.setV_no2(data[7]);
				}else{
					cbData.setV_no2(data[6]);
				}
				cbData.setV_mejang("1");
				cbData.setV_mm(data[8]);
				if(StringUtils.isNotBlank(data[9])){
					cbData.setV_good(data[9]);
				}else{
				 	cbData.setV_good("000000");
				}
					 
				cbData.setV_cmp_good(data[10]);
				cbData.setV_pum_name(data[11]);
				cbData.setV_good_name(data[12]);
			if(cbData.getV_cmp_cd().equals(GlobalConstants.KOREA_FLOWER)){
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
				//농협의 경우 
				String V_MEJANG =GlobalConstants.FLOWER_GUBN_ONE;
					
						cbData.setV_mejang(V_MEJANG);
						
			}
				
				cbData.setV_danq(new BigDecimal(data[13]));
				cbData.setV_dan_cd("12");
				cbData.setV_poj_cd("100");
				cbData.setV_size_cd("100");
				cbData.setV_lv_cd(data[15]);
				cbData.setV_qty(new Integer(data[16]).intValue());
				cbData.setV_tot_qty(new Integer(data[16]).intValue());
				cbData.setV_cost(new Integer(data[17]).intValue());
				cbData.setV_tot_amt(new Integer(data[16]).intValue()* new Integer(data[17]).intValue());
				cbData.setV_amer_cd(data[18]);
				cbData.setV_ch_cd(data[19]);
				cbData.setV_sman_cd(data[20]);
				cbData.setV_chul_no(data[21]);
				cbData.setV_chul_cd(data[22]);
				cbData.setV_chul_name(data[23]);
				cbData.setV_farm_name(null);
		 	if(StringUtils.isNotBlank(data[25])){
		 		cbData.setV_gubn(data[25]);
		 	}else{
		 		cbData.setV_gubn("5");	
		 	}
				cbData.setV_san_cd(data[26]);
				cbData.setV_cmp_san(data[27]);
				cbData.setV_san_name(data[28]);
				
			
			
			
 		 
			 
	 	 	
		}
		
		return cbData;
	}
	
	
}

	