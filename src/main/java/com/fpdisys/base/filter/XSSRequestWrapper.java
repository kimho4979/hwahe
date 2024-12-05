package com.fpdisys.base.filter;

import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

public class XSSRequestWrapper extends HttpServletRequestWrapper{ 
	
	public XSSRequestWrapper(HttpServletRequest servletRequest) {
		super(servletRequest);
	}

	@Override
	public String[] getParameterValues(String parameter) {
		String[] values = super.getParameterValues(parameter);

		if (values == null) {
			return null;
		}

		int count = values.length;
		String[] encodedValues = new String[count];
		for (int i = 0; i < count; i++) {
			encodedValues[i] = removeXSS(values[i], true);
		}

		return encodedValues;
	}

	@Override
	public String getParameter(String parameter) {
		String value = super.getParameter(parameter);

		return removeXSS(value, true);
	}

	@Override
	public String getHeader(String name) {
		String value = super.getHeader(name);
		return removeXSS(value, true);
	}

	@Override
	public Map getParameterMap() {
		Map<Object, Object> parameterMap = new HashMap<Object, Object>();
		Map originalParameterMap = super.getParameterMap();

		for (Object o : originalParameterMap.entrySet()) {
			Map.Entry<Object, Object> pairs = (Entry<Object, Object>) o;
			//System.out.println("test" + pairs.getValue().getClass().getName());
			parameterMap.put(pairs.getKey(), unscript2(pairs.getValue()) );
		}
		return parameterMap;
	}
	
 
	
	private Object unscript2(Object data) {
		if(data == null ){
			return data;
		}

		Object ret = data;
		if("[Ljava.lang.String;".equals(ret.getClass().getName())){
			String[] temp = (String[])ret ;
			for (int i = 0; i < temp.length; i++) {
				temp[i] = removeXSS(temp[i], true);
			}
			ret = temp;
		}else{
			return ret;
		}
		return ret;
	}
	
	
	private String cleanXSS(String value) {
		//You'll need to remove the spaces from the html entities below
		value = value.replaceAll("<", "& lt;").replaceAll(">", "& gt;");
		value = value.replaceAll("\\(", "& #40;").replaceAll("\\)", "& #41;");
		value = value.replaceAll("'", "& #39;");
		value = value.replaceAll("eval\\((.*)\\)", "");
		value = value.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
		value = value.replaceAll("script", "");
		return value;
	}
	
		
	
	/**
	 * XSS 방지 처리.
	 * 
	 * @param data
	 * @return
	 */
	private String unscript(String data) {
		if (data == null || data.trim().equals("")) {
			return "";
		}
		
		String ret = data;
		
		ret = ret.replaceAll("<(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;script");
		ret = ret.replaceAll("</(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;/script");
		
		ret = ret.replaceAll("<(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;object");
		ret = ret.replaceAll("</(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;/object");
		
		ret = ret.replaceAll("<(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;applet");
		ret = ret.replaceAll("</(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;/applet");
		
		ret = ret.replaceAll("<(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");
		ret = ret.replaceAll("</(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");
		
		ret = ret.replaceAll("<(F|f)(O|o)(R|r)(M|m)", "&lt;form");
		ret = ret.replaceAll("</(F|f)(O|o)(R|r)(M|m)", "&lt;form");

		return ret;
	}
	
	
	
	/*
	 *  XSS 방지
	 */
	public static String removeXSS(String str, boolean use_html) {
		if(str == null || "".equals(str)) return str;
		
		String str_low = "";
		if(use_html){ // HTML tag를 사용하게 할 경우 부분 허용
			// HTML tag를 모두 제거
			str = str.replaceAll("<","&lt;");
			str = str.replaceAll(">","&gt;");
			 
			// 특수 문자 제거
			//str = str.replaceAll("\"","&gt;");
			//str = str.replaceAll("&", "&amp;");
			str = str.replaceAll("%00", null);
			str = str.replaceAll("\"", "&#34;");
			str = str.replaceAll("\'", "&#39;");
			str = str.replaceAll("%", "&#37;");	
			str = str.replaceAll("\\.\\./", "");
			str = str.replaceAll("..\\\\", "");
			str = str.replaceAll("\\./", "");
			str = str.replaceAll("%2F", "");
			// 허용할 HTML tag만 변경
			str = str.replaceAll("&lt;p&gt;", "<p>");
			str = str.replaceAll("&lt;P&gt;", "<P>");
			str = str.replaceAll("&lt;br&gt;", "<br>");
			str = str.replaceAll("&lt;BR&gt;", "<BR>");
			// 스크립트 문자열 필터링 (선별함 - 필요한 경우 보안가이드에 첨부된 구문 추가)
			str_low= str.toLowerCase();
			if( str_low.contains("javascript") || str_low.contains("script")	 || str_low.contains("iframe") || 
					str_low.contains("document")	|| str_low.contains("vbscript")	|| str_low.contains("applet") || 
					str_low.contains("embed")	  || str_low.contains("object")	 || str_low.contains("frame") || 
					str_low.contains("grameset")	|| str_low.contains("layer")	  || str_low.contains("bgsound") || 
					str_low.contains("alert")	  || str_low.contains("onblur")	 || str_low.contains("onchange") || 
					str_low.contains("onclick")	|| str_low.contains("ondblclick") || str_low.contains("enerror") ||  
					str_low.contains("onfocus")	|| str_low.contains("onload")	 || str_low.contains("onmouse") || 
					str_low.contains("onscroll")	|| str_low.contains("onsubmit")	|| str_low.contains("onunload"))
			{
				str = str_low;
				str = str.replaceAll("javascript", "x-javascript");
				str = str.replaceAll("script", "x-script");
				str = str.replaceAll("iframe", "x-iframe");
				str = str.replaceAll("document", "x-document");
				str = str.replaceAll("vbscript", "x-vbscript");
				str = str.replaceAll("applet", "x-applet");
				str = str.replaceAll("embed", "x-embed");
				str = str.replaceAll("object", "x-object");
				str = str.replaceAll("frame", "x-frame");
				str = str.replaceAll("grameset", "x-grameset");
				str = str.replaceAll("layer", "x-layer");
				str = str.replaceAll("bgsound", "x-bgsound");
				str = str.replaceAll("alert", "x-alert");
				str = str.replaceAll("onblur", "x-onblur");
				str = str.replaceAll("onchange", "x-onchange");
				str = str.replaceAll("onclick", "x-onclick");
				str = str.replaceAll("ondblclick","x-ondblclick");
				str = str.replaceAll("enerror", "x-enerror");
				str = str.replaceAll("onfocus", "x-onfocus");
				str = str.replaceAll("onload", "x-onload");
				str = str.replaceAll("onmouse", "x-onmouse");
				str = str.replaceAll("onscroll", "x-onscroll");
				str = str.replaceAll("onsubmit", "x-onsubmit");
				str = str.replaceAll("onunload", "x-onunload");
			}
		}else{ // HTML tag를 사용하지 못하게 할 경우
			str = str.replaceAll("\"","&gt;");
			str = str.replaceAll("&", "&amp;");
			str = str.replaceAll("<", "&lt;");
			str = str.replaceAll(">", "&gt;");
			str = str.replaceAll("%00", null);
			str = str.replaceAll("\"", "&#34;");
			str = str.replaceAll("\'", "&#39;");
			str = str.replaceAll("%", "&#37;");	
			str = str.replaceAll("\\.\\./", "");
			str = str.replaceAll("..\\\\", "");
			str = str.replaceAll("\\./", "");
			str = str.replaceAll("%2F", "");
		}
		return str;
	}


	
}