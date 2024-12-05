package com.fpminput.base.util;

import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.UUID;

import org.apache.log4j.Logger;

public class CommonUtils {
private static final Logger log = Logger.getLogger(CommonUtils.class);
	
	public static String getRandomString(){
		return UUID.randomUUID().toString().replaceAll("-", "");
	}
	
	public static void printMap(Map<String,Object> map){
		Iterator<Entry<String,Object>> iterator = map.entrySet().iterator();
		Entry<String,Object> entry = null;
		log.info("--------------------printMap--------------------\n");
		while(iterator.hasNext()){
			entry = iterator.next();
			log.debug("key : "+entry.getKey()+",\tvalue : "+entry.getValue());
		}
		log.info("");
		log.info("------------------------------------------------\n");
	}
}
