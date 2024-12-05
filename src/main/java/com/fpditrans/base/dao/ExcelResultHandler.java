package com.fpditrans.base.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.ResultContext;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;

import com.fpditrans.base.dao.BaseResultHandlerImpl;
import com.fpditrans.base.excel.ExcelParam;
import com.fpditrans.base.excel.ExcelWriter;

/**
 * @Class Name : ExcelResultHandler.java
 * @Description : ExcelResultHandler Class
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

public  abstract class ExcelResultHandler extends BaseResultHandlerImpl{
	
	
	
	private int rowNum = 0;
	
	public ExcelResultHandler(){
		
	}
	
	public ExcelResultHandler(ExcelWriter writer, Map<String, XSSFCellStyle> styles, ExcelParam param){
		this.writer = writer;
		this.styles = styles;
		this.param 	= param;
		addHead();
	}
		
	public void init(ExcelWriter writer, Map<String, XSSFCellStyle> styles, ExcelParam param){	
		this.writer = writer;
		this.styles = styles;
		this.param 	= param;
		addHead();
	}

	@Override
	public void handleResult(ResultContext context) {
		
		if(context.getResultObject() != null) {
			HashMap<String, Object> r = refine(context.getResultObject());
			System.out.println(String.valueOf(r));
			addBody(r);
		}
		
	}
	
	public abstract HashMap<String, Object> refine(Object obj);
	
	private void addHead() {
		try {
			
			this.writer.insertRow(this.rowNum);
			
			for (int i = 0; i < param.getStrHeadCount(); i++) {
				this.writer.createCell(i, param.getStrHead(i), styles.get("head").getIndex());
			}
			this.writer.endRow();
			
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		this.rowNum ++;
	}

	private void addBody(HashMap<String, Object> row) {
		try {
			this.writer.insertRow(this.rowNum);
			for (int i = 0; i < param.getStrValueCount(); i++) {
				
				Object d = row.get(param.getStrValue(i));
				
				String data = (d==null)?"":d.toString();
				
				if(param.getIntLen(i) == 1) { // Numeric
					if(data.equals("")) {
						this.writer.createCell(i, 0, styles.get("bodyNumeric").getIndex());
					}else{
						this.writer.createCell(i, Double.parseDouble(data), styles.get("bodyNumeric").getIndex());
					}
					
				}else{
					this.writer.createCell(i, data, styles.get("body").getIndex());
				}
				
			}
			this.writer.endRow();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		this.rowNum ++;
	}



	
	
}

