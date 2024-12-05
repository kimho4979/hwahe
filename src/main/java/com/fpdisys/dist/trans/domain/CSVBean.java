package com.fpdisys.dist.trans.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
/**
 * @Class Name : CSVBean.java
 * @Description : CSVBean Class
 *	 
 * @ 파일읽기 및 전송처리  VO 클래스 
 * @  수정일	  수정자			  수정내용
 * @ ---------	---------	-------------------------------
 * @ 2016.07.28			최초생성
 *
 * @author 우림인포텍
 * @version 1.0
 * @see
 * 
 * Copyright (C) by woorim All right reserved.
 */
public class CSVBean {

	public CSVBean() {
	}
 
	
	private String v_nak_time; 	
	private String v_sale_date;
	private String v_cmp_cd;
	public String getV_no2() {
		return v_no2;
	}
	public void setV_no2(String v_no2) {
		this.v_no2 = v_no2;
	}


	private String v_seq; 
	private String v_no1;
	private String v_no2;
	private String v_mejang; 
	private String v_mm; 
	private String v_good; 
	private String v_cmp_good;	 
	private String v_pum_name; 
	private String v_good_name; 
	private String v_danq;	

	private String v_dan_cd; 
	private String v_poj_cd;
	private String v_size_cd;
	private String v_lv_cd; 
	private int v_qty;
	private int v_cost;
	private String v_amer_cd; 
	private String v_ch_cd;

	
	private String v_sman_cd;
	private String v_chul_no;
	private String v_chul_cd;
	private String v_chul_name;
	private String v_farm_name;
	private String v_gubn;
	private String v_san_cd;
	
	private String v_cmp_san;
	private String v_san_name;
	
	private int v_tot_qty;
	private int v_tot_amt;
	private int v_cdan_x;

	private String v_cjm_yn;
	private String v_cgood_yn;
	private String v_csan_yn;
	
	private String v_cgrade_yn;
	private String v_cdan_yn;
	private String v_csize_yn;

	private int v_cmain_cost;
	private int v_cmax_cost;
	private int v_c_cost;
	private String v_ch_date;
	
	private String v_file_name; 
	
	private String v_lv_etc_cd;
	
	private String v_lv_etc_nm;
		  
	public String getV_nak_time() {
		return v_nak_time;
	}
	public void setV_nak_time(String v_nak_time) {
		this.v_nak_time = v_nak_time;
	}
	public String getV_sale_date() {
		return v_sale_date;
	}
	public void setV_sale_date(String v_sale_date) {
		this.v_sale_date = v_sale_date;
	}
	public String getV_cmp_cd() {
		return v_cmp_cd;
	}
	public void setV_cmp_cd(String v_cmp_cd) {
		this.v_cmp_cd = v_cmp_cd;
	}
	public String getV_seq() {
		return v_seq;
	}
	public void setV_seq(String v_seq) {
		this.v_seq = v_seq;
	}
	public String getV_no1() {
		return v_no1;
	}
	public void setV_no1(String v_no1) {
		this.v_no1 = v_no1;
	}
	public String getV_mejang() {
		return v_mejang;
	}
	public void setV_mejang(String v_mejang) {
		this.v_mejang = v_mejang;
	}
	public String getV_mm() {
		return v_mm;
	}
	public void setV_mm(String v_mm) {
		this.v_mm = v_mm;
	}
	public String getV_good() {
		return v_good;
	}
	public void setV_good(String v_good) {
		this.v_good = v_good;
	}
	public String getV_cmp_good() {
		return v_cmp_good;
	}
	public void setV_cmp_good(String v_cmp_good) {
		this.v_cmp_good = v_cmp_good;
	}
	public String getV_pum_name() {
		return v_pum_name;
	}
	public void setV_pum_name(String v_pum_name) {
		this.v_pum_name = v_pum_name;
	}
	public String getV_good_name() {
		return v_good_name;
	}
	public void setV_good_name(String v_good_name) {
		this.v_good_name = v_good_name;
	}	
	public String getV_dan_cd() {
		return v_dan_cd;
	}
	public void setV_dan_cd(String v_dan_cd) {
		this.v_dan_cd = v_dan_cd;
	}
	public String getV_poj_cd() {
		return v_poj_cd;
	}
	public void setV_poj_cd(String v_poj_cd) {
		this.v_poj_cd = v_poj_cd;
	}
	public String getV_size_cd() {
		return v_size_cd;
	}
	public void setV_size_cd(String v_size_cd) {
		this.v_size_cd = v_size_cd;
	}
	public String getV_lv_cd() {
		return v_lv_cd;
	}
	public void setV_lv_cd(String v_lv_cd) {
		this.v_lv_cd = v_lv_cd;
	}
	public int getV_qty() {
		return v_qty;
	}
	public void setV_qty(int v_qty) {
		this.v_qty = v_qty;
	}
	public int getV_cost() {
		return v_cost;
	}
	public void setV_cost(int v_cost) {
		this.v_cost = v_cost;
	}
	public String getV_amer_cd() {
		return v_amer_cd;
	}
	public void setV_amer_cd(String v_amer_cd) {
		this.v_amer_cd = v_amer_cd;
	}
	public String getV_ch_cd() {
		return v_ch_cd;
	}
	public void setV_ch_cd(String v_ch_cd) {
		this.v_ch_cd = v_ch_cd;
	}
	public String getV_sman_cd() {
		return v_sman_cd;
	}
	public void setV_sman_cd(String v_sman_cd) {
		this.v_sman_cd = v_sman_cd;
	}
	public String getV_chul_no() {
		return v_chul_no;
	}
	public void setV_chul_no(String v_chul_no) {
		this.v_chul_no = v_chul_no;
	}
	public String getV_chul_cd() {
		return v_chul_cd;
	}
	public void setV_chul_cd(String v_chul_cd) {
		this.v_chul_cd = v_chul_cd;
	}
	public String getV_chul_name() {
		return v_chul_name;
	}
	public void setV_chul_name(String v_chul_name) {
		this.v_chul_name = v_chul_name;
	}
	public String getV_farm_name() {
		return v_farm_name;
	}
	public void setV_farm_name(String v_farm_name) {
		this.v_farm_name = v_farm_name;
	}
	public String getV_gubn() {
		return v_gubn;
	}
	public void setV_gubn(String v_gubn) {
		this.v_gubn = v_gubn;
	}
	public String getV_san_cd() {
		return v_san_cd;
	}
	public void setV_san_cd(String v_san_cd) {
		this.v_san_cd = v_san_cd;
	}
	public String getV_cmp_san() {
		return v_cmp_san;
	}
	public void setV_cmp_san(String v_cmp_san) {
		this.v_cmp_san = v_cmp_san;
	}
	public String getV_san_name() {
		return v_san_name;
	}
	public void setV_san_name(String v_san_name) {
		this.v_san_name = v_san_name;
	}
	public int getV_tot_qty() {
		return v_tot_qty;
	}
	public void setV_tot_qty(int v_tot_qty) {
		this.v_tot_qty = v_tot_qty;
	}
	public int getV_tot_amt() {
		return v_tot_amt;
	}
	public void setV_tot_amt(int v_tot_amt) {
		this.v_tot_amt = v_tot_amt;
	}
	public int getV_cdan_x() {
		return v_cdan_x;
	}
	public void setV_cdan_x(int v_cdan_x) {
		this.v_cdan_x = v_cdan_x;
	}
	public String getV_cjm_yn() {
		return v_cjm_yn;
	}
	public void setV_cjm_yn(String v_cjm_yn) {
		this.v_cjm_yn = v_cjm_yn;
	}
	public String getV_cgood_yn() {
		return v_cgood_yn;
	}
	public void setV_cgood_yn(String v_cgood_yn) {
		this.v_cgood_yn = v_cgood_yn;
	}
	public String getV_csan_yn() {
		return v_csan_yn;
	}
	public void setV_csan_yn(String v_csan_yn) {
		this.v_csan_yn = v_csan_yn;
	}
	public String getV_cgrade_yn() {
		return v_cgrade_yn;
	}
	public void setV_cgrade_yn(String v_cgrade_yn) {
		this.v_cgrade_yn = v_cgrade_yn;
	}
	public String getV_cdan_yn() {
		return v_cdan_yn;
	}
	public void setV_cdan_yn(String v_cdan_yn) {
		this.v_cdan_yn = v_cdan_yn;
	}
	public String getV_csize_yn() {
		return v_csize_yn;
	}
	public void setV_csize_yn(String v_csize_yn) {
		this.v_csize_yn = v_csize_yn;
	}
	public int getV_cmain_cost() {
		return v_cmain_cost;
	}
	public void setV_cmain_cost(int v_cmain_cost) {
		this.v_cmain_cost = v_cmain_cost;
	}
	public int getV_cmax_cost() {
		return v_cmax_cost;
	}
	public void setV_cmax_cost(int v_cmax_cost) {
		this.v_cmax_cost = v_cmax_cost;
	}
	public int getV_c_cost() {
		return v_c_cost;
	}
	public void setV_c_cost(int v_c_cost) {
		this.v_c_cost = v_c_cost;
	}
	public String getV_ch_date() {
		return v_ch_date;
	}
	public void setV_ch_date(String v_ch_date) {
		this.v_ch_date = v_ch_date;
	}
	public String getV_danq() {
		return v_danq;
	}
	public void setV_danq(String v_danq) {
		this.v_danq = v_danq;
	}
	public String getV_file_name() {
		return v_file_name;
	}
	public void setV_file_name(String v_file_name) {
		this.v_file_name = v_file_name;
	}
	
	public String getV_lv_etc_cd() {
		return v_lv_etc_cd;
	}
	public void setV_lv_etc_cd(String v_lv_etc_cd) {
		this.v_lv_etc_cd = v_lv_etc_cd;
	}
	public String getV_lv_etc_nm() {
		return v_lv_etc_nm;
	}
	public void setV_lv_etc_nm(String v_lv_etc_nm) {
		this.v_lv_etc_nm = v_lv_etc_nm;
	}
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
	}
}
