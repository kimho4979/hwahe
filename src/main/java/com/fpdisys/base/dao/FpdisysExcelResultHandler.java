package com.fpdisys.base.dao;


import java.util.HashMap;
import java.util.Map;

import org.apache.poi.xssf.usermodel.XSSFCellStyle;	

import com.fpdisys.base.excel.ExcelParam;
import com.fpdisys.base.excel.ExcelWriter;


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