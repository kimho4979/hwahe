package com.fpdisys.module.recv.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.module.recv.domain.SchoolInfoMVO;
import com.fpdisys.module.recv.mapper.NeisMapper;
import com.fpdisys.module.recv.service.NeisService;
import egovframework.rte.fdl.property.EgovPropertyService;
import com.fpdisys.base.util.ConvertUtils;

@Controller
public class NeisController extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());

	@Autowired
	protected MessageSource messageSource;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Autowired
	private NeisService neisService;
	
	@Autowired
	NeisMapper neisMapper;
	// 인증키 (개인이 받아와야함)

	// 학사일정 INSERT
	@RequestMapping(value="/neis/getSchoolScheduleBatch.json", method=RequestMethod.POST)
	public ResponseEntity<List<Map<String, Object>>> getSchoolScheduleBatch(HttpServletRequest header, @RequestBody List<Map<String, Object>> PreEventList){
		try{
			neisService.insertSchoolScheduleBatch(PreEventList);
		} catch(Exception e){
			e.printStackTrace();
		}
		List<Map<String, Object>> yourDataList = null;
		return new ResponseEntity<>(yourDataList, HttpStatus.OK);
	}
	
	//프로시저 실행 적용
	@RequestMapping(value="/neis/getinsertSchInfoBatch.json", method=RequestMethod.POST)
	public ResponseEntity<List<Map<String, Object>>> getinsertSchInfoBatch(HttpServletRequest header, @RequestBody Map<String, Object> schInfoRegMap){
		try{
			neisMapper.insertSchInfo(schInfoRegMap);
		} catch(Exception e){
			e.printStackTrace();
		}
		List<Map<String, Object>> yourDataList = null;
		return new ResponseEntity<>(yourDataList, HttpStatus.OK);
	}
	
	// 학교정보 INSERT
	@RequestMapping(value="/neis/getinsertSchoolInfoBatch.json", method=RequestMethod.POST)
	public ResponseEntity<Integer> getinsertSchoolInfoBatch(HttpServletRequest header, @RequestBody List<SchoolInfoMVO> preSchoolMVOList){
		List<Map<String, Object>> yourDataList = null;
		Integer res = null;
		try {
			res = neisService.insertSchoolInfo(preSchoolMVOList);
		} catch (Exception e) {
			System.out.println("매핑컨틀롤러 ERROR");
			throw new RuntimeException(e);
		}
		return new ResponseEntity<Integer>(res, HttpStatus.OK);
	}
	
	// 존재하지 않는 졸업식  Delete
	@RequestMapping(value="/neis/deleteEventList.json", method=RequestMethod.POST)
	public ResponseEntity<List<Map<String, Object>>> deleteEventList(HttpServletRequest header, @RequestBody List<Map<String, Object>> preSchoolMVOList){
		try{
			for(Map<String, Object> schoolMap : preSchoolMVOList){
				neisService.deleteEventList(schoolMap);
			}
		} catch(Exception e){
			e.printStackTrace();
		}
		List<Map<String, Object>> yourDataList = null;
		return new ResponseEntity<>(yourDataList, HttpStatus.OK);
	}
}
