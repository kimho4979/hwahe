package com.fpdisys.dist.customerBbs.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.customerBbs.mapper.CustomerBbsMapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class CustomerBbsService extends BaseService {
	
	@Autowired
	CustomerBbsMapper customerBbsMapper;

	public List<EgovMap> customerList(Map<String, Object> pRequestParamMap){
		return customerBbsMapper.customerList(pRequestParamMap);		
	}
	
	public int dupChkCustomer(Map<String, Object> pRequestParamMap) {
		return customerBbsMapper.dupChkCustomer(pRequestParamMap);
	}
	
	public int insertCustomer(Map<String, Object> pRequestParamMap){	
		return customerBbsMapper.insertCustomer(pRequestParamMap);
	}
	
	public int insertCustomerFile(Map<String, Object> pRequestParamMap){	
		return customerBbsMapper.insertCustomerFile(pRequestParamMap);
	}

	public void updateClickCnt(Map<String, Object> pRequestParamMap) {
		customerBbsMapper.updateClickCnt(pRequestParamMap);
		
	}

	public int updateCustomer(Map<String, Object> pRequestParamMap) {
		return customerBbsMapper.updateCustomer(pRequestParamMap);
	}

	public int updateCustomerFile(Map<String, Object> pRequestParamMap) {
		return customerBbsMapper.updateCustomerFile(pRequestParamMap);
		
	}
	
	public int deleteCustomer(Map<String, Object> pRequestParamMap) {
		return customerBbsMapper.deleteCustomer(pRequestParamMap);
	}

	public int deleteCustomerFile(Map<String, Object> pRequestParamMap) {
		return customerBbsMapper.deleteCustomerFile(pRequestParamMap);
		
	}

	public int insertCustomerFileEncrpt(Map<String, Object> pRequestParamMap) {
		return customerBbsMapper.insertCustomerFileEncrpt(pRequestParamMap);
		
	}
	
	
}
