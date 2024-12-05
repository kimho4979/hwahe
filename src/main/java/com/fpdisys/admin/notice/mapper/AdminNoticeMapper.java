package com.fpdisys.admin.notice.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.admin.notice.domain.AdminNoticeFileVO;
import com.fpdisys.admin.notice.domain.AdminNoticeVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("adminNoticeMapper")
public interface  AdminNoticeMapper {
	
	List<?> selectAdminNoticeAll(Map<String, Object> pRequestParamMap);
	
	List<?> selectAdminNoticeSearch(Map<String, Object> pRequestParamMap);
	
	List<?> selectAdminNoticeSearchPageAble(Map<String, Object> pRequestParamMap);
	
	List<?> selectAdminNoticeFileSearch(Map<String, Object> pRequestParamMap);
	
	AdminNoticeVO findNoticeOne(Map<String, Object> pRequestParamMap);
	
	AdminNoticeFileVO findNoticeFileOne(Map<String, Object> pRequestParamMap);
	
	void insertAdminNotice(Map<String, Object> pRequestParamMap);
	
	void updateAdminNotice(Map<String, Object> pRequestParamMap);

	void insertNoticePopup(Map<String, Object> pRequestParamMap);

	void deleteAdminNotice(Map<String, Object> pRequestParamMap);

}
