<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<style>
.navbar-inverse .navbar-nav .nav-link {
	color: rgb(255, 255, 255);
}

.color-button {
	color: rgb(255, 255, 255) !important;
}
</style>
<c:url value="/logout" var="logoutUrl" />
<form action="${logoutUrl}" method="post" id="logoutForm">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>
<nav class="navbar navbar-toggleable navbar-inverse bg-success">
	<button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>
	<a class="navbar-brand" href="#"><img src="<c:url value="/resources/images/logo-cesurcafe-2.svg"/>" alt="Card image cap" class="img-fluid" width="100px"></a>

	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item "> <a class="nav-link  btn btn-success" data-container="body" rel="tooltip" data-placement="bottom" title="<spring:message code="tooltip.go-index" />"  role="button"  href="<spring:url value="/"/>"> <spring:message code="navbar.index-url" /> <span class="sr-only">(current)</span></a></li>
			<li class="nav-item"><c:choose>
					<c:when test="${pageContext.response.locale.language == 'es'}">
						<a class="nav-link btn btn-success" data-container="body" rel="tooltip" data-placement="bottom" title="<spring:message code="to-see.language" />"  role="button" href="<spring:url value="?lang=en" />"> EN <img src="<c:url value="/resources/images/english-icon.png"/>" class="img-fluid" alt="Responsive image" width="18" height="18"></a>
					</c:when>
					<c:when test="${pageContext.response.locale.language == 'en'}">
						<a class="nav-link btn btn-success" role="button" data-container="body" rel="tooltip" data-placement="bottom" title="<spring:message code="to-see.language" />"   href="<spring:url value="?lang=es" />"> ES <img src="<c:url value="/resources/images/spanish-icon.png"/>" class="img-fluid" alt="Responsive image" width="18" height="18"></a>
					</c:when>
				</c:choose></li>
				<li class="nav-item "> <a class="nav-link  btn btn-success" data-container="body" rel="tooltip" data-placement="bottom" title="<spring:message code="user.manual" />"  role="button" target ="_blank"  href="https://drive.google.com/open?id=0By1VjmcVY702SmhMckkxY2tYRnM"> <i class="fa fa-book"></i> <span class="hidden-sm-up"><spring:message code="user.manual" /></span></a></li>
			
		</ul>
		
		<ul class="navbar-nav mr-auto">
		</ul> 
		<sec:authorize access="hasRole('ROLE_ADMIN') or hasRole('ROLE_TASTER') or hasRole('ROLE_ORGANIZER')">
			<ul class="navbar-nav">
			<li class="nav-item ">
				<a class="nav-link "  href="#" > <i class="fa fa-user-circle-o"></i> <spring:message code="greeting-hello" /> ${loggedinuser.firstName}</a>
					</li>
			<li class="nav-item "> <a class="nav-link  btn btn-success" data-container="body" rel="tooltip" data-placement="bottom" title="<spring:message code="navbar.loggedin-user.edit" />"  role="button"  href="<spring:url value="/updateYourself"/>"> <i class="fa fa-edit"></i> <span class="hidden-sm-up"><spring:message code="navbar.loggedin-user.edit" /></span></a></li>
			<li class="nav-item "> <a onclick="document.getElementById('logoutForm').submit()" class="nav-link  btn btn-success" data-container="body" rel="tooltip" data-placement="left" title="<spring:message code="navbar.logout" />"  role="button" > <i class="fa fa-sign-out"></i> <span class="hidden-sm-up"><spring:message code="navbar.logout" /></span><span class="hidden-xs-down"><spring:message code="logout" /></span></a></li>
				
			</ul>
		</sec:authorize>
	</div>
</nav>
