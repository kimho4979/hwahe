package com.fpdisys.admin.notice.domain;

import com.fpdisys.base.mvc.BaseVo;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class AdminNoticeFileVO extends BaseVo {
	private static final long serialVersionUID = 3681993006264972608L;
	/**
	 * 파일일련번호
	 */
	private int fileSeq;
	
	/**
	 * 게시판 일련번호
	 */
	private int seq;
	
	/**
	 * 게시판구분
	 */
	private String bbsGubn;
	/**
	 * 원파일이름
	 */
	private String orginFileName;
	/**
	 * 저장파일이름
	 */
	private String storedFileName;
	/**
	 * 파일경로
	 */
	private String filePath;
	/**
	 * 파일사이즈
	 */
	private int fileSize;
	/**
	 * 파일확장자
	 */
	private String fileExt;
	
	private String regDt;
		
	  
	private String uptSDt;
}
