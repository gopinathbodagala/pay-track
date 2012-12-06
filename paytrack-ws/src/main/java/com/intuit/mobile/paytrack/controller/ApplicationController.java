package com.intuit.mobile.paytrack.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.intuit.mobile.paytrack.dao.ClientDAO;
import com.intuit.mobile.paytrack.dao.ProviderDAO;
import com.intuit.mobile.paytrack.dao.ReceiptDAO;
import com.intuit.mobile.paytrack.jaxb.Client;
import com.intuit.mobile.paytrack.jaxb.Clients;
import com.intuit.mobile.paytrack.jaxb.Provider;
import com.intuit.mobile.paytrack.jaxb.Providers;
import com.intuit.mobile.paytrack.jaxb.Receipt;
import com.intuit.mobile.paytrack.jaxb.Receipts;

@Controller
public class ApplicationController {

	
	@Autowired
	private ProviderDAO providerDAO;

	@Autowired
	private ClientDAO clientDAO;
	
	@Autowired
	private ReceiptDAO receiptDAO;

	@RequestMapping("receipts.do")
	public ModelAndView getReceipts(String emailId, HttpServletRequest request) {
		Providers providers = receiptDAO.selectByEmail(emailId);
		Long providerId = null;
		Map<Long, List<Receipt>> clientIdReceiptMap = new HashMap<Long, List<Receipt>>();
		Map<Long, Client> clientIdClientMap = new HashMap<Long, Client>();

		if (providers != null && providers.getProviders() != null
				&& providers.getProviders().size() > 0) {
			providerId = providers.getProviders().get(0).getId();

			Clients clients = clientDAO.selectAll(providerId);
			if (clients != null && clients.getClients() != null
					&& clients.getClients().size() > 0) {
				List<Client> eachClient = clients.getClients();
				for (Client client : eachClient) {
					Receipts receipts = receiptDAO.selectAllReceipts(
							providerId, client.getId());
					if (receipts != null && receipts.getReceipts() != null
							&& receipts.getReceipts().size() > 0) {
						clientIdReceiptMap.put(client.getId(),
								receipts.getReceipts());
						clientIdClientMap.put(client.getId(), client);
					}
				}

			}
		}
		ModelAndView modelAndView = new ModelAndView("receipts");
		modelAndView.addObject("clientIdReceiptMap", clientIdReceiptMap);
		modelAndView.addObject("clientIdClientMap", clientIdClientMap);

		return modelAndView;

	}
		
	@RequestMapping("save-provider.do")
	public ModelAndView saveProvider(Provider provider) {
		provider = providerDAO.save(provider);
		ModelAndView modelAndView = new ModelAndView("home");
		modelAndView.addObject("provider", provider);
		return modelAndView;
	}
	
	@RequestMapping("show-provider.do")
	public ModelAndView showProvider() {
		ModelAndView modelAndView = new ModelAndView("add-provider");
		return modelAndView;
	}
	
	@RequestMapping("show-client.do")
	public ModelAndView showClient() {
		ModelAndView modelAndView = new ModelAndView("add-client");
		return modelAndView;
	}
	
	@RequestMapping("save-client.do")
	public ModelAndView saveClient(Long providerId, Client client) {
		clientDAO.save(providerId, client);
		ModelAndView modelAndView = new ModelAndView("home");
		return modelAndView;
	}
	
	@RequestMapping("show-receipt.do")
	public ModelAndView showReceipt() {
		ModelAndView modelAndView = new ModelAndView("add-receipt");
		return modelAndView;
	}
	
	@RequestMapping("save-receipt.do")
	public ModelAndView saveReceipt(Long providerId, Long clientId, Receipt receipt) {
		receiptDAO.save(providerId, clientId, receipt);
		ModelAndView modelAndView = new ModelAndView("home");
		return modelAndView;
	}
}
