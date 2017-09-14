<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>AccessDenied page</title>
<jsp:include page="fragments/title.jsp" />
<jsp:include page="fragments/css/bootstrap.jsp" />
<jsp:include page="fragments/css/signin.jsp" />
<jsp:include page="fragments/css/footer.jsp" />
<jsp:include page="fragments/css/fontAwesome.jsp" />
<jsp:include page="fragments/css/animate.jsp" />
</head>
<body>

<br /><br />
	<div class="container">
		<div class="jumbotron">
			<h1 class="display-3">
				<spring:message code="access.denied" />
			</h1>
			<p class="lead"></p>
			<hr class="my-4">
			
			
			<p class="lead"><spring:message code="access.denied.message" /></p>
			<p class="lead"> 
				<a class="btn btn-primary btn-lg" href="<c:url value="/logout" />"><spring:message	code="logout" /></a>
			</p>

		</div>
	</div>

	<jsp:include page="fragments/js/jquery.jsp" />
	<jsp:include page="fragments/js/bootstrap.jsp" />
</body>
</html>