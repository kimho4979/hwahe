package com.fpdisys.dist.prog.domain;

import java.util.List;

import com.fpdisys.base.mvc.BaseVo;
import com.fpdisys.dist.menu.domain.Menu;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class Program extends BaseVo{
	
	private String progCd;

	private String progNm;

	
	private String fileNm;

	
	private String progPh;

	
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

	
	private List<Menu> menuList;
}
