package com.fpditrans.base.excel;

import java.util.List;



/**
 * @Class Name : ExcelParam.java
 * @Description : ExcelParam Class
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


public class ExcelParam {

private String fileName;
	
	private String sheetName;
	
	private String[] strHead;
	
	private int[] intWidth;
	
	private String[] strValue;
	
	private int[] intLen;
	
	private String excelPath;
	
	private List<?> cmnMaskGrpList;
	
	

	public String getExcelPath() {
		return excelPath;
	}

	public void setExcelPath(String excelPath) {
		this.excelPath = excelPath;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getSheetName() {
		return sheetName;
	}

	public void setSheetName(String sheetName) {
		this.sheetName = sheetName;
	}

	public int[] getIntLen() {
		return intLen;
	}

	public void setIntLen(int ... intLen) {
		this.intLen = intLen;
	}
	
	public int getIntLen(int index) {
		return intLen[index];
	}
	
	public int getIntLenCount(){
		return getIntLen().length;
	}
	

	public String[] getStrHead() {
		return strHead;
	}
	
	public String getStrHead(int index) {
		return strHead[index];
	}
	
	public int getStrHeadCount(){
		return getStrHead().length;
	}

	public void setStrHead(String ... strHead) {
		this.strHead = strHead;
	}

	public int[] getIntWidth() {
		return intWidth;
	}

	public void setIntWidth(int ... intWidth) {
		this.intWidth = intWidth;
	}

	public String[] getStrValue() {
		return strValue;
	}

	public String getStrValue(int index) {
		return strValue[index];
	}
	
	public int getStrValueCount(){
		return getStrValue().length;
	}
	
	public void setStrValue(String ... strValue) {
		this.strValue = strValue;
	}

	public List<?> getCmnMaskGrpList() {
		return cmnMaskGrpList;
	}

	public void setCmnMaskGrpList(List<?> cmnMaskGrpList) {
		this.cmnMaskGrpList = cmnMaskGrpList;
	}
	

}

