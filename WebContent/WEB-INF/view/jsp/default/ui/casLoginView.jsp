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
<title><spring:message code="screen.welcome.label.title" /></title>
<link href="resource/skins/blue/css/login.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath}/js/jquery/jquery-1.8.0.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/activebar2/activebar2.js"></script>
	
<script type="text/javascript">

	function loadPage() {
		//document.getElementById("showFrom").style.display = "block";
		checkPosition();
		fm1.username.focus();
	}
	var winTop = window;
	function checkPosition() {
		if (winTop != window.top) {
			window.top.location.href = window.location.href;
		}
	}
  function cancelSubmit(){
	  $('#username').val("");
         $('#password').val("");
         $('#errorMessage').html("");
         $('#username').focus();
    }
	function submitForm() {
		//alert(123);
	    if(userpswValidate()){
	    	$('#fm1').submit();
	    }
		
	}
	function enterKey() {
		if (event.keyCode == 13) {
			submitForm();
		}
	}
	
	function availableBrowser() {
		if ($.browser.msie) {
			if ("6.0" == $.browser.version || "7.0" == $.browser.version) {
				return true;
			}
		}
		return false;
	}
	function flashPlayer(){
		var hasFlash = false;
		var flashVersion = 0;
		if ($.browser.msie){
			var swf;
			try{
				swf = new ActiveXObject('ShockwaveFlash.ShockwaveFlash');
			} catch (e) {
				swf = null;
			}
			
			if(swf){
				hasFlash = true;
				VSwf = swf.GetVariable("$version");
				flashVersion = parseInt(VSwf.split(" ")[1].split(",")[0]);
			}
		} else {
			// 其它版本浏览器
			if (navigator.plugins && navigator.plugins.length > 0){
				try{
					swf = navigator.plugins["Shockwave Flash"];
				} catch (e) {
					swf = null;
				}
				if (swf){
					hasFlash = true;
					var words = swf.description.split(" ");
					for (var i = 0; i < words.length; i++){
						if (isNaN(parseInt(words[i])))
							continue;
						flashVersion = parseInt(words[i]);
					}
				}
			}
		}
		return {f:hasFlash, v:flashVersion};
	}
	var downloadUrl =null;
	var message = "";
/* 	if (!availableBrowser()) {
		message = "您的浏览器版本不在我们的支持范围内！建议使用IE6/IE7进行浏览！&nbsp;&nbsp;&nbsp;&nbsp;";
	} */
	var downloadurl= "${pageContext.request.contextPath}/resource/plugins/flashplayer11.exe";
	var fls=flashPlayer();
	if (fls.f){
		if (fls.v < 11) {
			downloadUrl = downloadurl;
			message = message + "您当前使用的<a href=" + downloadUrl + ">Adobe Flash Player</a>版本过低，请下载较高版本的插件！";
		}
	} else {
		downloadUrl = downloadurl;
		message = message + "您尚未安装 <a href=" + downloadUrl + ">Adobe Flash Player</a>插件，请下载并安装 ！";
	}
	if (null != message && "" != message) {
		$(function() {
            $('<div></div>').html(message)
                            .activebar({
                                icon : '${pageContext.request.contextPath}/images/activebar-information.png',
                                button : '${pageContext.request.contextPath}/images/activebar-closebtn.png',
                                url : downloadUrl
                            });
        });
	}
	function userpswValidate(){
		$('#errorMessage').html("");
        var errorMesaage = "警告：";
        var usernameError = "";
        var passwordError = "";
        var username = $('#username').val();
        var password = $('#password').val();
        if (username != null && username != "" && password != null && password != "") {
            return true;
        }
        if (username == "" || username == null) {
            usernameError = "必须录入用户名";
        }
        if (password == "" || password == null) {
            passwordError = "必须录入密码";
        }
        if (usernameError != "" && passwordError != "") {
            errorMesaage += usernameError + "，" + passwordError;
        }
        else {
            errorMesaage += usernameError ? usernameError : passwordError;
        }
        $('#errorMessage').html(errorMesaage);
        return false;
}
</script>
</head>
<body style="margin:0;" scroll="no" onload="loadPage()">
	<div class="loginCentent">
		<form:form method="post" id="fm1" cssClass="fm-v clearfix"
			commandName="${commandName}" htmlEscape="true">
			<ul class="loginBox">
				<li>
				    <span style="font-weight:bold;font-family:宋体;">用户名：</span> 
				    <span class="password_bg">
						<c:if
								test="${not empty sessionScope.openIdLocalId}">
								<strong>${sessionScope.openIdLocalId}</strong>
						<input type="hidden" id="username" name="username"
									value="${sessionScope.openIdLocalId}" />
							</c:if> <c:if test="${empty sessionScope.openIdLocalId}">
								<spring:message code="screen.welcome.label.netid.accesskey"
									var="userNameAccessKey" />
								<!--<form:input id="username" tabindex="1" accesskey="${userNameAccessKey}" path="username" autocomplete="false" htmlEscape="true" />-->
								<input id="username" type="text" name="username" accesskey="n"
									tabindex=1 onkeydown="enterKey()"
									maxlength="15" class="userInput"/>
							</c:if>
				    </span>
				</li>
				<li>
				    <span style="font-weight:bold;font-family:宋体;">密&nbsp;&nbsp;码：</span> 
				    <span class="password_bg"> 
				        <input type="password" name="password" id="password" class="codeInput" 
				         accesskey="p" onkeydown="enterKey()" maxlength="20"/>
				    </span>
				</li>
				<div id="errorMessage" style="height: 10;">
				<spring:hasBindErrors name="credentials">
                                                                警告:
                        <c:forEach var="error"
								items="${errors.allErrors}">
								<spring:message code="${error.code}"
									text="${error.defaultMessage}" />
							</c:forEach>
						</spring:hasBindErrors></div>
				<li>
				    <input type="button" id="loginButton"  class="loginButton" onclick="submitForm()"/> 
					<input type="button" id="cancelButton" class="cancelButton" onclick="cancelSubmit()"/>
			    </li>
			</ul>
			<input type="hidden" name="lt" value="${loginTicket}" /> <input
				type="hidden" name="execution" value="${flowExecutionKey}" /> <input
				type="hidden" name="_eventId" value="submit" />

		</form:form>
	</div>
</body>
</html>