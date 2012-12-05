package com.intuit.mobile.paytrack.jaxb;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import javax.xml.bind.DatatypeConverter;

/**
 * @author Vijayan Srinivasan
 * @since Oct 10, 2012 6:04:38 PM
 */

public class DateAdapter {
	
	public static Date parseDate(String s) {
		return DatatypeConverter.parseDate(s).getTime();
	}

	public static String printDate(Date dt) {
		Calendar cal = new GregorianCalendar();
		cal.setTime(dt);
		return DatatypeConverter.printDateTime(cal);
	}

}
