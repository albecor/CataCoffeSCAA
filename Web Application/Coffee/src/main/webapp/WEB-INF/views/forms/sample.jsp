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
<jsp:include page="../fragments/css/animate.jsp" />
<style>
.hidden {
	display: none;
}
</style>
</head>
<body>
	<jsp:include page="../navbar.jsp" />
	<br />
	<div class="container">
		<div class="card">
			<h5 class="card-header text-center">
				<c:choose>
					<c:when test="${empty sample.id}">
						<spring:url value="/or/new-sample" var="postActionUrl" />
						<spring:message code="form.sample.card-header.add-sample" />
					</c:when>
					<c:otherwise>
						<spring:url value="/or/update-sample" var="postActionUrl" />
						<spring:message code="form.sample.card-header.update-sample" />
					</c:otherwise>
				</c:choose>
			</h5>
			<div class="card-block">
				<div class="alert alert-warning" role="alert">
					<spring:message code="form.sample.alert-warning.add-sample" />
				</div>
				<hr />
				<form:form method="POST" modelAttribute="sample" class="form-horizontal" action="${postActionUrl}">
					<form:hidden path="id" value="${sample.id}" />
					<form:hidden path="score" value="${sample.score}" />
					<h5>
						<spring:message code="sample.information" />
					</h5>
					<hr />
					<spring:bind path="code">
						<div class="form-group row ${status.error ? 'has-danger' : ''}">
							<label class="col-sm-5 col-md-4 col-lg-3 col-form-label"> <spring:message code="form.sample.label.code" />
							</label>
							<div class="col-sm-7 col-md-8 col-lg-9">
								<spring:message code="form.sample.label.code" var="placeholder" />
								<form:input path="code" maxlength="45" value="${sample.code}" type="text" class="form-control form-control-feedback" placeholder="${placeholder}" required="required" />
								<form:errors path="code" class="form-control-feedback" />
							</div>
						</div>
					</spring:bind>
					<div class="form-group row ${status.error ? 'has-danger' : ''}">
						<label class="col-sm-5 col-md-4 col-lg-3 col-form-label"> <spring:message code="form.sample.label.height" /> (<spring:message code="msl" />)
						</label>
						<div class="col-sm-7 col-md-8 col-lg-9">
							<spring:message code="form.sample.label.height" var="placeholder" />
							<form:input path="height" type="number" min="0" max="99999"  class="form-control form-control-feedback" placeholder="${placeholder}" required="required" />
							<form:errors path="height" class="form-control-feedback" />
						</div>
					</div>
					<div class="form-group row ${status.error ? 'has-danger' : ''}">
						<label class="col-sm-5 col-md-4 col-lg-3 col-form-label"> <spring:message code="form.sample.label.variety" />
						</label>
						<div class="col-sm-7 col-md-8 col-lg-9">
							<spring:message code="form.sample.label.variety" var="placeholder" />
							<form:input path="variety" type="text" maxlength="45" class="form-control form-control-feedback" placeholder="${placeholder}" required="required" />
							<form:errors path="variety" class="form-control-feedback" />
						</div>
					</div>
					<hr />
					<h5>
						<spring:message code="physical-analysis" />
					</h5>
					<hr />
					<div class="form-group row ${status.error ? 'has-danger' : ''}">
						<label class="col-sm-5 col-md-4 col-lg-3 col-form-label"> <spring:message code="form.sample.label.humidity" />
						</label>
						<div class="col-sm-7 col-md-8 col-lg-9">
							<spring:message code="form.sample.label.humidity" var="placeholder" />
							<div class="input-group mb-2 mr-sm-2 mb-sm-0">
								<div class="input-group-addon">%</div>
								<form:input path="humidity" min="0" max="100" type="number" step="any" class="form-control" placeholder="${placeholder}" required="required" />
							</div>
							<form:errors path="humidity" class="form-control-feedback" />
						</div>
					</div>
					
					<div class="form-group row ${status.error ? 'has-danger' : ''}">
						<label class="col-sm-5 col-md-4 col-lg-3 col-form-label"> <spring:message code="almond" />
						</label>
						<div class="col-sm-7 col-md-8 col-lg-9">
							<div class="row">
								<div class="col col-12 col-lg-6 py-2">
									<spring:message code='form.sample.label.almondTotal' var="placeholder" />
									<div class="input-group mb-2 mr-sm-2 mb-sm-0">
										<div class="input-group-addon">
											<strong>Total (g)</strong>
										</div>
										<form:input path="almondTotal" min="0" max="500" type="number" step="any" class="form-control" placeholder="${placeholder}" required="required" />
									</div>
									<form:errors path="almondTotal" class="form-control-feedback" />
								</div>
								<div class="col col-12 col-lg-6 py-2">
									<spring:message code='form.sample.label.almondHealthy' var="placeholder" />
									<div class="input-group mb-2 mr-sm-2 mb-sm-0">
										<div class="input-group-addon">
											<strong><spring:message code='healthy'/> (g)</strong>
										</div>
										<form:input path="almondHealthy" min="0" max="500" type="number" step="any" class="form-control" placeholder="${placeholder}" required="required" />
									</div>
									<form:errors path="almondHealthy" class="form-control-feedback" />
								</div>
							</div>
						</div>
					</div>
					<div class="form-group row ${status.error ? 'has-danger' : ''}">
						<label class="col-sm-5 col-md-4 col-lg-3 col-form-label"> <spring:message code="pasilla" />
						</label>
						<div class="col-sm-7 col-md-8 col-lg-9">
							<div class="row">
								<div class="col col-12 col-lg-6 py-2">
									<spring:message code='form.sample.label.pasillaGrams' var="placeholder" />
									<div class="input-group mb-2 mr-sm-2 mb-sm-0">
										<div class="input-group-addon">
											<strong>g</strong>
										</div>
										<form:input path="pasillaGrams" min="0" max="500" type="number" step="any" class="form-control" placeholder="${placeholder}" required="required" />
									</div>
									<form:errors path="pasillaGrams" class="form-control-feedback" />
								</div>
								<div class="col col-12 col-lg-6 py-2">
									<spring:message code='form.sample.label.pasillaPercentage' var="placeholder" />
									<div class="input-group mb-2 mr-sm-2 mb-sm-0">
										<div class="input-group-addon">
											<strong>%</strong>
										</div>
										<form:input path="pasillaPercentage" min="0" max="100" type="number" step="any" class="form-control" placeholder="${placeholder}" required="required" />
									</div>
									<form:errors path="pasillaPercentage" class="form-control-feedback" />
								</div>
							</div>
						</div>
					</div>
					
					<div class="form-group row ${status.error ? 'has-danger' : ''}">
						<label class="col-sm-5 col-md-4 col-lg-3 col-form-label"> <spring:message code="broca" />
						</label>
						<div class="col-sm-7 col-md-8 col-lg-9">
							<div class="row">
								<div class="col col-12 col-lg-6 py-2">
									<spring:message code='form.sample.label.brocaGrams' var="placeholder" />
									<div class="input-group mb-2 mr-sm-2 mb-sm-0">
										<div class="input-group-addon">
											<strong>g</strong>
										</div>
										<form:input path="brocaGrams" min="0" max="500" type="number" step="any" class="form-control" placeholder="${placeholder}" required="required" />
									</div>
									<form:errors path="brocaGrams" class="form-control-feedback" />
								</div>
								<div class="col col-12 col-lg-6 py-2">
									<spring:message code='form.sample.label.brocaPercentage' var="placeholder" />
									<div class="input-group mb-2 mr-sm-2 mb-sm-0">
										<div class="input-group-addon">
											<strong>%</strong>
										</div>
										<form:input path="brocaPercentage" min="0" max="100" type="number" step="any" class="form-control" placeholder="${placeholder}" required="required" />
									</div>
									<form:errors path="brocaPercentage" class="form-control-feedback" />
								</div>
							</div>
						</div>
					</div>
					
				
					<div class="form-group row ${status.error ? 'has-danger' : ''}">
						<label class="col-sm-5 col-md-4 col-lg-3 col-form-label"> <spring:message code="form.sample.label.fr" />
						</label>
						<div class="col-sm-7 col-md-8 col-lg-9">
							<spring:message code="form.sample.label.fr" var="placeholder" />
							<div class="input-group mb-2 mr-sm-2 mb-sm-0">
						<div class="input-group-addon"><strong>Kg</strong></div>
						<form:input path="fr" min="0" max="200" type="number" step="any" class="form-control" placeholder="${placeholder}" required="required" />
							
					</div>
					
							<form:errors path="fr" class="form-control-feedback" />
						</div>
					</div>
					<div class="form-group row ${status.error ? 'has-danger' : ''}">
						<label class="col-sm-5 col-md-4 col-lg-3 col-form-label"> <spring:message code="form.sample.label.merma" />
						</label>
						<div class="col-sm-7 col-md-8 col-lg-9">
							<spring:message code="form.sample.placeholder.merma" var="placeholder" />
							<div class="input-group mb-2 mr-sm-2 mb-sm-0">
						<div class="input-group-addon"><strong>%</strong></div>
						<form:input path="merma" min="0" max="100" type="number" step="any" class="form-control" placeholder="${placeholder}" required="required" />
							
					</div>
							<form:errors path="merma" class="form-control-feedback" />
						</div>
					</div>
					<div class="form-group row ${status.error ? 'has-danger' : ''}">
						<label class="col-sm-5 col-md-4 col-lg-3 col-form-label"> <spring:message code="form.sample.label.notesPhysicalAnalysis" />
						</label>
						<div class="col-sm-7 col-md-8 col-lg-9">
							<spring:message code="form.sample.label.notesPhysicalAnalysis" var="placeholdernotesPhysicalAnalysis" />
							<form:textarea path="notesPhysicalAnalysis" rows="4" maxlength="500" type="text" class="form-control form-control-feedback" placeholder="${placeholdernotesPhysicalAnalysis}" />
							<form:errors path="notesPhysicalAnalysis" class="form-control-feedback" />
						</div>
					</div>
					<hr />
					<h5>
						<spring:message code="form.sample.label.grower" />
					</h5>
					<hr />
					<div class="form-group row ${status.error ? 'has-danger' : ''}">
						<label class="col-sm-5 col-md-4 col-lg-3 col-form-label"> <spring:message code="form.sample.label.grower" />
						</label>
						<div class="col-sm-7 col-md-8 col-lg-9">
							<spring:message code="form.sample.label.grower" var="placeholder" />
							<form:input path="grower" maxlength="45" type="text" class="form-control form-control-feedback" placeholder="${placeholder}" required="required" />
							<form:errors path="grower" class="form-control-feedback" />
						</div>
					</div>
					<div class="form-group row ${status.error ? 'has-danger' : ''}">
						<label class="col-sm-5 col-md-4 col-lg-3 col-form-label"> <spring:message code="form.sample.label.growerId" />
						</label>
						<div class="col-sm-7 col-md-8 col-lg-9">
							<spring:message code="form.sample.label.growerId" var="placeholder" />
							<form:input path="growerId" maxlength="45" type="text" class="form-control form-control-feedback" placeholder="${placeholder}"  />
							<form:errors path="growerId" class="form-control-feedback" />
						</div>
					</div>
					<div class="form-group row ${status.error ? 'has-danger' : ''}">
						<label class="col-sm-5 col-md-4 col-lg-3 col-form-label"> <spring:message code="form.sample.label.phone" />
						</label>
						<div class="col-sm-7 col-md-8 col-lg-9">
							<spring:message code="form.sample.placeholder.phone" var="placeholderPhone" />
							<form:input path="phone" maxlength="45" type="phone" class="form-control form-control-feedback" placeholder="${placeholderPhone}" />
							<form:errors path="phone" class="form-control-feedback" />
						</div>
					</div>
					<div class="form-group row ${status.error ? 'has-danger' : ''}">
						<label class="col-sm-5 col-md-4 col-lg-3 col-form-label"> <spring:message code="form.sample.label.location" />
						</label>
						<div class="col-sm-7 col-md-8 col-lg-9">
							<spring:message code="form.sample.placeholder.location" var="placeholderLocation" />
							<form:input path="location" maxlength="100" type="text" class="form-control form-control-feedback" placeholder="${placeholderLocation}" />
							<form:errors path="location" class="form-control-feedback" />
						</div>
					</div>
					<div class="form-group row ${status.error ? 'has-danger' : ''}">
						<label class="col-sm-5 col-md-4 col-lg-3 col-form-label"><spring:message code="form.sample.label.departament" /> </label>
						<div class="col-sm-7 col-md-8 col-lg-9">
						<spring:message code="form.sample.label.departament" var="placeholder" />
							<form:input path="departament" maxlength="100" type="text" class="form-control form-control-feedback" placeholder="${placeholder}" />
							<form:errors path="departament" class="form-control-feedback" />
						</div>
					</div>
					<div class="form-group row ${status.error ? 'has-danger' : ''}">
						<label class="col-sm-5 col-md-4 col-lg-3 col-form-label"> <spring:message code="form.sample.label.municipalityGrower" />
						</label>
						<div class="col-sm-7 col-md-8 col-lg-9">
						<spring:message code="form.sample.label.municipalityGrower" var="placeholder" />
							<form:input path="municipalityGrower" maxlength="100" type="text" class="form-control form-control-feedback" placeholder="${placeholder}" />
							<form:errors path="municipalityGrower" class="form-control-feedback" />
						</div>
					</div>
					<div class="form-group row ${status.error ? 'has-danger' : ''}">
						<label class="col-sm-5 col-md-4 col-lg-3 col-form-label"> <spring:message code="form.sample.label.veredaGrower" />
						</label>
						<div class="col-sm-7 col-md-8 col-lg-9">
						<spring:message code="form.sample.label.veredaGrower" var="placeholder" />
							<form:input path="veredaGrower" maxlength="100" type="text" class="form-control form-control-feedback" placeholder="${placeholder}" />
							<form:errors path="veredaGrower" class="form-control-feedback" />
						</div>
					</div>
					
					<button type="submit" class="btn btn-success btn-lg pull-right">
						<c:choose>
							<c:when test="${empty sample.id}">
								<spring:message code="form.user.button.value.add" />
							</c:when>
							<c:otherwise>
								<spring:message code="form.user.button.value.edit" />
							</c:otherwise>
						</c:choose>
					</button>
				</form:form>
			</div>
		</div>
	</div>
	<jsp:include page="../fragments/footer.jsp" />
	<jsp:include page="../fragments/js/jquery.jsp" />
	<jsp:include page="../fragments/js/bootstrap.jsp" />
</body>
</html>