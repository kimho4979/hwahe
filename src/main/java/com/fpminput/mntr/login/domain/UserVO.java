package com.fpminput.mntr.login.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

import com.fpdisys.base.mvc.BaseVo;

@Setter
@Getter
public class UserVO extends BaseVo {

	private static final long serialVersionUID = 1L;
	
	/** 유저아이디 */
	private String userId;
	
	/** 유저명 */
	//private String username;
	
	/** 법인코드 */
	private String compCode;
	
	/**  법인명*/
	//private String compName;
		
	/** 패스워드 */ 
	private String userPasswd;
	
	/** 이메일 */
	private String email; 
	
	/** 유저구분 */
	private String userType;
	
	/** 모니터요원구분 */
	private String monitorType;
	
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
	
	/** 접근제한  플래그 */
	private String grpAuthCode;
	
	/** otp 등록 key */
	private String authKey;

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getCompCode() {
		return compCode;
	}

	public void setCompCode(String compCode) {
		this.compCode = compCode;
	}

	public String getUserPasswd() {
		return userPasswd;
	}

	public void setUserPasswd(String userPasswd) {
		this.userPasswd = userPasswd;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public String getMonitorType() {
		return monitorType;
	}

	public void setMonitorType(String monitorType) {
		this.monitorType = monitorType;
	}

	public Date getLastLoginDate() {
		return lastLoginDate;
	}

	public void setLastLoginDate(Date lastLoginDate) {
		this.lastLoginDate = lastLoginDate;
	}

	public Date getPasswdUpdateDate() {
		return passwdUpdateDate;
	}

	public void setPasswdUpdateDate(Date passwdUpdateDate) {
		this.passwdUpdateDate = passwdUpdateDate;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public int getPassErrNum() {
		return passErrNum;
	}

	public void setPassErrNum(int passErrNum) {
		this.passErrNum = passErrNum;
	}

	public Date getInsDt() {
		return insDt;
	}

	public void setInsDt(Date insDt) {
		this.insDt = insDt;
	}

	public String getInsId() {
		return insId;
	}

	public void setInsId(String insId) {
		this.insId = insId;
	}

	public Date getUptDt() {
		return uptDt;
	}

	public void setUptDt(Date uptDt) {
		this.uptDt = uptDt;
	}

	public String getUptId() {
		return uptId;
	}

	public void setUptId(String uptId) {
		this.uptId = uptId;
	}

	public String getGrpAuthCode() {
		return grpAuthCode;
	}

	public void setGrpAuthCode(String grpAuthCode) {
		this.grpAuthCode = grpAuthCode;
	}

	public String getAuthKey() {
		return authKey;
	}

	public void setAuthKey(String authKey) {
		this.authKey = authKey;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}
