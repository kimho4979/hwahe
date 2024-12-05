package com.fpditrans.base.controller;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;

import javax.servlet.ServletContext;

import org.springframework.web.context.ServletContextAware;

/**
 * @Class Name : ImagePaginationRenderer.java
 * @Description : ImagePaginationRenderer Class
 * @Modification Information
 * @
 * @  수정일	  수정자			  수정내용
 * @ ---------	---------	-------------------------------
 * @ 2009.03.16			최초생성
 *
 * @author 우림인포텍
 * @since 2009. 03.16
 * @version 1.0
 * @see
 *
 */
public class EgovImgPaginationRenderer extends AbstractPaginationRenderer implements ServletContextAware{

	private ServletContext servletContext;

	public EgovImgPaginationRenderer() {
		// no-op
	}

	/**
	* PaginationRenderer
	*
	* @see 개발프레임웍크 실행환경 개발팀
	*/
	public void initVariables() {
		/*
		firstPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\">" + "<image src='" + servletContext.getContextPath() + "/images/egovframework/cmmn/btn_page_pre10.gif' border=0/></a>&#160;";
		previousPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\">" + "<image src='" + servletContext.getContextPath() + "/images/egovframework/cmmn/btn_page_pre1.gif' border=0/></a>&#160;";
		currentPageLabel = "<strong>{0}</strong>&#160;";
		otherPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\">{2}</a>&#160;";
		nextPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\">" + "<image src='" + servletContext.getContextPath() + "/images/egovframework/cmmn/btn_page_next1.gif' border=0/></a>&#160;";
		lastPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\">" + "<image src='" + servletContext.getContextPath() + "/images/egovframework/cmmn/btn_page_next10.gif' border=0/></a>&#160;";
		*/
		firstPageLabel = "<a href=\"#\" class=\"btn_prev_prev\" onclick=\"{0}({1}); return false;\"></a>&#160;";
		previousPageLabel = "<a href=\"#\" class=\"btn_prev\" onclick=\"{0}({1}); return false;\"></a>&#160;";
		currentPageLabel = "<a href=\"#\" class=\"btn_page on\">{0}</a>&#160;";
		otherPageLabel = "<a href=\"#\" class=\"btn_page\" onclick=\"{0}({1}); return false;\">{2}</a>&#160;";
		nextPageLabel = "<a href=\"#\" class=\"btn_next\" onclick=\"{0}({1}); return false;\"></a>&#160;";
		lastPageLabel = "<a href=\"#\" class=\"btn_next_next\" onclick=\"{0}({1}); return false;\"></a>&#160;";
	}

	@Override
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
		initVariables();
	}
}

