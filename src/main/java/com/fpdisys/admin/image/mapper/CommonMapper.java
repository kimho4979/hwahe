package com.fpdisys.admin.image.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface CommonMapper {
	public List<Map<String, Object>> getFlowerCode();
	public List<Map<String, Object>> getMokCode();
	public List<Map<String, Object>> getJongCode();
	public void updatePumImage(Map<String, Object> param);
	public List<Map<String, Object>> getImgList(Map<String, Object> searchJongNm);
	public List<Map<String, Object>> getJongCodeP(Map<String, Object> p);
	public void deletePumImage(Map<String, Object> map);
	public void testInsert(Map<String, String> map);
}
