<%@ page session="true"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../fragments/title.jsp" />
<jsp:include page="../fragments/css/bootstrap.jsp" />
<jsp:include page="../fragments/css/footer.jsp" />
<jsp:include page="../fragments/css/fontAwesome.jsp" />
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.15/css/dataTables.bootstrap4.min.css" />
</head>
<body>
	<sec:authorize access="hasRole('ROLE_ADMIN')">
		<c:choose>
			<c:when test="${empty catado.id}">
				<spring:url value="/new-catado" var="userActionUrl" />
			</c:when>
			<c:otherwise>
				<spring:url value="/edit-user" var="userActionUrl" />
			</c:otherwise>
		</c:choose>
	</sec:authorize>
	<jsp:include page="../navbar.jsp" />
	<jsp:include page="../fragments/language.jsp" />
	<div class="container">
		<div class="card">
			<h5 class="card-header text-center">
				<sec:authorize access="hasRole('ROLE_ADMIN')">
					<c:choose>
						<c:when test="${empty catado.id}">
							<spring:message code="form.sample.card-header.add-sample" />
						</c:when>
						<c:otherwise>
							Nuevo Evento
						</c:otherwise>
					</c:choose>
				</sec:authorize>
			</h5>
			<div class="card-block">
				<div class="alert alert-warning" role="alert">
					<spring:message code="form.sample.alert-warning.add-sample" />
				</div>
				<hr />
			
					
				<br />
					<hr />
					<div class="alert alert-warning" role="alert">
						<spring:message code="form.sample.alert-warning.add-tasters" />
					</div>
				

					<div class="text-center">
						<span class="lead "><spring:message code="form.sample.taster-list" /></span>
					</div>
					<table class="table table-hover table-sm" id="example">
						<thead>
							<tr>
								<th><spring:message code="user.id" /></th>
								<th><spring:message code="user.name" /></th>
								<th class="hidden-sm-down"><spring:message code="user.phone" /></th>
								<th class="text-center"><spring:message code="add" /></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${users}" var="user">
								<tr>
									<td>${user.username}</td>
									<td>${user.firstName}${user.lastName}</td>
									<td class="hidden-sm-down">${user.phone}</td>
									<td>

									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<hr />
			
				
			</div>
		</div>
	</div>
	<jsp:include page="../fragments/footer.jsp" />
	
	<script type="text/javascript" src="https://cdn.datatables.net/v/bs-3.3.7/dt-1.10.15/datatables.min.js"></script>
	<script type="text/javascript" src="https://cdn.datatables.net/1.10.15/js/dataTables.bootstrap4.min.js"></script>
	<script type="text/javascript">
	$(document).ready(function() {
	    $('#example').DataTable();
	} );
	</script>
	<spring:url value="/resources/js/validatePassword.js" var="validatePasswordJs" />
	<script src="${validatePasswordJs}"></script>
</body>
</html>