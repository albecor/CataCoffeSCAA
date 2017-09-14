<%@ page session="true"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="fragments/title.jsp" />
<jsp:include page="fragments/css/bootstrap.jsp" />
<jsp:include page="fragments/css/footer.jsp" />
<jsp:include page="fragments/css/fontAwesome.jsp" />
<jsp:include page="fragments/css/animate.jsp" />
<style>
.hidden {
    display: none;
}

.navbar-padding{
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
	<jsp:include page="navbar.jsp" />
	<div class="navbar-padding"></div>
	<div class="container-fluid">
		<div class="row justify-content-center ">
			
			<sec:authorize access="not hasRole('ROLE_PERSONAL')">
				<div class="col col-auto py-2">
					<div class="card  h-100 card-width">
						<div class="card-icon d-flex justify-content-center">
							<i class=" align-self-center fa fa-user fa-3x "></i>
						</div>
						<div class="card-block d-flex flex-column ">
							<h4 class="card-title">
								<spring:message code="reset-password" />
							</h4>
							<div class="card-text">
								<div class="text-justify"><spring:message code="reset-password-message" /></div>
								<hr />
								<div class="text-center"  id="loading_icon" style="display:none;"> <i class=" fa fa-refresh fa-spin fa-2x fa-fw"></i></div>
								<spring:url value="/re/resetPassword" var="postActionUrl" />
								<form:form id="yourFormId" class="form-horizontal" method="post" modelAttribute="user" action="${postActionUrl}">
										<spring:bind path="username">
									<div class="form-group ${status.error ? 'has-danger' : ''}">
										<spring:message code="placeholder.id" var="placeholderNdivalue" />
										
										<form:input path="username" type="number" class="form-control form-control-feedback" placeholder="${placeholderNdivalue}" required="required" />
										<form:errors path="username" class="form-control-feedback" />
									
									</div>
										</spring:bind>
									<button id="submitBtn" type="submit" class="btn btn-success btn-block">
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
	<jsp:include page="fragments/footer.jsp" />
	<jsp:include page="fragments/js/jquery.jsp" />
	<jsp:include page="fragments/js/bootstrap.jsp" />
	<c:if test="${not empty notifyMesage}">
		<jsp:include page="fragments/js/notify.jsp">
			<jsp:param name="notifyMesage" value="${notifyMesage}" />
			<jsp:param name="notifyType" value="notifyType" />
		</jsp:include>
	</c:if>
	<script>
	$(document).ready(function () {
	    $("#yourFormId").submit(function () {
	        $("#submitBtn").attr("disabled", true);
	        document.getElementById("loading_icon").style.display = "block";
	        return true;
	    });
	});
	</script>
	
</body>
</html>