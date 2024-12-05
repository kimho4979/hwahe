package com.fpdisys.base.excel;

import java.util.List;

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
		int[] newIntLen = new int[intLen.length];
		System.arraycopy(intLen, 0, newIntLen, 0, intLen.length);
		return newIntLen;
	}

	public void setIntLen(int ... intLen) {
		int[] newIntLen = new int[intLen.length];
		System.arraycopy(intLen, 0, newIntLen, 0, intLen.length);
		this.intLen = newIntLen;
	}
	
	public int getIntLen(int index) {
		int[] newIntLen = new int[intLen.length];
		System.arraycopy(intLen, 0, newIntLen, 0, intLen.length);
		return newIntLen[index];
	}
	
	public int getIntLenCount(){
		return getIntLen().length;
	}
	

	public String[] getStrHead() {
		String[] newStrHead = new String[strHead.length];
		System.arraycopy(strHead, 0, newStrHead, 0, strHead.length);
		return newStrHead;
	}
	
	public String getStrHead(int index) {
		String[] newStrHead = new String[strHead.length];
		System.arraycopy(strHead, 0, newStrHead, 0, strHead.length);
		return newStrHead[index];
	}
	
	public int getStrHeadCount(){
		return getStrHead().length;
	}

	public void setStrHead(String ... strHead) {
		String[] newStrHead = new String[strHead.length];
		System.arraycopy(strHead, 0, newStrHead, 0, strHead.length);
		this.strHead = newStrHead;
	}

	public int[] getIntWidth() {
		int[] newIntWidth = new int[intWidth.length];
		System.arraycopy(intWidth, 0, newIntWidth, 0, intWidth.length);
		return newIntWidth;
	}

	public void setIntWidth(int ... intWidth) {
		int[] newIntWidth = new int[intWidth.length];
		System.arraycopy(intWidth, 0, newIntWidth, 0, intWidth.length);
		this.intWidth = newIntWidth;
	}

	public String[] getStrValue() {
		String[] newStrValue = new String[strValue.length];
		System.arraycopy(strValue, 0, newStrValue, 0, strValue.length);
		return newStrValue;
	}

	public String getStrValue(int index) {
		String[] newStrValue = new String[strValue.length];
		System.arraycopy(strValue, 0, newStrValue, 0, strValue.length);
		return newStrValue[index];
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
