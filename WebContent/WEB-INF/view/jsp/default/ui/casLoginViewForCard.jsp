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
<OBJECT id="ocx" classid="clsid:9A25691A-CDA5-4632-A728-C10108317610" codebase="resource/card/YKTCardInfo.cab" style="display: none">
</OBJECT>
<title><spring:message code="screen.welcome.label.title" /></title>
<link href="resource/skins/blue/css/login.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery/jquery-1.8.0.min.js"></script>
<script type="text/javascript" language="javascript">
    function loadPage() {
        document.getElementById("showFrom").style.display = "block";
        checkPosition();
    }
    var winTop = window;
    function checkPosition() {
        if (winTop != window.top) {
            window.top.location.href = window.location.href;
        }
    }
    function submitForm(obj) {
        if(document.forms[0]){          
           document.getElementById("cardIndentityCode").value = obj;
           document.getElementById("submit").click();
        }
    }
 function enterKey() {
        if (event.keyCode == 13) {
            //submitForm(obj);
        }
}
</script>
</head>
<body onload="loadPage()">
<div class="loginCard">
    	<%-- <div class="title1"></div>
        <div class="title2"><spring:message code="screen.welcome.label.title" /></div>
    	<div class="CopyrightKa"><spring:message code="screen.service.copyright" /></div> --%>
    		<div id="showFrom" style="display: none">
		<form:form method="post" id="fm1" cssClass="fm-v clearfix"
			commandName="${commandName}" htmlEscape="true">
			
				 <input type="hidden" id="cardIndentityCode"
						name="cardIndentityCode" value="" />
					<input type="hidden" name="username" id="username" value="111" />
					<input type="hidden" name="password" id="password" value="111" /> 
					<input type="hidden" name="lt" value="${loginTicket}" /> 
					<input type="hidden" name="execution" value="${flowExecutionKey}" /> 
					<input type="hidden" name="_eventId" value="submit" /> 
				    <input class="loginSubmitCard" value="" id="submit" name="submit" type="submit" style="display: none"/>
		</form:form>
	</div>
	<p class="tips">未放卡或读卡失败，请重新刷卡！</p>
    </div>
<script type="text/javascript">

    $(document).ready(function(){
    	
        $('.tips').hide();
    });
	
	var ocx = document.getElementById('ocx');
	var yingquid = '212122';
	var lastTime = new Date();
	var number=0;
	function readcardno() {
		number++;
		var obj = "";
			if (ocx && typeof ocx.YKT_GetCardNo !="undefined") {
				try {
					obj = ocx.YKT_GetCardNo(yingquid);
				} catch (e) {

				}
			}
			var nowTime = new Date();
			var is = (obj != '' && obj != null)
					&& (nowTime.getTime() - lastTime.getTime() > 1000);
			if (is) {
				submitForm(obj);
			}else{
				
			}
			if(number>=10){
				$('.tips').fadeIn(1000);
			}
			if(number>=15){
				$('.tips').fadeOut(1000);
				number=0;
			}
		
		setTimeout("readcardno();", 1000);
	}
	var start =  new Date();
	readcardno();
</script>
</body>
</html>