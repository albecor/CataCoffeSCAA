<%@ page session="true"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../fragments/title.jsp" />
<jsp:include page="../fragments/css/bootstrap.jsp" />
<jsp:include page="../fragments/css/footer.jsp" />
<jsp:include page="../fragments/css/fontAwesome.jsp" />
<jsp:include page="../fragments/css/animate.jsp" />
<style>
.navbar-padding {
	padding-top: 65px;
}

.card-icon {
	height: 5rem;
	width: 100%;
	background-color: #5cb85c!important;
}

.card-icon-event {
	height: 5rem;
	width: 100%;
	background-color: powderblue;
}

.card-width-event {
	width: 15rem;
}

.card-width {
	width: 20rem;
}

.navbar-inverse .navbar-nav .nav-link {
	color: rgb(255, 255, 255);
}
</style>
</head>
<body>
	<jsp:include page="../navbar.jsp" />
	<div class="navbar-padding"></div>
	<div class="container-fluid">
		<div class="row justify-content-center ">

			<sec:authorize access="hasAuthority('CHANGE_PASSWORD_PRIVILEGE')">
				<div class="col col-auto py-2">
					<div class="card  h-100 card-width">
						<div class="card-icon d-flex justify-content-center">
							<i class=" align-self-center fa fa-key fa-3x "></i>
						</div>
						<div class="card-block d-flex flex-column ">
							<h4 class="card-title">
								<spring:message code="reset-password" />
							</h4>
							<div class="card-text">
								<div class="text-justify">
									<spring:message code="new-password-message" />
								</div>
								<hr />
								<spring:url value="/ch/savePassword" var="postActionUrl" />
								<form:form class="form-horizontal" method="post"
									modelAttribute="user" action="${postActionUrl}">
									<spring:bind path="username">
										<div class="form-group ${status.error ? 'has-danger' : ''}">
											<spring:message code="placeholder.id"
												var="placeholderNdivalue" />

											<form:input path="username" min="0" type="number"
												class="form-control form-control-feedback"
												placeholder="${placeholderNdivalue}" required="required" />
											<form:errors path="username" class="form-control-feedback" />

										</div>
									</spring:bind>

									<div class="form-group ${status.error ? 'has-danger' : ''}">


										<spring:message code="placeholder-new-password"
											var="placeholderPassword" />
										<form:input path="password" maxlength="100" type="password"
											class="form-control form-control-feedback"
											placeholder="${placeholderPassword}" required="required" />
										<form:errors path="password" class="form-control-feedback" />

									</div>
									<div class="form-group ${status.error ? 'has-danger' : ''}">


										<spring:message code="placeholder.confirmPassword"
											var="placeholderConfirmPassword" />
										<input id="confirmPassword" type="password"
											class="form-control form-control-feedback"
											placeholder="${placeholderConfirmPassword}"
											required="required" />

									</div>
									<button type="submit" class="btn btn-primary btn-block">
										<spring:message code="consult" />
									</button>
								</form:form>
							</div>
						</div>
					</div>
				</div>
			</sec:authorize>

		</div>


	</div>
	<jsp:include page="../fragments/footer.jsp" />
	<jsp:include page="../fragments/js/jquery.jsp" />
	<jsp:include page="../fragments/js/bootstrap.jsp" />
	<script>
		var password = document.getElementById("password"), confirm_password = document
				.getElementById("confirmPassword");

		function validatePassword() {
			if (password.value != confirm_password.value) {
				confirm_password
						.setCustomValidity('<spring:message code="form.password-match" />');
			} else {
				confirm_password.setCustomValidity('');
			}
		}
		password.onchange = validatePassword;
		confirm_password.onkeyup = validatePassword;
	</script>
	<c:if test="${not empty notifyMesage}">
		<jsp:include page="../fragments/js/notify.jsp">
			<jsp:param name="notifyMesage" value="${notifyMesage}" />
			<jsp:param name="notifyType" value="notifyType" />
		</jsp:include>
	</c:if>

</body>
</html>