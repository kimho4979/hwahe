package com.fpdisys.base.util;

public class RequestHelper {
	//TODO  LoginUser와 JspPageInfo 구현필요
	/**
	 private HttpServletRequest request;

		private RequestHelper(HttpServletRequest request) {
			this.request = request;
		}

		public static RequestHelper of(HttpServletRequest request) {
			RequestHelper requestHelper = new RequestHelper(request);
			return requestHelper;
		}

		public String getString(String key) {
			return request.getParameter(key);
		}

		public String[] getStringArray(String key) {
			String[] targets = getString(key).split(",");
			return targets;
		}

		public String getString(String key, String defaultValue) {
			String value = getString(key);

			if(StringUtils.isEmpty(value)) {
				return defaultValue;
			}

			return value;
		}

		public int getInt(String key) {
			try {
				return Integer.parseInt(getString(key));
			} catch (Exception e) {
				return 0;
			}
		}

		public int getInt(String key, int defaultValue) {
			String value = getString(key);

			if(StringUtils.isEmpty(value)) {
				return defaultValue;
			}

			return getInt(key);
		}

		public long getLong(String key) {
			try {
				return Long.parseLong(getString(key));
			} catch (Exception e) {
				return 0L;
			}
		}

		public long getLong(String key, long defaultValue) {
			String value = getString(key);

			if(StringUtils.isEmpty(value)) {
				return defaultValue;
			}

			return getLong(key);
		}

		public void setAttribute(String key, String value) {
			request.setAttribute(key, value);
		}

		public String getStringAttribute(String key) {
			return getStringAttribute(key, "");
		}

		public String getStringAttribute(String key, String defaultValue) {
			Object value = request.getAttribute(key);

			if(value == null) {
				return defaultValue;
			}

			return value.toString();
		}

		public void setSessionAttribute(String key, Object value) {
			request.getSession().setAttribute(key, value);
		}

		public Object getSessionAttributeObject(String key) {
			return request.getSession().getAttribute(key);
		}

		public <T> T getSessionAttributeObject(String key, Class<T> clazz) {
			Object object = getSessionAttributeObject(key);

			if(object != null) {
				return clazz.cast(object);
			}
			return null;
		}


		public String getSessionAttributeString(String key) {
			return getSessionAttributeString(key, "");
		}

		public String getSessionAttributeString(String key, String defaultValue) {
			Object value = getSessionAttributeObject(key);

			if(value == null) {
				return defaultValue;
			}

			return value.toString();
		}

		public boolean hasSessionAttribute(String key) {
			return getSessionAttributeObject(key) == null ? false : true;
		}

		public String setAuth(String value) {
			if(value != null && value.equals("Y")) {
				return "Y";
			}
			return null;
		}

		public boolean hasParameter(String key) {
			if(request.getParameterMap() != null) {
				return request.getParameterMap().containsKey(key);
			}

			return false;
		}

		public void setSessionAttributes(JspPageInfo jspPageInfo, LoginUser user) {
			setSessionAttribute(GlobalConstants.JSP_PAGE_INFO, jspPageInfo);
			setSessionAttribute("pageId", jspPageInfo.getPageId());
			setSessionAttribute("pageName", jspPageInfo.getMenuName());
			setSessionAttribute("pageRemark", "");
			setSessionAttribute("className", jspPageInfo.getClassName());

			setSessionAttribute("searchAuth", setAuth(jspPageInfo.getSearchAuth()));
			setSessionAttribute("saveAuth", setAuth(jspPageInfo.getSaveAuth()));
			setSessionAttribute("excelAuth", setAuth(jspPageInfo.getExcelAuth()));
			setSessionAttribute("function1Auth", setAuth(jspPageInfo.getFunction1Auth()));
			setSessionAttribute("function2Auth", setAuth(jspPageInfo.getFunction2Auth()));
			setSessionAttribute("function3Auth", setAuth(jspPageInfo.getFunction3Auth()));
			setSessionAttribute("function4Auth", setAuth(jspPageInfo.getFunction4Auth()));
			setSessionAttribute("function5Auth", setAuth(jspPageInfo.getFunction5Auth()));

			setSessionAttribute(GlobalConstants.LOGIN_USER_NAME, user.getUserNm());
			setSessionAttribute(GlobalConstants.LOGIN_USER_ID, user.getUserNm());
			//setSessionAttribute(GlobalConstants.COMPANY_CODE, user.getCompanyCode());

			

		}
		
		**/

}
