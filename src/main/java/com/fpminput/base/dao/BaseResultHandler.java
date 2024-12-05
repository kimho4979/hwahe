package com.fpminput.base.dao;

import java.util.Map;

import org.apache.ibatis.session.ResultHandler;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;

import com.fpminput.base.excel.ExcelParam;
import com.fpminput.base.excel.ExcelWriter;

public interface BaseResultHandler extends ResultHandler {

	public void setWriter(ExcelWriter writer);
	
	public void setStyle(Map<String, XSSFCellStyle> styles);
	
	public void setExcelParam(ExcelParam param);
	
}
