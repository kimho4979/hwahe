/**
 * 
 */
package com.fpdisys.admin.faq.domain;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import com.fpdisys.base.mvc.BaseVo;


@Setter
@Getter
public class AdminBbsVO extends BaseVo {
	
	private static final long serialVersionUID = 3681993006264972606L;

	/**
	 * 일련번호
	 */
	private int seq;
	/**
	 * 게시판 구분
	 */
	private String bbsGubn;
	
	/**
	 * 제목
	 */
	private String title;
	/**
	 * 내용
	 */
	private String content;
	/**
	 * 표시여부
	 */
	private String dispYn;
	
	/**
	 * 법인코드
	 */
	private String compCode;
	
	/**
	 * 첨부파일 목록
	 */
	private List<AdminBbsFileVO> fileList;
	
	private String regDt;
	
 
	private String uptSDt;
}
