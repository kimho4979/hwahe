package com.fpminput.base.login;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InterruptedIOException;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {

protected Log log = LogFactory.getLog(this.getClass());	
	
	@Autowired  
	protected MessageSource messageSource; 
	
	/**
	 * controller 이벤트 호출전 
	 */
	@Override
	public boolean preHandle(HttpServletRequest request,
							 HttpServletResponse response, 
							 Object handler) throws IOException 
	{
		log.debug(">>>>>>>>>>>LoginInterceptor >>>>>>>>>>>");
		if ( request.getServletPath().contains("/login/"))
		{
			log.debug(">>>>>>>>>>> contains /login/ ");
			return true;
		}
		//----------------------------------------------------------------
		// Login 되어있는지 check
		//----------------------------------------------------------------
		LoginInfo loginInfo = new LoginInfo(request, response);
		if(!loginInfo.isLogin())
		{
			log.debug(">>>>>>>>>>>>>>>> not login >>>>>>>>>" + request.getRequestURI() + "=="  + request.getServletPath() );

			//----------------------------------------------------------------
			// Login 되어있지 않으면 로그인화면으로 redirect 또는 로그인결과 json 으로 redirect
			//----------------------------------------------------------------
			String uri = request.getRequestURI().toLowerCase();
			if(uri.indexOf(".json") == -1)
			{
				log.debug(">>>>>>>>>>>>>>>>LoginInterceptor -> IsSessionCheckException >>>>>>>>>");
//				throw new IsSessionCheckException();//세션체크
				
				Map<String, String> resultMap = new HashMap<String, String>();
				String  code = messageSource.getMessage("fpdisys.main.rtn_code.SESSION_FINISH", null, Locale.getDefault()) ;
				//String msg = messageSource.getMessage("fpdisys.main.rtn_code.SESSION_FINISH_MSG", null, Locale.getDefault()) ;
				log.debug("CODE = ["+code+"]");
			  
				response.sendRedirect( request.getScheme().replaceAll("\r", "").replaceAll("\n", "")+"://"+request.getServerName().replaceAll("\r", "").replaceAll("\n", "")+":"+request.getServerPort());
			}else{
				log.debug(">>>>>>>>>>>>>>>>LoginInterceptor -> IsSessionCheckAjaxException >>>>>>>>>" + request.getRequestURI() + "=="  + request.getServletPath() + "==>" + request.getRequestURI().replace ( request.getServletPath(), "" ) );
				response.sendRedirect(request.getScheme().replaceAll("\r", "").replaceAll("\n", "")+"://"+request.getServerName().replaceAll("\r", "").replaceAll("\n", "")+":"+request.getServerPort());
			}
			return false;

//			ModelAndView mv = new ModelAndView("http://localhost:8080/ktisMvno/cmn/login/sessionNullForAjaxReturn.json"); 
//			ModelAndViewDefiningException mvde = new ModelAndViewDefiningException(mv); 
//			throw mvde; 

		}else{
			//TODO 로그 등록 
		}
	
		return true;
	}
	
	/**
	 * controller 호출 후 view 페이지 출력전 
	 */
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView)	
	{
		try {
			super.postHandle(request, response, handler, modelAndView);
		} catch (InterruptedIOException  e) {
			log.error("입출력 오류 입출력 도중에 알수없는 인터럽트가 발생하였습니다!!");
		} catch (FileNotFoundException e) {
			log.error("입출력 오류 파일을 찾을 수 없습니다!!");
		} catch (IOException e) {
			log.debug("입출력 오류!!");
		} catch (ClassNotFoundException e) {
			log.error("오류발생 클래스를 찾을 수 없습니다!!");
		} catch (NoSuchMethodException e) {
			log.error("오류발생 메서드를 찾을수 없습니다!!");
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
		} catch (Exception e) {
			log.error("오류발생!!");
		}
	}

	/**
	 * controller + view 페이지 모두 출력 후 
	 */
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)  
	{
		try {
			super.afterCompletion(request, response, handler, ex);
		} catch (InterruptedIOException  e) {
			log.error("입출력 오류 입출력 도중에 알수없는 인터럽트가 발생하였습니다!!");
		} catch (FileNotFoundException e) {
			log.error("입출력 오류 파일을 찾을 수 없습니다!!");
		} catch (IOException e) {
			log.debug("입출력 오류!!");
		} catch (ClassNotFoundException e) {
			log.error("오류발생 클래스를 찾을 수 없습니다!!");
		} catch (NoSuchMethodException e) {
			log.error("오류발생 메서드를 찾을수 없습니다!!");
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
		} catch (Exception e) {
			log.error("오류발생!!");
		}
	}

	
}
