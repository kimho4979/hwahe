package com.fpditrans.base.mvc;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.fpditrans.base.mvc.BaseObject;

/**
 * @Class Name : SqlService.java
 * @Description : SqlService Class
 * @Modification Information
 * @
 * @  수정일	  수정자			  수정내용
 * @ ---------	---------	-------------------------------
 * @ 2016.08.16			최초생성
 *
 * @author 우림인포텍
 * @since 2016. 03.16
 * @version 1.0
 * @see
 *
 *  Copyright (C) by WOORIM All right reserved.
 */

public class SqlService extends  BaseObject {
	

	// context-mapper에서 생성되는 sqlSession이 실제 org.mybatis.spring.SqlSessionFactoryBean 이 아님 
	// 왜 그런지는 모르겠음 하여튼 crypto aop 적용후 동작이 이상해져서 
	// 실제 org.apache.ibatis.session.defaults.DefaultSqlSessionFactory로
	// 생성되므로 type 관련해서 아래와 같이 source기 변경됨
		
//		@Autowired  
////		@Resource(name="sqlSession")
//		protected SqlSessionFactoryBean  sqlSession;
//		protected SqlSessionFactory sqlSessionFactory ;
//		protected SqlSession sqlOpen ;
//		public SqlSession Open()  {
//			try {
//				sqlSessionFactory = sqlSession.getObject();
//				sqlOpen = sqlSessionFactory.openSession();
//			} catch (Exception e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//			return sqlOpen;
//		}
	  
//		public int insert(String queryId, Map<String, Object>  p_hashMap) {
//			return insert(queryId, p_hashMap);
//		}
	// 
//		public int update(String queryId, Map<String, Object> p_hashMap) {
//			return update(queryId, p_hashMap);
//		}
	// 
//		public int delete(String queryId, Map<String, Object> p_hashMap) {
//			return delete(queryId, p_hashMap);
//		}
	// 
//		public List<?> select(String queryId, Map<String, Object> p_hashMap) {
//			return select(queryId, p_hashMap);
//		}

		
		
		///=================================
//		@Resource(name="sqlSession")
		@Autowired  
		protected org.apache.ibatis.session.defaults.DefaultSqlSessionFactory  sqlSession;
//		protected SqlSessionFactory sqlSessionFactory ;
		protected SqlSession sqlOpen ;
	  

		public SqlSession open()  {
			try {
				sqlOpen = sqlSession.openSession() ;
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return sqlOpen;
		}

		public void close()  {
			try {
				sqlOpen.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				//e.printStackTrace();
				dummyCatch();
			}
		}

	}

