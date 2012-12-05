package com.intuit.mobile.paytrack.dao;

public interface SqlConstants {

	String INSERT_PROVIDER = "INSERT INTO providers (first_name, last_name,  email_id, mobile_number, "
			+ " address, service_name) " + " VALUES (?,?,?,?,?,?)";
	String UPDATE_PROVIDER = "UPDATE providers SET first_name = ?, "
			+ " last_name = ?, email_id = ?, mobile_number=?, address = ?, service_name = ? WHERE id = ?";

	String SELECT_ALL_PROVIDERS = "SELECT * FROM providers";
	String SELECT_PROVIDER_BY_ID = "SELECT * FROM providers where id=?";

	String SELECT_PROVIDERS_BY_EMAIL = "SELECT * FROM providers WHERE email_id= ?";
	String SELECT_PROVIDERS_BY_MOBILE_NUMBER = "SELECT * FROM providers WHERE mobile_number= ?";

	String UPDATE_CLIENT = "update clients set first_name = ?, last_name=?, email_id=?, mobile=?, address=? where id = ?";
	String INSERT_CLIENT = "INSERT INTO clients (first_name, last_name, "
			+ " email_id, mobile_number, address) " + " VALUES (?,?,?,?,?)";

	String INSERT_PROVIDER_CLIENTS = "INSERT INTO provider_clients (provider_id, client_id "
			+ " ) " + " VALUES (?,?)";

	String INSERT_RECEIPT = "INSERT INTO receipts (provider_clients_id,`from`,`to`,amount,payment_date) values(?,?,?,?,?)";
	String SELECT_PROVIDER_CLIENTS = "SELECT * FROM provider_clients WHERE provider_id= ? AND client_id= ?";

	String SELECT_ALL_CLIENTS_FOR_PROVIDER = "select c.* from clients c join provider_clients cp on c.id = cp.client_id where cp.provider_id = ?";

	String SELECT_CLIENT = "select c.* from clients c where c.id = ?";

	String SELECT_RECEIPTS = "SELECT r.* FROM receipts r join  provider_clients pc on r.provider_clients_id = pc.id WHERE pc.provider_id= ? and pc.client_id=?";
}