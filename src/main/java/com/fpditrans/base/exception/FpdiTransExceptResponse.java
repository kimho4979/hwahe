package com.fpditrans.base.exception;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.MediaType;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Class Name : FpdiTransExceptResponse.java
 * @Description : FpdiTransExceptResponse Class
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

public class FpdiTransExceptResponse {
	private static final long serialVersionUID = 1L;

	public static ModelAndView SystemError(HttpServletRequest request, Exception exception, boolean mobileweb) 
	{
		String contentType = request.getHeader("Content-Type");
		ModelAndView model=null;
		String jsp = "error";

		// Content-Type 확인, html, xml, json 용 View를 따로 처리함.
		if(contentType!=null)
		{
			if (MediaType.APPLICATION_JSON_VALUE.equals(contentType))
				jsp = "errorjson";
			else if (MediaType.APPLICATION_XML.equals(contentType))
				jsp = "errorxml";
		}

		if (mobileweb == true)
			jsp = "m_" + jsp;

		model = new ModelAndView(jsp);
		model.addObject("errfrom", "system");
		model.addObject("errcode", "500");		// Server Internal Error
		model.addObject("errormsg", exception.getMessage());		
		//response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);

		return model;
	}

}

