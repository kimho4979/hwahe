package com.fpdisys.module.recv.mapper;

import java.util.Map;

import com.fpdisys.module.recv.domain.ExamPlanMVO;
import com.fpdisys.module.recv.domain.QualExamSchdMVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("qnetMapper")
public interface QnetMapper {


	int insertExamPlan(ExamPlanMVO examPlanMVO);

	int insertQualExamSchd(QualExamSchdMVO examMVO);
	
	void insertSchInfo(Map<String, Object> paramMap);
}
