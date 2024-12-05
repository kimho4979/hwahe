package com.fpdisys.dist.batch.mapper;

import java.util.List;
import java.util.Map;

import com.fpdisys.dist.batch.domain.CategoryLargeVO;
import com.fpdisys.dist.batch.domain.CategoryMidVO;
import com.fpdisys.dist.batch.domain.CategorySmallVO;
import com.fpdisys.dist.batch.domain.KindCodeListVO;
import com.fpdisys.dist.cmmn.integrated.domain.KindVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("batchMapper")
public interface BatchMapper {
	
	/**
	 * T_SALE에서 코드목록 가져오기
	 * @param paramMap (marketCd, cmpGood)
	 * @return
	 * @throws Exception
	 */
	List<KindCodeListVO> selectKindCodeList(Map<String, String> paramMap) throws Exception;
	
	/**
	 * T_INT_MAPPING에서 기존 코드 존재 여부를 쿼리 (aT코드와 매핑이 되는 경우)
	 * @param kindListVO
	 * @return
	 * @throws Exception
	 */
	KindCodeListVO selectKindCodeInfo1(KindCodeListVO kindListVO) throws Exception;

	
	/**
	 * T_INT_ITEM에 등록 여부 쿼리
	 * @param kindListVO
	 * @return
	 * @throws Exception
	 */
	KindCodeListVO selectItemCode(KindVO vo) throws Exception;
	
	/**
	 * T_INT_KIND에 등여부 쿼리
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	KindCodeListVO selectKindCode(KindCodeListVO vo) throws Exception;

	/**
	 * T_INT_MAPPING_CONFLICTED에 이름까지 같은 것이 존재하는 쿼리
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	KindCodeListVO selectCoflicedKindCodeInfo(KindCodeListVO vo) throws Exception;
	
	/**
	 * 매칭되지지 않은 농협코드 등록여부 확인
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	KindCodeListVO selectNoneMappedCode(KindCodeListVO vo) throws Exception;
	
	/**
	 * 코드 매핑 테이블에 등록
	 * @param vo
	 * @throws Exception
	 */
	void insertKindCode(KindCodeListVO vo) throws Exception;
	
	
	/**
	 * 총돌된 코드 conflicted 테이블에 등록
	 * @param vo
	 * @throws Exception
	 */
	void insertConflictedKindCode(KindCodeListVO vo) throws Exception;
	
	/**
	 * 농협코드 중 공판장코드, 품종(9자리), 대,중,소,등급까지 매핑이 안된 데이터 입력
	 * @param vo
	 * @throws Exception
	 */
	void insertNoneMappedCode(KindCodeListVO vo) throws Exception;
	
	/**
	 * 대분류 조회
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	CategoryLargeVO selectLargeCategory(KindCodeListVO vo) throws Exception;
	
	/**
	 * 중분류 조회
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	CategoryMidVO selectMidCategory(KindCodeListVO vo) throws Exception;
	
	/**
	 * 소분류 조회
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	CategorySmallVO selectSmallCategory(KindCodeListVO vo) throws Exception;
	
	/**
	 * 대분류 등록
	 * @param vo
	 * @throws Exception
	 */
	void insertLargeCategory(CategoryLargeVO vo) throws Exception;
	
	/**
	 * 중분류 등록
	 * @param vo
	 * @throws Exception
	 */
	void insertMidCategory(CategoryMidVO vo) throws Exception;
	
	/**
	 * 소분류 등록
	 * @param vo
	 * @throws Exception
	 */
	void insertSmallCategory(CategorySmallVO vo) throws Exception;
	
	/**
	 * 통합품종코드채번
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	String selectMaxKindCd(KindCodeListVO vo) throws Exception;
	
	/**
	 * 통합품종(T_INT_KIND) 등록
	 * @param vo
	 * @throws Exception
	 */
	void insertIntKindCode(KindCodeListVO vo) throws Exception;
}
