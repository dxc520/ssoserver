package com.dataman.cas.web.flow.principal;

import org.jasig.cas.authentication.principal.UsernamePasswordCredentials;

/**
 * 定制凭证对象
 * 
 * @author xyyue
 * @since 1.6
 * @version 1.6
 */
public class AbstractCredentials extends UsernamePasswordCredentials {
	private static final long serialVersionUID = 8669801519474369288L;
	private String sessionid;

	public String getSessionid() {
		return sessionid;
	}

	public void setSessionid(String sessionid) {
		this.sessionid = sessionid;
	}
}
