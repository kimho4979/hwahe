package com.fpdisys.admin.image.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.admin.image.mapper.CommonMapper;

@Service
public class CommonServiceImpl implements CommonService {

	@Autowired
	private CommonMapper commonMapper;
	
	@Override
	public List<Map<String, Object>> getFlowerCode() {
		return commonMapper.getFlowerCode();
	}
	
	@Override
	public List<Map<String, Object>> getMokCode() {
		return commonMapper.getMokCode();
	}
	
	@Override
	public List<Map<String, Object>> getJongCode() {
		return commonMapper.getJongCode();
	}

	@Override
	public void updatePumImage(Map<String, Object> param) {
		commonMapper.updatePumImage(param);
	}

	@Override
	public List<Map<String, Object>> getImgList(Map<String, Object> searchJongNm) {
		return commonMapper.getImgList(searchJongNm);
	}

	@Override
	public List<Map<String, Object>> getJongCodeP(Map<String, Object> p) {
		return commonMapper.getJongCodeP(p);
	}

	@Override
	public void deletePumImage(Map<String, Object> map) {
		commonMapper.deletePumImage(map);
		
	}

}
