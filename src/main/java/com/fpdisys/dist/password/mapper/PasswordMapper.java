package com.fpdisys.dist.password.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.password.domain.PasswordVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("passwordMapper")
public interface PasswordMapper {

	List<PasswordVO> passwordMailInfo(Map<String, Object> pRequestParamMap);
	
	int updatePasswordInitYn(String userId);
	
	int updateChangePassword(Map<String, Object> pRequestParamMap);

}
