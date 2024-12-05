package com.fpdisys.base.service;

import net.sf.ehcache.Ehcache;

/**
 * <pre>
 * wenbiz.core.cache.service
 * CacheService.java
 * </pre>
 * @author mskim
 * @description 캐시 서비스 
 * @since 2017. 6. 20.
 * @version 1.0
 */
public interface CacheService {
	
	/**
	 * <pre>
	 * 메소드명 : getCache
	 * 작성일 : 2017. 6. 20.
	 * 작성자 : mskim
	 * 설명 : 캐쉬 셋팅 객체 반환 
	 * </pre>
	 * @param cacheSetName
	 * @return
	 */
	public Ehcache getCache(String cacheSetName);

	
	/**
	 * <pre>
	 * 메소드명 : setCacheObject
	 * 작성일 : 2017. 6. 20.
	 * 작성자 : mskim
	 * 설명 : 캐시 메모리 삽입 
	 * </pre>
	 * @param cacheSetName
	 * @param cacheKeyName
	 * @param obj
	 */
	public void setCacheObject(String cacheSetName, String cacheKeyName, Object obj);

	
	/**
	 * <pre>
	 * 메소드명 : getCacheObject
	 * 작성일 : 2017. 6. 20.
	 * 작성자 : mskim
	 * 설명 : 캐시 메모리 삽입 데이터 반환 
	 * </pre>
	 * @param cacheSetName
	 * @param cacheKeyName
	 * @return
	 */
	public Object getCacheObject(String cacheSetName, String cacheKeyName);
}
