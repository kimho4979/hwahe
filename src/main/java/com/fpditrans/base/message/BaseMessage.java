package com.fpditrans.base.message;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;


/**
 * @Class Name : BaseMessage.java
 * @Description : BaseMessage Class
 * @Modification Information
 * @
 * @  수정일	  수정자			  수정내용
 * @ ---------	---------	-------------------------------
 * @ 2016.08.16			최초생성
 *
 * @author 우림인포텍
 * @since 2016. 03.16
 * @version 1.0
 * @see
 *
 *  Copyright (C) by WOORIM All right reserved.
 */


public class BaseMessage extends HashMap<String, Object>{

	private static final long serialVersionUID = 1L;
	
	
	List<Object> data = null;
	
	public static final String MSG_RETURN_CODE = "MSG_RETURN_CODE";
	
	
	public static final String MSG_RETURN_DATA = "MSG_RETURN_DATA";
	
	
	public static final String MSG_RETURN_MSG = "MSG_RETURN_MSG";
	
	
	public void setReturnCode(String returnCode){
		this.put(MSG_RETURN_CODE, returnCode);
	}
	
	public void setReturnMessage(String message) {
		this.put(MSG_RETURN_MSG, message);
	}
	
	public void putReturnData(Object returnData) { 
		if(data==null) {
			data = new ArrayList<Object>();
			this.put(MSG_RETURN_DATA, returnData);
		}
		this.data.add(returnData);		
	}
}
