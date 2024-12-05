package com.fpditrans.base.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.poi.xssf.usermodel.XSSFCellStyle;

import com.fpditrans.base.dao.ExcelResultHandler;
import com.fpditrans.base.excel.ExcelParam;
import com.fpditrans.base.excel.ExcelWriter;

/**
 * @Class Name : FpdisysExcelResultHandler.java
 * @Description : FpdisysExcelResultHandler Class
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


public class FpdisysExcelResultHandler extends ExcelResultHandler {

	public FpdisysExcelResultHandler(ExcelWriter writer, Map<String, XSSFCellStyle> styles, ExcelParam param) {
		super(writer, styles, param);
	}

	@Override
	//@Crypto(decryptName="DBMSDec", fields = {"userSsn", "adSsn","cmsUserSsn","customerSsn"})
	public HashMap<String, Object> refine(Object obj) {
		return (HashMap<String, Object>) obj;
	}

}