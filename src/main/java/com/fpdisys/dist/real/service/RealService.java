package com.fpdisys.dist.real.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.base.util.GlobalConstants;
import com.fpdisys.dist.real.domain.RealVO;
import com.fpdisys.dist.real.mapper.RealMapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class RealService extends BaseService {
	
	@Autowired
	RealMapper realMapper;
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	// 한국화훼 데이터 저장
	public int saveRealData(Map<String, Object> pRequestParamMap) {
		RealVO realVo = new RealVO();
		Map<String, String> hashMap = new java.util.HashMap<String, String>();

		int result3 = 0; 
		try{
			// filename = S2017080112882022960013.txt
			String filename = (String) pRequestParamMap.get("filename");
			realVo.setSaleDate(filename.substring(1, 9));
			// recode = S2017080112882022960013.txt
			String record = (String) pRequestParamMap.get("recode");
			
			hashMap.put("filename", filename);
			hashMap.put("record", record);
			
			String[] arrRecord = record.split(";");
			realVo.setNakTime(arrRecord[1]);
			realVo.setChDate(arrRecord[2]);
			realVo.setCmpCd(arrRecord[4]);
			realVo.setSeq(arrRecord[5]);
			realVo.setNo1(arrRecord[6]);
			realVo.setNo2(arrRecord[6]);
			realVo.setMmCd(arrRecord[8]);
					
			String code = arrRecord[9];
			String mejang = code.substring(0, 2); // 경매장 구분에서 사용
			
			realVo.setLarge(mejang);
			realVo.setMid(code.substring(2, 4));
			realVo.setSmall(code.substring(4, 6));
			
			realVo.setCmpGood(arrRecord[10]);
			realVo.setPumName(arrRecord[11]);
			realVo.setGoodName(arrRecord[12]);
			
			String danQ = arrRecord[13];	// 총물량에서 사용		
			realVo.setDanq(danQ);
			
			String groupCode = arrRecord[14];
			
			realVo.setDanCd(groupCode.substring(0, 2));
			realVo.setPojCd(groupCode.substring(0, 1) + groupCode.substring(2, 4));
			realVo.setSizeCd(groupCode.substring(0, 1)+ groupCode.substring(4, 6));
			
			realVo.setLvCd(arrRecord[15]);
			
			String qty = arrRecord[16];
			String cost = arrRecord[17];
			realVo.setQty(qty);
			realVo.setCost(cost);
			realVo.setChCd(arrRecord[19]);
			realVo.setChulCd(arrRecord[22]);
			realVo.setChulName(arrRecord[23]);
			realVo.setGubn(arrRecord[25]);
			realVo.setSanCd(arrRecord[26]);
			realVo.setCmpSan(arrRecord[27]);
			realVo.setSanName(arrRecord[28]);
					
			if(mejang.equals("22")){
				realVo.setMejang("3");	// 난
			} else if(mejang.equals("26")){
				realVo.setMejang("2");	// 관엽
			} else{
				realVo.setMejang("5");	// 기타
			}
			
			realVo.setTotQty((Integer.parseInt(danQ) * Integer.parseInt(qty))+"");
			realVo.setTotAmt((Integer.parseInt(qty) * Integer.parseInt(cost))+"");		
			
			// 중복건 삭제 후 insert
			result3 = realMapper.deleteRealData(realVo);
			
			result3 = realMapper.saveRealData(realVo);
			
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
		} catch (RuntimeException e) {
			log.error("오류발생 런타임!!");
		} catch (Exception e) {
			log.error("오류발생!!");
		}

		return result3;
		
	}
	
	// 한국화훼 데이터 저장
		public int saveSaleData(Map<String, Object> pRequestParamMap) {
			RealVO realVo = new RealVO();
			Map<String, String> hashMap = new java.util.HashMap<String, String>();

			int result3 = 0; 
			try{
				// filename = S2017080112882022960013.txt
				//String filename = (String) pRequestParamMap.get("filename");
				//realVo.setSaleDate(filename.substring(1, 9));
				// recode = S2017080112882022960013.txt
				String record = (String) pRequestParamMap.get("recode");
				
				//hashMap.put("filename", filename);
				hashMap.put("record", record);
				
				String[] arrRecord = record.split(";");
				//realVo.setNakTime(arrRecord[1]);
				realVo.setSaleDate(addMinusChar(arrRecord[2]));
				realVo.setChDate(addMinusChar(arrRecord[2]));
				realVo.setCmpCd(arrRecord[4]);
				realVo.setSeq(arrRecord[5]);
				realVo.setNo1(arrRecord[6]);
				realVo.setNo2(arrRecord[6]);
				realVo.setMmCd(arrRecord[8]);
						
				String code = arrRecord[9];
				String mejang = code.substring(0, 2); // 경매장 구분에서 사용
				
				realVo.setLarge(mejang);
				realVo.setMid(code.substring(2, 4));
				realVo.setSmall(code.substring(4, 6));
				
				realVo.setCmpGood(arrRecord[10]);
				realVo.setPumName(arrRecord[11]);
				realVo.setGoodName(arrRecord[12]);
				
				String danQ = arrRecord[13];	// 총물량에서 사용		
				realVo.setDanq(danQ);
				
				String groupCode = arrRecord[14];
				
				realVo.setDanCd(groupCode.substring(0, 2));
				realVo.setPojCd(groupCode.substring(0, 1) + groupCode.substring(2, 4));
				realVo.setSizeCd(groupCode.substring(0, 1)+ groupCode.substring(4, 6));
				
				realVo.setLvCd(arrRecord[15]);
				
				String qty = arrRecord[16];
				String cost = arrRecord[17];
				realVo.setQty(qty);
				realVo.setCost(cost);
				realVo.setChCd(arrRecord[19]);
				realVo.setChulCd(arrRecord[22]);
				realVo.setChulName(arrRecord[23]);
				realVo.setGubn(arrRecord[25]);
				realVo.setSanCd(arrRecord[26]);
				realVo.setCmpSan(arrRecord[27]);
				realVo.setSanName(arrRecord[28]);
						
				if(mejang.equals("22")){
					realVo.setMejang("3");	// 난
				} else if(mejang.equals("26")){
					realVo.setMejang("2");	// 관엽
				} else{
					realVo.setMejang("5");	// 기타
				}
				
				realVo.setTotQty((Integer.parseInt(danQ) * Integer.parseInt(qty))+"");
				realVo.setTotAmt((Integer.parseInt(qty) * Integer.parseInt(cost))+"");		
				
				// 중복건 삭제 후 insert
				//result3 = realMapper.deleteSaleData(realVo);
				
				result3 = realMapper.saveSaleData(realVo);
				
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
			} catch (RuntimeException e) {
				log.error("오류발생 런타임!!");
			} catch (Exception e) {
				log.error("오류발생!!");
			}

			return result3;
			
		}
	
	// 실시간 데이터 저장
	public int saveNonghyup(Map<String, Object> pRequestParamMap) {
		RealVO realVo = new RealVO();
		Map<String, String> hashMap = new java.util.HashMap<String, String>();

		int result3 = 0;
		
		try{			
			String filename = (String) pRequestParamMap.get("filename");
			realVo.setSaleDate(filename.substring(8, 16));
			// recode = S2017080112882022960013.txt
			String record = (String) pRequestParamMap.get("recode");
			
			hashMap.put("filename", filename);
			hashMap.put("record", record);
			
			String[] arrRecord = record.split(";");
			// 실시간
			realVo.setNakTime(arrRecord[1]);
			realVo.setChDate(arrRecord[2]);
			realVo.setCmpCd(arrRecord[3]);
			realVo.setSeq(arrRecord[4]);
			realVo.setNo1(arrRecord[5]);
			realVo.setNo2(arrRecord[5]);
			realVo.setMmCd(arrRecord[6]);				
					
			String code = arrRecord[7];
			
			realVo.setLarge(code.substring(0, 2));
			realVo.setMid(code.substring(2, 4));
			realVo.setSmall(code.substring(4, code.length()));
			
			realVo.setCmpGood(arrRecord[8]);
			realVo.setPumName(arrRecord[9].trim());
			realVo.setGoodName(arrRecord[10].trim());
			
			float f = Float.parseFloat(arrRecord[11]);
			String str = String.format("%.0f", f);
			String danQ = str;	// 총물량에서 사용		
			realVo.setDanq(danQ);

			realVo.setDanCd(null);
			realVo.setPojCd(null);
			realVo.setSizeCd(null);
			realVo.setLvCd(null);

			if(realVo.getCmpCd().equals(GlobalConstants.KOREA_FLOWER)){
					//한국화훼일 경우  
					//레벨 등급 셋팅 
				if(realVo.getLvCd() != null){
					String LvCd =this.selectKoreaLvCdChage(realVo.getLvCd());
		 			realVo.setLvCd(LvCd);
				}else{
					realVo.setLvCd("10");
				}
				
				String V_MEJANG =GlobalConstants.FLOWER_GUBN_ONE;
				if(realVo.getLarge().equals(GlobalConstants.KOREA_FLOWER_MEJANG_ONE)){
					V_MEJANG = GlobalConstants.FLOWER_GUBN_THREE;
				}else if(realVo.getLarge().equals(GlobalConstants.KOREA_FLOWER_MEJANG_TWO)){
					V_MEJANG = GlobalConstants.FLOWER_GUBN_TWO;
				}
				realVo.setMejang(V_MEJANG);
				
	 		 }else{
	 			 // 농협의 경우 매장 셋팅 
	 				String mejang =this.selectFlowerGubnNong(realVo.getCmpGood(),realVo.getCmpCd());
	 				realVo.setMejang(mejang); 
	 		 }
			String qty = arrRecord[14];
			String cost = arrRecord[15];
			
			if(qty.equals("")){
				realVo.setQty("0");
			}else{
				realVo.setQty(qty);
			}
			
			if(cost.equals("")){
				realVo.setCost("0");
			}else{
				realVo.setCost(cost);
			}
			
			realVo.setChCd(arrRecord[16]);
			realVo.setChulCd(arrRecord[17]);
			realVo.setChulName(arrRecord[18]);
			realVo.setGubn(arrRecord[19]);
			realVo.setSanCd("");
			realVo.setCmpSan("");
			realVo.setSanName(arrRecord[23]);
			
			realVo.setTotQty((Integer.parseInt(danQ) * Integer.parseInt(qty))+"");
			realVo.setTotAmt((Integer.parseInt(qty) * Integer.parseInt(cost))+"");	
			
			// 중복건 삭제 후 insert

			result3 = realMapper.deleteRealData(realVo);
			result3 = realMapper.saveRealData(realVo);
			
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
		} catch (RuntimeException e) {
			log.error("오류발생 런타임!!");
		} catch (Exception e) {
			log.error("오류발생!!");
		}
		return result3;		
	}
	
	public List<RealVO> getRealData(Map<String, Object> pRequestParamMap) {
		return realMapper.getRealData(pRequestParamMap);
	}
	public List<RealVO> getRealMainData(Map<String, Object> pRequestParamMap) {
		return realMapper.getRealMainData(pRequestParamMap);
	}
	
	public List<EgovMap> getRealData1(Map<String, Object> pRequestParamMap) {
		return realMapper.getRealData1(pRequestParamMap);
	}
	
	public List<RealVO> getRealSaleData(Map<String, Object> pRequestParamMap) {
		return realMapper.getRealSaleData(pRequestParamMap);
	}
	
	public List<EgovMap> getRealPumNameData(Map<String, Object> pRequestParamMap) {
		return realMapper.getRealPumNameData(pRequestParamMap);
	}
	
	public List<RealVO> getRealSilData(Map<String, Object> pRequestParamMap) {
		return realMapper.getRealSilData(pRequestParamMap);
	}
	
	public List<RealVO> getRealLvData(Map<String, Object> pRequestParamMap) {
		return realMapper.getRealLvData(pRequestParamMap);
	}
	
	public List<RealVO> getRealInforData(Map<String, Object> pRequestParamMap) {
		return realMapper.getRealInforData(pRequestParamMap);
	}
	
	public List<RealVO> getRealchartData(Map<String, Object> pRequestParamMap) {
		return realMapper.getRealchartData(pRequestParamMap);
	}
	
	public String selectFlowerGubnNong(String cmpGood,String marketCd){
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("cmpGood", cmpGood);
		resultMap.put("marketCd", marketCd);

		return realMapper.selectFlowerGubnNong(resultMap);
	}
	
	public String selectKoreaLvCdChage(String lvCd){
		return realMapper.selectKoreaLvCdChage(lvCd);
	}
	
	public List<RealVO> selectPumAvg(Map<String, Object> pRequestParamMap) {
		return realMapper.selectPumAvg(pRequestParamMap);
	}
	public List<RealVO> selectLvCdAvg(Map<String, Object> pRequestParamMap) {
		return realMapper.selectLvCdAvg(pRequestParamMap);
	}
	
	public static String addMinusChar(String date) {
		if (date.length() == 8) {
			return date.substring(0, 4).concat("-").concat(date.substring(4, 6)).concat("-").concat(date.substring(6, 8));
		} else {
			return "";
		}
	}
	
	public List<RealVO> getRealDataExcel(Map<String, Object> pRequestParamMap) {
		return realMapper.getRealDataExcel(pRequestParamMap);
	}
	
	public int atMarketRealTotCnt(Map<String, Object> pRequestParamMap) {
		return realMapper.atMarketRealTotCnt(pRequestParamMap);
	}
	
	public void deleteAtRealData(Map<String, Object> pRequestParamMap){
		realMapper.deleteAtRealData(pRequestParamMap);
	}
}
