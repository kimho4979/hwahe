package com.fpdisys.base.dao;


import java.util.Map;

import org.apache.poi.xssf.usermodel.XSSFCellStyle;

import com.fpdisys.base.excel.ExcelParam;
import com.fpdisys.base.excel.ExcelWriter;

public abstract class BaseResultHandlerImpl implements BaseResultHandler {
	
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
	