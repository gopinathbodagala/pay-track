package com.intuit.mobile.paytrack.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import com.intuit.mobile.paytrack.dbo.ClientDO;
import com.intuit.mobile.paytrack.jaxb.Client;
import com.intuit.mobile.paytrack.jaxb.Clients;

@Repository
public class ClientDAO extends BaseDAO {

	public Clients selectAll(Long providerId) {
		List<ClientDO> clientDOs = jdbcTemplate
				.query(SqlConstants.SELECT_ALL_CLIENTS_FOR_PROVIDER,
						new BeanPropertyRowMapper<ClientDO>(ClientDO.class),
						providerId);

		Clients clients = new Clients();
		List<Client> clientList = clients.getClients();

		for (ClientDO clientDO : clientDOs) {
			Client client = mapper.map(clientDO, Client.class);
			clientList.add(client);
		}
		return clients;
	}

	public Client save(Long providerId, final Client client) {
		PreparedStatementCreator psc = new PreparedStatementCreator() {
			@Override
			public PreparedStatement createPreparedStatement(Connection con)
					throws SQLException {
				PreparedStatement ps = con.prepareStatement(
						SqlConstants.INSERT_CLIENT, new String[] { "id" });
				ps.setString(1, client.getFirstName());
				ps.setString(2, client.getLastName());
				ps.setString(3, client.getEmail());
				ps.setString(4, client.getMobile());
				ps.setString(5, client.getAddress());
				return ps;
			}

		};
		KeyHolder keyHolder = new GeneratedKeyHolder();
		jdbcTemplate.update(psc, keyHolder);
		client.setId(keyHolder.getKey().longValue());
		saveMapping(providerId, client.getId());
		return client;
	}

	private void saveMapping(Long providerId, long clientId) {
		jdbcTemplate.update(SqlConstants.INSERT_PROVIDER_CLIENTS, providerId,
				clientId);
	}

	public Client update(Client client) {

		jdbcTemplate.update(SqlConstants.UPDATE_CLIENT, client.getFirstName(),
				client.getLastName(), client.getEmail(), client.getMobile(),
				client.getAddress(), client.getId());
		return client;
	}

	public Client selectClient(Long clientId) {
		try {
			ClientDO clientDO = jdbcTemplate.queryForObject(
					SqlConstants.SELECT_CLIENT,
					new BeanPropertyRowMapper<ClientDO>(ClientDO.class),
					clientId);
			return mapper.map(clientDO, Client.class);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

}
