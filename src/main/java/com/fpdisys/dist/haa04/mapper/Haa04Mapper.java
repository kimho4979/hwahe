package com.fpdisys.dist.haa04.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.haa04.domain.Haa04VO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("haa04Mapper")
public interface Haa04Mapper {

	List<?> selectMainList(Map<String, Object> pRequestParamMap);
	
	List<?> graphMainAmtList(Map<String, Object> pRequestParamMap);

	List<?> selectCutList(Map<String, Object> pRequestParamMap);

	List<?> graphCutAmtList(Map<String, Object> pRequestParamMap);

	List<?> selectNanList(Map<String, Object> pRequestParamMap);

	List<?> graphNanAmtList(Map<String, Object> pRequestParamMap);

	List<?> selectGwanList(Map<String, Object> pRequestParamMap);

	List<?> graphGwanAmtList(Map<String, Object> pRequestParamMap);

	List<?> selectChunList(Map<String, Object> pRequestParamMap);

	List<?> graphChunAmtList(Map<String, Object> pRequestParamMap);
	
	List<?> getSaleMonth(Map<String, Object> pRequestParamMap);
	
	/*List<Haa04VO> selectTotalAuction(Map<String, Object> pRequestParamMap);

	List<Haa04VO> selectTotalAuctionGraph(Map<String, Object> pRequestParamMap);

	List<Haa04VO> selectCutflowerAuction(Map<String, Object> pRequestParamMap);

	List<Haa04VO> selectCutflowerAuctionGraph(Map<String, Object> pRequestParamMap);

	List<Haa04VO> selectOrchidAuction(Map<String, Object> pRequestParamMap);

	List<Haa04VO> selectOrchidAuctionGraph(Map<String, Object> pRequestParamMap);

	List<Haa04VO> selectfoliagePlantAuction(Map<String, Object> pRequestParamMap);

	List<Haa04VO> selectfoliagePlantAuctionGraph(Map<String, Object> pRequestParamMap);

	List<Haa04VO> selectOrchidSpringAuction(Map<String, Object> pRequestParamMap);

	List<Haa04VO> selectOrchidSpringAuctionGraph(Map<String, Object> pRequestParamMap);*/
	

}
