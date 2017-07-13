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
<OBJECT id="ocx" classid="clsid:9A25691A-CDA5-4632-A728-C10108317610" codebase="resource/card/YKTCardInfo.cab" style="display: none"></OBJECT>
<title><spring:message code="screen.welcome.label.title" /></title>
 <script src="js/jquery/jquery-1.8.0.min.js"></script>
<link href="resource/skins/blue/css/login.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" language="javascript">
        $(document).ready(function(){
            $('#loginTypeSelect').change(function(){
                $('#username').val("");
                $('#password').val("");
                $('#errorMessageValidate').html("");
                var selectIndex = $('#loginTypeSelect').get(0).selectedIndex;
                writeCookie("loginKeyIndexSelected",selectIndex);
                if($(this).get(0).selectedIndex == 0){
                    $('#username').removeAttr("readonly");
                    $('#password').removeAttr("readonly");
                    $('#username').focus();
                }else{
                    $('#username').attr("readonly",true);
                   $('#password').attr("readonly",true);
                    $('#username').blur();
                    $('#password').blur();

                }
            });
        });
        function cancelSubmit(){
        	$('#username').val("");
        	$('#password').val("");
        	$('#errorMessageValidate').html("");
        	$('#username').focus();
	    }
        function loadPage(){
            checkPosition();
            defaultLoginType();
            defaultInputState();
        }

        var winTop = window;
        function checkPosition(){
            if (winTop != window.top) {
                window.top.location.href = window.location.href;
            }
        }

        function submitForm(){
            var selectedIndexVar = $('#loginTypeSelect').get(0).selectedIndex;
            var errorMesaage = "";
            if (parseInt(selectedIndexVar) == 0) {
                if (userpswValidate()){
                	$('#fm1').submit();
                	return;
                };
            }
            if (selectedIndexVar == 1) {
                if(cardValidate()){
                	$('#fm1').submit();
                	return;
                };
            }
            if (selectedIndexVar == 2) {
                caValidate();
                $('#fm1').submit();
                return;
            }
        }


        function userpswValidate(){
            $('#errorMessageValidate').html("");;
            var errorMesaage = "警告：";
            var usernameError = "";
            var passwordError = "";
            var username =  $('#username').val();;
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
            $('#errorMessageValidate').html(errorMesaage);
            return false;
        }
        function cardValidate(){
           $('#errorMessageValidate').html("");
            var cardCode = readCard();
            if ( cardCode != "NO_CARD_MESSAGE") {
                $('#cardIndentityCode').val(cardCode);
                $('#username').removeAttr("readonly");
                $('#password').removeAttr("readonly");
               // $('#username').attr("disabled",true);
                //$('#password').attr("disabled",true);;  
                $('#username').attr("readonly",true);
                $('#password').attr("readonly",true);  
                $('#username').val("-------------");
                $('#password').val("111111111");
                return true;
            }
            else {
                errorMesaage  = "警告：卡信息读取失败，请重新刷卡";
                $('#errorMessageValidate').html(errorMesaage) ;
                return false;
            }
        }
        function caValidate(){

            $('#errorMessageValidate').html("");
            $('#username').removeAttr("readonly");
            $('#password').removeAttr("readonly");
            $('#username').attr("readonly",true);
            $('#password').attr("readonly",true);;
            $('#username').val("----------");
            $('#password').val("-------");
            return true;

        }
        function writeCookie(cookieName,cookieValue,expireDays){
            if(expireDays == null){
                expireDays = 7;
            }
            var exp = new Date();
            exp.setTime(exp.getTime()+expireDays*24*3600*1000);
            document.cookie=cookieName+"="+escape(cookieValue)+",expires="+exp.toGMTString();
        }
        function getCookie(cookieName){
            if(document.cookie.length > 0){
                var begin = document.cookie.indexOf(cookieName+"=");
                if(begin !=-1){
                    begin+=cookieName.length+1;
                    end = document.cookie.indexOf(";",begin);
                    if(end == -1){
                        end = document.cookie.length;
                    }
                    return unescape(document.cookie.substring(begin,end));
                }
            }
            if(cookieName == "loginKeyIndexSelected") {
                var exp = new Date();
                exp.setTime(exp.getTime()+7*24*3600*1000);
                return "0"+",expires="+exp.toGMTString();
            }
            return "INVALID_COOKIVE_VALUE";
        }
        function defaultLoginType(){
            var cookieValue = getCookie("loginKeyIndexSelected");
            var seletedIndex = 0;
            if (cookieValue.indexOf(",") > -1) {
                seletedIndex = cookieValue.substring(0, cookieValue.indexOf(","));
            }
            $('#loginTypeSelect').get(0).selectedIndex = parseInt(seletedIndex);

        }
        function defaultInputState(){
            var seletedIndex = $('#loginTypeSelect').get(0).selectedIndex;

            if (parseInt(seletedIndex) == 0) {

                $('#username').removeAttr("readonly");
                $('#password').removeAttr("readonly");
                $('#username').focus();
            }
            else {
                $('#username').attr("readonly",true);
                $('#password').attr("readonly",true);
                $('#username').blur();
                $('#password').blur();
            }
        }
    </script>

</head>
<body onload="loadPage()">
	<div class="loginCentent">
		
		<form:form method="post" id="fm1" cssClass="fm-v clearfix"
			commandName="${commandName}" htmlEscape="true">
			<ul class="loginBox">
				<li>
				    <span class="">用&nbsp;&nbsp;户&nbsp;&nbsp;名：</span> 
				    <span class="password_bg">
						<input type="text" id="username" name="username"  class="userInput"  />
				    </span>
				</li>
				<li>
				    <span class="">密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码：</span> 
				    <span class="password_bg"> 
				        <input type="password" name="password" id="password" class="codeInput" 
				         accesskey="p" onkeydown="enterKey()" maxlength="20" />
				    </span>
				</li>
				<li>
				    <span class="">登录方式：</span> 
				    <div class="selectbox"> 
				        <select id="loginTypeSelect">
							<option id="user_0" value="用户名/密码">
								<p>用户名/密码</p>
							</option>
							<option id="user_1" value="读卡登录">读卡登录</option>
							<option id="user_2" value="USBKey">USBKey</option> 
					</select>
				    </div>
				</li>
				<div id="errorMessageValidate" style="height: 10;">
				<spring:hasBindErrors name="credentials">
                                                                警告:
                        <c:forEach var="error"
								items="${errors.allErrors}">
								<spring:message code="${error.code}"
									text="${error.defaultMessage}" />
							</c:forEach>
						</spring:hasBindErrors></div>
				<li>
				    <input type="button" name="button" id="loginButton" class="loginButton" onclick="submitForm()"/> 
					<input type="button" name="button" id="cancelButton"  class="cancelButton" onclick="cancelSubmit()"/>
			    </li>
			</ul>
			
			
			<input type="hidden" id="cardIndentityCode" name="cardIndentityCode" value="" />
			<input type="hidden" name="lt" value="${loginTicket}" />
			<input type="hidden" name="execution" value="${flowExecutionKey}" />
			<input type="hidden" name="_eventId" value="submit" />
		</form:form>
		
	</div>
</body>
<script type="text/javascript">
	var ocx = document.getElementById('ocx');
	var yingquid = '212122';
	function readCard() {
		var obj = '' ;
		if(ocx && typeof ocx.YKT_GetCardNo !="undefined"){
			try{
			    obj = ocx.YKT_GetCardNo(yingquid);
			}catch(e){
			}
		}
		if(obj!= null && obj !=''){
			 return obj;
		}else{
			obj = 'NO_CARD_MESSAGE';
		}
		return obj;
	}
</script>
</html>