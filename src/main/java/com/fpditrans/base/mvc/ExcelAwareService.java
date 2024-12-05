package com.fpditrans.base.mvc;

import java.awt.Color;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;

import com.fpditrans.base.dao.ExcelResultHandler;
import com.fpditrans.base.dao.FpdisysExcelResultHandler;
import com.fpditrans.base.excel.ExcelParam;
import com.fpditrans.base.excel.ExcelWriter;
import com.fpditrans.base.mvc.BaseService;
import com.fpditrans.base.util.WoorimUtil;

/**
 * @Class Name : ExcelAwareService.java
 * @Description : ExcelAwareService Class
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

public class ExcelAwareService extends BaseService {
	
	@Autowired
	SqlSession sqlSession;
	
	@Autowired
	private SqlSessionFactory sqlSessionFactory;
	

	
	protected String doDownload(HttpServletResponse response, File file, String fileName) {
		
		return doDownload(response, file, fileName, true);
	}
	
	protected String doDownload(HttpServletResponse response, File file, String fileName, boolean deleteFlag) {
		
		String encodingFileName = fileName;
		try {
			encodingFileName = new String(fileName.getBytes("EUC-KR"), "ISO-8859-1");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}  
			
		response.setHeader("Cache-Control", "");
		response.setHeader("Pragma", "");

		response.setContentType("Content-type:application/octet-stream");
		response.setHeader("Content-Disposition", "attachment; filename=\"" + encodingFileName + "\";");
		response.setHeader("Content-Transfer-Encoding", "binary");

		
		BufferedInputStream 	bis = null;
		BufferedOutputStream 	bos = null;
		
		try {
				  
			bis = new BufferedInputStream(new FileInputStream(file));
			bos = new BufferedOutputStream(response.getOutputStream());
				
			byte[] buf = new byte[2048];
			int read = 0;
			while ((read = bis.read(buf)) != -1) {
				bos.write(buf, 0, read);
			}
			bos.flush();	
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (bis != null) {
			  try {
				bis.close();
			  } catch (Exception e) {
				logger.error(e);
			  }
			}
			if (bos != null) {
			  try {
				bos.close();
			  } catch (Exception e) {
				  logger.error(e);
			  }

			}
			
			if(deleteFlag) file.delete();
		}
		return fileName;
	}
	
	
	
	public File makeBigDataExcel(String sqlId, Object sqlParam , ExcelParam excelParam) {
			
		XSSFWorkbook wb = new XSSFWorkbook();
		XSSFSheet sheet = wb.createSheet(excelParam.getSheetName());
		
		Map<String, XSSFCellStyle> wbStyle = createCellStyles(wb);
		String sheetRef = sheet.getPackagePart().getPartName().getName();
		
		//local path
		File dirTarget 		= new File(excelParam.getExcelPath());
		File dirTemp 		= new File(excelParam.getExcelPath());
		
		File fTarget 	= null;
		File fTemp 		= null;
		File fXml 		= null;
		
		
		if(!dirTarget.isDirectory()) dirTarget.mkdir();
		
		if(!dirTemp.isDirectory()) 	dirTemp.mkdir();
		
		FileOutputStream fosTemp = null;
		
		try {
			String tempFileName = System.currentTimeMillis() + "";
			
			fTarget = File.createTempFile(excelParam.getFileName(), ".xlsx", dirTarget);
			fTemp = File.createTempFile("Excel", ".tmp", dirTemp);
			
			fosTemp = new FileOutputStream(fTemp);
			wb.write(fosTemp);
			
			fXml = File.createTempFile(tempFileName, ".xml", dirTemp);		
		} catch (IOException e1) {
			
			e1.printStackTrace();
		} finally {
			if(fosTemp != null)
				try {
					fosTemp.close();
				} catch (IOException e) {
					throw new RuntimeException(e);
				}
		}
		
		Writer writer = null;
		
		try {
			writer = new OutputStreamWriter(new FileOutputStream(fXml), "UTF-8");
			ExcelWriter writerExcel = new ExcelWriter(writer);
			
			writerExcel.beginSheet();
			
			FpdisysExcelResultHandler handler= new FpdisysExcelResultHandler(writerExcel, wbStyle, excelParam);
			sqlSession.select(sqlId, sqlParam, handler);
			
			writerExcel.endSheet();
		} catch (UnsupportedEncodingException e) {
			throw new RuntimeException(e);
		} catch (FileNotFoundException e) {
			throw new RuntimeException(e);
		} catch (IOException e) {
			throw new RuntimeException(e);
		} finally{
			try {
				if(writer != null) writer.close();
			} catch (IOException e) {
				throw new RuntimeException(e);
			}
		}
		
		FileOutputStream out = null;
		ZipOutputStream zos = null;
		
		try{
			out = new FileOutputStream(fTarget);
			Map sheetMap = new HashMap();
			sheetMap.put(sheetRef.substring(1), fXml);
			substitute(fTemp, sheetMap, out);
		}catch(Exception ex){
			throw new RuntimeException(ex);
		}finally{
			try {
				if (out != null)
					out.close();
			} catch (IOException e) {
				throw new RuntimeException(e);
			}
			try {
				if (zos != null)
					zos.close();
			} catch (IOException e) {
				throw new RuntimeException(e);
			}
			
			fTemp.delete();
			fXml.delete();
		}
		
		return fTarget;
		//return doExcelDownload(response, makeFileName(fileName), workBook, Integer.parseInt(propertyService.getString("excelPathLen")));
	}
	
	public File makeBigDataExcel(String sqlId, Object sqlParam , ExcelParam excelParam, ExcelResultHandler handler) {
		
		XSSFWorkbook wb = new XSSFWorkbook();
		XSSFSheet sheet = wb.createSheet(excelParam.getSheetName());
		
		Map<String, XSSFCellStyle> wbStyle = createCellStyles(wb);
		String sheetRef = sheet.getPackagePart().getPartName().getName();
		
		//local path
		File dirTarget 		= new File(excelParam.getExcelPath());
		File dirTemp 		= new File(excelParam.getExcelPath());
		
		File fTarget 	= null;
		File fTemp 		= null;
		File fXml 		= null;
		
		
		if(!dirTarget.isDirectory()) dirTarget.mkdir();
		
		if(!dirTemp.isDirectory()) 	dirTemp.mkdir();
		
		FileOutputStream fosTemp = null;
		
		try {
			String tempFileName = System.currentTimeMillis() + "";
			
			fTarget = File.createTempFile(excelParam.getFileName(), ".xlsx", dirTarget);
			fTemp = File.createTempFile("Excel", ".tmp", dirTemp);
			
			fosTemp = new FileOutputStream(fTemp);
			wb.write(fosTemp);
			
			fXml = File.createTempFile(tempFileName, ".xml", dirTemp);		
		} catch (IOException e1) {
			
			e1.printStackTrace();
		} finally {
			if(fosTemp != null)
				try {
					fosTemp.close();
				} catch (IOException e) {
					throw new RuntimeException(e);
				}
		}
		
		Writer writer = null;
		
		try {
			writer = new OutputStreamWriter(new FileOutputStream(fXml), "UTF-8");
			ExcelWriter writerExcel = new ExcelWriter(writer);
			
			writerExcel.beginSheet();
			
			
			handler.init(writerExcel, wbStyle, excelParam);
			
			sqlSession.select(sqlId, sqlParam, handler);
			
			writerExcel.endSheet();
		} catch (UnsupportedEncodingException e) {
			throw new RuntimeException(e);
		} catch (FileNotFoundException e) {
			throw new RuntimeException(e);
		} catch (IOException e) {
			throw new RuntimeException(e);
		} finally{
			try {
				if(writer != null) writer.close();
			} catch (IOException e) {
				throw new RuntimeException(e);
			}
		}
		
		FileOutputStream out = null;
		ZipOutputStream zos = null;
		
		try{
			out = new FileOutputStream(fTarget);
			Map sheetMap = new HashMap();
			sheetMap.put(sheetRef.substring(1), fXml);
			substitute(fTemp, sheetMap, out);
		}catch(Exception ex){
			throw new RuntimeException(ex);
		}finally{
			try {
				if (out != null)
					out.close();
			} catch (IOException e) {
				throw new RuntimeException(e);
			}
			try {
				if (zos != null)
					zos.close();
			} catch (IOException e) {
				throw new RuntimeException(e);
			}
			fTemp.delete();
			fXml.delete();
		}
		
		return fTarget;
		//return doExcelDownload(response, makeFileName(fileName), workBook, Integer.parseInt(propertyService.getString("excelPathLen")));
	}
	
	private void substitute(File zipfile, Map sheetMap, OutputStream out)
		throws IOException {
		
		ZipFile zip = new ZipFile(zipfile);
		ZipOutputStream zos = new ZipOutputStream(out);
	
		Enumeration<ZipEntry> en = (Enumeration<ZipEntry>) zip.entries();
		while (en.hasMoreElements()) {
			ZipEntry ze = en.nextElement();
			if (!sheetMap.containsKey(ze.getName())) {
				zos.putNextEntry(new ZipEntry(ze.getName()));
				InputStream is = zip.getInputStream(ze);
				copyStream(is, zos);
				is.close();
			}
		}

		Iterator it = sheetMap.keySet().iterator();
		while (it.hasNext()) {
			String entry = (String) it.next();
			System.out.println(entry);
			zos.putNextEntry(new ZipEntry(entry));
			InputStream is = new FileInputStream((File) sheetMap.get(entry));
			copyStream(is, zos);
			is.close();
		}
		zos.close();
	}
		
	private void copyStream(InputStream in, OutputStream out) throws IOException {
		byte[] chunk = new byte[1024];
		int count;
		while ((count = in.read(chunk)) >=0 ) {
			out.write(chunk,0,count);
		}
	}
	
	protected String makeFileName(String strFileName) {
		StringBuilder sbFileName = new StringBuilder();
		Date toDay = new Date();
		String strToDay = WoorimUtil.toStr(toDay, WoorimUtil.DATETIME_SHORT);
		sbFileName.append(strFileName);
		sbFileName.append(strToDay);
		sbFileName.append(".xls");
		
		return sbFileName.toString();
	}
	
	private Map<String, XSSFCellStyle> createCellStyles(XSSFWorkbook workBook){
		
		Map<String, XSSFCellStyle> styles = new HashMap<String, XSSFCellStyle>();
			
		XSSFFont headFont = workBook.createFont();
		headFont.setBold(true);
		headFont.setFontName("맑은 고딕");
		headFont.setColor(XSSFFont.COLOR_NORMAL);
		headFont.setFontHeight(10);
		
		XSSFFont bodyFont = workBook.createFont();
		bodyFont.setBold(false);
		bodyFont.setFontName("맑은 고딕");
		bodyFont.setColor(XSSFFont.COLOR_NORMAL);
		bodyFont.setFontHeight(10);
		
		XSSFColor gray = new XSSFColor(Color.LIGHT_GRAY);
		
		XSSFCellStyle headStyle = workBook.createCellStyle();
		headStyle.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		headStyle.setWrapText(true);
		headStyle.setFont(headFont);
		
		styles.put("head", headStyle);
		
		XSSFCellStyle bodyStyle = workBook.createCellStyle();
		bodyStyle.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		bodyStyle.setFont(bodyFont);
	  
		styles.put("body", bodyStyle);
		
		XSSFCellStyle bodyNumericStyle = workBook.createCellStyle();
		bodyNumericStyle.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		bodyNumericStyle.setDataFormat(workBook.createDataFormat().getFormat("#,##0"));
		bodyNumericStyle.setFont(bodyFont);
		
		styles.put("bodyNumeric", bodyNumericStyle);
		
		return styles;
	}
		
}
