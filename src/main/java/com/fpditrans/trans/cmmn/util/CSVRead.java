package com.fpditrans.trans.cmmn.util;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

import com.opencsv.CSVReader;

public class CSVRead {

	public CSVRead() {}
	
	
	public List<String []> readCsv(String filename) {
		
		List<String[]> data = new ArrayList<String[]>();
		
		try {
			// 영문 
			//CSVReader reader = new CSVReader(new FileReader(filename));
			// UTF-8
			CSVReader reader = new CSVReader(new InputStreamReader(new FileInputStream(filename), "UTF-8"), ';');
			String[] s;
			while ((s = reader.readNext()) != null) {
				data.add(s);
			}
		 } catch (FileNotFoundException e) {
				e.printStackTrace();
		 } catch (IOException e) {
				e.printStackTrace();
		 }
		
		return data;
				
	}
}
