package com.intuit.mobile.paytrack.dbo;

import java.io.Serializable;
import java.sql.Timestamp;
import java.math.BigDecimal;


/**
 * The persistent class for the reciepts database table.
 * 
 */
public class RecieptDO implements Serializable {
	private static final long serialVersionUID = 1L;

	private int id;

	private BigDecimal amount;

	private Timestamp from;

	private Timestamp paymentDate;

	private int providerClientsId;

	private Timestamp to;

	public RecieptDO() {
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public BigDecimal getAmount() {
		return this.amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public Timestamp getFrom() {
		return this.from;
	}

	public void setFrom(Timestamp from) {
		this.from = from;
	}

	public Timestamp getPaymentDate() {
		return this.paymentDate;
	}

	public void setPaymentDate(Timestamp paymentDate) {
		this.paymentDate = paymentDate;
	}

	public int getProviderClientsId() {
		return this.providerClientsId;
	}

	public void setProviderClientsId(int providerClientsId) {
		this.providerClientsId = providerClientsId;
	}

	public Timestamp getTo() {
		return this.to;
	}

	public void setTo(Timestamp to) {
		this.to = to;
	}

}