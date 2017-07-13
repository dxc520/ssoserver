<%@ page session="false"  contentType="text/html; charset=GBK"%><cas:serviceResponse xmlns:cas='http://www.yale.edu/tp/cas'>
	<cas:authenticationFailure code='${code}'>
		${description}
	</cas:authenticationFailure>
</cas:serviceResponse>