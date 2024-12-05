package com.fpdisys.dist.customerBbs.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("CustomerBbsMapper")
public interface CustomerBbsMapper {

	List<EgovMap> customerList(Map<String, Object> pRequestParamMap);

	int insertCustomer(Map<String, Object> pRequestParamMap);

	int insertCustomerFile(Map<String, Object> pRequestParamMap);

	void updateClickCnt(Map<String, Object> pRequestParamMap);

	int updateCustomer(Map<String, Object> pRequestParamMap);

	int updateCustomerFile(Map<String, Object> pRequestParamMap);

	int deleteCustomer(Map<String, Object> pRequestParamMap);

	int deleteCustomerFile(Map<String, Object> pRequestParamMap);

	int insertCustomerFileEncrpt(Map<String, Object> pRequestParamMap);

	int dupChkCustomer(Map<String, Object> pRequestParamMap);

}
