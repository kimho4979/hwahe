package com.kati.util;

import javax.annotation.Resource;

import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.fpdisys.base.mvc.BaseObject;

public class BaseService2 extends BaseObject {
//  
//	//---------------------------------
//	// transaction
//	//---------------------------------
//
	@Resource(name="txManager3")
  public DataSourceTransactionManager txManager3;
//	
	private DefaultTransactionDefinition mTxDefinition = null;
	private TransactionStatus mTxStatus = null;
//	private DataSourceTransactionManager txManager = null;

	protected void startTx()
	{
		
		mTxDefinition = new DefaultTransactionDefinition();	
		mTxDefinition.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);	

		mTxStatus = txManager3.getTransaction(mTxDefinition);
	}
  
  protected void commit(){
  	
  	try{
  		txManager3.commit(mTxStatus);
  	}catch ( org.springframework.transaction.IllegalTransactionStateException e)
  	{
  		return;
  	}		
  }
  
  protected void rollback(){
  	
  	try{
  		txManager3.rollback(mTxStatus);
  	}catch ( org.springframework.transaction.IllegalTransactionStateException e)
  	{
  		return;
  	}		
  }

}
