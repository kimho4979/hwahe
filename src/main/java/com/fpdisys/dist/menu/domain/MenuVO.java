package com.fpdisys.dist.menu.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import lombok.Getter;
import lombok.Setter;


/**
 * MenuVO
 * @Class Name MenuVO.java
 * @Description
 * @author syoh
 * @since 2020. 5. 6.
 * @version 1.0
 */

public class MenuVO implements Serializable {
	private static final long serialVersionUID = 1L;

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
	
	private String protocol;
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public void setChildren(List<MenuVO> children) {
		this.children = children;
	}

	/**
	 * 하위 메뉴 개수
	 * @return
	 */
	public final int getChildrenCount(){
		return ( children != null ) ? children.size() : 0;
	}

	/**
	 * 하위 메뉴 존재 여부
	 * @see #getChildrenCount()
	 * @return
	 */
	public final boolean hasChildren(){
		return ( children != null ) ? !children.isEmpty() : false;
	}

	/**
	 * 하위 메뉴 추가
	 * @param bean
	 */
	public void addChild(MenuVO bean){
		if(bean == null){
			return ;
		}

		if( children == null ){
			children = new ArrayList<MenuVO>();
		}

		if(children.contains(bean)){
			children.remove(bean);
		}

		children.add(bean);
	}

	/**
	 * 지정 index 해당 메뉴 DTO 객체 리턴
	 * @param index
	 * @return
	 */
	public MenuVO getChildAt(int index){
		return ( children != null ) ? (MenuVO)children.get(index) : null;
	}

	/**
	 * 하위 메뉴 목록 객체 리턴
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MenuVO> getChildren(){
		return ( children != null ) ? Collections.unmodifiableList(children) :  Collections.EMPTY_LIST;
	}

	/**
	 * menuId (CATEGORY_CODE)가 같은 MenuVO 객체는 같다고 본다.
	 */
	public boolean equals(Object obj) {
		if(obj == null){
			return false;
		} else if(obj == this){
			return true;
		}

		if(this.menuId == null ){
			return false;
		}

		if(obj instanceof MenuVO){
			return this.menuId.equals(((MenuVO)obj).menuId);
		} else {
			return false;
		}
	}

	/**
	 * Hash Code Return
	 */
	public int hashCode() {
		if(this.menuId != null ){
			return menuId.hashCode();
		}
		return super.hashCode();
	}
	
	/** BasePath 설정 */
	public void setBasePath(String basePath) {
		this.basePath = basePath;
	}

	/** basePath 값 반환 */
	public String getBasePath() {
		if(this.url == null) return null;
		if(this.basePath == null) {
			this.basePath = this.url.substring(0, this.url.lastIndexOf("/") + 1);
		}
		return basePath;
	}
	/** executePath 설정 */
	public void setExecutePath(String executePath) {
		this.executePath = executePath;
	}
	
	/** executePath 값 반환 */
	public String getExecutePath() {
		if(this.url == null) return null;
		if(this.executePath == null) {
			this.executePath = this.url.substring(this.url.lastIndexOf("/"));
		}
		return executePath;
	}

	/** menuId 값 반환 */
	public String getMenuId() {
		return menuId;
	}

	/** menuId 설정 */
	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}

	/** menuNm 값 반환 */
	public String getMenuNm() {
		return menuNm;
	}

	/** menuNm 설정 */
	public void setMenuNm(String menuNm) {
		this.menuNm = menuNm;
	}

	/** url 값 반환 */
	public String getUrl() {
		return url;
	}

	/** url 설정 */
	public void setUrl(String url) {
		this.url = url;
	}

	/** upperId 값 반환 */
	public String getUpperId() {
		return upperId;
	}

	/** upperId 설정 */
	public void setUpperId(String upperId) {
		this.upperId = upperId;
	}

	/** upperName 값 반환 */
	public String getUpperName() {
		return upperName;
	}

	/** upperName 설정 */
	public void setUpperName(String upperName) {
		this.upperName = upperName;
	}

	/** depth 값 반환 */
	public Integer getDepth() {
		return depth;
	}

	/** depth 설정 */
	public void setDepth(Integer depth) {
		this.depth = depth;
	}

	/** orders 값 반환 */
	public Integer getOrders() {
		return orders;
	}

	/** orders 설정 */
	public void setOrders(Integer orders) {
		this.orders = orders;
	}

	/** positionBit 값 반환 */
	public Integer getPositionBit() {
		return positionBit;
	}

	/** positionBit 설정 */
	public void setPositionBit(Integer positionBit) {
		this.positionBit = positionBit;
	}

	/** positionBitArr 값 반환 */
	public String[] getPositionBitArr() {
		return positionBitArr;
	}

	/** positionBitArr 설정 */
	public void setPositionBitArr(String[] positionBitArr) {
		this.positionBitArr = positionBitArr;
	}

	/** positionBitTxt 값 반환 */
	public String getPositionBitTxt() {
		return positionBitTxt;
	}

	/** positionBitTxt 설정 */
	public void setPositionBitTxt(String positionBitTxt) {
		this.positionBitTxt = positionBitTxt;
	}

	/** pathId 값 반환 */
	public String getPathId() {
		return pathId;
	}

	/** pathId 설정 */
	public void setPathId(String pathId) {
		this.pathId = pathId;
	}

	/** pathNm 값 반환 */
	public String getPathNm() {
		return pathNm;
	}

	/** pathNm 설정 */
	public void setPathNm(String pathNm) {
		this.pathNm = pathNm;
	}

	/** description 값 반환 */
	public String getDescription() {
		return description;
	}

	/** description 설정 */
	public void setDescription(String description) {
		this.description = description;
	}

	/** displayBit 값 반환 */
	public Long getDisplayBit() {
		return displayBit;
	}

	/** displayBit 설정 */
	public void setDisplayBit(Long displayBit) {
		this.displayBit = displayBit;
	}

	/** displayBitArr 값 반환 */
	public String[] getDisplayBitArr() {
		return displayBitArr;
	}

	/** displayBitArr 설정 */
	public void setDisplayBitArr(String[] displayBitArr) {
		this.displayBitArr = displayBitArr;
	}

	/** displayBitTxt 값 반환 */
	public String getDisplayBitTxt() {
		return displayBitTxt;
	}

	/** displayBitTxt 설정 */
	public void setDisplayBitTxt(String displayBitTxt) {
		this.displayBitTxt = displayBitTxt;
	}

	/** accessBit 값 반환 */
	public Long getAccessBit() {
		return accessBit;
	}

	/** accessBit 설정 */
	public void setAccessBit(Long accessBit) {
		this.accessBit = accessBit;
	}

	/** accessBitArr 값 반환 */
	public String[] getAccessBitArr() {
		return accessBitArr;
	}

	/** accessBitArr 설정 */
	public void setAccessBitArr(String[] accessBitArr) {
		this.accessBitArr = accessBitArr;
	}

	/** accessBitTxt 값 반환 */
	public String getAccessBitTxt() {
		return accessBitTxt;
	}

	/** accessBitTxt 설정 */
	public void setAccessBitTxt(String accessBitTxt) {
		this.accessBitTxt = accessBitTxt;
	}

	/** type 값 반환 */
	public String getType() {
		return type;
	}

	/** type 설정 */
	public void setType(String type) {
		this.type = type;
	}

	/** programId 값 반환 */
	public String getProgramId() {
		return programId;
	}

	/** programId 설정 */
	public void setProgramId(String programId) {
		this.programId = programId;
	}

	/** programNm 값 반환 */
	public String getProgramNm() {
		return programNm;
	}

	/** programNm 설정 */
	public void setProgramNm(String programNm) {
		this.programNm = programNm;
	}

	public String getProgramUpperNm() {
		return programUpperNm;
	}

	public void setProgramUpperNm(String programUpperNm) {
		this.programUpperNm = programUpperNm;
	}

	/** targetId 값 반환 */
	public String getTargetId() {
		return targetId;
	}

	/** targetId 설정 */
	public void setTargetId(String targetId) {
		this.targetId = targetId;
	}

	/** targetNm 값 반환 */
	public String getTargetNm() {
		return targetNm;
	}

	/** targetNm 설정 */
	public void setTargetNm(String targetNm) {
		this.targetNm = targetNm;
	}

	/** hrefTarget 값 반환 */
	public String getHrefTarget() {
		return hrefTarget;
	}

	/** hrefTarget 설정 */
	public void setHrefTarget(String hrefTarget) {
		this.hrefTarget = hrefTarget;
	}

	public Long getGroupId() {
		return groupId;
	}

	public void setGroupId(Long groupId) {
		this.groupId = groupId;
	}

	public String getGroupNm() {
		return groupNm;
	}

	public void setGroupNm(String groupNm) {
		this.groupNm = groupNm;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getRegUserId() {
		return regUserId;
	}

	public void setRegUserId(String regUserId) {
		this.regUserId = regUserId;
	}

	public String getRegIp() {
		return regIp;
	}

	public void setRegIp(String regIp) {
		this.regIp = regIp;
	}

	public String getMenuCd() {
		return menuCd;
	}

	public void setMenuCd(String menuCd) {
		this.menuCd = menuCd;
	}

	public String getProtocol() {
		return protocol;
	}

	public void setProtocol(String protocol) {
		this.protocol = protocol;
	}

	
}
