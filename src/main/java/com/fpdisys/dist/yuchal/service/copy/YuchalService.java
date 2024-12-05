package com.fpdisys.dist.yuchal.service.copy;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.at.domain.AtMarketVO;
import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.yuchal.domain.YuChalVO;
import com.fpdisys.dist.yuchal.mapper.YuchalMapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class YuchalService extends BaseService {
	
	@Autowired
	YuchalMapper yuchalMapper;
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	// 유찰 데이터 삭제
	public int deleteYuchal(Map<String, Object> pRequestParamMap) {
		int result3 = 0; 
		try{
			result3 = yuchalMapper.deleteYuchal(pRequestParamMap);
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
	
	// 유찰 데이터 insert
		public int insertYuchal(AtMarketVO rs) {
			int result3 = 0; 
			try{
				result3 = yuchalMapper.insertYuchal(rs);
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

		public List<EgovMap> getYuchalData(Map<String, Object> pRequestParamMap) {
			return yuchalMapper.getYuchalData(pRequestParamMap);
		}
		
		public List<YuChalVO> getYuchalDataExcel(Map<String, Object> pRequestParamMap) {
			return yuchalMapper.getYuchalDataExcel(pRequestParamMap);
		}
}
