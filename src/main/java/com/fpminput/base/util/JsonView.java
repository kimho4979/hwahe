package com.fpminput.base.util;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.web.servlet.view.AbstractView;

/**
 * @class JsonView
 * @brief [Mandatory] 이 클래스/인터페이스에 대한 설명을 한 줄로 기술한다.
 *
 * [Optional] 상세설명
 *
 * @brief [Mandatory] 클래스/인터페이스의 주요 기능
 *		[Mandatory] 모듈 수준의 인터페이스에 대한 설명
 *		[Mandatory] 실행 순서
 * @see  [Optional] 관련 정보
 * @version 0.1
 * @author  chuhongjae
 */
public class JsonView extends AbstractView {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		ObjectMapper om = new ObjectMapper();
		
		StringBuffer gson = new StringBuffer(om.writeValueAsString(model));

		
//		response.setContentType("application/json");
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");

		response.setHeader("Cache-Control", "no-cache");

		response.setContentLength(gson.toString().getBytes("utf-8").length);
		
		log.debug(">>>>  JSON >>" + gson.toString());
		
		response.getWriter().print(gson.toString());
		response.flushBuffer();
//		response = null;  // code inspection땜에 막음 막으면 안되는지 테스트 필요
//		response.reset();
//		response.resetBuffer();
		gson = null;
		om = null;
	
	}
}


