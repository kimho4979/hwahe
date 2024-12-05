package com.fpditrans.trans.login.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

import com.fpditrans.base.mvc.BaseVo;

/**
 * @Class Name : UserVO.java
 * @Description : UserVO Class
 *	 
 * @  회원정보  도메인 클래스 
 * @  수정일	  수정자			  수정내용
 * @ ---------	---------	-------------------------------
 * @ 2016.08.03			최초생성
 *
 * @author 우림인포텍
 * @version 1.0
 * @see
 * 
 * Copyright (C) by woorim All right reserved.
 */
@Setter
@Getter
public class UserVO extends BaseVo{
	
	private static final long serialVersionUID = 1L;
	
	/** 유저아이디 */
	private String userId;
	
	/** 유저명 */
	private String username;
	
	/** 법인코드 */
	private String compCode;
	
	/**  법인명*/
	private String compName;
	
	
	/** 패스워드 */ 
	private String userPasswd;
	
	/** 이메일 */
	private String email; 
	/** 유저구분 */
	private String userType;
	/** 마지막 로그인 일시 */
	private Date  lastLoginDate;
	
	/** 패스워드 최종 수정일 */
	private Date passwdUpdateDate;
	
	/** 비고 */
	private String remark;
	
	/** 사용여부 */
	private String useYn;
	
	/** 패스워드 틀린횟수 */
	private int passErrNum;
	
	/** 등록일시 */
	private Date insDt;
	
	/** 등록자아이디 */
	private String insId;
	
	/** 수정일시 */
	private Date uptDt;
	
	/** 수정자아이디 */
	private String uptId;
	

	

}
