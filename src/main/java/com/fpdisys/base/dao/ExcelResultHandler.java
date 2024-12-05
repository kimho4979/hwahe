package com.fpdisys.base.dao;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InterruptedIOException;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.ResultContext;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;

import com.fpdisys.base.excel.ExcelParam;
import com.fpdisys.base.excel.ExcelWriter;

public abstract class ExcelResultHandler extends BaseResultHandlerImpl{
	
	protected Log log = LogFactory.getLog(this.getClass());
	
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
			
		} catch (InterruptedIOException  e) {
			log.error("입출력 오류 입출력 도중에 알수없는 인터럽트가 발생하였습니다!!");
		} catch (FileNotFoundException e) {
			log.error("입출력 오류 파일을 찾을 수 없습니다!!");
		} catch (IOException e) {
			log.debug("입출력 오류!!");
		} catch (ArithmeticException e) {
			log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
		} catch (NumberFormatException e) {
			log.error("오류발생 숫자로 변환 할 수 없습니다!!");
		} catch (ArrayIndexOutOfBoundsException e) {
			log.error("오류발생 배열인텍스에서 벗어났습니다!!");
		} catch (NegativeArraySizeException e) {
			log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
		} catch (NullPointerException e) {
			log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
		} catch (NoSuchMethodError e) {
			log.error("오류발생 메서드를 찾을수 없습니다!!");
		} catch (NoClassDefFoundError e) {
			log.error("오류발생 클래스를 찾을 수 없습니다!!");
		} catch (RuntimeException e) {
			log.error("오류발생 런타임!!");
		} catch (Exception e) {
			log.error("오류발생!!");
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
		} catch (InterruptedIOException  e) {
			log.error("입출력 오류 입출력 도중에 알수없는 인터럽트가 발생하였습니다!!");
		} catch (FileNotFoundException e) {
			log.error("입출력 오류 파일을 찾을 수 없습니다!!");
		} catch (IOException e) {
			log.debug("입출력 오류!!");
		} catch (ArithmeticException e) {
			log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
		} catch (NumberFormatException e) {
			log.error("오류발생 숫자로 변환 할 수 없습니다!!");
		} catch (ArrayIndexOutOfBoundsException e) {
			log.error("오류발생 배열인텍스에서 벗어났습니다!!");
		} catch (NegativeArraySizeException e) {
			log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
		} catch (NullPointerException e) {
			log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
		} catch (NoSuchMethodError e) {
			log.error("오류발생 메서드를 찾을수 없습니다!!");
		} catch (NoClassDefFoundError e) {
			log.error("오류발생 클래스를 찾을 수 없습니다!!");
		} catch (RuntimeException e) {
			log.error("오류발생 런타임!!");
		} catch (Exception e) {
			log.error("오류발생!!");
		}
		this.rowNum ++;
	}



	
	
}

