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
<title>集成运行平台</title>
<link href="css/login.css" rel="stylesheet" type="text/css" />
<script type="" language="javascript">
	function loadPage() {
		document.getElementById("showFrom").style.display = "block";
		checkPosition();
		fm1.username.focus();
	}
	var winTop = window;
	function checkPosition() {
		if (winTop != window.top) {
			window.top.location.href = window.location.href;
		}
	}
	function submitForm() {
        alert(document.forms[0].action);
		document.forms[0].submit();
	}
	function enterKey() {
		if (event.keyCode == 13) {
			submitForm();
        }
    }
</script>
</head>
<body onload="loadPage()">
	<div id="showFrom" style="display: none">
		<!-- 
		<form name="form" method="post"
			action="<%=response.encodeRedirectURL("login?service=" + portalURL)%>">
			<input type="hidden" name="lt" value="${flowExecutionKey}" /> <input
				type="hidden" name="_eventId" value="submit" />
			<div class="loginCenter">
				<div class="loginLogo"></div>
				<div class="loginBox">
						<li class="paddingTop"><span>用&nbsp;&nbsp;户：</span><span class="username_bg"><input
								id="username" type="text" name="username" accesskey="n"
								tabindex=1 class="userOnblur" onkeydown="enterKey()"
								  maxlength="15"/> </span></li>
						<li class="marginTop"><span>密&nbsp;&nbsp;码：</span><span class="password_bg"><input
								type="password" id="password" name="password" tabindex=2
								accesskey="p" onkeydown="enterKey()" class="passOnblur"
								  maxlength="20"/> </span></li>
						<li class="errorInfo"><spring:hasBindErrors
								name="credentials">
						警告:
						<c:forEach var="error" items="${errors.allErrors}">
									<spring:message code="${error.code}"
										text="${error.defaultMessage}" />
								</c:forEach>
							</spring:hasBindErrors></li>
						<li class="loginButtonMargin"><input type="button" value=""
							class="loginButton" tabindex=3 onclick="submitForm()" /></li>
				</div>
				<input type="hidden" name="sessionid"
					value="<%=request.getSession().getId()%>" />
				<div class="loginBottom"></div>
			</div>
		</form>
		 -->
		<form:form method="post" id="fm1" cssClass="fm-v clearfix"
			commandName="${commandName}" htmlEscape="true">
			<div class="loginCenter">
				<div class="loginLogo"></div>
				<div class="loginBox">
					<li class="paddingTop"><span>用&nbsp;&nbsp;户：</span> <span
						class="username_bg"> <c:if
								test="${not empty sessionScope.openIdLocalId}">
								<strong>${sessionScope.openIdLocalId}</strong>
								<input type="hidden" id="username" name="username"
									value="${sessionScope.openIdLocalId}" />
							</c:if> <c:if test="${empty sessionScope.openIdLocalId}">
								<spring:message code="screen.welcome.label.netid.accesskey"
									var="userNameAccessKey" />
								<!--<form:input id="username" tabindex="1" accesskey="${userNameAccessKey}" path="username" autocomplete="false" htmlEscape="true" />-->
								<input id="username" type="text" name="username" accesskey="n"
									tabindex=1 class="userOnblur" onkeydown="enterKey()"
									maxlength="15" />
							</c:if>
					</span></li>
					<li class="marginTop"><span>密&nbsp;&nbsp;码：</span> <span
						class="password_bg"> <input type="password" id="password"
							name="password" tabindex=2 accesskey="p" onkeydown="enterKey()"
							class="passOnblur" maxlength="20" />
					</span> <!-- 
	                    <div class="row fl-controls-left">
	                        <label for="password" class="fl-label"><spring:message code="screen.welcome.label.password" /></label>
	                        <spring:message code="screen.welcome.label.password.accesskey" var="passwordAccessKey" />
	                        <form:password cssClass="required" cssErrorClass="error" id="password" size="25" tabindex="2" path="password"  accesskey="${passwordAccessKey}" htmlEscape="true" autocomplete="off" />
	                    </div>
	                    <div class="row check">
	                        <input id="warn" name="warn" value="true" tabindex="3" accesskey="<spring:message code="screen.welcome.label.warn.accesskey" />" type="checkbox" />
	                        <label for="warn"><spring:message code="screen.welcome.label.warn" /></label>
	                    </div>
	                     --></li>
					<li class="errorInfo"><spring:hasBindErrors name="credentials">
                                                                警告:
                        <c:forEach var="error"
								items="${errors.allErrors}">
								<spring:message code="${error.code}"
									text="${error.defaultMessage}" />
							</c:forEach>
						</spring:hasBindErrors></li>
					<li class="loginButtonMargin"><input type="hidden" name="lt"
						value="${loginTicket}" /> <input type="hidden" name="execution"
						value="${flowExecutionKey}" /> <input type="hidden"
						name="_eventId" value="submit" /> <input class="loginButton"
						value="" name="submit" accesskey="l" tabindex="3" type="submit" />
					</li>
					<!-- 
                    <div class="row btn-row">
                        <input type="hidden" name="lt" value="${loginTicket}" />
                        <input type="hidden" name="execution" value="${flowExecutionKey}" />
                        <input type="hidden" name="_eventId" value="submit" />

                        <input class="btn-submit" name="submit" accesskey="l" value="<spring:message code="screen.welcome.button.login" />" tabindex="4" type="submit" />
                        <input class="btn-reset" name="reset" accesskey="c" value="<spring:message code="screen.welcome.button.clear" />" tabindex="5" type="reset" />
                    </div>
                     -->
				</div>
			</div>
		</form:form>
	</div>
</body>
</html>