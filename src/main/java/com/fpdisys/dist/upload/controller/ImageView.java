package com.fpdisys.dist.upload.controller;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.AbstractView;

import com.fpdisys.dist.upload.controller.ImageFile;

@Component("imageView")
public class ImageView extends AbstractView {

	protected Log log = LogFactory.getLog(this.getClass());
	
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		ImageFile imageFile = (ImageFile)model.get("imageFile");
		
		res.setContentLength(imageFile.getContentLength());
		res.setContentType(imageFile.getContentType());
		
		byte[] bytes = readFile(imageFile.getFileName());
		write(res, bytes);
	}
	
	/**
	 * 파일로부터 byte 배열 읽어오기 
	 */
	private byte[] readFile(String fileName) throws IOException {
		String path = ImageFile.IMAGE_DIR + fileName;
		
		BufferedInputStream bis = null;
		byte[] bytes = null;
		try {
			bis = new BufferedInputStream(new FileInputStream(path));
			int length = bis.available();
			bytes = new byte[length];
			bis.read(bytes);
			bis.close();
		} catch (IOException e) {
			 log.error("IOException !!" + e.getStackTrace());
		} finally {
			if (bis != null) {
				  try {
					  bis.close();
				  } catch (IOException e) {
					  log.error("IOException !!" + e.getStackTrace());
				  }
			}
		}
		
		return bytes;
	}
	
	/**
	 * 응답 OutputStream에 파일 내용 쓰기
	 */
	private void write(HttpServletResponse res, byte[] bytes) throws IOException {
		OutputStream output = res.getOutputStream();
		output.write(bytes);
		output.flush();
	}
}
