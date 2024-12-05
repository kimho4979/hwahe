package com.fpdisys.dist.hca03.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.hca03.domain.Hca03ExcelVO;
import com.fpdisys.dist.hca03.domain.Hca03VO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("hca03Mapper")
public interface Hca03Mapper {

	List<Hca03VO> selectHca03(Map<String, Object> pRequestParamMap);
	
	List<Hca03VO> selectHca03Test(Map<String, Object> pRequestParamMap);
	
	List<Hca03VO> selectJakgwangList(Hca03VO hca03vo);

	Map<String, String> selectCropFileDetail(String fileSeq);

	List<Hca03VO> selectCropMainChart(Map<String, Object> pRequestParamMap);
	
	List<Hca03ExcelVO> selectHca03Excel(Map<String, Object> pRequestParamMap);

}
