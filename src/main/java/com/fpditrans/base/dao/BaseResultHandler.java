package com.fpditrans.base.dao;

import java.util.Map;

import org.apache.ibatis.session.ResultHandler;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;

import com.fpditrans.base.excel.ExcelParam;
import com.fpditrans.base.excel.ExcelWriter;

/**
 * @Class Name : BaseResultHandler.java
 * @Description : BaseResultHandler Class
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

public interface BaseResultHandler	extends ResultHandler {

	public void setWriter(ExcelWriter writer);
	
	public void setStyle(Map<String, XSSFCellStyle> styles);
	
	public void setExcelParam(ExcelParam param);
	
}

