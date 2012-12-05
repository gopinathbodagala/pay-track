package com.intuit.mobile.paytrack.dbo;

import java.io.Serializable;
import java.math.BigInteger;


/**
 * The persistent class for the clients database table.
 * 
 */
public class ClientDO implements Serializable {
	private static final long serialVersionUID = 1L;

	private int id;

	private String address;

	private String emailId;

	private String firstName;

	private String lastName;

	private BigInteger mobileNumber;

	public ClientDO() {
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getEmailId() {
		return this.emailId;
	}

	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}

	public String getFirstName() {
		return this.firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return this.lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public BigInteger getMobileNumber() {
		return this.mobileNumber;
	}

	public void setMobileNumber(BigInteger mobileNumber) {
		this.mobileNumber = mobileNumber;
	}

}