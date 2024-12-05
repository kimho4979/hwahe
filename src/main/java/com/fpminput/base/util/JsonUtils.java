package com.fpminput.base.util;

import java.io.IOException;
import java.util.Collection;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.MapperFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.databind.type.CollectionType;

public class JsonUtils {
	private final ObjectMapper mapper;

	protected final static Log log = LogFactory.getLog(JsonUtils.class);
	
	private JsonUtils() {
		mapper = new ObjectMapper();
		mapper.configure(SerializationFeature.FAIL_ON_EMPTY_BEANS, false);
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		mapper.configure(MapperFeature.AUTO_DETECT_GETTERS, true);
		mapper.configure(MapperFeature.AUTO_DETECT_IS_GETTERS, true);
		mapper.configure(JsonParser.Feature.ALLOW_SINGLE_QUOTES, true);
		mapper.configure(MapperFeature.DEFAULT_VIEW_INCLUSION, false);
	}

	public static JsonUtils getInstance() {
		return new JsonUtils();
	}

	private static ObjectMapper getMapper() {
		return getInstance().mapper;
	}

	public static String toJson(Object object) {
		try {
			return getMapper().writeValueAsString(object);
		} catch (IOException e) {
			log.debug("입출력 오류!!");
			return "";
		} catch (ArithmeticException e) {
			log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
			return "";
		} catch (NumberFormatException e) {
			log.error("오류발생 숫자로 변환 할 수 없습니다!!");
			return "";
		} catch (ArrayIndexOutOfBoundsException e) {
			log.error("오류발생 배열인텍스에서 벗어났습니다!!");
			return "";
		} catch (NegativeArraySizeException e) {
			log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
			return "";
		} catch (NullPointerException e) {
			log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
			return "";
		} catch (NoSuchMethodError e) {
			log.error("오류발생 메서드를 찾을수 없습니다!!");
			return "";
		} catch (NoClassDefFoundError e) {
			log.error("오류발생 클래스를 찾을 수 없습니다!!");
			return "";
		} catch (RuntimeException e) {
			log.error("오류발생 런타임!!");
			return "";
		} catch (Exception e) {
			log.error("오류발생!! ");
			return "";
		} 
	}

	public static <T> T fromJson(String jsonStr, Class<T> cls) {
		try {
			return getMapper().readValue(jsonStr, cls);
		} catch (IOException e) {
			log.debug("입출력 오류!!");
			return null;
		} catch (ArithmeticException e) {
			log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
			return null;
		} catch (NumberFormatException e) {
			log.error("오류발생 숫자로 변환 할 수 없습니다!!");
			return null;
		} catch (ArrayIndexOutOfBoundsException e) {
			log.error("오류발생 배열인텍스에서 벗어났습니다!!");
			return null;
		} catch (NegativeArraySizeException e) {
			log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
			return null;
		} catch (NullPointerException e) {
			log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
			return null;
		} catch (NoSuchMethodError e) {
			log.error("오류발생 메서드를 찾을수 없습니다!!");
			return null;
		} catch (NoClassDefFoundError e) {
			log.error("오류발생 클래스를 찾을 수 없습니다!!");
			return null;
		} catch (RuntimeException e) {
			log.error("오류발생 런타임!!");
			return null;
		} catch (Exception e) {
			log.error("오류발생!! ");
			return null;
		}
		
	}

	public static <T> T fromJson(String jsonStr, TypeReference<T> typeReference) {
		try {
			return getMapper().readValue(jsonStr, typeReference);
		} catch (IOException e) {
			log.debug("입출력 오류!!");
			return null;
		} catch (ArithmeticException e) {
			log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
			return null;
		} catch (NumberFormatException e) {
			log.error("오류발생 숫자로 변환 할 수 없습니다!!");
			return null;
		} catch (ArrayIndexOutOfBoundsException e) {
			log.error("오류발생 배열인텍스에서 벗어났습니다!!");
			return null;
		} catch (NegativeArraySizeException e) {
			log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
			return null;
		} catch (NullPointerException e) {
			log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
			return null;
		} catch (NoSuchMethodError e) {
			log.error("오류발생 메서드를 찾을수 없습니다!!");
			return null;
		} catch (NoClassDefFoundError e) {
			log.error("오류발생 클래스를 찾을 수 없습니다!!");
			return null;
		} catch (RuntimeException e) {
			log.error("오류발생 런타임!!");
			return null;
		} catch (Exception e) {
			log.error("오류발생!! ");
			return null;
		}
	}

	public static JsonNode fromJson(String json) throws Exception {
		try {
			return getMapper().readTree(json);
		} catch (IOException e) {
			log.debug("입출력 오류!!");
			return null;
		} catch (ArithmeticException e) {
			log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
			return null;
		} catch (NumberFormatException e) {
			log.error("오류발생 숫자로 변환 할 수 없습니다!!");
			return null;
		} catch (ArrayIndexOutOfBoundsException e) {
			log.error("오류발생 배열인텍스에서 벗어났습니다!!");
			return null;
		} catch (NegativeArraySizeException e) {
			log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
			return null;
		} catch (NullPointerException e) {
			log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
			return null;
		} catch (NoSuchMethodError e) {
			log.error("오류발생 메서드를 찾을수 없습니다!!");
			return null;
		} catch (NoClassDefFoundError e) {
			log.error("오류발생 클래스를 찾을 수 없습니다!!");
			return null;
		} catch (RuntimeException e) {
			log.error("오류발생 런타임!!");
			return null;
		} catch (Exception e) {
			log.error("오류발생!! ");
			return null;
		}
	}

	public static <T extends Collection> T fromJson(String jsonStr, CollectionType collectionType) {
		try {
			return getMapper().readValue(jsonStr, collectionType);
		} catch (IOException e) {
			log.debug("입출력 오류!!");
			return null;
		} catch (ArithmeticException e) {
			log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
			return null;
		} catch (NumberFormatException e) {
			log.error("오류발생 숫자로 변환 할 수 없습니다!!");
			return null;
		} catch (ArrayIndexOutOfBoundsException e) {
			log.error("오류발생 배열인텍스에서 벗어났습니다!!");
			return null;
		} catch (NegativeArraySizeException e) {
			log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
			return null;
		} catch (NullPointerException e) {
			log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
			return null;
		} catch (NoSuchMethodError e) {
			log.error("오류발생 메서드를 찾을수 없습니다!!");
			return null;
		} catch (NoClassDefFoundError e) {
			log.error("오류발생 클래스를 찾을 수 없습니다!!");
			return null;
		} catch (RuntimeException e) {
			log.error("오류발생 런타임!!");
			return null;
		} catch (Exception e) {
			log.error("오류발생!! ");
			return null;
		}
	}
}

