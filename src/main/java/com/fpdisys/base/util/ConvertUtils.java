package com.fpdisys.base.util;

import java.lang.reflect.Field;
import java.util.*;

public class ConvertUtils {
    private ConvertUtils() {}

    public static Map<String, Object> convertToMap(Object obj) {
        try {
            if (null == (obj)) {
                return Collections.emptyMap();
            }
            Map<String, Object> convertMap = new HashMap<>();

            Field[] fields = obj.getClass().getDeclaredFields();

            for (Field field : fields) {
                field.setAccessible(true);
                convertMap.put(field.getName(), field.get(obj));
            }
            return convertMap;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public static <T> T convertToValueObject(Map<String, Object> map, Class<T> type) {
        try {
            Objects.requireNonNull(type, "Class cannot be null");
            T instance = type.getConstructor().newInstance();

            if (map == null || map.isEmpty()) {
                return instance;
            }

            Field[] fields = type.getDeclaredFields();

            for (Map.Entry<String, Object> entry : map.entrySet()) {
                String key = entry.getKey();
                Object value = entry.getValue();

                for (Field field : fields) {
                    field.setAccessible(true);
                    String name = field.getName();

                    if (value != null) {
                        boolean isSameType = value.getClass().equals(getReferenceType(field.getType()));
                        boolean isSameName = key.equals(name);

                        if (isSameType && isSameName) {
                            field.set(instance, map.get(name));
                            break;
                        }
                    }
                }
            }
            return instance;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public static List<Map<String, Object>> convertToMaps(List<?> list) {
        if (list == null || list.isEmpty()) {
            return Collections.emptyList();
        }
        List<Map<String, Object>> convertList = new ArrayList<>(list.size());

        for (Object obj : list) {
            convertList.add(ConvertUtils.convertToMap(obj));
        }
        return convertList;
    }

    public static <T> List<T> convertToValueObjects(List<Map<String, Object>> list, Class<T> type) {
        Objects.requireNonNull(type, "Class cannot be null");

        if (list == null || list.isEmpty()) {
            return Collections.emptyList();
        }
        List<T> convertList = new ArrayList<>(list.size());

        for (Map<String, Object> map : list) {
            convertList.add(ConvertUtils.convertToValueObject(map, type));
        }
        return convertList;
    }

    private static Class<?> getReferenceType(Class<?> type) {
        switch (type.getName()) {
            case "boolean" : return Boolean.class;
            case "byte"    : return Byte.class;
            case "short"   : return Short.class;
            case "char"    : return Character.class;
            case "int"     : return Integer.class;
            case "long"    : return Long.class;
            case "float"   : return Float.class;
            case "double"  : return Double.class;
            default        : return type;
        }
    }
}