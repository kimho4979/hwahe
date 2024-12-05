package com.fpdisys.dist.customInfo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.customInfo.domain.CustomInfoSnsVO;
import com.fpdisys.dist.customInfo.domain.CustomInfoVO;
import com.fpdisys.dist.customInfo.mapper.CustomInfoMapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class CustomInfoService extends BaseService {
	
	@Autowired
	CustomInfoMapper customInfoMapper;
	
	public int saveUser(Map<String, Object> pRequestParamMap){
		//1. 사용자 정보 insert
		int result1 = customInfoMapper.saveCustomInfo(pRequestParamMap);
		
		pRequestParamMap.put("report1Yn","N");
		pRequestParamMap.put("report2Yn","N");
		pRequestParamMap.put("saleYn","N");
		pRequestParamMap.put("realYn","N");
		int result2 = 	customInfoMapper.saveCustomInfoDtl(pRequestParamMap);
		
		return result1;
		
	}
	
	@Transactional
	public int saveCustomInfo(Map<String, Object> pRequestParamMap){
		
		String[] arrLoc = ((String) pRequestParamMap.get("arrLoc")).split(",");
		String[] arrFlowerCd = ((String) pRequestParamMap.get("arrFlowerCd")).split(",");
		String[] arrItemCd = ((String) pRequestParamMap.get("arrItemCd")).split(",");
		String[] arrItemCd1 = ((String) pRequestParamMap.get("arrItemCd1")).split(",");
		System.out.println("ssssssssss + " + pRequestParamMap.toString() );
		int result = 0;
		
		//1. 사용자 정보 insert
		int result1 = customInfoMapper.saveCustomInfo(pRequestParamMap);
				
		//	2. 사용자 상세정보 insert
		int result2 = 	customInfoMapper.saveCustomInfoDtl(pRequestParamMap);
		
		int result3=0;
		for(int i =0; i<arrLoc.length; i++){
		//	3. 사용자 실시간 정보 insert
			Map<String, Object> arrMap = new HashMap<String, Object>();
			arrMap.put("sidoCd", arrLoc[i]);
			//arrMap.put("arrFlowerCd", arrFlowerCd[i]);
			arrMap.put("itemCd", arrItemCd[i]);
			arrMap.put("itemCd1", arrItemCd1[i]);
			arrMap.put("flowerCd", arrFlowerCd[i]);
			arrMap.put("userId", pRequestParamMap.get("userId"));
			
			//customInfoMapper.deleteCustomInfoReal(userId);
			result3 = customInfoMapper.saveCustomInfoReal(arrMap);
		}
		result = result1+result2+result3;
		
		return result;
		
	}
	
	@Transactional
	public int updateCustomInfo(Map<String, Object> pRequestParamMap){
		
		String[] arrLoc = ((String) pRequestParamMap.get("arrLoc")).split(",");
		String[] arrFlowerCd = ((String) pRequestParamMap.get("arrFlowerCd")).split(",");
		String[] arrItemCd = ((String) pRequestParamMap.get("arrItemCd")).split(",");
		String[] arrItemCd1 = ((String) pRequestParamMap.get("arrItemCd1")).split(",");
		String userId = (String)pRequestParamMap.get("userId");
		int result = 0;
		
		//1. 사용자 정보 insert
		//int result1 = customInfoMapper.saveCustomInfo(pRequestParamMap);
				
		//	2. 사용자 상세정보 insert
		int result2 = 	customInfoMapper.updateCustomInfoDtl(pRequestParamMap);
		
		customInfoMapper.deleteCustomInfoReal(userId);
		
		for(int i =0; i<arrLoc.length; i++){
		//	3. 사용자 실시간 정보 insert
			Map<String, Object> arrMap = new HashMap<String, Object>();
			arrMap.put("sidoCd", arrLoc[i]);
			//arrMap.put("arrFlowerCd", arrFlowerCd[i]);
			arrMap.put("itemCd", arrItemCd[i]);
			arrMap.put("itemCd1", arrItemCd1[i]);
			arrMap.put("flowerCd", arrFlowerCd[i]);
			arrMap.put("userId", pRequestParamMap.get("userId"));
			
			int result3 = customInfoMapper.saveCustomInfoReal(arrMap);
		}
		
		return result;
		
	}

	public int updateCustomInfoReal(Map<String, Object> pRequestParamMap){
		return customInfoMapper.updateCustomInfoReal(pRequestParamMap);		
	}
	
	public CustomInfoVO getCustomInfo(Map<String, Object> pRequestParamMap){
		return customInfoMapper.getCustomInfo(pRequestParamMap);		
	}
	
	/**
	 * 맞춤정보-스케쥴러 가격정보 알림 목록
	 * @param pRequestParamMap
	 * @return List<CustomInfoVO>
	 */
	public List<CustomInfoSnsVO> getSnsList(Map<String, Object> pRequestParamMap) {
		return customInfoMapper.getSnsList(pRequestParamMap);
	}

	/**
	 * 인증메일 전송
	 * @param pRequestParamMap
	 * @return List<CustomInfoVO>
	 */
	public int sendMail(Map<String, Object> pRequestParamMap) {
		return customInfoMapper.sendMail(pRequestParamMap);
		/*boolean result = false;
		
		String email = (String) pRequestParamMap.get("userId");
		
		Properties props = new Properties();
		// at서버
		props.setProperty("mail.transport.protocol", "smtp");
		props.setProperty("mail.host", "210.103.25.88");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", "25");
		props.setProperty("mail.smtp.quitwait", "false");
		// google 메일 서버
		props.setProperty("mail.host", "smtp.gmail.com");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", "587");
		props.put("mail.smtp.starttls.enable", "true");
		
		Authenticator auth = new EmailAuthentication();
		
		//session 생성 및  MimeMessage생성
		Session session = Session.getDefaultInstance(props, auth);
		MimeMessage msg = new MimeMessage(session);
				
		try{
		//편지보낸시간
		msg.setSentDate(new Date());
		InternetAddress from = new InternetAddress();		
		from = new InternetAddress("noreply@at.or.kr");
		// 이메일 발신자
		msg.setFrom(from);		 
		
		// 이메일 수신자
		InternetAddress to = new InternetAddress(email);
		//InternetAddress to = new InternetAddress("symin89@naver.com");
		msg.setRecipient(Message.RecipientType.TO, to);
		 
		// 이메일 제목
		msg.setSubject(pRequestParamMap.get("title").toString(), "UTF-8");
		 
		// 이메일 내용
		msg.setText(pRequestParamMap.get("subject").toString(), "UTF-8");
		 
		// 이메일 헤더
		msg.setHeader("content-Type", "text/html");
		 
		//메일보내기
		javax.mail.Transport.send(msg);

		result = true; 
		
		}catch (AddressException addr_e) {
			addr_e.printStackTrace();
		}catch (MessagingException msg_e) {
			msg_e.printStackTrace();
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;*/
	}	
	/**
	 * 인증번호 휴대폰 전송
	 * @param pRequestParamMap
	 * @return List<CustomInfoVO>
	 */
	public int sendKakao(Map<String, Object> pRequestParamMap) {
		return customInfoMapper.sendKakao(pRequestParamMap);
	}
	/**
	 * 품목병 가져오기
	 * @param pRequestParamMap
	 * @return List<CustomInfoVO>
	 */
	public List<String> getPumName(Map<String, Object> pRequestParamMap) {
		return customInfoMapper.getPumName(pRequestParamMap);
	}
	
	/**
	 * 품종병 가져오기
	 * @param pRequestParamMap
	 * @return List<CustomInfoVO>
	 */
	public List<String> getGoodName(Map<String, Object> pRequestParamMap) {
		return customInfoMapper.getGoodName(pRequestParamMap);
	}
 
	public CustomInfoVO loginCustomInfo(Map<String, Object> pRequestParamMap) {
		return customInfoMapper.loginCustomInfo(pRequestParamMap);
	}
	
	public List<CustomInfoVO> getCustomInfoMs(Map<String, Object> pRequestParamMap) {
		return customInfoMapper.getCustomInfoMs(pRequestParamMap);
	}

	public List<CustomInfoVO> getCustomInfoList(
			Map<String, Object> pRequestParamMap) {
		return customInfoMapper.getCustomInfoList(pRequestParamMap);		
	}

	public void updateCustomInfoPw(Map<String, Object> pRequestParamMap) {
		customInfoMapper.updateCustomInfoPw(pRequestParamMap);
		
	}

	public void insertAuthCode(Map<String, Object> pRequestParamMap) {
		customInfoMapper.insertAuthCode(pRequestParamMap);
		
	}

	public void deleteAuthCode(Map<String, Object> pRequestParamMap) {
		customInfoMapper.deleteAuthCode(pRequestParamMap);		
	}

	public int compareAuthCode(Map<String, Object> pRequestParamMap) {
		return customInfoMapper.compareAuthCode(pRequestParamMap);
	}

	public EgovMap getUserSearch(Map<String, Object> pRequestParamMap) {
		return customInfoMapper.getUserSearch(pRequestParamMap);
	}

	public int insertUserSearch(Map<String, Object> pRequestParamMap) {
		return customInfoMapper.insertUserSearch(pRequestParamMap);
	}

	public int updateUserSearch(Map<String, Object> pRequestParamMap) {
		return customInfoMapper.updateUserSearch(pRequestParamMap);
	}

	public List<EgovMap> selectMainSet(Map<String, Object> pRequestParamMap) {
		return customInfoMapper.selectMainSet(pRequestParamMap);
	}
	
	public int insertMainSet(Map<String, Object> pRequestParamMap) {
		return customInfoMapper.insertMainSet(pRequestParamMap);
	}

	public int deleteMainSet(Map<String, Object> pRequestParamMap) {
		return customInfoMapper.deleteMainSet(pRequestParamMap);
	}
	
	public void leaveMember(Map<String, Object> pRequestParamMap) {
		String userId = (String)pRequestParamMap.get("userId");
		
		// 1. 실시간 발송정보 삭제
		customInfoMapper.deleteCustomInfoReal(userId);
		
		// 2. 사용자 기본 설정정보 삭제
		customInfoMapper.deleteCustomInfoDtl(pRequestParamMap);
		
		// 3. 사용자 검색 설정정보 삭제
		customInfoMapper.deleteUserSearch(pRequestParamMap);
		
		// 4. main 설정정보 삭제
		customInfoMapper.deleteMainSet(pRequestParamMap);
		
		// 5. 즐겨찾기 삭제
		customInfoMapper.deleteFavor(pRequestParamMap);
		
		// 5. 사용자 삭제
		customInfoMapper.deleteCustomInfo(pRequestParamMap);
	}
	
	public List<EgovMap> getFavoriteList(String userId) {
		return customInfoMapper.getFavoriteList(userId);
	}

	public void insertFavor(Map<String, Object> pRequestParamMap) {
		customInfoMapper.insertFavor(pRequestParamMap);
		
	}
	public int selectFavor(Map<String, Object> pRequestParamMap) {
		return customInfoMapper.selectFavor(pRequestParamMap);
	}

	public void deleteFavor(Map<String, Object> pRequestParamMap) {
		customInfoMapper.deleteFavor(pRequestParamMap);
	}

	public List<EgovMap> selectMenuList() {
		return customInfoMapper.selectMenuList();
	}
}
