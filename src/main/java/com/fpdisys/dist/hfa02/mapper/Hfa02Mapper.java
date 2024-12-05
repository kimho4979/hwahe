package com.fpdisys.dist.hfa02.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.hfa02.domain.Hfa02VO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("hfa02Mapper")
public interface Hfa02Mapper {

	List<Hfa02VO> selectHfa02(Map<String, Object> pRequestParamMap);
	
	int insertNotice (Map<String, Object> pReqParamMap);
	
	int insertNoticeFile(Map<String, Object> pRequestParamMap);
	
	int updateNotice(Map<String, Object> pReqParamMap);
	
	int updateNoticeFile(Map<String, Object> pRequestParamMap);

	int deleteNotice(Map<String, Object> pRequestParamMap);
	
	int deleteNoticeFile(Map<String, Object> pRequestParamMap);

}
