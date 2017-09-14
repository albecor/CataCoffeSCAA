<%@ page session="true"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<jsp:include page="../fragments/css/animate.jsp" />
</head>
<body>
	<sec:authorize access="hasRole('ROLE_TEMPORAL')">
		<spring:url value="/te/new-admin" var="userActionUrl" />
	</sec:authorize>
	<sec:authorize access="NOT hasRole('ROLE_TEMPORAL')">
		<c:choose>
			<c:when test="${empty user.id}">
				<sec:authorize access="hasRole('ROLE_ORGANIZER')">
					<spring:url value="/or/new-user" var="userActionUrl" />
				</sec:authorize>
				<sec:authorize access="hasRole('ROLE_ADMIN')">
					<spring:url value="/ad/new-user" var="userActionUrl" />
				</sec:authorize>
			</c:when>
			<c:otherwise>
				<c:choose>
					<c:when test="${loggedinuser.username != user.username}">
						<spring:url value="/ad/update-user" var="userActionUrl" />
					</c:when>
					<c:otherwise>
						<spring:url value="/updateYourself" var="userActionUrl" />
					</c:otherwise>
				</c:choose>
			</c:otherwise>
		</c:choose>
	</sec:authorize>
	<jsp:include page="../navbar.jsp" />
	<br />
	<div class="container">
		<div class="card">
			<h5 class="card-header text-center">
				<sec:authorize access="hasRole('ROLE_TEMPORAL')">
					<spring:message code="form.user.card-header.temporal" />
				</sec:authorize>
				<sec:authorize access="NOT hasRole('ROLE_TEMPORAL')">
					<c:choose>
						<c:when test="${empty user.id}">
							<spring:message code="form.user.card-header.add-user" />
						</c:when>
						<c:otherwise>
							<spring:message code="form.user.card-header.edit-user" />
						</c:otherwise>
					</c:choose>
				</sec:authorize>
			</h5>
			<div class="card-block">
				<div class="alert alert-warning" role="alert">
					<sec:authorize access="hasRole('ROLE_TEMPORAL')">
						<spring:message code="form.user.alert-warning.temporal" />
					</sec:authorize>
					<sec:authorize access="NOT hasRole('ROLE_TEMPORAL')">
						<spring:message code="form.user.alert-warning.admin" />
					</sec:authorize>
				</div>
				<hr />
				<form:form method="POST" modelAttribute="user" class="form-horizontal" action="${userActionUrl}">
					<form:hidden path="id" />
					<c:choose>
						<c:when test="${empty user.id}">
							<sec:authorize access="hasRole('ROLE_TEMPORAL')">
								<form:hidden path="roles" value="2" />
							</sec:authorize>
							<sec:authorize access="hasRole('ROLE_ORGANIZER') AND NOT hasRole('ROLE_ADMIN')">
								<form:hidden path="roles" value="1" />
							</sec:authorize>
						</c:when>
						<c:otherwise>
							<sec:authorize access="NOT hasAnyRole('ROLE_ADMIN','ROLE_TEMPORAL')"> ROLES COMO LOS TRAIGA
						<c:forEach items="${user.roles}" var="current" varStatus="status">
									<c:set var="rolesId" value="${status.first ? '' : rolesId}${current.id}${status.last ? '' : ','}" />
								</c:forEach>
								<form:hidden path="roles" value="${rolesId}" />
							</sec:authorize>
							<sec:authorize access="NOT hasRole('ROLE_TEMPORAL') AND NOT hasRole('ROLE_ADMIN') ">
								<c:if test="${not empty user.id}">
									<c:set var="disabledNdivalue" value="true" />
									<form:hidden path="username" />
								</c:if>
							</sec:authorize>
						</c:otherwise>
					</c:choose>
					<sec:authorize access="hasRole('ROLE_ADMIN')">
						<spring:bind path="roles">
							<div class="form-group row ${status.error ? 'has-danger' : ''}">
								<label class="col-sm-5 col-md-4 col-lg-3 col-form-label"><spring:message code="form.role_user" /></label>
								<div class="col-sm-7 col-md-8 col-lg-9">
									<select multiple class="form-control" id="roles" name="roles" required size="3" autofocus="${status.error ? 'autofocus' : ''}">
										<c:forEach items="${officialRoles}" var="role">
											<c:forEach items="${user.roles}" var="roleSelected">
												<c:if test="${role.id eq roleSelected.id}">
													<c:set var="roleSelect" value="true" />
												</c:if>
											</c:forEach>
											<option value="${role.id}" ${roleSelect eq true ? 'selected' : ''}>
												<spring:message code="${fn:toLowerCase(role.type)}" /></option>
											<c:set var="roleSelect" value="false" />
										</c:forEach>
									</select>
									<form:errors path="roles" class="form-control-feedback" />
								</div>
							</div>
						</spring:bind>
					</sec:authorize>
					<hr />
					<spring:bind path="username">
						<div class="form-group row ${status.error || disabledNdivalue ? 'has-danger' : ''}">
							<label class="col-sm-5 col-md-4 col-lg-3 col-form-label"><spring:message code="form.ndivalue" /></label>
							<div class="col-sm-7 col-md-8 col-lg-9">
								<spring:message code="form.placeholder.ndivalue" var="placeholderNdivalue" />
								<form:input path="username" value="${user.username}" min="0" type="number" class="form-control form-control-feedback" placeholder="${placeholderNdivalue}" required="required" autofocus="${status.error ? 'autofocus' : ''}" disabled="${disabledNdivalue ? 'true' : ''}" />
								<form:errors path="username" class="form-control-feedback" />
								<div class="form-control-feedback" ${disabledNdivalue ? '' : 'style="display: none;"'}>
									<spring:message code="notify.id.not-change" />
								</div>
							</div>
						</div>
					</spring:bind>
					<div class="form-group row ${status.error ? 'has-danger' : ''}">
						<label class="col-sm-5 col-md-4 col-lg-3 col-form-label"><spring:message code="form.firstName" /></label>
						<div class="col-sm-7 col-md-8 col-lg-9">
							<spring:message code="form.placeholder.firstName" var="placeholderfirstName" />
							<form:input path="firstName" maxlength="45"  type="text" class="form-control form-control-feedback" placeholder="${placeholderfirstName}" required="required" />
							<form:errors path="firstName" class="form-control-feedback" />
						</div>
					</div>
					<div class="form-group row ${status.error ? 'has-danger' : ''}">
						<label class="col-sm-5 col-md-4 col-lg-3 col-form-label"><spring:message code="form.lastName" /></label>
						<div class="col-sm-7 col-md-8 col-lg-9">
							<spring:message code="form.placeholder.lastName" var="placeholderLastName" />
							<form:input path="lastName"  maxlength="45" type="text" class="form-control form-control-feedback" placeholder="${placeholderLastName}" required="required" />
							<form:errors path="lastName" class="form-control-feedback" />
						</div>
					</div>
					<div class="form-group row ${status.error ? 'has-danger' : ''}">
						<label class="col-sm-5 col-md-4 col-lg-3 col-form-label"><spring:message code="form.birthdate" /></label>
						<spring:message code="form.placeholder.birthdate" var="placeholderBirthdate" />
						<spring:message code="title.birthdate" var="titleBirthdate" />
						<div class="col-sm-7 col-md-8 col-lg-9">
							<form:input path="birthdate" type="date" class="form-control form-control-feedback" placeholder="${placeholderBirthdate}" pattern="(0[1-9]|1[0-9]|2[0-9]|3[01])-(0[1-9]|1[012])-[0-9]{4}" title="${titleBirthdate}" required="required" autofocus="${status.error ? 'autofocus' : ''}" />
							<form:errors path="birthdate" class="form-control-feedback" />
						</div>
					</div>
					<div class="form-group row ${status.error ? 'has-danger' : ''}">
						<label class="col-sm-5 col-md-4 col-lg-3 col-form-label"><spring:message code="form.email" /></label>
						<div class="col-sm-7 col-md-8 col-lg-9">
							<spring:message code="form.placeholder.email" var="placeholderEmail" />
							<form:input path="email" type="email" class="form-control form-control-feedback" placeholder="${placeholderEmail}" required="required" autofocus="${status.error ? 'autofocus' : ''}" />
							<form:errors path="email" class="form-control-feedback" />
						</div>
					</div>
					<div class="form-group row ${status.error ? 'has-danger' : ''}">
						<label class="col-sm-5 col-md-4 col-lg-3 col-form-label"><spring:message code="form.tel" /></label>
						<div class="col-sm-7 col-md-8 col-lg-9">
							<spring:message code="form.placeholder.tel" var="placeholderTelmobile" />
							<form:input path="phone"  maxlength="45" type="phone" class="form-control form-control-feedback" placeholder="${placeholderTelmobile}" required="required" autofocus="${status.error ? 'autofocus' : ''}" />
							<form:errors path="phone" class="form-control-feedback" />
						</div>
					</div>
					<div class="form-group row ${status.error ? 'has-danger' : ''}">
						<label class="col-sm-5 col-md-4 col-lg-3 col-form-label"><spring:message code="form.password" /></label>
						<div class="col-sm-7 col-md-8 col-lg-9">
							<spring:message code="form.placeholder.password" var="placeholderPassword" />
							<form:input path="password"  maxlength="100" type="password" class="form-control form-control-feedback" placeholder="${placeholderPassword}" required="required" />
							<form:errors path="password" class="form-control-feedback" />
						</div>
					</div>
					<div class="form-group row ${status.error ? 'has-danger' : ''}">
						<label class="col-sm-5 col-md-4 col-lg-3 col-form-label"><spring:message code="form.confirmPassword" /></label>
						<div class="col-sm-7 col-md-8 col-lg-9">
							<spring:message code="form.placeholder.confirmPassword" var="placeholderConfirmPassword" />
							<input id="confirmPassword" type="password" class="form-control form-control-feedback" placeholder="${placeholderConfirmPassword}" required="required" />
						</div>
					</div>
					<div class="form-group row">
						<div class="col">
							<button type="submit" class="btn-lg btn-primary pull-right">
								<c:choose>
									<c:when test="${empty user.id}">
										<spring:message code="form.user.button.value.add" />
									</c:when>
									<c:otherwise>
										<spring:message code="form.user.button.value.edit" />
									</c:otherwise>
								</c:choose>
							</button>
						</div>
					</div>
				</form:form>
			</div>
		</div>
	</div>
	<jsp:include page="../fragments/footer.jsp" />
	<jsp:include page="../fragments/js/jquery.jsp" />
	<jsp:include page="../fragments/js/bootstrap.jsp" />
	
	
	<script>



	$( document ).ready(function() {
		

		
	    // opcion seleccionada con un click y se hace post
	$('option').mousedown(function(e) {
		    e.preventDefault();
		  
		    var nombre = $(this).parent().attr('id');
		   
		    var select = $( "#"+nombre )[ 0 ];
		  //  alert(select.attr('id'));
		    var scroll = select.scrollTop;
		  //  alert(select.scrollTop);
		   // $(this).prop('selected', $(this).prop('selected') ? false : true);
		   // alert(JSON.stringify(e.target));
		    e.target.selected = !e.target.selected;
		    setTimeout(function(){select.scrollTop = scroll;}, 0);
		  //  alert(scroll);
		    //$(select).focus();	

			return false;
		    
		}).mousemove(function(e){e.preventDefault()});

	})


	
	
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