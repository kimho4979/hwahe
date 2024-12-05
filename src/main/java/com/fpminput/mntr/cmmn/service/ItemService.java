package com.fpminput.mntr.cmmn.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.base.mvc.BaseService;
import com.fpminput.mntr.cmmn.domain.ItemVO;
import com.fpminput.mntr.cmmn.mapper.ItemMapper;

@Service
public class ItemService extends BaseService {
	
	@Autowired
	ItemMapper itemMapper;
	
	public List<ItemVO> selectItemListLargeNm(ItemVO itemVo){
		return itemMapper.selectItemListLargeNm(itemVo);
	}
	
	public List<ItemVO> selectItemListSmallNm(ItemVO itemVo){
		return itemMapper.selectItemListSmallNm(itemVo);
	}

}
