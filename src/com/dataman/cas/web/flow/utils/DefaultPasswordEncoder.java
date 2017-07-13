/*
 * Copyright 2007 The JA-SIG Collaborative. All rights reserved. See license
 * distributed with this file and available online at
 * http://www.uportal.org/license.html
 */
package com.dataman.cas.web.flow.utils;

import org.jasig.cas.authentication.handler.PasswordEncoder;

/**
 * Implementation of PasswordEncoder using message digest. Can accept any
 * message digest that the JDK can accept, including MD5 and SHA1. Returns the
 * equivalent Hash you would get from a Perl digest.
 * 
 * @author Scott Battaglia
 * @author Stephen More
 * @version $Revision: 1.1 $ $Date: 2010/03/05 07:48:22 $
 * @since 3.1
 */
public final class DefaultPasswordEncoder implements PasswordEncoder {

	private String encodingAlgorithm = "MD5";

	public DefaultPasswordEncoder(final String encodingAlgorithm) {
		this.encodingAlgorithm = encodingAlgorithm;
	}

	public String encode32(final String password) {
		if (password == null) {
			return null;
		}
		if (encodingAlgorithm != null
				&& encodingAlgorithm.equalsIgnoreCase("MD5")) {
			MD5 md5 = new MD5();
			return md5.getMD5ofStr(password);
		}
		return password;
	}

	public String encode(final String password) {
		String ecpwd = encode32(password);
		return (ecpwd != null && ecpwd.length() == 32) ? ecpwd.substring(12)
				: password;
	}
}
