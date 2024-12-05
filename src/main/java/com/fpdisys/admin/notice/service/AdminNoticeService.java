package com.fpdisys.admin.notice.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.admin.notice.domain.AdminNoticeFileVO;
import com.fpdisys.admin.notice.domain.AdminNoticeVO;
import com.fpdisys.admin.notice.mapper.AdminNoticeMapper;
import com.fpdisys.base.mvc.BaseService;

@Service
public class AdminNoticeService extends BaseService{
	
	@Autowired
	AdminNoticeMapper adminNoticeMapper;
	
	
	
	
	
	/**
	 * 전체 리스트출력
	 * @param pRequestParamMap
	 * @return
	 */
	public List<?> selectAdminNoticeAll(Map<String, Object> pRequestParamMap){
		return adminNoticeMapper.selectAdminNoticeAll(pRequestParamMap);
	}
	/**
	 * 조건 출력
	 * @param pRequestParamMap
	 * @return
	 */
	public List<?> selectAdminNoticeSearch(Map<String, Object> pRequestParamMap){
		return adminNoticeMapper.selectAdminNoticeSearch(pRequestParamMap);
	}
	
	/**
	 * 페이징 처리 
	 * @param pRequestParamMap
	 * @return
	 */
	public List<?> selectAdminNoticeSearchPageAble(Map<String, Object> pRequestParamMap){
		return adminNoticeMapper.selectAdminNoticeSearchPageAble(pRequestParamMap);
	}
	
	/**
	 * 첨부파일 목록
	 * @param pRequestParamMap
	 * @return
	 */
	public List<?> selectAdminNoticeFileSearch(Map<String, Object> pRequestParamMap){
		return adminNoticeMapper.selectAdminNoticeFileSearch(pRequestParamMap);
	}
	
	/**
	 * 공지사항보기 
	 * @param pRequestParamMap
	 * @return
	 */
	public AdminNoticeVO findNoticeOne(Map<String, Object> pRequestParamMap){
		return 	adminNoticeMapper.findNoticeOne(pRequestParamMap);
	}
	
	/**
	 * 첨부파일 호출
	 * @param pRequestParamMap
	 * @return
	 */
	public AdminNoticeFileVO findNoticeFileOne(Map<String, Object> pRequestParamMap){
		return adminNoticeMapper.findNoticeFileOne(pRequestParamMap);
	}

	public void insertAdminNotice(Map<String, Object> pRequestParamMap){
		adminNoticeMapper.insertAdminNotice(pRequestParamMap);
	}
	
	public void updateAdminNotice(Map<String, Object> pRequestParamMap){
		adminNoticeMapper.updateAdminNotice(pRequestParamMap);
	}
	public void deleteAdminNotice(Map<String, Object> pRequestParamMap) {
		adminNoticeMapper.deleteAdminNotice(pRequestParamMap);
		
	}

}
