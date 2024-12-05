package com.kati.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kati.mapper.KatiDataMapper;


@Service
public class KatiDataService {
	
	@Autowired
	KatiDataMapper katiDataMapper;
	
	public List<?> selectImportList(Map<String, Object> pRequestParamMap){
		return katiDataMapper.selectImportList(pRequestParamMap);
	}
	
	public List<?> selectImportPumList(Map<String, Object> pRequestParamMap){
		return katiDataMapper.selectImportPumList(pRequestParamMap);
	}

	public List<?> selectImportNatList(Map<String, Object> pRequestParamMap){
		return katiDataMapper.selectImportNatList(pRequestParamMap);
	}

}
