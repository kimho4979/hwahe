package com.fpdisys.module.recv.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.base.util.ConvertUtils;
import com.fpdisys.module.recv.domain.SchoolEventMVO;
import com.fpdisys.module.recv.domain.SchoolInfoMVO;
import com.fpdisys.module.recv.mapper.NeisMapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class NeisService extends BaseService {

	@Autowired
	NeisMapper neisMapper;

	protected Log log = LogFactory.getLog(this.getClass());

	
	public int insertSchoolInfo(List<SchoolInfoMVO> list) throws Exception {
		int cnt = 0;

		for ( SchoolInfoMVO school : list ) {
			try{
				cnt += neisMapper.insertSchoolInfo(school);
			} catch (ArithmeticException e) {
				log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
			} catch (NumberFormatException e) {
				log.error("오류발생 숫자로 변환 할 수 없습니다!!");
			} catch (ArrayIndexOutOfBoundsException e) {
				log.error("오류발생 배열인텍스에서 벗어났습니다!!");
			} catch (NegativeArraySizeException e) {
				log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
			} catch (NullPointerException e) {
				log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
			} catch (NoSuchMethodError e) {
				log.error("오류발생 메서드를 찾을수 없습니다!!");
			} catch (NoClassDefFoundError e) {
				log.error("오류발생 클래스를 찾을 수 없습니다!!");
			} catch (RuntimeException e) {
				log.error("오류발생 런타임!!");
				log.error(e.getMessage());
			} catch (Exception e) {
				log.error("오류발생!!");
			}
		}
		return cnt;
	}

	public int insertSchoolEventInfo(List<SchoolEventMVO> list) throws Exception {

		int cnt = 0;
		for ( SchoolEventMVO event : list ) {
			try{
				cnt += neisMapper.insertSchoolEventInfo(event);
			} catch (ArithmeticException e) {
				log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
			} catch (NumberFormatException e) {
				log.error("오류발생 숫자로 변환 할 수 없습니다!!");
			} catch (ArrayIndexOutOfBoundsException e) {
				log.error("오류발생 배열인텍스에서 벗어났습니다!!");
			} catch (NegativeArraySizeException e) {
				log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
			} catch (NullPointerException e) {
				log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
			} catch (NoSuchMethodError e) {
				log.error("오류발생 메서드를 찾을수 없습니다!!");
			} catch (NoClassDefFoundError e) {
				log.error("오류발생 클래스를 찾을 수 없습니다!!");
			} catch (RuntimeException e) {
				log.error("오류발생 런타임!!");
				log.error(e.getMessage());
			} catch (Exception e) {
				log.error("오류발생!!");
			}
		}
		return cnt;
	}


	public List<EgovMap> selectSchoolList(Map<String, Object> pReqParamMap){
		return neisMapper.selectSchoolList(pReqParamMap);
	}

	public void insertSchoolScheduleBatch(List<Map<String, Object>> PreEventList){
		try{
			List<SchoolEventMVO> eventList = new ArrayList<>();
	    	for(Map<String, Object> eventMap : PreEventList){
		    	SchoolEventMVO eventMVO = new SchoolEventMVO();
		    	eventMVO = ConvertUtils.convertToValueObject(eventMap, SchoolEventMVO.class);
		
		    	eventList.add(eventMVO);
	    	}
	    	insertSchoolEventInfo(eventList);
		} catch(Exception e){
			e.printStackTrace();
		}
	}
	public void deleteEventList(Map<String, Object> pReqParamMap){
		neisMapper.deleteEventList(pReqParamMap);
	}
}
