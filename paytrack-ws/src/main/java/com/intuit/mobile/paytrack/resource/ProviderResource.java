/**
 * 
 */
package com.intuit.mobile.paytrack.resource;

import static javax.ws.rs.core.MediaType.APPLICATION_JSON;
import static javax.ws.rs.core.MediaType.APPLICATION_XML;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.intuit.mobile.paytrack.dao.ClientDAO;
import com.intuit.mobile.paytrack.dao.ProviderDAO;
import com.intuit.mobile.paytrack.dao.ReceiptDAO;
import com.intuit.mobile.paytrack.jaxb.Client;
import com.intuit.mobile.paytrack.jaxb.Clients;
import com.intuit.mobile.paytrack.jaxb.Provider;
import com.intuit.mobile.paytrack.jaxb.Providers;
import com.intuit.mobile.paytrack.jaxb.Receipt;
import com.intuit.mobile.paytrack.jaxb.Receipts;

/**
 * @author Vijayan Srinivasan
 */
@Component
@Path("providers")
@Consumes({ APPLICATION_XML, APPLICATION_JSON })
@Produces({ APPLICATION_XML, APPLICATION_JSON })
public class ProviderResource {

	@Autowired
	private ProviderDAO providerDAO;

	@Autowired
	private ClientDAO clientDAO;
	
	@Autowired
	private ReceiptDAO receiptDAO;

	@GET
	public Providers getAll(@QueryParam("email") String email,
			@QueryParam("mobile") String mobile) {
		Providers projects = null;
		if (email == null && mobile == null) {
			projects = providerDAO.selectAll();

		} else if (email != null) {
			projects = providerDAO.selectByEmail(email);
		} else {
			projects = providerDAO.selectByMobile(mobile);
		}
		return projects;
	}

	@POST
	public Provider post(Provider provider) {
		provider = providerDAO.save(provider);
		return provider;
	}

	@PUT
	@Path("{id}")
	public Provider put(@PathParam("id") Long id, Provider provider) {
		provider = providerDAO.update(provider);
		return provider;
	}
	
	@GET
	@Path("{id}")
	public Provider put(@PathParam("id") Long id) {
		Provider provider = providerDAO.selectById(id);
		return provider;
	}

	@GET
	@Path("{providerId}/clients")
	public Clients getAllClients(@PathParam("providerId") Long providerId) {
		Clients clients = clientDAO.selectAll(providerId);
		return clients;
	}
	
	@GET
	@Path("{providerId}/clients/{clientId}")
	public Client getClient(@PathParam("providerId") Long providerId,
			@PathParam("clientId") Long clientId) {
		Client client = clientDAO.selectClient(clientId);
		return client;
	}

	@POST
	@Path("{providerId}/clients")
	public Client addClient(@PathParam("providerId") Long providerId,
			Client client) {
		client = clientDAO.save(providerId, client);
		return client;
	}

	@PUT
	@Path("{providerId}/clients/{clientId}")
	public Client updateClient(@PathParam("providerId") Long providerId,
			@PathParam("clientId") Long clientId, Client client) {
		client = clientDAO.update(client);
		return client;
	}
	
	@GET
	@Path("{providerId}/clients/{clientId}/receipts")
	public Receipts selectReceipts(@PathParam("providerId") Long providerId,
			@PathParam("clientId") Long clientId) {
		Receipts receipts = receiptDAO.selectAllReceipts(providerId, clientId);
		return receipts;
	}
	
	@POST
	@Path("{providerId}/clients/{clientId}/receipts")
	public Receipt addReceipt(@PathParam("providerId") Long providerId,
			@PathParam("clientId") Long clientId,
			Receipt receipt) {
		receipt = receiptDAO.save(providerId, clientId, receipt);
		return receipt;
	}
}
