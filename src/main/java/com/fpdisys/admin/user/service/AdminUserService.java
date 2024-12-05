package com.fpdisys.admin.user.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.admin.user.domain.AdminUserVO;
import com.fpdisys.admin.user.mapper.AdminUserMapper;
import com.fpdisys.base.mvc.BaseService;

@Service
public class AdminUserService extends BaseService {
	

	@Autowired
	private AdminUserMapper adminUserMapper;
	
	public List<?> selectAdminUserAll(Map<String, Object> pRequestParamMap){
		return adminUserMapper.selectAdminUserAll(pRequestParamMap);
	}
		
	public List<?> selectAdminUserSearch(Map<String, Object> pRequestParamMap){
		return adminUserMapper.selectAdminUserSearch(pRequestParamMap);
	}
		
	public List<?> selectAdminUserSearchPageAble(Map<String, Object> pRequestParamMap){
		return adminUserMapper.selectAdminUserSearchPageAble(pRequestParamMap);
	}
		
	public AdminUserVO selectAdminUserSearchOne(Map<String, Object> pRequestParamMap){
		return adminUserMapper.selectAdminUserSearchOne(pRequestParamMap);
	}
	
	public int selectCntAdminSanCd(Map<String, Object> pRequestParamMap){
		return adminUserMapper.selectCntAdminSanCd(pRequestParamMap);
	}
		
	public int insertAdminUser(Map<String, Object> pRequestParamMap){
	  return adminUserMapper.insertAdminUser(pRequestParamMap);	
	}
		
	public int updateAdminUser(Map<String, Object> pRequestParamMap){
		return adminUserMapper.updateAdminUser(pRequestParamMap);
	}
		
	public int getMargeAdminUser(Map<String, Object> pRequestParamMap){
		return adminUserMapper.getMargeAdminUser(pRequestParamMap);
	}
	
	public String saveInsertUserProc(Map<String, Object> pRequestParamMap){
		String msg ="등록되었습니다.";
		
		this.insertAdminUser(pRequestParamMap);
		
		this.insertAdminUserAuth(pRequestParamMap);
		
		
		
		
		
		return msg;
	}
		
	public List<?> selectAdminGrpAuth(Map<String, Object> pRequestParamMap){
		return adminUserMapper.selectAdminGrpAuth(pRequestParamMap);
	}
		
	public int insertAdminUserAuth(Map<String, Object> pRequestParamMap){
		return adminUserMapper.insertAdminUserAuth(pRequestParamMap);
	}
		
	public int updateAdminUserAuth(Map<String, Object> pRequestParamMap){
		return adminUserMapper.updateAdminUserAuth(pRequestParamMap);	
	}
		
	public int getMargeAdminUserAuth(Map<String, Object> pRequestParamMap){
		return adminUserMapper.getMargeAdminUserAuth(pRequestParamMap);	
	}
	
	public int selectAdminUserDuplicated(Map<String, Object> pRequestParamMap){
		return adminUserMapper.selectAdminUserDuplicated(pRequestParamMap);
	}
	public String checkedUserId(Map<String, Object> pRequestParamMap){
		
		 String msg = "사용하셔도 되는 아이디입니다.";
		 int iCnt = this.selectAdminUserDuplicated(pRequestParamMap);
		 if(iCnt>0){
			 msg = "중복된아이디입니다. 다른아이디를 선택하세요";
		 }
		 
		
		return msg;
	}
	
	public List<?> selectAdminUserSanCd(Map<String, Object> pRequestParamMap){
		return adminUserMapper.selectAdminUserSanCd(pRequestParamMap);
	}
	
	public List<?> selectAdminSanCdPageAble(Map<String, Object> pRequestParamMap){
		return adminUserMapper.selectAdminSanCdPageAble(pRequestParamMap);
	}
	public String saveUpdateUserProc(Map<String, Object> pRequestParamMap){
		String msg ="수정되었습니다.";
		 
		this.updateAdminUser(pRequestParamMap);
		
		this.updateAdminUserAuth(pRequestParamMap);
		
		return msg;
	}

}
