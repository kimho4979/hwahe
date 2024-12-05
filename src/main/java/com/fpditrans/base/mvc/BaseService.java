package com.fpditrans.base.mvc;

import javax.annotation.Resource;

import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.fpditrans.base.mvc.BaseObject;

/**
 * @Class Name : BaseService.java
 * @Description : BaseService Class
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

public class BaseService extends BaseObject{

//  
//	//---------------------------------
//	// transaction
//	//---------------------------------
//
	@Resource(name="txManager")
  public DataSourceTransactionManager txManager;
//	
	private DefaultTransactionDefinition mTxDefinition = null;
	private TransactionStatus mTxStatus = null;
//	private DataSourceTransactionManager txManager = null;

	protected void startTx()
	{
		
		mTxDefinition = new DefaultTransactionDefinition();	
		mTxDefinition.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);	

		mTxStatus = txManager.getTransaction(mTxDefinition);
	}
  
  protected void commit(){
  	
  	try{
  		txManager.commit(mTxStatus);
  	}catch ( org.springframework.transaction.IllegalTransactionStateException e)
  	{
  		return;
  	}		
  }
  
  protected void rollback(){
  	
  	try{
  		txManager.rollback(mTxStatus);
  	}catch ( org.springframework.transaction.IllegalTransactionStateException e)
  	{
  		return;
  	}		
  }

}