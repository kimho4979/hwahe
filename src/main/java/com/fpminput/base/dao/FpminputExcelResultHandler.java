package com.fpminput.base.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.poi.xssf.usermodel.XSSFCellStyle;

import com.fpminput.base.dao.ExcelResultHandler;
import com.fpminput.base.excel.ExcelParam;
import com.fpminput.base.excel.ExcelWriter;

public class FpminputExcelResultHandler extends ExcelResultHandler {

	public FpminputExcelResultHandler(ExcelWriter writer, Map<String, XSSFCellStyle> styles, ExcelParam param) {
		super(writer, styles, param);
	}

	@Override
	//@Crypto(decryptName="DBMSDec", fields = {"userSsn", "adSsn","cmsUserSsn","customerSsn"})
	public HashMap<String, Object> refine(Object obj) {
		return (HashMap<String, Object>) obj;
	}

}