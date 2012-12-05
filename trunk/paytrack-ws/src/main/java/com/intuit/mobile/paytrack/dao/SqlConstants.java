package com.intuit.mobile.paytrack.dao;

public interface SqlConstants {

	String INSERT_PROVIDER = "INSERT INTO providers (first_name, last_name,  email_id, mobile_number, "
			+ " address, service_name) " + " VALUES (?,?,?,?,?,?)";
	String UPDATE_PROVIDER = "UPDATE providers SET first_name = ?, "
			+ " last_name = ?, email_id = ?, mobile_number=?, address = ?, service_name = ? WHERE id = ?";

	String SELECT_ALL_PROVIDERS = "SELECT * FROM providers";
	String SELECT_PROVIDERS_BY_EMAIL= "SELECT * FROM providers WHERE email_id= ?";
	String SELECT_PROVIDERS_BY_MOBILE_NUMBER= "SELECT * FROM providers WHERE mobile_number= ?";

}
