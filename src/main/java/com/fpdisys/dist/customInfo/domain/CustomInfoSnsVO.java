package com.fpdisys.dist.customInfo.domain;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class CustomInfoSnsVO{
	
	private static final long serialVersionUID = 1L;
	
	// 사용자ID
	private String userId;
	// kakao/email
	private String userGubun;
	// 사용여부
	private String useYn;
	// 수급예측보고서
	private String report1Yn;
	// 월간거래동향 보고서
	private String report2Yn;
	// 정산
	private String saleYn;
	// 정산품목 
	private String salePum;
	// 실시간
	private String realYn;
	// 실시간
	private String realTime;
	
	private List<CustomInfoVO> customInfoVo;
	
}
