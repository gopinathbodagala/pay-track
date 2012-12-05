package com.intuit.mobile.paytrack.dbo;

import java.io.Serializable;


/**
 * The persistent class for the provider_clients database table.
 * 
 */
public class ProviderClientDO implements Serializable {
	private static final long serialVersionUID = 1L;

	private int id;

	private int clientId;

	private int providerId;

	public ProviderClientDO() {
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getClientId() {
		return this.clientId;
	}

	public void setClientId(int clientId) {
		this.clientId = clientId;
	}

	public int getProviderId() {
		return this.providerId;
	}

	public void setProviderId(int providerId) {
		this.providerId = providerId;
	}

}