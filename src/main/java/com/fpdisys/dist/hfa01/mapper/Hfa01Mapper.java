package com.fpdisys.dist.hfa01.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.hfa01.domain.Hfa01VO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("hfa01Mapper")
public interface Hfa01Mapper {

	List<Hfa01VO> selectHfa01(Map<String, Object> pRequestParamMap);
	
	List<Hfa01VO> selectMainGongi(Hfa01VO hfa01vo);
	
	Hfa01VO selectMainGongiSeq(String seq);
	
	int insertNotice (Map<String, Object> pReqParamMap);
	
	int insertNoticeFile(Map<String, Object> pRequestParamMap);
	
	int updateNotice(Map<String, Object> pReqParamMap);
	
	int updateNoticeFile(Map<String, Object> pRequestParamMap);

	int deleteNotice(Map<String, Object> pRequestParamMap);
	
	int deleteNoticeFile(Map<String, Object> pRequestParamMap);

	void updateNoticeClickCnt(Map<String, Object> pRequestParamMap);

}
