package com.fpdisys.dist.batch.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.dist.batch.service.BatchService;
import com.fpditrans.base.excel.read.ExcelRead;
import com.fpditrans.base.excel.read.ExcelReadOption;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class BatchController extends BaseController {

	protected Log log = LogFactory.getLog(this.getClass());	
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Autowired
	private BatchService batchService;
	
	/**
	 * 통합코드 초기생성 화면 - 엑셀업로드 화면
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/mig/setMapping.do")
	public String setMapping(ModelMap model) throws Exception {
		return "/batch/setMapping";
	}
	
	
	/**
	 * 통합코드 엑셀을 통한 등록
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/mig/setMappingProcess.do")
	public String setMappingProcess(MultipartHttpServletRequest request)  throws Exception{
		MultipartFile excelFile =request.getFile("excelFile");
		System.out.println("엑셀 파일 업로드 컨트롤러");
		if(excelFile==null || excelFile.isEmpty()){
			throw new RuntimeException("엑셀파일을 선택 해 주세요.");
		}
		
		File destFile = new File("D:\\"+excelFile.getOriginalFilename());
		try{
			excelFile.transferTo(destFile);
		}catch(IllegalStateException | IOException e){
			throw new RuntimeException(e.getMessage(),e);
		}
		
		//Service 단에서 가져온 코드 
		ExcelReadOption excelReadOption = new ExcelReadOption();
		excelReadOption.setFilePath(destFile.getAbsolutePath());
		excelReadOption.setOutputColumns("A","B","C","D","E","F","G","H","I");
		excelReadOption.setSheet(7);
		excelReadOption.setStartRow(2);
		
		
		List<Map<String, String>>excelContent =ExcelRead.read(excelReadOption);
		
		batchService.setNongMappingCode(excelContent);
//		for(Map<String, String> article: excelContent){
//			System.out.println(i++ +", " + article.get("A") + ", " + article.get("B") + ", " + article.get("C") + ", " + article.get("D") + ", " + article.get("E") + ", " + article.get("F") + ", " + article.get("G") + ", " + article.get("H") + ", " + article.get("I") + ", " + article.get("J"));
			
//		}
		
		//userService.excelUpload(destFile); //서비스 부분을 삭제한다.
		
		//FileUtils.forceDelete(destFile.getAbsolutePath());
		return "jsonView";

	}
}
