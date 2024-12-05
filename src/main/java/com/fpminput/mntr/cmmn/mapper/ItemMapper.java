package com.fpminput.mntr.cmmn.mapper;

import java.util.List;

import com.fpminput.mntr.cmmn.domain.ItemVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("itemMapper")
public interface ItemMapper {
	
	List<ItemVO> selectItemListLargeNm(ItemVO itemVo);
	
	List<ItemVO> selectItemListSmallNm(ItemVO itemVo);
	
}
