package com.fpditrans.trans.cmmn.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;

import com.fpditrans.base.util.EgovProperties;
import com.fpditrans.base.util.Globals;
import com.fpditrans.base.util.EgovResourceCloseHelper;

public class EgovNetInfo {
	// 최대 문자길이
	static final int MAX_STR_LEN = 1024;

	/**
	 * <pre>
	 * Comment : 호스트 정보를 확인한다.
	 * </pre>
	 * @return String hostStr 호스트명을 리턴한다.(테스트용 함수)
	 * @version 1.0 (2009.01.12.)
	 * @see
	 */
	public static String getHostName() throws Exception {
		// 실행할 명령을 프로퍼티 파일에서 확인한다.
		String command = EgovProperties.getPathProperty(Globals.SHELL_FILE_PATH, "SHELL." + Globals.OS_TYPE + ".getHostName");

		// 출력할 결과 (파싱대상)
		String hostStr = "";
		String tmp = "";
		BufferedReader b_err = null;
		BufferedReader b_out = null;
		try {
			Process p = Runtime.getRuntime().exec(command);
			//프로세스가 처리될때까지 대기
			p.waitFor();

			//프로세스 에러시 종료
			if (p.exitValue() != 0) {
				b_err = new BufferedReader(new InputStreamReader(p.getErrorStream()));
				while (b_err.ready()) {
				}
			}
			//프로세스 실행 성공시 결과 확인
			else {
				b_out = new BufferedReader(new InputStreamReader(p.getInputStream()));
				int i = 0;
				while (b_out.ready()) {
					//도스명령어 실행시 결과는 3번째 라인부터 출력됨..
					tmp = b_out.readLine();
					if (tmp.length() <= MAX_STR_LEN) {
						if (i > 1) {
							hostStr += tmp + "\n";
						}
						i++;
					}
				}
				// 시스템 로그 출력
			}
		} finally {
			EgovResourceCloseHelper.close(b_err, b_out);
		}
		return hostStr;
	}
}

