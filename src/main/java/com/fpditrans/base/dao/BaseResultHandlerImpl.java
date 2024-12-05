package com.fpditrans.base.dao;

import java.util.Map;


import org.apache.poi.xssf.usermodel.XSSFCellStyle;

import com.fpditrans.base.dao.BaseResultHandler;
import com.fpditrans.base.excel.ExcelParam;
import com.fpditrans.base.excel.ExcelWriter;

/**
 * @Class Name : BaseResultHandlerImpl.java
 * @Description : BaseResultHandlerImpl Class
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



public  abstract class BaseResultHandlerImpl implements BaseResultHandler {
	
	protected ExcelParam param;
	protected ExcelWriter writer;
	protected Map<String, XSSFCellStyle> styles;
	
	
	public BaseResultHandlerImpl(){
		super();
	}

	@Override
	public void setWriter(ExcelWriter writer) {
		this.writer = writer;
	}

	@Override
	public void setStyle(Map<String, XSSFCellStyle> styles) {
		this.styles = styles;
	}

	@Override
	public void setExcelParam(ExcelParam param) {
		this.param = param;
	}
	
	
}