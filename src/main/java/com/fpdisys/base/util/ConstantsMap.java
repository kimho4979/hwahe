package com.fpdisys.base.util;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface ConstantsMap {

	/**
	 * RESULT_PROCESS_COMMAND
	 * <pre>
	 *  - OPENER_REFRESH[부모창 새로고침 처리]
	 *  - OPENER_RE_MOVE[부모창 새로고침후 이동 ]
	 *  - OPENER_RE_CLOSE[부모창 새로고침 후 작업창 닫음]
	 *  - CLOSE[현재 작업창 닫음 ]
	 *  - BACK[이전페이지 이동]
	 * </pre>
	 */
	public static class RESULT_PROCESS_COMMAND {
		/** 부모창 새로고침 처리 */
		public static String OPENER_REFRESH = "OPENER_REFRESH";
		/** 부모창 새로고침후 이동 */
		public static String OPENER_RE_MOVE = "OPENER_RE_MOVE";
		/** 부모창 새로고침 후 작업창 닫음 */
		public static String OPENER_RE_CLOSE = "OPENER_RE_CLOSE";
		/** 현재 작업창 닫음 */
		public static String CLOSE = "CLOSE";
		/** 이전페이지 이동 */
		public static String BACK = "BACK";
	}
	/**
	 * 세션이름 상수정의
	 * @author 최석원
	 *<pre>
	 * - userLoginVO [포털 로그인세션명]
	 * - adminLoginVO [관리자 로그인세션명]
	 * - returnURL [로그인 후 분기될 URL]
	 * - passwdCheck [비밀번호 재설정시 발행될 토큰 세션]
	 * - kcbVO [휴대폰인증시 사용되는 세션]
	 *</pre>
	 */
	public final class SESSION_KEY extends ConstWrapper {
		private static final long serialVersionUID = 1L;
		private static final Map<Object, ConstWrapper> CONST_MAP = new HashMap<Object, ConstWrapper>();

		/** 포털 로그인 세션 키 :  userLoginVO */
		public static final SESSION_KEY userLoginVO = new SESSION_KEY("userLoginVO");
		/** 관리자 로그인 세션 키 : adminLoginVO */
		public static final SESSION_KEY adminLoginVO = new SESSION_KEY("adminLoginVO");
		/** 로그인 RETURN URL 세션키 : returnURL */
		public static final SESSION_KEY returnURL = new SESSION_KEY("returnURL");

		public SESSION_KEY (Object value) {
			super (CONST_MAP, value);
		}

		public static SESSION_KEY parse(String typeStr) {
			return (SESSION_KEY) CONST_MAP.get(typeStr);
		}
	}

	/**
	 * SYSTEM_KEY : 시스템 키 Constants
	 * <pre>
	 *  - USER_SESSION_KEY[사용자 세션 키 : ssUserInfo]
	 *  - ANONYMOUS_ACCESS_BIT [익명사용자 Access Bit : 1]
	 *  - ACCESS_HISTORY_SESSION_KEY [접속 이력 맵 세션 키 : ssAccessHistory]
	 * </pre>
	 */
	public static class SYSTEM_KEY {
		/** 사용자 세션 키  : ssUserInfo */
		public static String USER_SESSION_KEY = "ssUserInfo";
		/** 모바일 사용자 세션 키  : ssUserInfo */
		public static String MOBILE_USER_SESSION_KEY = "mobileSsUserInfo";
		/** 익명사용자 Access Bit */
		public static final Long ANONYMOUS_ACCESS_BIT = 1L;
		/** 접속 이력 맵 세션 키 */
		public static String ACCESS_HISTORY_SESSION_KEY = "ssAccessHistory";
		public static final Integer ANONYMOUS_GROUP_ID = 0;
		public static final String ANONYMOUS_GROUP_NM = "익명사용자";
		/** 관리 도메인 정보 세션 키 */
		public static String CURRENT_MANAGE_DOMAIN = "ssManageDomain";
	}
	/**
	 * 사용자 기본 URL
	 * @author 이광호
	 *
	 */
	public static class FRONT_BASE_URL {
		/** 인덱스 : */
		public static final String INDEX = "/front/home/M000000000/index.do";
		/** 로그인 */
		public static final String LOGIN = "/front/user/M000000036/login.do";
		/** 회원가입 */
		public static final String JOIN = "/front/user/M000000034/join.do";
	}
	/**
	 * 모바일 기본 URL
	 * @author 이광호
	 *
	 */
	public static class MOBILE_BASE_URL {
		/** 인덱스 : */
		public static final String INDEX = "/mobile/home/M100000000/index.do";
		/** 로그인 */
		public static final String LOGIN = "/mobile/user/M000000122/login.do";
		/** 회원가입 */
		public static final String JOIN = "/mobile/user/M000000123/join.do";
	}
	/**
	 * 관리자 기본 URL
	 * @author 최석원
	 *
	 */
	public static class ADMIN_BASE_URL {
		/** 인덱스 : */
		public static final String INDEX = "/admin/home/M900000000/index.do";
		/** 로그인 */
		public static final String LOGIN = "/admin/user/M900100000/login.do";
		/** 로그인메뉴ID */
		public static final String LOGIN_MENU_ID = "M900100000";
	}
	/**
	 * 사이트 식별자 prefix
	 * @author 최석원
	 * <pre>
	 *  FRONT : 포털메뉴
	 *  ADMIN  : 관리자메뉴
	 * </pre>
	 */
	public static class SITE_PREFIX {
		public static final String FRONT = "front";
		public static final String MOBILE = "mobile";
		public static final String ADMIN = "admin";
	}
	/**
	 * URL에서 메뉴식별자의 index 위치
	 * @author 최석원
	 * <pre>
	 *  MENU_ID = 1
	 * </pre>
	 */
	public static class URI_INDEX {
		public static final int MENU_ID = 1;
	}

	/**
	 * YES ['Y' : Yes]
	 * NO ['N' : No]
	 */
	public final class YesNo extends ConstWrapper {
		private static final long serialVersionUID = 1L;
		private static final Map<Object, ConstWrapper> CONST_MAP = new HashMap<Object, ConstWrapper>();

		/** Yes : Y */
		public static final YesNo YES = new YesNo("Y",true);
		/** No  : N */
		public static final YesNo NO = new YesNo("N", false);

		private boolean ynValue;

		public YesNo(Object value, boolean yn) {
			super(CONST_MAP, value);
			ynValue = yn;
		}

		public boolean toBoolean(){
			return ynValue;
		}

		public static YesNo toYesNo(boolean yn){
			return yn ? YES : NO;
		}

		public static YesNo parseYesNo(String yn){
			return ("Y".equals(yn) || "y".equals(yn)) ? YES : NO;
		}

		public static boolean parseBoolean(String yn){
			return "Y".equals(yn) || "y".equals(yn);
		}
	}
	
	/**
	 * 신청 상태값
	 * <pre>
	 * 	- JUDGE [심사중 : J]
	 * 	- REJECT [반려 : R]
	 * 	- APPROVAL [승인 : A]
	 * </pre
	 * @author swchoi
	 *
	 */
	public final class SUBSCRIPTION_STATUS extends ConstWrapper {
		private static final long serialVersionUID = 1L;
		private static final Map<Object, ConstWrapper> CONST_MAP = new HashMap<Object, ConstWrapper>();
		
		/** 심사중 */
		public static final SUBSCRIPTION_STATUS JUDGE = new SUBSCRIPTION_STATUS("J");
		/** 반려 */
		public static final SUBSCRIPTION_STATUS REJECT = new SUBSCRIPTION_STATUS("R");
		/** 심사중 */
		public static final SUBSCRIPTION_STATUS APPROVAL = new SUBSCRIPTION_STATUS("A");
		
		public SUBSCRIPTION_STATUS(Object value) {
			super(CONST_MAP, value);
		}
		
		public static SUBSCRIPTION_STATUS parse (String typeStr) {
			return (SUBSCRIPTION_STATUS) CONST_MAP.get(typeStr);
		}
	}

	/**
	 * CRUD
	 * <pre>
	 * 	- CREATE [등록 : C]
	 *  - RETRIEVE [조회 : R]
	 *  - UPDATE [수정 : U]
	 *  - DELETE [삭제 : D]
	 * </pre>
	 */
	public final class ACTION extends ConstWrapper {
		private static final long serialVersionUID = 1L;
		private static final Map<Object, ConstWrapper> CONST_MAP = new HashMap<Object, ConstWrapper>();

		/** 등록 : C */
		public static final ACTION CREATE = new ACTION("C");
		/** 조회 : R */
		public static final ACTION RETRIEVE = new ACTION("R");
		/** 수정 : U */
		public static final ACTION UPDATE = new ACTION("U");
		/** 삭제 : D */
		public static final ACTION DELETE = new ACTION("D");

		public ACTION(Object value) {
			super(CONST_MAP, value);
		}

		public static ACTION parse(String typeStr) {
			return (ACTION) CONST_MAP.get(typeStr);
		}
	}

	/**
	 * MULTIPART_DENIED : 파일 업로드 불가 코드 Constants
	 * <pre>
	 *  - DENIED_CONTENT_TYPE : 제한 파일 형식
	 *  - DENIED_EXTENSION : 제한 확장자
	 *  - SIZE_ZERO : 파일 용량 0 Byte
	 *  - SIZE_OVER : 제한 용량 초과
	 * </pre>
	 */
	public final class MULTIPART_DENIED extends ConstWrapper {
		private static final long serialVersionUID = 1L;
		private static final Map<Object, ConstWrapper> CONST_MAP = new HashMap<Object, ConstWrapper>();
		private static final List<MULTIPART_DENIED> DESC_LIST = new ArrayList<MULTIPART_DENIED>();
		private String desc;

		/** DENIED_CONTENT_TYPE :  */
		public static final MULTIPART_DENIED DENIED_CONTENT_TYPE = new MULTIPART_DENIED( "DENIED_CONTENT_TYPE", "제한 파일 형식" );
		/** DENIED_EXTENSION :  */
		public static final MULTIPART_DENIED DENIED_EXTENSION = new MULTIPART_DENIED( "DENIED_EXTENSION", "제한 확장자" );
		/** SIZE_ZERO :  */
		public static final MULTIPART_DENIED SIZE_ZERO = new MULTIPART_DENIED( "SIZE_ZERO", "파일 용량 0 Byte" );
		/** SIZE_OVER :  */
		public static final MULTIPART_DENIED SIZE_OVER = new MULTIPART_DENIED( "SIZE_OVER", "제한 용량 초과" );

		public MULTIPART_DENIED(Object value, String desc) {
			super(CONST_MAP, value);
			this.desc = desc;
			DESC_LIST.add(this);
		}

		public static MULTIPART_DENIED parse( String typeStr ){
			return (MULTIPART_DENIED)CONST_MAP.get( typeStr );
		}

		public static final List<MULTIPART_DENIED> getDescList(){
			return DESC_LIST;
		}

		public String getDesc(){
			return desc;
		}
	}

	/**
	 * BASE_URL
	 * <pre>
	 * 	- INDEX [인덱스	   : /index.do]
	 *  - LOGIN [로그인	   : /login.do]
	 *  - LOGOUT[로그아웃  : /logout.do]
	 * </pre>
	 */
	public static class BASE_URL {
		/** 인덱스	   : /index.do */
		public static String INDEX = "/home/M000000000/index.do";
		/** 인덱스	   : /index.do */
		public static String REDIRECTINDEX = "/home/M000000000/index.do";

		/** 로그인	   : /login.do */
		public static String LOGIN = "/user/M000080000/login.do";
		/** 로그아웃  : /logout.do */
		public static String LOGOUT = "/user/M000080000/logout.do";

		/** 모바일인덱스	   : /index.do */
		public static String MOBILE_INDEX = "/mobile/home/M500000000/index.do";
		/** 모바일로그인	   : /login.do */
		public static String MOBILE_LOGIN = "/mobile/user/M506050000/login.do";
		/** 모바일로그아웃  : /logout.do */
		public static String MOBILE_LOGOUT = "/mobile/user/M506050000/logout.do";
	}

	/**
	 * USER_GROUP
	 * <pre>
	 * SUPER				- [-1 : 슈퍼관리자]
	 * ANONYMOUS			- [0 : 익명사용자]
	 * USER					- [1 : 일반사용자]
	 * ADMIN				- [3 : 일반관리자]
	 * PRODUCER				- [4 : 생산자]
	 * BUSINESS				- [5 : 직거래사업자]
	 * MANAGER				- [6 : 지자체담당자]
	 * GOVERNMENT			- [7 : 정부부처]
	 * TEMP					- [8 : 임시 사용자]
	 *
	 * </pre>
	 */
	public final class USER_GROUP extends ConstWrapper {
		private static final long serialVersionUID = 1L;
		private static final Map<Object, ConstWrapper> CONST_MAP = new HashMap<Object, ConstWrapper>();
		private static final List<USER_GROUP> DESC_LIST = new ArrayList<USER_GROUP>();
		private String desc;


		/** SUPER : 슈퍼관리자 */
		public static final USER_GROUP SUPER = new USER_GROUP( "-1", "슈퍼관리자" );
		/** ANONYMOUS : 익명사용자 */
		public static final USER_GROUP ANONYMOUS = new USER_GROUP( "0", "익명사용자" );
		/** USER : 일반회원 */
		public static final USER_GROUP USER = new USER_GROUP( "1", "일반회원" );
		/** USER : 기업회원 */
		public static final USER_GROUP BUSINESS = new USER_GROUP( "2", "기업회원" );
		/** TEMP : 임시 사용자 */
		public static final USER_GROUP TEMP = new USER_GROUP( "8", "임시 사용자" );

		public USER_GROUP(Object value, String desc) {
			super(CONST_MAP, value);
			this.desc = desc;
			DESC_LIST.add(this);
		}

		public static USER_GROUP parse( String typeStr ){
			return (USER_GROUP)CONST_MAP.get( typeStr );
		}

		public static final List<USER_GROUP> getDescList(){
			return DESC_LIST;
		}

		public String getDesc(){
			return desc;
		}
	}

	public final class BUSINESS_OPEN extends ConstWrapper {
		private static final long serialVersionUID = -467418262474397489L;
		private static final Map<Object, ConstWrapper> CONST_MAP = new HashMap<Object, ConstWrapper>();
		private static final List<BUSINESS_OPEN> DESC_LIST = new ArrayList<BUSINESS_OPEN>();
		private String desc;

		public static final BUSINESS_OPEN LISTED = new BUSINESS_OPEN("001", "상장/코스닥");
		public static final BUSINESS_OPEN AUDIT = new BUSINESS_OPEN("002", "외감");
		public static final BUSINESS_OPEN GENERAL = new BUSINESS_OPEN("003", "일반/중소");
		public static final BUSINESS_OPEN COMBINATION = new BUSINESS_OPEN("004", "흡수/합병");
		public static final BUSINESS_OPEN ETC = new BUSINESS_OPEN("005", "기타");
		public static final BUSINESS_OPEN SUSPENSION = new BUSINESS_OPEN("006", "휴/폐업");

		public BUSINESS_OPEN(Object value, String desc) {
			super(CONST_MAP, value);
			this.desc = desc;
			DESC_LIST.add(this);
		}

		public static BUSINESS_OPEN parse(String typeStr) {
			return (BUSINESS_OPEN)CONST_MAP.get(typeStr);
		}

		public static final List<BUSINESS_OPEN> getDescList() {
			return DESC_LIST;
		}

		public String getDesc() {
			return desc;
		}
	}

	/**
	 * DEFAULT_USER_ID
	 * <pre>
	 *  - ADMIN [관리자]
	 *  - ANONYMOUS [익명사용자]
	 * </pre>
	 */
	public static class DEFAULT_USER_ID {
		/** 관리자 */
		public static String ADMIN = "U000000001";
		/** 익명사용자 */
		public static String ANONYMOUS = "U000000000";
	}

	/**
	 * USER_REG_TYPE
	 * <pre>
	 * FP	- [FP : FIP 사용자]
	 * AT	- [AT : AT 통합회원]
	 * </pre>
	 */
	public static class USER_REG_TYPE {
		/** FIP 사용자 */
		public static String FP = "FP";
		/** AT 통합회원 */
		public static String AT = "AT";

		public static String getFP() {
			return FP;
		}
		public static String getAT() {
			return AT;
		}
	}

	/**
	 * MESSAGE
	 * <pre>
	 * NOT_SUPPORT - [NOT_SUPPORT : 본 서비스에서는 해당 기능을 지원하지 않습니다.]
	 * </pre>
	 */
	public final class MESSAGE extends ConstWrapper {
		private static final long serialVersionUID = 1L;
		private static final Map<Object, ConstWrapper> CONST_MAP = new HashMap<Object, ConstWrapper>();

		/** NOT_SUPPORT : 본 서비스에서는 해당 기능을 지원하지 않습니다. */
		public static final MESSAGE NOT_SUPPORT = new MESSAGE( "본 서비스에서는 해당 기능을 지원하지 않습니다." );

		public MESSAGE(Object value) {
			super(CONST_MAP, value);
		}

		public static MESSAGE parse( String typeStr ){
			return (MESSAGE)CONST_MAP.get( typeStr );
		}
	}


	public static abstract class ConstWrapper implements Serializable{
		private static final long serialVersionUID = 8751896621976432853L;

		private Object value;

		private Map<Object, ConstWrapper> constMap;

		public ConstWrapper(Map<Object, ConstWrapper> constMap, Object value){
			if(value == null){
				throw new IllegalArgumentException("ConstWrapper's constructor arguments must not be null.");
			}

			this.constMap = constMap;
			this.value = value;
			synchronized(constMap){
				constMap.put(value, this);
			}
		}

		public Object getValue(){
			return value;
		}

		@Override
		public boolean equals(Object obj) {
			if(obj == null){
				return false;
			} else if(obj == this){
				return true;
			}

			if(obj instanceof ConstWrapper){
				return this.value.equals(obj);
			} else {
				return this.value.equals(obj);
			}
		}

		@Override
		public String toString() {
			return value.toString();
		}


		public ConstWrapper parse(Object value){
			return (ConstWrapper)constMap.get(value);
		}
	}

	/**
	 * ANSWER_CODE\
	 */
	public final class ANSWER_CODE extends ConstWrapper {
		private static final long serialVersionUID = 1L;
		private static final Map<Object, ConstWrapper> CONST_MAP = new HashMap<Object, ConstWrapper>();
		private static final List<ANSWER_CODE> ANSWER_CODE = new ArrayList<ANSWER_CODE>();
		private String desc;


		public ANSWER_CODE(Object value, String desc) {
			super(CONST_MAP, value);
			this.desc = desc;
			ANSWER_CODE.add(this);
		}

		public static ANSWER_CODE parse( String typeStr ){
			return (ANSWER_CODE)CONST_MAP.get( typeStr );
		}

		public static final List<ANSWER_CODE> getDescList(){
			return ANSWER_CODE;
		}

		public String getDesc(){
			return desc;
		}


	}

	/**
	 * MENU_CODE\
	 */
	public final class MENU_CODE extends ConstWrapper {
		private static final long serialVersionUID = 1L;
		private static final Map<Object, ConstWrapper> CONST_MAP = new HashMap<Object, ConstWrapper>();
		private static final List<MENU_CODE> MENU_CODE = new ArrayList<MENU_CODE>();
		private String desc;

		public static final MENU_CODE MENU1 = new MENU_CODE("M901030101","M009010100");
		public static final MENU_CODE MENU2 = new MENU_CODE("M901040101","M010010100");
		public static final MENU_CODE MENU3 = new MENU_CODE("M901040102","M010010200");
		public static final MENU_CODE MENU4 = new MENU_CODE("M901050100","M011010000");
		public static final MENU_CODE MENU5 = new MENU_CODE("M901050102","M011010200");
		public static final MENU_CODE MENU6 = new MENU_CODE("M901050301","M011030100");


		public MENU_CODE(Object value, String desc) {
			super(CONST_MAP, value);
			this.desc = desc;
			MENU_CODE.add(this);
		}

		public static MENU_CODE parse( String typeStr ){
			return (MENU_CODE)CONST_MAP.get( typeStr );
		}

		public static final List<MENU_CODE> getDescList(){
			return MENU_CODE;
		}

		public String getDesc(){
			return desc;
		}


	}

	/**
	 * PTYPE
	 * <pre>
	 *  - BUSINESS_CARD [명함]
	 *  - CALENDAR [달력]
	 *  - CATALOG [카탈로그]
	 *  - FLYERS [전단지]
	 *  - PHOTO_BOOK [포토북]
	 * </pre>
	 */
	public static class PTYPE {
		/** 명함 */
		public static String BUSINESS_CARD = "c1";
		/** 카탈로그 */
		public static String CATALOG = "c14";
		/** 안내장/고지서 */
		public static String FLYERS = "c15";
		/** 포토북 */
		public static String PHOTO_BOOK = "c24";
		/** 포토카렌더 */
		public static String CALENDAR = "c3";
	}

	/**
	 * MULTIMEDIA_CATEGORY
	 * <pre>
	 *  - ADMIN [관리자]
	 *  - ANONYMOUS [익명사용자]
	 * </pre>
	 */
	public static class MULTIMEDIA_CATEGORY {
		/** 알람톡 */
		public static String TALK = "CD00000196";
		/** 문자 */
		public static String SMS = "CD00000238";
		public static String LMS = "CD00000239";
		public static String MMS = "CD00000240";
		/**이메일*/
		public static String EMAIL = "CD00000241";
		/**우편*/
		public static String POST = "CD00000275";
	}

	public static class EMAIL_SEND_AUTOTYPE {
		/**다매체발송*/
		public static String MULTIMEDIA = "101";
		/**첨부파일 다매체발송*/
		public static String MULTIMEDIA_FILE = "102";
		/**회원가입*/
		public static String JOIN = "101";
		/**비밀번호찾기*/
		public static String FINDPASSWORD = "101";
	}
	
	public static class CALLING_NUMBER_CERT {
		/**인증됨*/
		public static String CERT = "CD00000272";
		/**인증불가*/
		public static String NO = "CD00000273";
		/**인증전*/
		public static String YET = "CD00000274";
	}
	
	/**
	 * BOARD_NO
	 * <pre>
	 *  - NOTICE [공지사항]
	 *  - QNA [QNA]
	 *  - EVENT [이벤트]
	 * </pre>
	 */
	public static class BOARD_NO {
		/** 공지사항 */
		public static String NOTICE = "7";
		/** QNA */
		public static String QNA = "4";
		/** 이벤트 */
		public static String EVENT = "5";
	}
	
	/**
	 * 우편발송항목
	 * <pre>
	 * </pre>
	 */
	public static class POST {
		public static String CATEGORY = "CD00000296";
	}
	
	/**
	 * POINT_TYPE
	 * <pre>
	 *  - CHARGE [충전]
	 *  - SAVING [적립]
	 *  - SUBTRACT [차감]
	 * </pre>
	 */
	public static class POINT_TYPE {
		
		/** 충전 */
		public static String CHARGE = "CD00000293";
		/** 적립 */
		public static String SAVING = "CD00000292";
		/** 차감 */
		//public static String SUBTRACT = "CD00000289";
		
		public static String SUBTRACT = "CD00000289";
		
		public static String SUBTRACT(String str) {
			String code = "CD00000289";
			
			if("MMS".equals(str)) {
				code = "CD00000294";
			}
			if("SMS".equals(str)) {
				code = "CD00000295";
			}
			
			return code;
		}
	}
	
	/**
	 * 다매체 포인트차감 유형
	 * <pre>
	 * </pre>
	 */
	public static class MULTI_POINT_TYPE {
		public static String TALK = "CD00000319";
		public static String SMS = "CD00000295";
		public static String MMS = "CD00000294";
		public static String LMS = "CD00000317";
		public static String EMAIL = "CD00000318";
		public static String POST = "CD00000320";
		public static String REFUND = "CD00000366";
		
	}
	
	/**
	 * 알림톡 사용등록을위한 authKey,siteId
	 * <pre>
	 * </pre>
	 */
	public static class TALK_CREATE {
		public static String AUTHKEY = "ZTRhNWRlN2Q5MzdhYzQ0NzdkNDliNjY3OGM1MDAyOWJmMWEyNGVjZTU0ZDgxMTZhMDkzNzA0ODNjYTEzNTQyOA==";
		public static String SITEID = "postopia";
		/*public static String AUTHKEY = "MTBjYzIxMzM2OThiNjk2MDM2NWFhMGJlYzQzMzRiNTM4NDQwMGJkNzM0YzhmOGFmZmUwNTc4ZjY3M2I5MWRiNg==";
		public static String SITEID = "netpathy";*/
	}
	
	/**
	 * 회원 상태 유형
	 */
	public static class USER_STATUS {
		public static String NORMAL = "CD00000250";
		public static String LEAVE = "CD00000251";
		public static String DORMANT = "CD00000334";
	}
	
	public final class Aeskey{
		//public static String KEY = "aes256-apply-key!!";
		public static String KEY = "daskdkaljsoifgwoidlsanfslfh";
		
	}

}
