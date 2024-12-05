package com.egovapi.controller;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.StringReader;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.XMLConstants;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.JDOMException;
import org.jdom2.input.SAXBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.egovapi.mapper.DataGoCustMapper;
import com.egovapi.service.DataGoCustService;
import com.egovapi.service.DataGoForecastService;
import com.egovapi.service.DataGoPlntQrtService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fpdisys.admin.image.mapper.CommonMapper;

@Controller
public class XMLApiController2TEST {
	
	protected Log log = LogFactory.getLog(this.getClass());		
	
	@Autowired
	DataGoCustService dataGoCustService;
	
	@Autowired
	DataGoForecastService dataGoForecastService;
	
	@Autowired
	DataGoPlntQrtService dataGoPlntQrtService;
	
	@Autowired
	DataGoCustMapper dataGoCustMapper;
	
	@Autowired
	CommonMapper commonMapper;
	
	private final static String pattern = "yyyy-MM-dd HH:mm:ss";
	private final static java.util.Locale currentLocale = new java.util.Locale("KOREAN", "KOREA");
	// 운영
	protected final static String domain = "https://http://210.103.25.28:8082/";
	// 개발
	//protected final static String domain = "http://175.106.91.132:8180/fpdiAPI/";
	
	
	
	@RequestMapping("/test/test.json")
	public String test(ModelMap model) throws Exception {
		
		SAXBuilder sax = new SAXBuilder();

        // https://rules.sonarsource.com/java/RSPEC-2755
        // prevent xxe
        //sax.setProperty(XMLConstants.ACCESS_EXTERNAL_DTD, "");
        //sax.setProperty(XMLConstants.ACCESS_EXTERNAL_SCHEMA, "");

        // XML is a local file
        Document doc = sax.build(new File("C:\\Users\\macho\\location.xml"));

        Element rootNode = doc.getRootElement();
        
        List<Element> list = rootNode.getChildren("Province");
        //Province
        for (Element target : list) {
        	Map<String,String> map = new HashMap<String, String>(); 
    		map.put("code", target.getAttributeValue("code"));
    		map.put("label", target.getAttributeValue("label"));
			commonMapper.testInsert(map);
        	 List<Element> ele = target.getChildren();
        	 for (Element e : ele) {
        		//Map<String,String> map = new HashMap<String, String>(); 
        		//map.put("code", e.getAttributeValue("code"));
        		//map.put("label", e.getAttributeValue("label"));
				//commonMapper.testInsert(map);
			}
        }
        
		//commonMapper.testInsert()
		model.addAttribute("aaaaa","aaaaaaa");
		return "jsonView";
	}
	
	
	
	// XML 파싱 후 DB 저장
	
	public void xmlDataInput(@RequestParam Map<String, String> pRequestParamMap){
		
		System.out.println(new java.text.SimpleDateFormat(pattern,currentLocale).format(new java.util.Date()) + "식물검역 디비로 넣기전 데이터 확인 \t : " + pRequestParamMap);
		
		String parseStr = String.valueOf(pRequestParamMap);
		String plntStr = parseStr.substring(parseStr.indexOf("data=")+5, parseStr.indexOf("&type"));
		
		
		Map<String, String> result = new HashMap<String, String>();
	    for (String param : parseStr.substring(parseStr.indexOf("&type="), parseStr.length()-1 ).split("&")) {
	        String pair[] = param.split("=");
	        if (pair.length>1) {
	            result.put(pair[0], pair[1]);
	        }else{
	            result.put(pair[0], "");
	        }
	    }
	    pRequestParamMap.clear();
	    pRequestParamMap = result;
		
		
		String data = plntStr;//String.valueOf(pRequestParamMap.get("data"));
		System.out.println(new java.text.SimpleDateFormat(pattern,currentLocale).format(new java.util.Date()) + "식물검역 디비로 넣기전 데이터 확인 \t : " + pRequestParamMap.get("data"));
		List<Map<String, String>> dataList = new ArrayList<Map<String,String>>();
		Map<String, String> map = null;
		
		String yyyymmdd = String.valueOf(pRequestParamMap.get("yyyymmdd"));
		String type = String.valueOf(pRequestParamMap.get("type"));
		
		if(data != null && !"".equals(data) && !"null".equals(data)){
			try {
				// xml 파싱 Document - > List<Map<String, String>
				Document doc = new SAXBuilder().build(new StringReader(data));
				//getStringFromDocument(doc);
				Element root = doc.getRootElement();
				
				List<Element> temp = new ArrayList<Element>();
				if(type != null && !"null".equals(type) && !"".equals(type) ){
					if(type.equals("1") || type.equals("2")|| type.equals("3")) 
						temp = root.getChild("body").getChild("items").getChildren("item");
				}
				
				//if(temp.size() != 0)
				for (int i = 0; i < temp.size(); i++) {
					List<Element> child = temp.get(i).getChildren();
					map = new HashMap<String, String>();
					for (int j = 0; j < child.size(); j++) {
						 Element e = (Element) child.get(j);
						 map.put(e.getName(), e.getText().trim());
					}
					map.put("yyyymm", yyyymmdd);
					dataList.add(map);
				}
				System.out.println("dataList\n" + dataList);
			} catch (JDOMException | IOException e) {
				e.printStackTrace();
			}
			
			
		}
	}
	
	
}
