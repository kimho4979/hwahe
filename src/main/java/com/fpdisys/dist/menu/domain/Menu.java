package com.fpdisys.dist.menu.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;
import org.springframework.ldap.odm.annotations.Entry;

import com.fpdisys.base.mvc.BaseVo;
import com.fpdisys.dist.prog.domain.Program;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Alias("menu")
public class Menu  extends BaseVo {
	
		private String mnuCd;

	  
		private String mnuNm;

	  
		private String icon;

	  
		private Integer mnuLv;

		
		private Integer mnuIx;

		
		private String mnuUpCd;

		
		private String progCd;
		
		private String progNm;

	  		
		private Program program;
	  
		private String remark;

		
		private String useYn;
		
		private Date createdAt;
		
		private String createdBy;
		
		private Date modifiedAt;
		
		private String modifiedBy;
		
		
		private String menuNm;
		private String menuUrl;
		private Integer menuGubn;
		private Integer menuOrder;
		private String menuDetail;
		private Integer menuDepth;
		/** 메뉴 ID */
		private String menuId;
 
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
		 
		private String regDate;
		
		private String regUserId;
		
		private String regIp;
		
		private String menuCd;
		
}
