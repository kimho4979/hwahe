package com.fpdisys.base.util;

import java.awt.AlphaComposite;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.Closeable;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InterruptedIOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.drew.imaging.ImageMetadataReader;
import com.drew.metadata.Directory;
import com.drew.metadata.Metadata;
import com.drew.metadata.exif.ExifIFD0Directory;

@Component("fileUtils")
public class FileUtils {
//private static final String filePath = "D:\\dev\\file\\";
	private static final String filePath = "/usr/webapps/upload/";
	//private static final String filePath = "C:\\Flower\\eGovFrameDev-3.5.1-64bit\\workspace\\fpminput\\src\\main\\webapp\\upload\\";
	//private static final String filePath = "C:\\FLOWER\\files\\";
	public static final int BUFF_SIZE = 2048;
	
	@Autowired
	ServletContext servletContext;
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	public List<Map<String,Object>> parseInsertFileInfo(Map<String,Object> pRequestParamMap, HttpServletRequest request) throws Exception{
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
		Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
		
		
	    File logoFile = new File( servletContext.getRealPath("/images/main/logo2.png") );

		
		MultipartFile multipartFile = null;
		String originalFileName = null;
		String originalFileExtension = null;
		String storedFileName = null;
		
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		Map<String, Object> listMap = null; 
		
		String boardIdx = (String)pRequestParamMap.get("IDX");
		
		File file = new File(filePath);
		if(file.exists() == false){
			file.mkdirs();
		}
		
		while(iterator.hasNext()){
			multipartFile = multipartHttpServletRequest.getFile(iterator.next());
			if(multipartFile.isEmpty() == false){
				originalFileName = multipartFile.getOriginalFilename();
				originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
				originalFileExtension = ".img";
				storedFileName = CommonUtils.getRandomString() + originalFileExtension;
		
				file = new File(filePath + storedFileName);
				if(file.exists() == true)
					file.delete();
				
				makeWatermark(multipartFile, logoFile, filePath+storedFileName);
				//multipartFile.transferTo(file);
				
				listMap = new HashMap<String,Object>();
				listMap.put("CROP_IDX", boardIdx);
				listMap.put("ORIGINAL_FILE_NAME", originalFileName);
				listMap.put("STORED_FILE_NAME", storedFileName);
				listMap.put("FILE_SIZE", multipartFile.getSize());
				list.add(listMap);
			}
		}
		return list;
	}
	
	/**
	 * 서버의 파일을 다운로드한다.
	 *
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public void downFile(String downFileIn, String orgFileNameIn, HttpServletRequest request, HttpServletResponse response) throws Exception {

		String downFileName = null;
		if(downFileIn.indexOf("/admin/img/loc/") != -1)
			downFileName = downFileIn.substring(downFileIn.indexOf("/admin/img/loc/"), downFileIn.length());
		else downFileName = downFileIn;
		downFileName = filePath+downFileName.split("/")[4];
		String orgFileName = orgFileNameIn;

		orgFileName = orgFileName.replaceAll("\r", "").replaceAll("\n", "");

		File file = new File(filePathBlackList(downFileName));

		if (!file.exists()) {
			throw new FileNotFoundException(downFileName);
		}

		if (!file.isFile()) {
			throw new FileNotFoundException(downFileName);
		}
		BufferedInputStream fin = null;
		BufferedOutputStream outs = null;
		
		try {
			if (file.exists() && file.isFile()) {
				response.setContentType("application/octet-stream; charset=utf-8");
				response.setContentLength((int) file.length());
				String browser = getBrowser(request);
				String disposition = getDisposition(orgFileName, browser);
				System.out.println(browser);
				System.out.println(disposition);
				response.setHeader("Content-Disposition", disposition);
				response.setHeader("Content-Transfer-Encoding", "binary");
				
				byte[] buffer = new byte[BUFF_SIZE]; //buffer size 2K.
				System.out.println("파일쓰기---------------------");
				fin = new BufferedInputStream(new FileInputStream(file));
				outs = new BufferedOutputStream(response.getOutputStream());
				System.out.println("파일쓰기---------------------준비완료"); 
				int read = 0;

				while ((read = fin.read(buffer)) != -1) {
					outs.write(buffer, 0, read);
					
				}
				System.out.println("파일완료............................");
			}
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
		} finally {
			if (fin != null) {
				  try {
					  fin.close();
				  } catch (IOException e) {
					  log.error("IOException !!" + e.getStackTrace());
				  }
			}
			if (outs != null) {
				try {
					outs.close();
				} catch (IOException e) {
					log.error("IOException !!" + e.getStackTrace());
				}
			}
		}
		
	}
	public static String filePathBlackList(String value) {
		String returnValue = value;
		if (returnValue == null || returnValue.trim().equals("")) {
			return "";
		}

		returnValue = returnValue.replaceAll("\\.\\./", ""); // ../
		returnValue = returnValue.replaceAll("\\.\\.\\\\", ""); // ..\

		return returnValue;
	}

	/**
	 * Resource close 처리.
	 * @param resources
	 */
	public void close(Closeable  ... resources) {
		for (Closeable resource : resources) {
			if (resource != null) {
				try {
					resource.close();
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
			}
		}
	}

	private String getBrowser(HttpServletRequest request) {
		String header = request.getHeader("User-Agent");
		if (header.indexOf("MSIE") > -1 || header.indexOf("Trident") > -1)
			return "MSIE";
		else if (header.indexOf("Chrome") > -1)
			return "Chrome";
		else if (header.indexOf("Opera") > -1)
			return "Opera";
		return "Firefox";
	}

	private String getDisposition(String filename, String browser) throws UnsupportedEncodingException {
		String dispositionPrefix = "attachment;filename=\"";
		String encodedFilename = null;
		if (browser.equals("MSIE")) {
			encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
		} else if (browser.equals("Firefox")) {
			encodedFilename = "" + new String(filename.getBytes("UTF-8"), "8859_1") + "";
		} else if (browser.equals("Opera")) {
			encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
		} else if (browser.equals("Chrome")) {
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < filename.length(); i++) {
				char c = filename.charAt(i);
				if (c > '~') {
					sb.append(URLEncoder.encode("" + c, "UTF-8"));
				} else {
					sb.append(c);
				}
			}
			encodedFilename = sb.toString();
		} 
		return dispositionPrefix + encodedFilename+"\"";
	}
	
	private static BufferedImage rotateImage (BufferedImage bimage, int radians) {
		BufferedImage newImage;
		if(radians == 90 || radians == 270) {
			newImage = new BufferedImage(bimage.getHeight(),bimage.getWidth(),bimage.getType());
		} else if (radians==180){
			newImage = new BufferedImage(bimage.getWidth(),bimage.getHeight(),bimage.getType());
	 	} else{
			return bimage;
		}
		Graphics2D graphics = (Graphics2D) newImage.getGraphics();
		graphics.rotate(Math.toRadians(radians), newImage.getWidth() / 2, newImage.getHeight() / 2);
		graphics.translate((newImage.getWidth() - bimage.getWidth()) / 2, (newImage.getHeight() - bimage.getHeight()) / 2);
		graphics.drawImage(bimage, 0, 0, bimage.getWidth(), bimage.getHeight(), null);

		return newImage;
	}
	
	public static String makeWatermark(MultipartFile src,  File src2, String dest) throws Exception {
        
		BufferedImage srcImage2 = ImageIO.read(src2);
        
        int orientation = 1;
        
        BufferedInputStream bis = new BufferedInputStream(src.getInputStream());
		
        
        
        Metadata metadata = ImageMetadataReader.readMetadata(bis);
  
        
        
        InputStream targetStream = new ByteArrayInputStream(src.getBytes());
        BufferedImage srcImage = ImageIO.read(targetStream);
        
        
        
        Directory directory = metadata.getFirstDirectoryOfType(ExifIFD0Directory.class);
        if(directory != null){
        	orientation = directory.getInt(ExifIFD0Directory.TAG_ORIENTATION);
        }
        
        if(orientation == 6){
        	srcImage = rotateImage(srcImage, 90);
        } else if (orientation == 3){
        	srcImage = rotateImage(srcImage, 180);
        } else if(orientation == 8){
        	srcImage = rotateImage(srcImage, 270);
        }
        
        int width = srcImage.getWidth(null);
        int height = srcImage.getHeight(null);
        BufferedImage destImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics g = destImage.getGraphics();
        g.drawImage(srcImage, 0, 0, width, height, null);
        g.drawImage(rotate(srcImage2,45.0), 0 , 0 , width  , height  , null);
        g.finalize();
        g.dispose();
        ImageIO.write(destImage, "png", new File(dest));
        return "";
    }
	
	
    
    public static BufferedImage rotate(BufferedImage bimg, Double angle) {
        double sin = Math.abs(Math.sin(Math.toRadians(angle))),
               cos = Math.abs(Math.cos(Math.toRadians(angle)));
        int w = bimg.getWidth();
        int h = bimg.getHeight();
        int neww = (int) Math.floor(w*cos + h*sin),
            newh = (int) Math.floor(h*cos + w*sin);
        BufferedImage rotated = new BufferedImage(neww, newh,  java.awt.Transparency.TRANSLUCENT);
        Graphics2D graphic = rotated.createGraphics();
        graphic.translate((neww-w)/2, (newh-h)/2);
        graphic.rotate(Math.toRadians(angle), w/2, h/2);
        float alpha = (float)0.3; //draw half transparent
        AlphaComposite ac = AlphaComposite.getInstance(AlphaComposite.SRC_OVER,alpha);
        graphic.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
        graphic.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
        graphic.setComposite(ac);
        graphic.drawRenderedImage(bimg, null);
        graphic.dispose();
        return rotated;
    }

}
