<%@page language="java" contentType="text/html;charset=gbk"%>
<%@page import="org.nci.cas.web.flow.utils.CustomUtil"%>
<%@page import="org.nci.cas.web.flow.utils.AuthenticationContants"%>
<%
		String portalURL = CustomUtil.getPortalURL();
		request.getSession().getServletContext().setAttribute(AuthenticationContants.PORTAL_URL, portalURL);
		response.sendRedirect(response.encodeRedirectURL(portalURL));
%>

���ɹ���¼������ѡ��������ϵͳ��

<ul>

	<li><a href="<%=portalURL%>" target="_self">ƽ̨</a></li>


</uL>

<!--iframe src="http://hf:8090/xmgl/index.jsp" width=600 height=600></iframe>

<iframe src="http://hp27204143103.:8082/xmgl/index.jsp" width=600 height=600></iframe>-->