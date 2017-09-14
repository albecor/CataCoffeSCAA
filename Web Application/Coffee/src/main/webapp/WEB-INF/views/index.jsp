<%@page import="java.util.HashSet"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="com.spring.coffee.model.Tests"%>
<%@page import="com.spring.coffee.model.Test"%>
<%@page import="java.util.Set"%>
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
.card-icon {
	height: 7rem;
	width: 100%;
	background-color: #241508;
	color: #C19D67;
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

.jumbotron { 
    background-color: #ffffff;

}
</style>
</head>
<body>
	<jsp:include page="navbar.jsp" />
	<br />
	<c:if test="${not empty panels}">
	
	<div class="container">
	
	<div class="row justify-content-center">
			<div class="col col-auto">
	<div class="dropdown card-width">
	
	  <button type="button" class="btn btn-success dropdown-toggle btn-block" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
   <strong>	<i class="fa fa-bell" aria-hidden="true"></i>  </strong> <spring:message code="notify.sample.to-taste" />!
  </button>


  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
  <c:forEach var="panel" items="${panels}">							
							<a href="<spring:url value="/ta/panel-test-${panel.id}"/>" class=" dropdown-item"> Panel ${panel.id} - <spring:message code="samples" />: 
							<c:set var="testsesList" value="${panel.testses}" />																	
							<%	
							
							Set<Tests> testses = (Set<Tests>) pageContext.getAttribute("testsesList");
							Set<String> codes = new HashSet();
							
							for (Tests tests : testses) {
								codes.add(tests.getSample().getCode());
							}
								
							%>	
									<c:forEach items="<%=codes%>" var="code" varStatus="loop">
												${code}
 										<c:if test="${!loop.last}">,</c:if>
</c:forEach>
							
							 </a>	
												
						</c:forEach>
    
  </div>
</div>
</div>
</div> 
	</div>
	<%--    
	<div class="container">
		<div class="row justify-content-center">
			<div class="col col-auto">
				<div class="card card-width card-inverse card-success">
					<div class="card-header">
					 <strong>	<i class="fa fa-bell" aria-hidden="true"></i>  </strong> <spring:message code="notify.sample.to-taste" />!
					</div>
					<div class="card-block">
						<c:forEach var="panel" items="${panels}">							
							<a href="<spring:url value="/ta/panel-test-${panel.id}"/>" class="btn btn-secondary"> Panel ${panel.id} </a>							
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div> --%> 
	</c:if>
	
	<div class="container-fluid">
		<div class="row justify-content-center ">
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<div class="col col-auto py-2">
					<div class="card  h-100 card-width">
						<div class="card-icon d-flex justify-content-center">
							<i class="align-self-center fa fa-users fa-3x "></i>
						</div>
						<div class="card-block d-flex flex-column ">
							<h4 class="card-title">
								<spring:message code="index.user.s" />
							</h4>
							<div class="card-text">
								<spring:message code="index.user.message" />
								<hr />
								<a href="<spring:url value="/ad/new-user"/>" class="btn btn-success btn-block"><i class="fa fa-plus fa-fw"></i> <spring:message code="index.user.new" /></a>
								<hr />
								<spring:url value="/ad/consult-user" var="postActionUrl" />
								<form:form class="form-horizontal" method="post" modelAttribute="user" action="${postActionUrl}">
									<spring:bind path="username">
										<div class="form-group  ${status.error ? 'has-danger' : ''}">
											<spring:message code="index.user.id" var="placeholderNdivalue" />
											<form:input path="username" value="${user.username}" type="number" class="form-control form-control-feedback" placeholder="${placeholderNdivalue}" required="required" autofocus="${status.error ? 'autofocus' : ''}" />
											<form:errors path="username" class="form-control-feedback" />
										</div>
									</spring:bind>
									<button type="submit" class="btn btn-success btn-block">
										<spring:message code="index.user.update-delete" />
									</button>
								</form:form>
							</div>
						</div>
					</div>
				</div>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_ORGANIZER') AND NOT hasRole('ROLE_ADMIN')">
				<div class="col col-auto py-2">
					<div class="card  h-100 card-width">
						<div class="card-icon d-flex justify-content-center">
							<i class="align-self-center fa fa-users fa-3x "></i>
						</div>
						<div class="card-block d-flex flex-column ">
							<h4 class="card-title">
								<spring:message code="add-taster" />
							</h4>
							<div class="card-text">
								<spring:message code="add-taster.message" />
								<hr />
								<a href="<spring:url value="/or/new-user"/>" class="btn btn-success btn-block"><spring:message code="add" /></a>
							</div>
						</div>
					</div>
				</div>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_ORGANIZER')">
				<div class="col col-auto py-2">
					<div class="card  h-100 card-width">
						<div class="card-icon d-flex justify-content-center">
							<i class="align-self-center fa fa-coffee fa-3x "></i>
						</div>
						<div class="card-block d-flex flex-column ">
							<h4 class="card-title">
								<spring:message code="index.organizer.panel" />
							</h4>
							<div class="card-text">
								<spring:message code="index.organizer.panel.message" />
								<hr />
								<a href="<spring:url value="/or/new-panel"/>" class="btn btn-success btn-block"><spring:message code="start" /></a>
							</div>
							<div class="card-text text-justify">
							<br />
								<spring:message code="index.organizer.panel.message.edit" />
								<hr />
								<a href="<spring:url value="/or/panels"/>" class="btn btn-success btn-block"><spring:message code="panel.authorize" /></a>
							</div>
						</div>
					</div>
				</div>
				<div class="col col-auto py-2">
					<div class="card  h-100 card-width">
						<div class="card-icon d-flex justify-content-center">
							<img src="<c:url value="/resources/images/coffee-bean.svg"/>" alt="Card image cap" class="img-fluid align-self-center" width="50px">
						</div>
						<div class="card-block d-flex flex-column ">
							<h4 class="card-title">
								<spring:message code="samples" />
							</h4>
							<div class="card-text">
								<spring:message code="consult-samples.message" />
								<hr />
								<a href="<spring:url value="/or/samples"/>" class="btn btn-success btn-block"><spring:message code="consult-samples" /></a>
								<hr />
								<a href="<spring:url value="or/new-sample"/>" class="btn btn-success btn-block"><i class="fa fa-plus fa-fw"></i><spring:message code="sample.add" /></a>
							</div>
						</div>
					</div>
				</div>
			</sec:authorize>
		</div>
	</div>
	
	<sec:authorize access="hasRole('ROLE_TASTER') AND NOT hasRole('ROLE_ORGANIZER') AND NOT hasRole('ROLE_ADMIN')">
	<br />
	<div class="container">
	<div class="jumbotron">
  <h1 class="display-4"><spring:message code="taster.index.welcome" /> </h1>
  <p class="lead"><spring:message code="taster.index.message2" /></p>
  <hr class="my-4"> 
  <spring:message code="taster.index.message3" />
  <spring:message code="taster.index.message4" />
  
  <p class="lead">
    <a class="btn btn-primary btn-sm" target="_blank" href="http://scaa.org/?page=resources&d=cupping-protocols" role="button"> <spring:message code="taster.index.message5" /></a>
  </p>
</div>
	</div>
	</sec:authorize>
	
	<div class="container-fluid">
		<sec:authorize access="hasRole('ROLE_TASTER')">
			<c:if test="${not empty events}">
				<div class="row justify-content-center py-3">
					<c:forEach items="${events}" var="event">
						<div class="col col-auto">
							<div class="card">
								<div class="card-header">
									<spring:message code="new-test" />
								</div>
								<div class="card-block">
									<h3 class="card-title">
										<spring:message code="test" />
										#. ${event.id.testId}
									</h3>
									<p class="card-text">Tienes una prueba por realizar para la muestra No. ${event.id.sampleId}</p>
									<a href="<spring:url value="/test-${event.id.testId}"/>" class="btn btn-success"><spring:message code="start" /></a>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</c:if>
		</sec:authorize>
		<br />
	</div>
	<jsp:include page="fragments/js/jquery.jsp" />
	<jsp:include page="fragments/js/bootstrap.jsp" />
	<c:if test="${not empty notifyMesage}">
		<jsp:include page="fragments/js/notify.jsp">
			<jsp:param name="notifyMesage" value="${notifyMesage}" />
			<jsp:param name="notifyType" value="notifyType" />
		</jsp:include>
	</c:if>
</body>
</html>