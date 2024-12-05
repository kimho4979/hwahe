package com.fpdisys.base;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.FrameworkServlet;

public class IA {
	//private final static Logger logger = Logger.getLogger(IA.class);
	protected static Log logger = LogFactory.getLog(IA.class);

	/**
	 * 진행 로그
	 * @param msg
	 */
	public static void log(String msg){
		log(msg, null);
	}

	public static void log(String msg, Logger logger){
		if(logger == null) return ;
		logger.info(msg);
	}

	public static void err(String msg){
		err(msg, null);
	}

	public static void err(String msg, Logger logger){
		if(logger == null) return ;
		logger.error(msg);
	}

	/**
	 * spring init
	 * @author mk
	 *
	 */
	public static class LoadSpringResource {
		/**
		 * xml 설정에 의한 Resource bean 리턴
		 * @param path
		 * @param beanName
		 * @return
		 */
		@SuppressWarnings("resource")
		public static Object getBeanByXml(String path, String beanName) {
			
			Object obj = null;
			try {
				ApplicationContext ac = new ClassPathXmlApplicationContext(new String[]{path});
				obj = (Object) ac.getBean(path);
			} catch (Exception e) {
				//IA.err(">> Spring Resource init Error By Xml [path = "+ path + ", bean name = " + beanName + "]", logger);
				logger.debug(">> Spring Resource init Error By Xml [path = "+ path + ", bean name = " + beanName + "]");
			}
			return obj;
		}

		/**
		 * Annotation 설정에 의한 Resource bean 리턴
		 * @param request
		 * @param beanName
		 * @return
		 */
		public static Object getBeanByAnnotation(HttpServletRequest request, String beanName) {
			return getBeanByAnnotation(request.getSession().getServletContext(), beanName);
		}

		/**
		 * Annotation 설정에 의한 Resource bean 리턴
		 * @param session
		 * @param beanName
		 * @return
		 */
		public static Object getBeanByAnnotation(HttpSession session, String beanName) {
			logger.debug("IA의 getBeanByAnnotation ");
			return getBeanByAnnotation(session.getServletContext(), beanName);
		}

		/**
		 * Annotation 설정에 의한 Resource bean 리턴
		 * @param context
		 * @param beanName
		 * @return
		 */
		public static Object getBeanByAnnotation(ServletContext context, String beanName) {
			Object obj = null;
			try {
				WebApplicationContext ac = WebApplicationContextUtils.getWebApplicationContext(context, FrameworkServlet.SERVLET_CONTEXT_PREFIX + "action");
				obj = (Object) ac.getBean(beanName);
			} catch (Exception e) {
				logger.debug(">> Spring Resource init By Annotation [bean name = " + beanName + "]");
			}
			return obj;
		}

	}
}
