package com.egovapi.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class CommonApiUtil {

	
	/**
	 * e.getMessage() 를 통하여 조회된 오라클 에러내용을 수집한다.
	 * @param errorMessage
	 * @return
	 */
	public static String getSqlErrorMessage(String errorMessage){
		String result = "";
		/*Pattern p = Pattern.compile("ORA-[0-9]{5}:");  // insert your pattern here
		\(.*\) 괄호 내용 없애기
		Matcher m = p.matcher(errorMessage);
		if (m.find()) {
			result = errorMessage.substring(m.end());
		}*/
		
		if(errorMessage.indexOf("ORA-") >= 0){
			result = errorMessage.substring(errorMessage.lastIndexOf("ORA-")).replaceAll("\\(.*\\)", "");
		}else{
			result = errorMessage;
		}
		return result;
	}
	
	
	
}
