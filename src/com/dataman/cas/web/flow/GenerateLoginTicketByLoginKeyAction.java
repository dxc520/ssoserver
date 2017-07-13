package com.dataman.cas.web.flow;

import javax.validation.constraints.NotNull;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jasig.cas.util.UniqueTicketIdGenerator;
import org.jasig.cas.web.flow.GenerateLoginTicketAction;
import org.jasig.cas.web.support.WebUtils;
import org.springframework.webflow.execution.RequestContext;

import com.dataman.cas.web.flow.utils.PropertiesUtils;
import com.dataman.cas.web.flow.utils.SpringContextUtil;

/**
 * 
 * 扩展的login ticket生成类
 * 
 * @since 1.6
 * @version 1.6
 */
public class GenerateLoginTicketByLoginKeyAction extends GenerateLoginTicketAction {

	private static final String PREFIX = "LT";

	@NotNull
	private UniqueTicketIdGenerator ticketIdGenerator;

	/**
	 * 日志对象
	 */
	private final Log logger = LogFactory.getLog(getClass());

	/**
	 * 生成lt,并根据登录方式返回指定的字符串
	 * 
	 * @param context
	 *            请求上下文
	 * @return 跳转标识字符串
	 */
	public final String generateByLoginKey(final RequestContext context) {
		final String loginTicket = ticketIdGenerator.getNewTicketId(PREFIX);
		this.logger.debug("Generated login ticket " + loginTicket);
		WebUtils.putLoginTicket(context, loginTicket);
		return generateLoginTicket();
	}

	public UniqueTicketIdGenerator getTicketIdGenerator() {
		return ticketIdGenerator;
	}

	public void setTicketIdGenerator(UniqueTicketIdGenerator ticketIdGenerator) {
		this.ticketIdGenerator = ticketIdGenerator;
	}

	/**
	 * 并根据登录方式返回指定的字符串
	 * 
	 * @return 跳转标识字符串
	 */
	private String generateLoginTicket() {
		String loginKey = PropertiesUtils.getValue("loginKey", "0");
		String generated = "generated";
		/*
		 * if (loginKey.equals("1")) { generated = "generatedLTforCard"; } else
		 * if (loginKey.equals("2")) { generated = "generatedLTforCa"; } else if
		 * (loginKey.equals("3")) { generated = "generatedLTforMix"; }
		 */
		if (loginKey.equals("3") && SpringContextUtil.getBean("EIDAuthenticationDetector") != null) {
			generated = "generatedLTforMix";
		}
		return generated;
	}
}
