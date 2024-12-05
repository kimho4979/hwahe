package com.at.domain;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class SituationVO {

	private static final long serialVersionUID = 1L;
	
	// 매출계획대실적
	String month;
	
	String plan_sum;
	
	String pan_sum;
	
	String five_year_avg;
	
	String before_year_avg;
	
	// 금일 경매실적
	String pan_day;
	
	String bun_chk;
	
	String bun_chk_rank;
	
	String tot_sok;
	
	String tot_price;
	
	String bef_day;
	
	String bef_tot_sok;
	
	String bef_tot_price;
	
	String day_yoil;
	
	String bef_day_yoil;	
	
	// 월별 경매실적
	String yyyymm;
	
	String bun_chk_name;
	
	String plan;
	
	String sum_plan;
	
	String sum_pan;
	
	String plan_year_sum;
	
	String plan_per;
	
	String sum_per;
}
