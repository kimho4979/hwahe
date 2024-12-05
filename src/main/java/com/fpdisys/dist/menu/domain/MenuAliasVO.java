package com.fpdisys.dist.menu.domain;

import java.io.Serializable;
import java.util.List;

import lombok.Getter;
import lombok.Setter;



/**
 * <pre>
 * wenbiz.core.menu.service
 * MenuAliasVO.java
 * </pre>
 * @author mskim
 * @description 메뉴 별칭 테이블 Beans
 * @since 2017. 6. 20.
 * @version 1.0
 */
@Getter
@Setter
public class MenuAliasVO implements Serializable {
	private static final long serialVersionUID = -2812389324848980416L;
	/** 별칭 ID */
	private Integer aliasId;

	/** 프로토콜 */
	private String protocol;

	/** 메뉴 ID */
	private String menuId;
	/** 메뉴명 */
	private String menuNm;
	/** URL */
	private String url;
	/** 상위 메뉴 ID */
	private String upperId;
	/** 상위 메뉴명 */
	private String upperName;
	/** 단계 */
	private Integer depth;
	/** 정렬순서 */
	private Integer orders;
	/** 출력 위치 설정값 */
	private Integer positionBit;
	/** 출력 위치 설정값 배열 */
	private String[] positionBitArr;
	/** 출력 위치 설정 내역 */
	private String positionBitTxt;
	/** 메뉴 ID 경로 */
	private String pathId;
	/** 메뉴명 경로 */
	private String pathNm;
	/** 메뉴 설명 */
	private String description;
	/** 출력여부 설정값 */
	private Long displayBit;
	/** 출력여부 설정값 배열 */
	private String[] displayBitArr;
	/** 출력여부 설정값 내역 */
	private String displayBitTxt;
	/** 접근권한 설정값 */
	private Long accessBit;
	/** 접근권한 설정값 배열 */
	private String[] accessBitArr;
	/** 접근권한 설정값 내역 */
	private String accessBitTxt;
	/** 접근권한 그룹 ID */
	private Long groupId;
	/** 접근권한 그룹명 */
	private String groupNm;
	/** 메뉴구분 */
	private String type;
	/** 프로그램ID */
	private String programId;
	/** 프로그램명 */
	private String programNm;
	/** 상위프로그램명 */
	private String programUpperNm;
	/** 대상ID */
	private String targetId;
	/** 대상명 */
	private String targetNm;
	/** 링크 Target 형식 */
	private String hrefTarget;

	/** 메뉴 기본 경로 */
	private String basePath;
	/** 메뉴 기본 마지막 경로 */
	private String executePath;
	
	/** 하위 메뉴 목록 객체 */
	private List<MenuVO> children;
	
	
	private String useYn;
	
	private String regDate;
	
	private String regUserId;
	
	private String regIp;
	
	private String menuCd;
	
}