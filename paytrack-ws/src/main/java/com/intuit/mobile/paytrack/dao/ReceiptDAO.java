package com.intuit.mobile.paytrack.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import com.intuit.mobile.paytrack.dbo.ProviderClientDO;
import com.intuit.mobile.paytrack.dbo.ProviderDO;
import com.intuit.mobile.paytrack.dbo.ReceiptDO;
import com.intuit.mobile.paytrack.jaxb.Provider;
import com.intuit.mobile.paytrack.jaxb.Providers;
import com.intuit.mobile.paytrack.jaxb.Receipt;
import com.intuit.mobile.paytrack.jaxb.Receipts;

@Repository
public class ReceiptDAO extends BaseDAO {

	public Receipt save(Long providerId, Long clientId, final Receipt receipt) {

		final ProviderClientDO providerClientDO = getProviderClients(
				providerId, clientId);
		;
		PreparedStatementCreator psc = new PreparedStatementCreator() {
			@Override
			public PreparedStatement createPreparedStatement(Connection con)
					throws SQLException {
				PreparedStatement ps = con.prepareStatement(
						SqlConstants.INSERT_RECEIPT, new String[] { "id" });
				ps.setLong(1, providerClientDO.getId());
				ps.setTimestamp(2, new Timestamp(receipt.getFrom().getTime()));
				ps.setTimestamp(3, new Timestamp(receipt.getTo().getTime()));
				ps.setDouble(4, receipt.getAmount());
				ps.setTimestamp(5, new Timestamp(receipt.getDate().getTime()));
				return ps;
			}

		};
		KeyHolder keyHolder = new GeneratedKeyHolder();
		jdbcTemplate.update(psc, keyHolder);
		receipt.setId(keyHolder.getKey().longValue());

		return receipt;

	}

	private ProviderClientDO getProviderClients(Long providerId, Long clientId) {
		ProviderClientDO providerClientDO = jdbcTemplate.queryForObject(
				SqlConstants.SELECT_PROVIDER_CLIENTS,
				new BeanPropertyRowMapper<ProviderClientDO>(
						ProviderClientDO.class), providerId, clientId);
		return providerClientDO;
	}

	public Providers selectByEmail(String email) {

		List<ProviderDO> providerDOs = jdbcTemplate.query(
				SqlConstants.SELECT_PROVIDERS_BY_EMAIL,
				new BeanPropertyRowMapper<ProviderDO>(ProviderDO.class), email);

		Providers providers = new Providers();
		List<Provider> providerList = providers.getProviders();

		for (ProviderDO providerDO : providerDOs) {
			Provider provider = mapper.map(providerDO, Provider.class);
			providerList.add(provider);
		}
		return providers;
	}

	public Receipts selectAllReceipts(Long providerId, Long clientId) {

		List<ReceiptDO> receiptDOs = jdbcTemplate.query(
				SqlConstants.SELECT_RECEIPTS,
				new BeanPropertyRowMapper<ReceiptDO>(ReceiptDO.class),
				providerId, clientId);

		Receipts receipts = new Receipts();
		List<Receipt> receiptList = receipts.getReceipts();

		for (ReceiptDO receiptDO : receiptDOs) {
			Receipt receipt = mapper.map(receiptDO, Receipt.class);
			receiptList.add(receipt);
		}

		return receipts;
	}

}
