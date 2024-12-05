package com.fpdisys.dist.hca02.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.hca02.domain.Hca02ExcelVO;
import com.fpdisys.dist.hca02.domain.Hca02VO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("hca02Mapper")
public interface Hca02Mapper {

	List<Hca02VO> selectHca02(Map<String, Object> pRequestParamMap);

	List<Map<String, String>> selectCropTrendList(Hca02VO hca02vo);

	List<Hca02ExcelVO> selectHca02Excel(Map<String, Object> pRequestParamMap);

	/*List<?> selectGridList(Map<String, Object> pRequestParamMap);*/

}
