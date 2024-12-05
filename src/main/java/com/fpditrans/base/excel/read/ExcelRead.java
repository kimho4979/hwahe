package com.fpditrans.base.excel.read;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.fpditrans.base.service.ExcelService;

public class ExcelRead {
	
	public static List<Map<String, String>> read(ExcelReadOption excelReadOption) throws Exception {
		//엑셀 파일 자체
		//엑셀파일을 읽어 들인다.
		//FileType.getWorkbook() <-- 파일의 확장자에 따라서 적절하게 가져온다.
		Workbook wb = ExcelFileType.getWorkbook(excelReadOption.getFilePath());
		
		
		Sheet sheet = wb.getSheetAt(excelReadOption.getSheet());
		
		System.out.println("Sheet 이름: "+ wb.getSheetName(excelReadOption.getSheet())); 
		System.out.println("데이터가 있는 Sheet의 수 :" + wb.getNumberOfSheets());
		/**
		 * sheet에서 유효한(데이터가 있는) 행의 개수를 가져온다.
		 */
		int numOfRows = sheet.getPhysicalNumberOfRows();
		int numOfCells = 0;
		
		Row row = null;
		Cell cell = null;
		
		String cellName = "";
		/**
		 * 각 row마다의 값을 저장할 맵 객체
		 * 저장되는 형식은 다음과 같다.
		 * put("A", "이름");
		 * put("B", "게임명");
		 */
		Map<String, String> map = null;
		/*
		 * 각 Row를 리스트에 담는다.
		 * 하나의 Row를 하나의 Map으로 표현되며
		 * List에는 모든 Row가 포함될 것이다.
		 */
		List<Map<String, String>> result = new ArrayList<Map<String, String>>(); 
		/**
		 * 각 Row만큼 반복을 한다.
		 */
		for(int rowIndex = excelReadOption.getStartRow() - 1; rowIndex < numOfRows; rowIndex++) {
			/*
			 * 워크북에서 가져온 시트에서 rowIndex에 해당하는 Row를 가져온다.
			 * 하나의 Row는 여러개의 Cell을 가진다.
			 */
			row = sheet.getRow(rowIndex);
			
			if(row != null) {
				/*
				 * 가져온 Row의 Cell의 개수를 구한다.
				 */
				numOfCells = row.getLastCellNum();
				/*
				 * 데이터를 담을 맵 객체 초기화
				 */
				map = new HashMap<String, String>();
				/*
				 * cell의 수 만큼 반복한다.
				 */
				for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {
					/*
					 * Row에서 CellIndex에 해당하는 Cell을 가져온다.
					 */
					cell = row.getCell(cellIndex);
					/*
					 * 현재 Cell의 이름을 가져온다
					 * 이름의 예 : A,B,C,D,......
					 */
					cellName = ExcelCellRef.getName(cell, cellIndex);
//					System.out.println(cellName + ":" + cell);
					/*
					 * 추출 대상 컬럼인지 확인한다
					 * 추출 대상 컬럼이 아니라면, 
					 * for로 다시 올라간다
					 */
					if( !excelReadOption.getOutputColumns().contains(cellName) ) {
						continue;
					}
					/*
					 * map객체의 Cell의 이름을 키(Key)로 데이터를 담는다.
					 */
					map.put(cellName, ExcelCellRef.getValue(cell));
				}
				/*
				 * 만들어진 Map객체를 List로 넣는다.
				 */
				result.add(map);
				
			}
			
		}
		
		return result;
		
	}
	
	public static List<Map<String, String>> readFilter(String fileName, InputStream inputStream, String year) throws Exception {
		//엑셀 파일 자체
		//엑셀파일을 읽어 들인다.
		//FileType.getWorkbook() <-- 파일의 확장자에 따라서 적절하게 가져온다.
		Workbook wb = null;
		if(fileName.toUpperCase().endsWith(".XLS")) {
			try {
				wb = new HSSFWorkbook(inputStream);
			} catch (IOException e) {
				throw new RuntimeException(e.getMessage(), e);
			}
		}
		else if(fileName.toUpperCase().endsWith(".XLSX")) {
			try {
				wb = new XSSFWorkbook(inputStream);
			} catch (IOException e) {
				throw new RuntimeException(e.getMessage(), e);
			}
		}
		
		
		
		Sheet sheet = wb.getSheetAt(0);
		
		System.out.println("Sheet 이름: "+ wb.getSheetName(0)); 
		System.out.println("데이터가 있는 Sheet의 수 :" + wb.getNumberOfSheets());
		System.out.println("데이터가 있는 Sheet의 라인수 :" + sheet.getPhysicalNumberOfRows());
		/**
		 * sheet에서 유효한(데이터가 있는) 행의 개수를 가져온다.
		 */
		int numOfRows = sheet.getPhysicalNumberOfRows();
		
		int numOfCells = 0;
		
		Row row = null;
		Cell cell = null;
		
		String cellName = "";
		row = sheet.getRow(3);
		String[] cellNames = new String[row.getLastCellNum()];
		for(int cellIndex = 0; cellIndex < row.getLastCellNum(); cellIndex++) {
			cellNames[cellIndex] = ExcelCellRef.getValue(row.getCell(cellIndex));
		}
		row = null;
		/**
		 * 각 row마다의 값을 저장할 맵 객체
		 * 저장되는 형식은 다음과 같다.
		 * put("A", "이름");
		 * put("B", "게임명");
		 */
		Map<String, String> map = null;
		/*
		 * 각 Row를 리스트에 담는다.
		 * 하나의 Row를 하나의 Map으로 표현되며
		 * List에는 모든 Row가 포함될 것이다.
		 */
		List<Map<String, String>> result = new LinkedList<Map<String, String>>(); 
		/**
		 * 각 Row만큼 반복을 한다.
		 */
		
		System.out.println("엑셀 읽기 시작...............");
		for(int rowIndex = 4; rowIndex < numOfRows; rowIndex++) {
			
			row = sheet.getRow(rowIndex);
			
			if(row != null && !row.getZeroHeight()) {
				
				numOfCells = row.getLastCellNum();
				
				map = new LinkedHashMap<String, String>();
				map.put("YEAR", year);
				//AD_CD_INDST_IDV_CD
				
				if(cellNames[0].equals("AD_CD_INDST_IDV_CD") && Pattern.matches("^[A-Z]*$", ExcelCellRef.getValue(row.getCell(0)).substring(2, 3))) {
					map.put("lvl", "1");
				}else if(ExcelCellRef.getValue(row.getCell(0)).length() <= 5){
					map.put("lvl", "1");
				}else if(cellNames[0].equals("AD_CD_INDST_IDV_CD") && Integer.parseInt(ExcelCellRef.getValue(row.getCell(0)).substring(4, 5)) > 0){
					map.put("lvl", "3");
				}else {
					map.put("lvl", "2");
				}
				
				
				for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {
					
					cell = row.getCell(cellIndex);
					
					cellName = cellNames[cellIndex];
					
					if(ExcelCellRef.getValue(cell).equals("X") || ExcelCellRef.getValue(cell).equals("") || ExcelCellRef.getValue(cell) == null ) {
						map.put(cellName, "0");
					 		
					} else {
						map.put(cellName, ExcelCellRef.getValue(cell));
					}
					
				}
				
				//System.out.println(map);
				if( (ExcelCellRef.getValue(sheet.getRow(5).getCell(0)).substring(0, 2).equals(ExcelCellRef.getValue(row.getCell(0)).substring(0,2))      ) && (!ExcelCellRef.getValue(row.getCell(0)).endsWith("000") && !ExcelCellRef.getValue(row.getCell(0)).endsWith("00")) && !ExcelCellRef.getValue(row.getCell(0)).endsWith("0")) {					
					result.add(map);
				} else {
					System.out.println("중복건들 : "+map);
				}
					
				
			}
			
		}
		
		//System.out.println(result);
		System.out.println("엑셀 읽기 끝...............");
		
		return result;
		
	}
	
	public static List<List<String>> read(String fileName, InputStream inputStream) throws Exception {
		//엑셀 파일 자체
		//엑셀파일을 읽어 들인다.
		//FileType.getWorkbook() <-- 파일의 확장자에 따라서 적절하게 가져온다.
		Workbook wb = null;
		if(fileName.toUpperCase().endsWith(".XLS")) {
			try {
				wb = new HSSFWorkbook(inputStream);
			} catch (IOException e) {
				throw new RuntimeException(e.getMessage(), e);
			}
		}
		else if(fileName.toUpperCase().endsWith(".XLSX")) {
			try {
				wb = new XSSFWorkbook(inputStream);
			} catch (IOException e) {
				throw new RuntimeException(e.getMessage(), e);
			}
		}
		
		
		
		Sheet sheet = wb.getSheetAt(0);
		
		System.out.println("Sheet 이름: "+ wb.getSheetName(0)); 
		System.out.println("데이터가 있는 Sheet의 수 :" + wb.getNumberOfSheets());
		System.out.println("데이터가 있는 Sheet의 라인수 :" + sheet.getPhysicalNumberOfRows());
		/**
		 * sheet에서 유효한(데이터가 있는) 행의 개수를 가져온다.
		 */
		int numOfRows = sheet.getPhysicalNumberOfRows();
		
		int numOfCells = 0;
		
		Row row = null;
		Cell cell = null;
		
		/**
		 * 각 row마다의 값을 저장할 맵 객체
		 * 저장되는 형식은 다음과 같다.
		 * put("A", "이름");
		 * put("B", "게임명");
		 */
		Map<String, String> map = null;
		/*
		 * 각 Row를 리스트에 담는다.
		 * 하나의 Row를 하나의 Map으로 표현되며
		 * List에는 모든 Row가 포함될 것이다.
		 */
		List<List<String>> result = new ArrayList<List<String>>(); 
		/**
		 * 각 Row만큼 반복을 한다.
		 */
		System.out.println("엑셀 읽기 시작...............");
		for(int rowIndex = 0; rowIndex < numOfRows; rowIndex++) {
			
			row = sheet.getRow(rowIndex);
			List<String> resultRow = new ArrayList<String>();
			
			if(row != null && !row.getZeroHeight()) {
				
				numOfCells = row.getLastCellNum();
				
				map = new LinkedHashMap<String, String>();
				
				for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {
					
					cell = row.getCell(cellIndex);
					resultRow.add(ExcelCellRef.getValue(cell));
				}
				
				result.add(resultRow);
				
			}
			
		}
		
		System.out.println("엑셀 읽기 끝...............");
		return result;
		
	}
	
}
