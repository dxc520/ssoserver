<%@ page session="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@page import="org.springframework.util.StringUtils"%>
<%@page import="org.nci.cas.web.flow.utils.CustomUtil"%>
<%@page import="org.nci.cas.web.flow.utils.AuthenticationContants"%>
<%
	String service = request.getParameter("service");
	String portalURL = (String) request.getSession()
			.getServletContext()
			.getAttribute(AuthenticationContants.PORTAL_URL);
	if (portalURL == null || "".equals(portalURL)) {
		portalURL = CustomUtil.getPortalURL();
		request.getSession()
				.getServletContext()
				.setAttribute(AuthenticationContants.PORTAL_URL,
						portalURL);
	}
	if (!portalURL.equals(service)) {
		response.sendRedirect("login?service="
				+ response.encodeRedirectURL(portalURL));
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><spring:message code="screen.welcome.label.title" /></title>
<link href="resource/skins/blue/css/error.css" rel="stylesheet" type="text/css" />
</head>
<script type="text/javascript" language="javascript">
  var time = 300;
	function autoCloseWindow() {
		setTimeout('autoCloseWindow()', 100);
		if (time > 0) {
			document.getElementById("showText").innerHTML = parseInt(time/10+1) + "</font>秒后关闭当前窗口";
			time--;
		} else {
			window.opener = '';
			window.open('','_self','');
			window.close();
		}
	}
	function windowClose(){
		if(confirm("您确定要离开当前页面吗？")){
		    window.opener = '';
		    window.open('','_self','');
		    window.close();
		}
	}
</script>
<body onload="autoCloseWindow();">
	<div class="loginCentent">
    	<%-- <div class="title1"></div>
        <div class="title2"><spring:message code="screen.welcome.label.title" /></div> --%>
		 <div class="ds">
            <p id="showText"></p>
            <!--  <li class="errorInfoLogout" style="list-style:none"> -->
            <p class="errorInfoLogout">
            <spring:hasBindErrors name="credentials">警告:
                <c:forEach var="error" items="${errors.allErrors}">
                    <spring:message code="${error.code}" text="${error.defaultMessage}" />
                </c:forEach>
            </spring:hasBindErrors>
            </p>
            <div style="margin-left:170px;">        	
            	<a href="<%=portalURL%>>" class="newLogin"></a>
        		<a href="#" class="close" onclick="windowClose()"></a>
        </div>
        </div>
       <%-- <div class="Copyright"><spring:message code="screen.service.copyright" /></div> --%>
    </div>

</body>
</html>