package com.dataman.cas.web.flow.principal;


/**
 * CA凭证
 * 
 * @author xyyue
 * @since 1.6
 * @version 1.6
 */
public class CACredentials extends AbstractCredentials {
	private static final long serialVersionUID = -4441794824034642329L;
	private String dncode;
	private String requestSessionid;

	public String getDncode() {
		return dncode;
	}

	public void setDncode(String dncode) {
		this.dncode = dncode;
	}

	public String getRequestSessionid() {
		return requestSessionid;
	}

	public void setRequestSessionid(String requestSessionid) {
		this.requestSessionid = requestSessionid;
	}
}
