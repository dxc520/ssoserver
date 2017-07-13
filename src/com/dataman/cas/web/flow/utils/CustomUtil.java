package com.dataman.cas.web.flow.utils;

import org.jasig.cas.web.support.WebUtils;
import org.springframework.webflow.execution.RequestContext;

/**
 * 自定义验证结果类
 * @author xyyue
 * @version 1.0
 * @since 1.6
 */
public class CustomUtil {
	/**
	 * 获取转向地址
	 * 
	 * @return String PortalURL
	 */
	public static String getPortalURL() {
		String portalURL = PropertiesUtils
				.getValue(AuthenticationContants.PORTAL_URL);
		if (portalURL != null && !portalURL.endsWith("/")) {
			//portalURL += "/";
		}
		return portalURL;
	}

	/**
	 * 根据配置登录类型返回指定的标识字符串
	 * @param code
	 * @return 标识字符串
	 */
	public static String getEvent(String code) {
		String loginKey = PropertiesUtils.getValue("loginKey", "0");
		String res = "";
		if (code.equalsIgnoreCase("error")) {
			if (loginKey.equals("0")) {
				res = "error";
			} else if (loginKey.equals("1")) {
				res = "errorCard";
			} else if (loginKey.equals("2")) {
				res = "errorCa";
			} else if (loginKey.equals("3")) {
				res = "errorMix";
			}
		} else {
			res = code;
		}
		return res;
	}
	
	public static String getEvent(RequestContext context){
		String res = "error";
		String loginKey = PropertiesUtils.getValue("loginKey", "0");
		if (loginKey.equals("3")) {
			return "errorMix";
		}
		String type = (String) WebUtils.getHttpServletRequest(context)
				.getAttribute(AuthenticationContants.AUTHENTICATION_TYPE);
		if(AuthenticationContants.AUTHENTICATION_TYPE_CA
				.equalsIgnoreCase(type)){
			res = "errorCa";
		}
		if(loginKey.equals("1") && SpringContextUtil.getBean("EIDAuthenticationDetector") != null){
			res = "errorCard";
		}
		return res;
	}
}
