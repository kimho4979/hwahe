package com.fpdisys.dist.batch.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.batch.domain.CategoryLargeVO;
import com.fpdisys.dist.batch.domain.CategoryMidVO;
import com.fpdisys.dist.batch.domain.CategorySmallVO;
import com.fpdisys.dist.batch.domain.KindCodeListVO;
import com.fpdisys.dist.batch.mapper.BatchMapper;
import com.fpdisys.dist.cmmn.integrated.domain.KindVO;
import com.fpdisys.dist.real.mapper.RealMapper;

@Service
public class BatchService extends BaseService {
	protected Log log = LogFactory.getLog(this.getClass());	
	
	@Autowired
	BatchMapper batchMapper;
	
	@Autowired
	RealMapper realMapper;
	
	/**
	 * 기존 원장(T_SALE)을 통해서 코드목록 가져오기 - 농협코드
	 * @param paramList
	 * @throws Exception
	 */
	public void setNongMappingCode(List<Map<String, String>> paramList) throws Exception {
		int i = 0;
		for(Map<String, String> article: paramList) {
			Map<String, String> paramMap = new HashMap<String, String>();
			paramMap.put("marketCd", article.get("E"));
			paramMap.put("cmpGood", article.get("F"));
			paramMap.put("atCode", article.get("I"));
			
			if (paramMap.get("cmpGood").length() != 12) {
				i++;
				continue;
			}
			
			// T_SALE에서 코드 검색
			List<KindCodeListVO> kindCodeList = batchMapper.selectKindCodeList(paramMap);
			
			for(KindCodeListVO kindCodeInfoMap : kindCodeList) {
				if (StringUtils.isEmpty(kindCodeInfoMap.getLarge())) kindCodeInfoMap.setLarge("00");
				if (StringUtils.isEmpty(kindCodeInfoMap.getMid())) kindCodeInfoMap.setMid("00");
				if (StringUtils.isEmpty(kindCodeInfoMap.getSmall())) kindCodeInfoMap.setSmall("00");
				
				// T_INT_MAPPING에서 검색
				kindCodeInfoMap.setFlowerGubn(article.get("A"));
				kindCodeInfoMap.setFlowerCode(article.get("B"));
				kindCodeInfoMap.setItemCd(article.get("C"));
				kindCodeInfoMap.setKindCd(article.get("D"));
				kindCodeInfoMap.setQueryType("1");
				KindCodeListVO ret = batchMapper.selectKindCodeInfo1(kindCodeInfoMap);
			
				if (ret != null) {
					KindCodeListVO conflicedVO = batchMapper.selectCoflicedKindCodeInfo(ret);
					
					if (conflicedVO == null) {
						batchMapper.insertConflictedKindCode(ret);
					}
				} else {
					this.setCategory(kindCodeInfoMap);

					if (paramMap.get("marketCd").equals("1288202296")) {
						
					} else {
						Map<String, Object> flowerGubnMap = new HashMap<String, Object>();
						flowerGubnMap.put("cmpGood", (String) paramMap.get("cmpGood"));
						flowerGubnMap.put("marketCd", (String) paramMap.get("marketCd"));
						
						String flowerGubn = realMapper.selectFlowerGubnNong(flowerGubnMap);
						kindCodeInfoMap.setFlowerGubn(flowerGubn);
						KindVO vo = new KindVO();
						String itemNm = article.get("G");
						int pos = itemNm.indexOf("(");
						if (pos > -1) {
							itemNm = article.get("G").substring(0, pos);
						}
						vo.setItemNm(itemNm);
						vo.setFlowerGubn(kindCodeInfoMap.getFlowerGubn());
						KindCodeListVO retItem = batchMapper.selectItemCode(vo);
						
						if (retItem == null) {
							// T_INT_ITEM에서 쿼리
							KindCodeListVO retNoneMappedCode = batchMapper.selectNoneMappedCode(kindCodeInfoMap);
							if (retNoneMappedCode == null) {
								batchMapper.insertNoneMappedCode(kindCodeInfoMap);
							}
							continue;
						} else {
							kindCodeInfoMap.setFlowerCode(retItem.getFlowerCode());
							kindCodeInfoMap.setItemCd(retItem.getItemCd());
							kindCodeInfoMap.setKindNm(article.get("H"));
							if (kindCodeInfoMap.getKindNm().equals("구몬초")) {
								System.out.println("DDDDDDDDDDDDDD");
							}
							
							KindCodeListVO retKind = batchMapper.selectKindCode(kindCodeInfoMap);
							
							if (retKind == null) {
								String maxKindCd = batchMapper.selectMaxKindCd(kindCodeInfoMap);
							
								kindCodeInfoMap.setKindCd(maxKindCd);
								batchMapper.insertIntKindCode(kindCodeInfoMap);
							} else {
								kindCodeInfoMap.setKindCd(retKind.getKindCd());
							}
						}
						
					}

					KindCodeListVO ret1 = batchMapper.selectKindCodeInfo1(kindCodeInfoMap);

					if (ret1 == null) {
						//Mapping 테이블에 insert (양재도 화훼공판장)
						batchMapper.insertKindCode(kindCodeInfoMap);
					}
				}
			}
			i++;
			log.debug("################# " + i + "/" + paramList.size());
		}
	}
	/**
	 * 기존 원장(T_SALE)을 통해서 코드목록 가져오기 - aT코드
	 * @param paramList
	 */
	public void setMappingCode(List<Map<String, String>> paramList) throws Exception {
		int i = 0;
		for(Map<String, String> article: paramList){
			Map<String, String> paramMap = new HashMap<String, String>();
			paramMap.put("marketCd", article.get("A"));
			paramMap.put("cmpGood", article.get("B"));
			
			// T_SALE에서 코드 검색
			List<KindCodeListVO> kindCodeList = batchMapper.selectKindCodeList(paramMap);
			
			for(KindCodeListVO kindCodeInfoMap : kindCodeList) {
				KindCodeListVO ret = batchMapper.selectKindCodeInfo1(kindCodeInfoMap);
				
				if (ret != null) {
					ret = batchMapper.selectCoflicedKindCodeInfo(ret);
					
					if (ret == null) {
						batchMapper.insertConflictedKindCode(kindCodeInfoMap);
					}
				} else {
					CategoryLargeVO categoryLargeVO = batchMapper.selectLargeCategory(kindCodeInfoMap);
					
					CategoryLargeVO categoryLVO = new CategoryLargeVO();
					categoryLVO.setLarge(kindCodeInfoMap.getLarge());
					if (categoryLargeVO == null) {
						if (kindCodeInfoMap.getLarge() == null) {
							categoryLVO.setLarge("00");
						} else {
							categoryLVO.setLarge(kindCodeInfoMap.getLarge());
						}
						categoryLVO.setLargeName("원장에만 있음");
						batchMapper.insertLargeCategory(categoryLVO);
					}
					
					CategoryMidVO categoryMidVO = batchMapper.selectMidCategory(kindCodeInfoMap);

					CategoryMidVO categoryMVO = new CategoryMidVO();
					categoryMVO.setMid(kindCodeInfoMap.getMid());
					if (categoryMidVO == null) {
						if (kindCodeInfoMap.getLarge() == null) {
							categoryMVO.setLarge("00");
						} else {
							categoryMVO.setLarge(kindCodeInfoMap.getLarge());
						}
						if (kindCodeInfoMap.getMid() == null) {
							categoryMVO.setMid("00");
						} else {
							categoryMVO.setMid(kindCodeInfoMap.getMid());
						}
						categoryMVO.setMidName("원장에만 있음");
						categoryMVO.setGubn("N");
						batchMapper.insertMidCategory(categoryMVO);
					}
					
					CategorySmallVO categorySmallVO = batchMapper.selectSmallCategory(kindCodeInfoMap);

					CategorySmallVO categorySVO = new CategorySmallVO();
					categorySVO.setSmall(kindCodeInfoMap.getSmall());
					if (categorySmallVO == null) {
						if (kindCodeInfoMap.getLarge() == null) {
							categorySVO.setLarge("00");
						} else {
							categorySVO.setLarge(kindCodeInfoMap.getLarge());
						}
						
						if (kindCodeInfoMap.getMid() == null) {
							categorySVO.setMid("00");
						} else {
							categorySVO.setMid(kindCodeInfoMap.getMid());
						}
						if (kindCodeInfoMap.getSmall() == null) {
							categorySVO.setLarge(categoryLVO.getLarge());
						} else {
							categorySVO.setSmall(kindCodeInfoMap.getSmall());
						}
						categorySVO.setGoodName("원장에만 있음");
						categorySVO.setGubn("N");
						batchMapper.insertSmallCategory(categorySVO);
					}
					
					//Mapping 테이블에 insert (양재도 화훼공판장)
					batchMapper.insertKindCode(kindCodeInfoMap);
				}
				i++;
				log.debug("################# " + i + "/" + paramList.size());
			}
		}
	}
	
	public void setCategory(KindCodeListVO kindCodeInfoMap) throws Exception {
		CategoryLargeVO categoryLargeVO = batchMapper.selectLargeCategory(kindCodeInfoMap);
		
		if (kindCodeInfoMap.getLarge() == null) kindCodeInfoMap.setLarge("00");
		if (kindCodeInfoMap.getMid() == null) kindCodeInfoMap.setMid("00");
		if (kindCodeInfoMap.getSmall() == null) kindCodeInfoMap.setSmall("00");
		
		CategoryLargeVO categoryLVO = new CategoryLargeVO();
		categoryLVO.setLarge(kindCodeInfoMap.getLarge());
		if (categoryLargeVO == null) {
			if (kindCodeInfoMap.getLarge() == null) {
				categoryLVO.setLarge("00");
			} else {
				categoryLVO.setLarge(kindCodeInfoMap.getLarge());
			}
			categoryLVO.setLargeName("원장에만 있음");
			batchMapper.insertLargeCategory(categoryLVO);
		}
		
		CategoryMidVO categoryMidVO = batchMapper.selectMidCategory(kindCodeInfoMap);

		CategoryMidVO categoryMVO = new CategoryMidVO();
		categoryMVO.setMid(kindCodeInfoMap.getMid());
		if (categoryMidVO == null) {
			if (kindCodeInfoMap.getLarge() == null) {
				categoryMVO.setLarge("00");
			} else {
				categoryMVO.setLarge(kindCodeInfoMap.getLarge());
			}
			if (kindCodeInfoMap.getMid() == null) {
				categoryMVO.setMid("00");
			} else {
				categoryMVO.setMid(kindCodeInfoMap.getMid());
			}
			categoryMVO.setMidName("원장에만 있음");
			categoryMVO.setGubn("N");
			batchMapper.insertMidCategory(categoryMVO);
		}
		
		CategorySmallVO categorySmallVO = batchMapper.selectSmallCategory(kindCodeInfoMap);

		CategorySmallVO categorySVO = new CategorySmallVO();
		categorySVO.setSmall(kindCodeInfoMap.getSmall());
		if (categorySmallVO == null) {
			if (kindCodeInfoMap.getLarge() == null) {
				categorySVO.setLarge("00");
			} else {
				categorySVO.setLarge(kindCodeInfoMap.getLarge());
			}
			
			if (kindCodeInfoMap.getMid() == null) {
				categorySVO.setMid("00");
			} else {
				categorySVO.setMid(kindCodeInfoMap.getMid());
			}
			if (kindCodeInfoMap.getSmall() == null) {
				categorySVO.setLarge(categoryLVO.getLarge());
			} else {
				categorySVO.setSmall(kindCodeInfoMap.getSmall());
			}
			categorySVO.setGoodName("원장에만 있음");
			categorySVO.setGubn("N");
			batchMapper.insertSmallCategory(categorySVO);
		}
		
	}
}
