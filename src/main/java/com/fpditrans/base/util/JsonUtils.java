package com.fpditrans.base.util;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.type.CollectionType;


import java.io.IOException;
import java.util.Collection;
/**
 * @Class Name : JsonUtils.java
 * @Description : JsonUtils Class
 *	 
 * @ JSONUtil 클래스
 * @  수정일	  수정자			  수정내용
 * @ ---------	---------	-------------------------------
 * @ 2016.07.28			최초생성
 *
 * @author 우림인포텍
 * @version 1.0
 * @see
 *
 *  Copyright (C) by woorim All right reserved.
 */
public class JsonUtils {
	private final ObjectMapper mapper;

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
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public static <T> T fromJson(String jsonStr, Class<T> cls) {
		try {
			return getMapper().readValue(jsonStr, cls);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public static <T> T fromJson(String jsonStr, TypeReference<T> typeReference) {
		try {
			return getMapper().readValue(jsonStr, typeReference);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public static JsonNode fromJson(String json) throws Exception {
		try {
			return getMapper().readTree(json);
		} catch (IOException e) {
			throw new RuntimeException(e.getMessage(), e);
		}
	}

	public static <T extends Collection> T fromJson(String jsonStr, CollectionType collectionType) {
		try {
			return getMapper().readValue(jsonStr, collectionType);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
}
