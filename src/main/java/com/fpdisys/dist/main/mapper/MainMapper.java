package com.fpdisys.dist.main.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.hab06.domain.Hab06VO;
import com.fpdisys.dist.hfa01.domain.Hfa01VO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("mainMapper")
public interface MainMapper {

	List<?> selectFlowerMain(Map<String, Object> pRequestParamMap);

	List<?> selectGridJong(Map<String, Object> pRequestParamMap);

	List<?> selectMainIndex(Map<String, Object> pRequestParamMap);

	List<?> selectChartListIndex(Map<String, Object> pRequestParamMap);

	List<?> selectAuctionDate(Map<String, Object> pRequestParamMap);

	List<?> selectGridListMok(Map<String, Object> pRequestParamMap);

	List<?> selectGridListAnalysis(Map<String, Object> pRequestParamMap);

	List<?> selectChartListChulHa(Map<String, Object> pRequestParamMap);

	List<?> selectChartListChulHaShdul(Map<String, Object> pRequestParamMap);

	List<?> selectSalePriceTrand(Map<String, Object> pRequestParamMap);
	
	List<?> selectGridListMokSub(Map<String, Object> pRequestParamMap);
	
	List<?> selectGridListMokSubMonth(Map<String, Object> pRequestParamMap);
	
	List<?> selectGridListMokSubYear(Map<String, Object> pRequestParamMap);

	List<?> selectSaleTrend(Map<String, Object> pRequestParamMap);
	
	List<?> getPumInfo(Map<String, Object> pRequestParamMap);

	List<EgovMap> situationNewChart1(Map<String, Object> pRequestParamMap);

	List<EgovMap> situationNewChart2(Map<String, Object> pRequestParamMap);

	List<EgovMap> situationNewTable2(Map<String, Object> pRequestParamMap);

	List<EgovMap> situationNewChart3(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> situationNewChart4(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> situationNewChart5(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> hab01Chart1(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> hab01Chart2(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> hab01Button(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectFlowerMainMonth(Map<String, Object> pRequestParamMap);
	
	
	/*
	 * 2021.09.07~ 추가
	 */
	List<EgovMap> selectDealTrendList(int flowerGubn);
	
	List<EgovMap> selectRealSaleDate(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectSaleDate(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectPumMokSaledate(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectAreaSaleDate(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectRealData(Map<String, Object> pReqeustParamMap);
	
	List<EgovMap> selectSaleData(Map<String, Object> pReqeustParamMap);
	
	List<EgovMap> selectPumMokData(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectPumMokTotalInfo(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectAreaChartData(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectDetailAreaChartData(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> selectAreaMapData(Map<String, Object> pRequestParamMap);
}
