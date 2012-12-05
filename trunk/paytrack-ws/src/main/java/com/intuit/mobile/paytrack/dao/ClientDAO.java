package com.intuit.mobile.paytrack.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.stereotype.Repository;

import com.intuit.mobile.paytrack.dbo.ClientDO;
import com.intuit.mobile.paytrack.jaxb.Client;
import com.intuit.mobile.paytrack.jaxb.Clients;

@Repository
public class ClientDAO extends BaseDAO {

	public Clients selectAll(Long providerId) {
		List<ClientDO> clientDOs = jdbcTemplate
				.query("select * from clients where provider_id = ?",
						new BeanPropertyRowMapper<ClientDO>(ClientDO.class),
						providerId);

		Clients clients = new Clients();
		List<Client> clientList = clients.getClients();
		
		for(ClientDO clientDO: clientDOs){
			Client client = mapper.map(clientDO, Client.class);
			clientList.add(client);
		}
		return clients;
	}

	public Client save(Long providerId, Client client) {
		// TODO Auto-generated method stub
		return null;
	}

	public Client update(Long providerId, Client client) {
		// TODO Auto-generated method stub
		return null;
	}

}
