package com.fpminput.base.exception;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.MediaType;
import org.springframework.web.servlet.ModelAndView;

public class FpminputExceptResponse {
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