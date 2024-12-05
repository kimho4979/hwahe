package com.fpdisys.dist.hab09.mapper;

import java.util.List;
import java.util.Map;











import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("hab09Mapper")
public interface Hab09Mapper {
	
	List<EgovMap> getAucBbsList(Map<String, Object> pRequestParamMap);
	
	void updateClickCnt(Map<String, Object> pRequestParamMap);
	
	Map<String, Object> selectHab09Detail(Map<String, Object> pRequestParamMap);
	
	List<EgovMap> getDataCmpList(Map<String, Object> dateParam);
	
	void insertAucBbs(Map<String, Object> param);

	List<EgovMap> selectAucExcel(Map<String, Object> pReqeustParamMap);
}
