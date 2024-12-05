package com.fpdisys.base.util;

import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/****
 * a_pum_mok_info, a_pum_jong_info 테이블 동기화 
 * 
 * 
 * ***/
@Controller
public class syncApumInfoSchedule  {

	static final String JDBC_DRIVER = "oracle.jdbc.driver.OracleDriver";
	static final String DB_URL = "jdbc:oracle:thin:@192.168.12.12:1521:AMIS";
	static final String DB_URL2 = "jdbc:oracle:thin:@175.106.91.132:1521:flower";
	static final String USERNAME = "rflo";
	static final String USERNAME2 = "flower";
	static final String PASSWORD = "dbxhd_1882";
	static final String PASSWORD2 = "flower";

	private static List<Map<String, Object>> getNonCommonValues(List<Map<String, Object>> list1, List<Map<String, Object>> list2) {
		List<Map<String, Object>> nonCommonValues = new ArrayList<>();

		// 두 리스트를 비교하여 존재하지 않는 값을 추출
		for (Map<String, Object> map1 : list1) {
			if (!containsMap(list2, map1)) {
				nonCommonValues.add(map1);
			}
		}

		/*for (Map<String, Object> map2 : list2) {
			if (!containsMap(list1, map2)) {
				nonCommonValues.add(map2);
			}
		}*/

		return nonCommonValues;
	}

	// 리스트에 특정 맵이 포함되어 있는지 확인
	private static boolean containsMap(List<Map<String, Object>> list, Map<String, Object> map) {
		for (Map<String, Object> item : list) {
			if (isMapsEqual(item, map)) {
				return true;
			}
		}
		return false;
	}

	// 맵 간의 동등성 비교
	private static boolean isMapsEqual(Map<String, Object> map1, Map<String, Object> map2) {
		if (map1.size() != map2.size()) {
			///return false;
		}

		for (Map.Entry<String, Object> entry : map1.entrySet()) {
			//String key = entry.getKey();
			String key = "PUM_CODE";
			Object value1 = map1.get(key);
			Object value2 = map2.get(key);
			if (value1 == null) {
				if (value2 != null) {
					return false;
				}
			} else if (!value1.equals(value2)) {
				return false;
			}
		}

		return true;
	}


	@Scheduled(cron = "0 0 11 * * 0")
	public void startAmisSyncSchedule7(){
		amisDBSelect(null,"7");
	}
	@Scheduled(cron = "0 0 10 * * 0")
	public void startAmisSyncSchedule5(){
		amisDBSelect(null,"5");
	}
	@Scheduled(cron = "0 0 9 * * 0")
	public void startAmisSyncSchedule8(){
		amisDBSelect(null,"8");
	}
	@Scheduled(cron = "0 0 8 * * 0")
	public void startAmisSyncSchedule6(){
		amisDBSelect(null,"6");
	}
	//
	@Scheduled(cron = "0 0 7 * * 0")
	public void startAmisSyncSchedule3(){
		amisDBSelect(null,"3");
	}

	//
	@Scheduled(cron = "0 0 6 * * 0")
	public void startAmisSyncSchedule1(){
		amisDBSelect(null,"1");
	}

	@RequestMapping(value="/amis/test{code}.json")
	public String webCallAmisSync(HttpServletRequest req, ModelMap model, @PathVariable("code") String code)  {
        try {

            model.addAttribute("접근아이피",req.getRemoteHost());
			//if(req.getRemoteHost().equals("127.0.0.1")) {
			if(!req.getRemoteHost().equals("211.218.243.40")) {
				model.addAttribute("접근불가","해당아이피는 접근불가합니다.");
				throw new RuntimeException("접근불가 런타임오류 ");
				//return "jsonView";
			}
			amisDBSelect(model,code);
        } catch (Exception e) {
			model.addAttribute("err",e.getMessage());

		} finally {

		}
		return "jsonView";
    }

	public void amisDBSelect(ModelMap model,String flowerCode) {

		Connection conn = null;
		Connection conn2 = null;
		PreparedStatement stmt = null;
		PreparedStatement stmt2 = null;
		ResultSet rs = null;
		ResultSet rs2 = null;

		try {
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(DB_URL, USERNAME, PASSWORD);
			conn2 = DriverManager.getConnection(DB_URL2, USERNAME2, PASSWORD2);

			String sql1 = "select * from( select rownum as rn,a.* from flower.VV_PUM_JONG a ) where rn >= 1 and flower_code = '"+flowerCode+"'";
			String sql2 = "select * from( select rownum as rn,a.* from A_PUM_JONG_INFO a ) where rn >= 1 and flower_code = '"+flowerCode+"'";
			stmt = conn.prepareStatement(sql1);
			stmt2 = conn2.prepareStatement(sql2);
			rs = stmt.executeQuery();
			rs2 = stmt2.executeQuery();
			List<Map<String,Object>> nmap = new LinkedList<>();
			List<Map<String,Object>> omap = new LinkedList<>();
			List<Map<String,Object>> t1 = new LinkedList<>();
			List<Map<String,Object>> t2 = new LinkedList<>();
			while(rs.next()) {

				Map<String,Object> map = new LinkedHashMap<>();
				java.util.Date F_I_DT = rs.getDate("F_I_DT");
				java.util.Date L_U_DT = rs.getDate("L_U_DT");
				String JONG_NAME = rs.getString("JONG_NAME");
				String PUM_CODE = rs.getString("PUM_CODE");
				String MOK_CODE = rs.getString("MOK_CODE");
				String JONG_CODE = rs.getString("JONG_CODE");
				String FLOWER_CODE = rs.getString("FLOWER_CODE");
				map.put("JONG_NAME", JONG_NAME);
				map.put("FLOWER_CODE", FLOWER_CODE);
				map.put("F_I_DT", F_I_DT);
				map.put("L_U_DT", L_U_DT);
				map.put("PUM_CODE", PUM_CODE);
				map.put("MOK_CODE", MOK_CODE);
				map.put("JONG_CODE", JONG_CODE);
				nmap.add(map);

			}
			while(rs2.next()) {
				Map<String,Object> map = new LinkedHashMap<>();
				java.util.Date F_I_DT = rs2.getDate("F_I_DT");
				String JONG_NAME = rs2.getString("P_JONG_NAME");
				String PUM_CODE = rs2.getString("PUM_CODE");
				map.put("JONG_NAME", JONG_NAME);
				map.put("F_I_DT", F_I_DT);
				map.put("PUM_CODE", PUM_CODE);
				omap.add(map);
			}

			List<Map<String,String>> r = new LinkedList<>();
			List<Map<String,Object>> r2 = new LinkedList<>();

			///System.out.println(getNonCommonValues(t1,t2));

			for (Map<String, Object> map : omap) {
				for (Map<String, Object> map2 : nmap) {
					java.util.Date od = (java.util.Date)map.get("F_I_DT");
					java.util.Date od2 = (java.util.Date)map2.get("F_I_DT");
					String JONG_NAME = map.get("JONG_NAME").toString();
					String PUM_CODE = map.get("PUM_CODE").toString();
					String JONG_NAME2 = map2.get("JONG_NAME").toString();
					String PUM_CODE2 = map2.get("PUM_CODE").toString();

					if(od.compareTo(od2) == -1  && PUM_CODE.equals(PUM_CODE2) ) {
						// 변경내용 업데이트 부분
						stmt2.executeUpdate("update A_PUM_JONG_INFO set P_JONG_NAME='"+JONG_NAME2+"' where PUM_CODE='"+PUM_CODE+"'");

						Map<String,String> rr= new HashMap<>();
						rr.put("JONG_NAME", JONG_NAME);
						rr.put("JONG_NAME2", JONG_NAME2);
						rr.put("PUM_CODE", PUM_CODE);
						rr.put("PUM_CODE2", PUM_CODE2);
						rr.put("DATE", od.toString());
						rr.put("DATE2", od2.toString());
						r.add(rr);
					}
				}
			}

			r2 = getNonCommonValues(nmap,omap);

			for (Map<String,Object> o : r2){
				String sql = "insert into A_PUM_JONG_INFO (P_UNIT1,P_JONG_NAME,FLOWER_CODE,F_I_DT,L_U_DT,PUM_CODE,P_MOK_CODE,P_JONG_CODE) values ('-','"+o.get("JONG_NAME")+"','"+o.get("FLOWER_CODE")+"','"+o.get("F_I_DT")+"','"+o.get("L_U_DT")+"','"+o.get("PUM_CODE")+"','"+o.get("MOK_CODE")+"','"+o.get("JONG_CODE")+"')";
				stmt2.executeQuery(sql);
			}


			if(model != null){
				model.addAttribute("data1",r);
				model.addAttribute("data2",r2);
			}


			rs2.close();
			rs.close();
			stmt.close();
			stmt2.close();
			conn.close();
			conn2.close();
		} catch (Exception e) {
			e.printStackTrace();
			if(model != null)
				model.addAttribute("err",e.getMessage());
		} finally {
			rs = null;
			stmt = null;
			conn = null;
			rs2 = null;
			stmt2 = null;
			conn2 = null;
		}


	}


}
