package com.dataman.cas.web.flow;

import javax.validation.constraints.NotNull;

import org.jasig.cas.adaptors.jdbc.AbstractJdbcUsernamePasswordAuthenticationHandler;
import org.jasig.cas.authentication.handler.AuthenticationException;
import org.jasig.cas.authentication.principal.UsernamePasswordCredentials;

/**
 * 
 * 默认的用户验证handle
 * @author xyyue
 * @version 1.6
 * @since 1.6
 */
public class DefaultDBAuthenticationHandler extends
		AbstractJdbcUsernamePasswordAuthenticationHandler {
	@NotNull
	private String sql;

	/**
	 * 查询SQL
	 * 
	 * @param sql
	 *            The sql to set.
	 */
	public void setSql(final String sql) {
		this.sql = sql;
	}

	@Override
	protected boolean authenticateUsernamePasswordInternal(
			UsernamePasswordCredentials credentials)
			throws AuthenticationException {
		String pwd = credentials.getPassword();
		String username = getJdbcTemplate().queryForObject(this.sql,
				String.class, pwd);

		if (username != null) {
			credentials.setUsername(username);
			return true;
		}
		return false;
	}

}
