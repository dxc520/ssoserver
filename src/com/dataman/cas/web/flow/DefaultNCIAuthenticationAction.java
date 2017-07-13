/**
 * 
 */
package com.dataman.cas.web.flow;

import org.springframework.webflow.action.AbstractAction;
import org.springframework.webflow.execution.Event;
import org.springframework.webflow.execution.RequestContext;

import com.dataman.cas.web.flow.utils.PropertiesUtils;
import com.dataman.cas.web.flow.utils.SpringContextUtil;

/**
 * @author xyyue
 *
 */
public class DefaultNCIAuthenticationAction extends AbstractAction {
	
	
	private final String ERROR_EVENT_ID = getEventFactorySupport()
			.getErrorEventId();

	/* (non-Javadoc)
	 * @see org.springframework.webflow.action.AbstractAction#doExecute(org.springframework.webflow.execution.RequestContext)
	 */
	@Override
	protected Event doExecute(RequestContext context) throws Exception {
		Event event = result(ERROR_EVENT_ID);
		String loginKey = PropertiesUtils.getValue("loginKey", "0");
		if (loginKey.equals("0")) {
			event = result("base");
		}else{
			if(SpringContextUtil.getBean("EIDAuthenticationDetector") != null){
				event = result("extension");
			}
		}
		return event;
	}

}
