package com.fpdisys.admin.prog.domain;


import lombok.Getter;
import lombok.Setter;

import com.fpdisys.base.mvc.BaseVo;

@Setter
@Getter
public class ProgVO extends BaseVo {

	private static final long serialVersionUID = 3681993006264972618L;

	private String sysCd;

	private String progCd;

	private String progNm;

	private String progPh;

	private String fileNm;

	private String target;

	private String schAh;

	private String savAh;

	private String exlAh;

	private String fn1Ah;

	private String fn2Ah;

	private String fn3Ah;

	private String fn4Ah;

	private String fn5Ah;

	private String remark;

	private String useYn;

	private String regDt;

	private String sUptDt;

}
