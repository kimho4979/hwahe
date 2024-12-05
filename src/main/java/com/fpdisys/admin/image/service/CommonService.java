package com.fpdisys.admin.image.service;

import java.util.List;
import java.util.Map;

public interface CommonService {
	List<Map<String,Object>> getFlowerCode(); 
	List<Map<String,Object>> getMokCode(); 
	List<Map<String,Object>> getJongCode();
	void updatePumImage(Map<String, Object> param);
	List<Map<String,Object>> getImgList(Map<String, Object> searchJongNm);
	List<Map<String,Object>> getJongCodeP(Map<String, Object> p);
	void deletePumImage(Map<String, Object> map); 
}
