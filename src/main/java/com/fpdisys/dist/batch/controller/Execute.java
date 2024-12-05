package com.fpdisys.dist.batch.controller;

public class Execute {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String a = "팔레노시스(1)";
		
		int pos = a.indexOf("(");
		String b;
		if (pos > -1) {
			b = a.substring(0, pos);
		} else {
			b = a;
		}
		
		System.out.println(b);
	}

}
