<%@page import="java.time.LocalDateTime"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ page session="true"%>
<% request.setCharacterEncoding("utf-8"); %>
<html>
<head>
<jsp:include page="../fragments/title.jsp" />
<jsp:include page="../fragments/css/bootstrap.jsp" />
<jsp:include page="../fragments/css/footer.jsp" />
<jsp:include page="../fragments/css/fontAwesome.jsp" />
<jsp:include page="../fragments/css/datatable.jsp" />
	<jsp:include page="../fragments/css/animate.jsp" />
<style>
@media ( min-width : 768px) {
	dt {
		text-align: right;
	}
}
</style>
</head>
<body>
	<jsp:include page="../navbar.jsp" />
	<div class="container">
		<br />
		<div class="card">
			<div class="card-block">
				<div class="row">
					<div class="col-12  py-2 justify-content-center">
						<h5>Informacion personal
						</h5>
						<hr />
						<div class="row">
							<div class="col text-md-right">
								<strong><spring:message code="user.id" />: </strong>
							</div>
							<div class="col">${user.username}</div>
						</div>
						<div class="row">
							<div class="col text-md-right">
								<strong><spring:message code="user.name" />: </strong>
							</div>
							<div class="col">${user.firstName} ${user.lastName}</div>
						</div>
						<div class="row">
							<div class="col text-md-right">
								<strong><spring:message code="user.email" />: </strong>
							</div>
							<div class="col">${user.email}</div>
						</div>
						<div class="row">
							<div class="col text-md-right">
								<strong><spring:message code="user.age" />: </strong>
							</div>
							<div class="col">${age}
								<spring:message code="user.age.years" />
							</div>
						</div>
						<div class="row">
							<div class="col text-md-right">
								<strong><spring:message code="user.birthdate" />: </strong>
							</div>
							<div class="col">${user.birthdate}</div>
						</div>
					</div>
					
				</div>
				
			</div>
		</div>
		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<br />
			<div class="card">			
				<div class="card-block">
					<div class="row">
						<div class="col-12 col-md-4 py-1 text-center">
							<strong><spring:message code="question.do" /></strong>
						</div>
						<spring:url value="/ad/update-user/${user.username}" var="updateUserUrl" />
						<div class="col-12 col-md-4 py-1">
							<a href="${updateUserUrl}" class="btn btn-primary btn-block"><i class="fa fa-edit"></i> <spring:message code="user.update" /></a>
						</div>
						
						<spring:url value="/ad/delete-user-${user.username}" var="deleteUserUrl" />
						<div class="col-12 col-md-4 py-1">
							<a data-toggle="modal" data-href="${deleteUserUrl}" data-target="#myModalDeleteUser" href="#" class="btn btn-danger btn-block"><i class="fa fa-times"></i> <spring:message code="user.delete" /></a>
						</div>
					</div>
				</div>
			</div>
		</sec:authorize>	
		
		
	</div>

	<!-- /container -->
	<!-- call Modal -->
	<jsp:include page="../fragments/footer.jsp" />
	<jsp:include page="../fragments/js/jquery.jsp" />
	<jsp:include page="../fragments/js/bootstrap.jsp" />

	<script>
$('[data-toggle="popover"]').popover();   

$('.popover-dismiss').popover({
	  trigger: 'focus'
	})

</script>
	<jsp:include page="../fragments/js/datatable.jsp" />
	<%-- Modal for delete user button --%>
	<spring:message code="user.delete" var="titleModal" />
	<spring:message code="modal.body.user.delete" var="bodyModal" arguments="${user.firstName}" />
	<jsp:include page="../fragments/modal.jsp">
		<jsp:param name="idModal" value="myModalDeleteUser" />
		<jsp:param name="bodyModal" value="${bodyModal}" />
		<jsp:param name="titleModal" value="${titleModal}" />
	</jsp:include>
	<c:if test="${not empty notifyMesage}">
		<jsp:include page="../fragments/js/notify.jsp">
			<jsp:param name="notifyMesage" value="${notifyMesage}" />
			<jsp:param name="notifyType" value="${notifyType}" />
		</jsp:include>
	</c:if>
</body>
</html>