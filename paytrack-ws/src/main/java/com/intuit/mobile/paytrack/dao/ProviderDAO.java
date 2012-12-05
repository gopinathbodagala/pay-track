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

import com.intuit.mobile.paytrack.dbo.ProviderDO;
import com.intuit.mobile.paytrack.jaxb.Provider;
import com.intuit.mobile.paytrack.jaxb.Providers;

@Repository
public class ProviderDAO extends BaseDAO {

	public Providers selectAll() {

		List<ProviderDO> providerDOs = jdbcTemplate.query(
				SqlConstants.SELECT_ALL_PROVIDERS,
				new BeanPropertyRowMapper<ProviderDO>(ProviderDO.class));

		Providers providers = new Providers();
		List<Provider> providerList = providers.getProviders();

		for (ProviderDO providerDO : providerDOs) {
			Provider provider = mapper.map(providerDO, Provider.class);
			providerList.add(provider);
		}
		return providers;
	}

	public Provider save(final Provider provider) {

		PreparedStatementCreator psc = new PreparedStatementCreator() {
			@Override
			public PreparedStatement createPreparedStatement(Connection con)
					throws SQLException {
				PreparedStatement ps = con.prepareStatement(
						SqlConstants.INSERT_PROVIDER, new String[] { "id" });
				ps.setString(1, provider.getFirstName());
				ps.setString(2, provider.getLastName());
				ps.setString(3, provider.getEmail());
				ps.setString(4, provider.getMobile());
				ps.setString(5, provider.getAddress());
				ps.setString(6, provider.getServiceName());
				return ps;
			}

		};
		KeyHolder keyHolder = new GeneratedKeyHolder();
		jdbcTemplate.update(psc, keyHolder);
		provider.setId(keyHolder.getKey().longValue());

		return provider;
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

	public Providers selectByMobile(String mobile) {

		List<ProviderDO> providerDOs = jdbcTemplate
				.query(SqlConstants.SELECT_PROVIDERS_BY_MOBILE_NUMBER,
						new BeanPropertyRowMapper<ProviderDO>(ProviderDO.class),
						mobile);

		Providers providers = new Providers();
		List<Provider> providerList = providers.getProviders();

		for (ProviderDO providerDO : providerDOs) {
			Provider provider = mapper.map(providerDO, Provider.class);
			providerList.add(provider);
		}
		return providers;
	}

	public Provider update(Provider provider) {
		jdbcTemplate.update(SqlConstants.UPDATE_PROVIDER,
				provider.getFirstName(), provider.getLastName(),
				provider.getEmail(), provider.getMobile(),
				provider.getAddress(), provider.getServiceName(),
				provider.getId());
		return provider;
	}

	public Provider selectById(Long id) {
		try {
			ProviderDO poviderDO = jdbcTemplate
					.queryForObject(SqlConstants.SELECT_PROVIDER_BY_ID,
							new BeanPropertyRowMapper<ProviderDO>(
									ProviderDO.class), id);
			return mapper.map(poviderDO, Provider.class);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

}
