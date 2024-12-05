package com.fpdisys.base.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fpdisys.base.service.CacheService;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import net.sf.ehcache.Ehcache;
import net.sf.ehcache.Element;


/**
 * <pre>
 * wenbiz.core.cache.service.impl
 * CacheServiceImpl.java
 * </pre>
 * @author mskim
 * @description Cache Common Service Implements Class
 * @since 2017. 6. 20.
 * @version 1.0
 */
@Service("cacheService")
public class CacheServiceImpl extends EgovAbstractServiceImpl implements CacheService {

	/**
	 * Cache Resource Load
	 */
	@Resource(name="ehcache")
	private Ehcache gCache;

	/* (non-Javadoc)
	 * @see wenbiz.core.cache.service.CacheService#getCache(java.lang.String)
	 */
	public Ehcache getCache( String cacheSetName ) {
		Ehcache cache = this.gCache.getCacheManager().getCache( cacheSetName );
		return cache;
	}

	
	/* (non-Javadoc)
	 * @see wenbiz.core.cache.service.CacheService#setCacheObject(java.lang.String, java.lang.String, java.lang.Object)
	 */
	public void setCacheObject(String cacheSetName, String cacheKeyName, Object obj) {
		try {
			Ehcache cache = getCache(cacheSetName);
			cache.put(new Element(cacheKeyName, obj));
		} catch (Exception e) {
			egovLogger.error(e.getMessage(), e);
		} finally {
			egovLogger.debug(":::::::::::::::::: 캐싱 수행 완료 [ cache set name = " + cacheSetName + " : cache key name = " + cacheKeyName + " ] ::::::::::::::::::");
		}
	}

	/**
	 * 캐시 메모리 삽입 데이터 반환
	 */
	public Object getCacheObject(String cacheSetName, String cacheKeyName) {
		Object obj = null;
		// 캐쉬 데이터 조회
		Ehcache cache = getCache(cacheSetName);
		if(cache != null) {
			Element value = cache.get(cacheKeyName);
			if(value != null) {
				obj = (Object) value.getValue();
			}
		}
		return obj;
	}
}