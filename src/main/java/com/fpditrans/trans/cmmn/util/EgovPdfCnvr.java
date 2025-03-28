package com.fpditrans.trans.cmmn.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Iterator;

import com.fpditrans.base.util.EgovWebUtil;
import com.fpditrans.base.util.EgovProperties;
import com.fpditrans.base.util.EgovBasicLogger;
import com.fpditrans.base.util.EgovResourceCloseHelper;
import com.fpditrans.base.util.EgovStringUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.artofsolving.jodconverter.DocumentConverter;
import com.artofsolving.jodconverter.openoffice.connection.SocketOpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.converter.OpenOfficeDocumentConverter;

public class EgovPdfCnvr {
	public static String addrIP = "";
	static final char FILE_SEPARATOR = File.separatorChar;
	// 최대 문자길이
	static final int MAX_STR_LEN = 1024;

	public static final int BUFF_SIZE = 2048;

	/**
	 * <pre>
	 * Comment : doc, xls 파일등을 PDF변환 변환한다. .
	 * </pre>
	 * @param String pdfFileSrc		doc, xls 파일 전체경로
	 * @param String targetPdf		 변환파일명(확장자 제외)
	 * @return boolean  status		 true/false 를 리턴한다.
	 * @version 1.0 (2009.02.10)
	 * @see
	 */
	public static boolean getPDF(String targetPdf, HttpServletRequest request, HttpServletResponse response) throws Exception {
		boolean status = false;

		try {
			MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest) request;
			Iterator<String> file_iter = mptRequest.getFileNames();

			while (file_iter.hasNext()) {
				MultipartFile mFile = mptRequest.getFile((String) file_iter.next());

				if (mFile.getSize() > 0) {

					//Write File 이후 Move File????
					String newName = "";
					String stordFilePath = EgovProperties.getProperty("Globals.fileStorePath");
					
					//String orginFileName = mFile.getOriginalFilename();
					//int index = orginFileName.lastIndexOf(".");
					//String fileExt = orginFileName.substring(index + 1);

					//newName 은 Naming Convention에 의해서 생성
					newName = EgovStringUtil.getTimeStamp();
					writeFile(mFile, newName, stordFilePath);

					String pdfFileSrcValue = stordFilePath.replace('\\', FILE_SEPARATOR).replace('/', FILE_SEPARATOR);
					File inputFile = new File(EgovWebUtil.filePathBlackList(pdfFileSrcValue + newName));

					if (inputFile.exists()) {
						// connect to an OpenOffice.org instance running on port 8100
						SocketOpenOfficeConnection connection = new SocketOpenOfficeConnection(8100);
						connection.connect();
						//원본 디렉토리에 targetPdf 명칭지정
						String valueFile = null;
						valueFile = inputFile.getParent().replace('\\', FILE_SEPARATOR).replace('/', FILE_SEPARATOR);
						File outputFile = new File(valueFile + "/" + targetPdf + ".pdf");
						// convert
						DocumentConverter converter = new OpenOfficeDocumentConverter(connection);
						converter.convert(inputFile, outputFile);
						// close the connection
						connection.disconnect();

						if (inputFile.exists()) {
							//3. 삭제해줍니다.
							status = inputFile.delete();
						}
						status = true;
					} else {
						status = false;
					}
				}
			}
		} catch (IOException ex) {
			EgovBasicLogger.debug("PDF converting error", ex);

			status = false;
		}
		// 메소드 종료 Log
		return status;
	}

	/**
	 * 파일을 실제 물리적인 경로에 생성한다.
	 * @param file
	 * @param newName
	 * @param stordFilePath
	 * @throws Exception
	 */
	protected static void writeFile(MultipartFile file, String newName, String stordFilePath) throws IOException {
		InputStream stream = null;
		OutputStream bos = null;

		try {
			stream = file.getInputStream();
			File cFile = new File(EgovWebUtil.filePathBlackList(stordFilePath));

			if (!cFile.isDirectory())
				cFile.mkdir();

			bos = new FileOutputStream(EgovWebUtil.filePathBlackList(stordFilePath + File.separator + newName));

			int bytesRead = 0;
			byte[] buffer = new byte[BUFF_SIZE];

			while ((bytesRead = stream.read(buffer, 0, BUFF_SIZE)) != -1) {
				bos.write(buffer, 0, bytesRead);
			}

		} finally {
			EgovResourceCloseHelper.close(bos, stream);
		}
	}
}
