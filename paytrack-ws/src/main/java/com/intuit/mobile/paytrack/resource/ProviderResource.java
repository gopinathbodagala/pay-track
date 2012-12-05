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

import com.intuit.mobile.paytrack.dao.ProviderDAO;
import com.intuit.mobile.paytrack.jaxb.Provider;
import com.intuit.mobile.paytrack.jaxb.Providers;

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

	

	@GET
	public Providers getAll(@QueryParam("email") String email,
			@QueryParam("mobile") String mobile) {
		Providers projects = null;
		if (email == null && mobile == null) {
			projects = providerDAO.selectAll();

		} else if(email!=null){
			projects = providerDAO.selectByEmail(email);
		}else{
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
	public Provider put(@PathParam("id") Long id,
			Provider provider) {
		provider = providerDAO.update(provider);
		return provider;
	}

}
