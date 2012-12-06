package com.intuit.mobile.paytrack.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
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
import com.intuit.mobile.paytrack.resource.ProviderResource;

@Controller
public class ApplicationController {

	@Autowired
	private ProviderDAO providerDAO;

	@Autowired
	private ClientDAO clientDAO;

	@Autowired
	private ReceiptDAO receiptDAO;

	@Autowired
	private ProviderResource providerResource;

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

	@RequestMapping("home.do")
	public ModelAndView showHome(
			@CookieValue(value = "providerId", defaultValue = "") String providerId) {
		String viewName = "home";
		if (StringUtils.isBlank(providerId)) {
			viewName = "add_provider";
		}
		ModelAndView modelAndView = new ModelAndView(viewName);
		return modelAndView;
	}

	@RequestMapping("save-provider.do")
	public ModelAndView saveProvider(Provider provider,
			HttpServletResponse response) {
		provider = providerDAO.save(provider);
		ModelAndView modelAndView = new ModelAndView("home");
		response.addCookie(new Cookie("providerId", provider.getId().toString()));
		return modelAndView;
	}

	@RequestMapping("show-provider.do")
	public ModelAndView showProvider() {
		ModelAndView modelAndView = new ModelAndView("add_provider");
		return modelAndView;
	}

	@RequestMapping("add_client.do")
	public ModelAndView showClient() {
		ModelAndView modelAndView = new ModelAndView("add_client");
		return modelAndView;
	}

	@RequestMapping("save-client.do")
	public ModelAndView saveClient(
			@CookieValue("providerId") String providerId, Client client) {
		clientDAO.save(Long.valueOf(providerId), client);
		ModelAndView modelAndView = new ModelAndView("home");
		return modelAndView;
	}

	@RequestMapping("add_payment.do")
	public ModelAndView showReceipt(@CookieValue("providerId") String providerId) {
		Clients clients = clientDAO.selectAll(Long.valueOf(providerId));
		ModelAndView modelAndView = new ModelAndView("add_payment");
		modelAndView.addObject("clients", clients);
		return modelAndView;
	}

	@RequestMapping("save-receipt.do")
	public ModelAndView saveReceipt(
			@CookieValue("providerId") String providerId, Long clientId,
			Receipt receipt) {

		receipt = providerResource.addReceipt(Long.valueOf(providerId),
				clientId, receipt);

		ModelAndView modelAndView = new ModelAndView("home");
		return modelAndView;
	}
}
