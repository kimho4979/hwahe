package com.fpdisys.base.mvc;

import javax.annotation.Resource;

import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

public class BaseService1 extends BaseObject{

//  
//	//---------------------------------
//	// transaction
//	//---------------------------------
//
	@Resource(name="txManager1")
  public DataSourceTransactionManager txManager1;
//	
	private DefaultTransactionDefinition mTxDefinition = null;
	private TransactionStatus mTxStatus = null;
//	private DataSourceTransactionManager txManager = null;

	protected void startTx()
	{
		
		mTxDefinition = new DefaultTransactionDefinition();	
		mTxDefinition.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);	

		mTxStatus = txManager1.getTransaction(mTxDefinition);
	}
  
  protected void commit(){
  	
  	try{
  		txManager1.commit(mTxStatus);
  	}catch ( org.springframework.transaction.IllegalTransactionStateException e)
  	{
  		return;
  	}		
  }
  
  protected void rollback(){
  	
  	try{
  		txManager1.rollback(mTxStatus);
  	}catch ( org.springframework.transaction.IllegalTransactionStateException e)
  	{
  		return;
  	}		
  }

}

