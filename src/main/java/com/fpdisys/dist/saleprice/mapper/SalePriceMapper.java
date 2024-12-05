package com.fpdisys.dist.saleprice.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.fpdisys.dist.saleprice.domain.SalePriceVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("salePriceMapper")
public interface SalePriceMapper {

	List<SalePriceVO> selectSalePrice(Map<String, Object> pRequestParamMap);

	List<SalePriceVO> selectPointSalePrice(Map<String, Object> pRequestParamMap);

	String selectFastDay();	
		
	List<?> getBizMsg(Map<String, Object> pRequestParamMap);

	void delBizMsg(Map<String, Object> pRequestParamMap);	
	
	List<?> getBizMail(Map<String, Object> pRequestParamMap);

	void delBizMail(Map<String, Object> pRequestParamMap);

	void insertBizMSGForOarcle(Map<String, String> map);

	String selectTodaySale();
	
	List<SalePriceVO> selectPointSalePriceExcel(Map<String, Object> pRequestParamMap);

}
