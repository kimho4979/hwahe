package com.fpdisys.base.mvc;

import java.io.Serializable;
import java.lang.reflect.Field;
import java.util.Date;

import org.apache.commons.lang.builder.ToStringBuilder;

public class BaseVo implements Serializable {


	/**
	 * serialVersion UID
	 */
	private static final long serialVersionUID = -7368272039902431437L;
	
	public void print() {
		for (Field field : this.getClass().getDeclaredFields()) {
			field.setAccessible(true);
			try {
				Object value = field.get(this);
				if (value != null) {
					value = value;  // code inspection 용
//					System.out.println(field.getName() + "=" + value);
				}
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			}	 
		}
	}
	

	/** 검색조건 */
	private String searchCondition = "";

	/** 검색Keyword */
	private String searchKeyword = "";

	/** 검색사용여부 */
	private String searchUseYn = "";

	/** 현재페이지 */
	private int pageIndex = 1;

	/** 페이지갯수 */
	private int pageUnit = 10;

	/** 페이지사이즈 */
	private int pageSize = 10;

	/** firstIndex */
	private int firstIndex = 1;

	/** lastIndex */
	private int lastIndex = 1;

	/** recordCountPerPage */
	private int recordCountPerPage = 10;

	/** login usr_id */
	private String sessionUserId = "";
	
	/** login usr_name */
	private String sessionUserName = "";


	/** select total count */
	private String totalCount = "";

	/** user maskingt */
	private String sessionUserMasking = "";
	
	/** user orgn_id */
	private String sessionUserOrgnId = "";
	
	/** user orgn_nm */
	private String sessionUserOrgnNm = "";
	
	/** MENU ID */
	private String sessionMenuId = "";


	/** MNGR_RULE*/
	private String sessionUserMngrRule = "";
	
	
	private Date insDt;
	
	private Date uptDt;
	
	private  String insId;
	
	private String insUserNm;
	
	private String uptId;
	
	private String uptUserNm;
	

	public String getSessionUserMngrRule() {
		return sessionUserMngrRule;
	}

	public void setSessionUserMngrRule(String sessionUserMngrRule) {
		this.sessionUserMngrRule = sessionUserMngrRule;
	}

	public String getSessionMenuId() {
		return sessionMenuId;
	}

	public void setSessionMenuId(String sessionMenuId) {
		this.sessionMenuId = sessionMenuId;
	}

	public String getSessionUserOrgnId() {
		return sessionUserOrgnId;
	}

	public void setSessionUserOrgnId(String sessionUserOrgnId) {
		this.sessionUserOrgnId = sessionUserOrgnId;
	}

	public String getSessionUserOrgnNm() {
		return sessionUserOrgnNm;
	}
	
	public void setSessionUserOrgnNm(String sessionUserOrgnNm) {
		this.sessionUserOrgnNm = sessionUserOrgnNm;
	}

	
	
	/** user orgn_type_cd */
	private String sessionUserOrgnTypeCd = "";

	public String getSessionUserOrgnTypeCd() {
		return sessionUserOrgnTypeCd;
	}

	public void setSessionUserOrgnTypeCd(String sessionUserOrgnTypeCd) {
		this.sessionUserOrgnTypeCd = sessionUserOrgnTypeCd;
	}
	
	
	/** user orgn_type_cd */
	private String sessionUserOrgnLvlCd = "";
	
	
	public String getSessionUserOrgnLvlCd() {
		return sessionUserOrgnLvlCd;
	}

	public void setSessionUserOrgnLvlCd(String sessionUserOrgnLvlCd) {
		this.sessionUserOrgnLvlCd = sessionUserOrgnLvlCd;
	}
	

	/** user orgn_type_cd */
	private String sessionUserLogisCnterYn = "";

	public String getSessionUserLogisCnterYn() {
		return sessionUserLogisCnterYn;
	}

	public void setSessionUserLogisCnterYn(String sessionUserLogisCnterYn) {
		this.sessionUserLogisCnterYn = sessionUserLogisCnterYn;
	}



	public String getSessionUserMasking() {
		return sessionUserMasking;
	}

	public void setSessionUserMasking(String sessionUserMasking) {
		this.sessionUserMasking = sessionUserMasking;
	}
	
	/** user maskingt */
	private String sessionUserMskAuthYn = "";
	

	public String getSessionUserMskAuthYn() {
		return sessionUserMskAuthYn;
	}

	public void setSessionUserMskAuthYn(String sessionUserMskAuthYn) {
		this.sessionUserMskAuthYn = sessionUserMskAuthYn;
	}
	

	public int getFirstIndex() {
		return firstIndex;
	}

	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}

	public int getLastIndex() {
		return lastIndex;
	}

	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}

	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}

	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}

	public String getSearchCondition() {
		return searchCondition;
	}

	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}

	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

	public String getSearchUseYn() {
		return searchUseYn;
	}

	public void setSearchUseYn(String searchUseYn) {
		this.searchUseYn = searchUseYn;
	}

	public int getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}

	public int getPageUnit() {
		return pageUnit;
	}

	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	

	public String getSessionUserId() {
		return sessionUserId;
	}

	public void setSessionUserId(String sessionUserId) {
		this.sessionUserId = sessionUserId;
	}

	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	

	public String getSessionUserName() {
		return sessionUserName;
	}

	public void setSessionUserName(String sessionUserName) {
		this.sessionUserName = sessionUserName;
	}
	


	public String getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(String totalCount) {
		this.totalCount = totalCount;
	}

	public Date getInsDt() {
		return insDt;
	}

	public void setInsDt(Date insDt) {
		this.insDt = insDt;
	}

	public Date getUptDt() {
		return uptDt;
	}

	public void setUptDt(Date uptDt) {
		this.uptDt = uptDt;
	}

	public String getInsUserNm() {
		return insUserNm;
	}

	public void setInsUserNm(String insUserNm) {
		this.insUserNm = insUserNm;
	}
	
	public String getUptUserNm() {
		return uptUserNm;
	}

	public void setUptUserNm(String uptUserNm) {
		this.uptUserNm = uptUserNm;
	}

	public String getInsId() {
		return insId;
	}

	public void setInsId(String insId) {
		this.insId = insId;
	}

	public String getUptId() {
		return uptId;
	}

	public void setUptId(String uptId) {
		this.uptId = uptId;
	}
	
	
	
}