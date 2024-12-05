package com.fpditrans.base.mybatis;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;

import javax.xml.datatype.DatatypeConfigurationException;
import javax.xml.datatype.DatatypeFactory;
import javax.xml.datatype.XMLGregorianCalendar;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.GregorianCalendar;

/**
 * @Class Name : XMLGregorianCalendarTypeHandler.java
 * @Description : XMLGregorianCalendarTypeHandler Class
 * @Modification Information
 * @
 * @  수정일	  수정자			  수정내용
 * @ ---------	---------	-------------------------------
 * @ 2016.08.16			최초생성
 *
 * @author 우림인포텍
 * @since 2016. 03.16
 * @version 1.0
 * @see
 *
 *  Copyright (C) by WOORIM All right reserved.
 */

public class XMLGregorianCalendarTypeHandler extends BaseTypeHandler<XMLGregorianCalendar> {

	@Override
	public void setNonNullParameter(PreparedStatement ps, int i, XMLGregorianCalendar parameter, JdbcType jdbcType)
			throws SQLException {
		if(parameter == null) {
			ps.setTimestamp(i, null);
			return;
		}
		GregorianCalendar cal = ((XMLGregorianCalendar) parameter).toGregorianCalendar();
		ps.setTimestamp(i, new Timestamp(cal.getTimeInMillis()));

	}

	@Override
	public XMLGregorianCalendar getNullableResult(ResultSet rs, String columnName)
			throws SQLException {

		if(rs.wasNull()) {
			return null;
		}

		return getXMLGregorianCalendar(rs.getTimestamp(columnName).getTime());
	}

	@Override
	public XMLGregorianCalendar getNullableResult(ResultSet rs, int columnIndex)
			throws SQLException {

		if(rs.wasNull()) {
			return null;
		}

		return getXMLGregorianCalendar(rs.getTimestamp(columnIndex).getTime());
	}

	@Override
	public XMLGregorianCalendar getNullableResult(CallableStatement cs, int columnIndex)
			throws SQLException {

		if(cs.wasNull()) {
			return null;
		}

		return getXMLGregorianCalendar(cs.getTimestamp(columnIndex).getTime());
	}

	private XMLGregorianCalendar getXMLGregorianCalendar(long millisecond) {
		GregorianCalendar cal = new GregorianCalendar();
		cal.setTimeInMillis(millisecond);

		XMLGregorianCalendar xcal = null;
		try {
			xcal = DatatypeFactory.newInstance().newXMLGregorianCalendar((GregorianCalendar)cal);
		} catch (DatatypeConfigurationException e) {
			throw new IllegalStateException(e);
		}
		return xcal;
	}
}

