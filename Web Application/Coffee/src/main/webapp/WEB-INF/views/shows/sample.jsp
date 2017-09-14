<%@ page session="true"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../fragments/title.jsp" />
<jsp:include page="../fragments/css/bootstrap.jsp" />
<jsp:include page="../fragments/css/footer.jsp" />
<jsp:include page="../fragments/css/fontAwesome.jsp" />
<jsp:include page="../fragments/css/animate.jsp" />
<jsp:include page="../fragments/js/jquery.jsp" />
<script src="<spring:url value="/resources/js/Chart.min.js"/>"></script>
<style>
.nopadding {
	padding: 0 !important;
	margin: 0 !important;
}

#chart {
	text-align: left;
	box-shadow: 0px 2px 8px rgba(0, 0, 0, .2);
	border: 1px solid #aaa;
	margin: 32px auto;
	background: white;
}

#radio-selector .btn.active, #radio-selector .btn:active {
	box-shadow: 0 0 0 3px black;
}
</style>
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
	<div class="container">
		<br />
		<div class="card">
			<div class="card-header">
				<h6>
					<strong><spring:message code="sample.information" /></strong>
				</h6>
			</div>
			<div class="card-block">
				<div class="row">
					<div class="col-12 col-md-6 py-1">
						<ul class="list-group">
							<li class="list-group-item justify-content-between"><spring:message code="number-sample" />: <span>${sample.id}</span></li>
							<li class="list-group-item justify-content-between"><spring:message code="code" />: <span> ${sample.code}</span></li>
						</ul>
					</div>
					<div class="col-12 col-md-6 py-1">
						<ul class="list-group">
							<li class="list-group-item justify-content-between"><spring:message code="height" /> : <span> <fmt:formatNumber value="${sample.height}" /> ( <spring:message code="msl" /> )
							</span></li>
							<li class="list-group-item justify-content-between"><spring:message code="form.sample.label.variety" />: <span> ${sample.variety}</span></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<br />
		<div class="card">
			<div class="card-header">
				<h6>
					<strong><spring:message code="form.sample.label.grower" /></strong>
				</h6>
			</div>
			<div class="card-block ">
				<div class="row">
					<div class="col nopadding">
						<ul class="list-group">
							<li class="list-group-item justify-content-between "><spring:message code="form.user.label.firstName" /> : <span>${sample.grower}</span></li>
						</ul>
					</div>
				</div>
				<div class="row">
					<div class="col col-12 col-md-6 py-1 nopadding">
						<ul class="list-group">
							<li class="list-group-item justify-content-between"><spring:message code="growerId" />: <span>${sample.growerId}</span></li>
							<li class="list-group-item justify-content-between"><spring:message code="form.sample.label.phone" />: <span> ${sample.phone}</span></li>
							<li class="list-group-item justify-content-between"><spring:message code="form.sample.label.location" /> : <span> ${sample.location}</span></li>
						</ul>
					</div>
					<div class="col col-12 col-md-6 py-1 nopadding">
						<ul class="list-group">
							<li class="list-group-item justify-content-between"><spring:message code="form.sample.label.departament" />: <span> ${sample.departament}</span></li>
							<li class="list-group-item justify-content-between"><spring:message code="form.sample.label.municipalityGrower" />: <span> ${sample.municipalityGrower}</span></li>
							<li class="list-group-item justify-content-between"><spring:message code="form.sample.label.veredaGrower" />: <span> ${sample.veredaGrower}</span></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<br />
		<div class="card">
			<div class="card-header">
				<h6>
					<strong><spring:message code="physical-analysis" /></strong>
				</h6>
			</div>
			<div class="card-block ">
				<div class="row d-flex flex-row">
					<div class="col col-12 col-md-6 py-1  h-100 d-flex flex-column">
						<ul class="list-group">
							<li class="list-group-item justify-content-between"><spring:message code='form.sample.label.almondTotal' /> : <span> ${sample.almondTotal} %</span></li>
							<li class="list-group-item justify-content-between"><spring:message code='form.sample.label.almondHealthy' /> : <span> ${sample.almondHealthy} %</span></li>
							<li class="list-group-item justify-content-between"><spring:message code="form.sample.label.broca" /> (g) : <span>${sample.brocaGrams} g</span></li>
							<li class="list-group-item justify-content-between"><spring:message code="form.sample.label.broca" /> (%) : <span>${sample.brocaPercentage} %</span></li>
							<li class="list-group-item justify-content-between"><spring:message code="form.sample.label.pasilla" /> (g) : <span> ${sample.pasillaGrams} g</span></li>
							<li class="list-group-item justify-content-between"><spring:message code="form.sample.label.pasilla" /> (%) : <span> ${sample.pasillaPercentage} %</span></li>
						</ul>
					</div>
					<div class="col col-12 col-md-6 py-1  h-100 d-flex flex-column">
						<ul class="list-group">
							<li class="list-group-item justify-content-between"><spring:message code="form.sample.label.fr" /> : <span> ${sample.fr} Kg</span></li>
							<li class="list-group-item justify-content-between"><spring:message code="form.sample.label.humidity" /> : <span> ${sample.humidity} %</span></li>
							<li class="list-group-item justify-content-between"><spring:message code="form.sample.label.merma" /> : <span> ${sample.merma} %</span></li>
							<li class="list-group-item ">
								<div class="d-flex flex-column">
									<div class="p-2">
										<spring:message code="form.sample.label.notesPhysicalAnalysis" />
										:
									</div>
									<div class="p-2">${sample.merma}%</div>
								</div>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<br />
		<div class="card">
			<div class="card-header">
				<strong> <spring:message code="sensory-analysis" /></strong>
			</div>
			<div class="card-block">
			
			<c:choose>
					<c:when test="${sample.test.finished == 1}">
						
						<div class="row justify-content-center d-flex flex-row py-2">
					<div class="col-12 col-md-6 d-flex flex-column">
						<div class="card h-100 w-100">
							<div class="card-header">
								<strong> <spring:message code="results" /></strong>
							</div>
							<div class="card-block ">
								<table class="table table-sm ">
									<thead>
										<tr>
											<th>#</th>
											<th><spring:message code="attributes" /></th>
											<th><spring:message code="score" /></th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<th scope="row">1</th>
											<td><spring:message code="fragrance" /></td>
											<td>+ <fmt:formatNumber value="${sample.test.fragrance}" />/2
											</td>
										</tr>
										<tr>
											<th scope="row">2</th>
											<td><spring:message code="aroma" /></td>
											<td>+ <fmt:formatNumber value="${sample.test.aroma}" />/2
											</td>
										</tr>
										<tr>
											<th scope="row">3</th>
											<td><spring:message code="flavor" /></td>
											<td>+ <fmt:formatNumber value="${sample.test.flavor}" /></td>
										</tr>
										<tr>
											<th scope="row">4</th>
											<td><spring:message code="residualFlavor" /></td>
											<td>+ <fmt:formatNumber value="${sample.test.residualFlavor}" /></td>
										</tr>
										<tr>
											<th scope="row">5</th>
											<td><spring:message code="acidity" /></td>
											<td>+ <fmt:formatNumber value="${sample.test.acidity}" /></td>
										</tr>
										<tr>
											<th scope="row">6</th>
											<td><spring:message code="body" /></td>
											<td>+ <fmt:formatNumber value="${sample.test.body}" /></td>
										</tr>
										<tr>
											<th scope="row">7</th>
											<td><spring:message code="uniformity" /></td>
											<td>+ <fmt:formatNumber value="${sample.test.uniformity}" /></td>
										</tr>
										<tr>
											<th scope="row">8</th>
											<td><spring:message code="balance" /></td>
											<td>+ <fmt:formatNumber value="${sample.test.balance}" /></td>
										</tr>
										<tr>
											<th scope="row">9</th>
											<td><spring:message code="cleanCup" /></td>
											<td>+ <fmt:formatNumber value="${sample.test.cleanCup}" /></td>
										</tr>
										<tr>
											<th scope="row">10</th>
											<td><spring:message code="sweetness" /></td>
											<td>+ <fmt:formatNumber value="${sample.test.sweetness}" /></td>
										</tr>
										<tr>
											<th scope="row">11</th>
											<td><spring:message code="defect" /></td>
											<td>- <fmt:formatNumber value="${sample.test.defect}" /></td>
										</tr>
										<tr>
											<th scope="row">12</th>
											<td><spring:message code="tasterScore" /></td>
											<td>+ <fmt:formatNumber value="${sample.test.tasterScore}" /></td>
										</tr>
										<tr>
											<th scope="row">#</th>
											<td><strong><spring:message code="totalScore" /></strong></td>
											<td><strong><fmt:formatNumber value="${sample.test.totalScore}" /></strong></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div class="col-12 col-md-6 d-flex flex-column">
						<div class="card h-100 w-100">
							<div class="card-header">
								<strong> <spring:message code="sensory-lexicon" /></strong>
							</div>
							<div class="card-block">
								<strong><spring:message code="attributes" />:</strong>
								<hr />
								<ul>
									<c:forEach items="${sample.test.attributes}" var="attribute">
										<c:if test="${attribute.type == 'a'}">
											<li><spring:message code="${attribute.name}" /></li>
										</c:if>
									</c:forEach>
								</ul>
							</div>
							<div class="card-block">
								<strong><spring:message code="defect" />:</strong>
								<hr />
								<ul>
									<c:forEach items="${sample.test.attributes}" var="attribute">
										<c:if test="${attribute.type == 'd'}">
											<li><spring:message code="${attribute.name}" /></li>
										</c:if>
									</c:forEach>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col">
						<div class="card">
							<div class="card-header">
								<strong><spring:message code="general-observations" /></strong>
							</div>
							<div class="card-block" id="hidden-test-notes">
								<strong><spring:message code="fragrance" />/<spring:message code="aroma" /></strong>
								: ${sample.test.fragranceNotes} <br />
								<strong><spring:message code="flavor" /></strong>
								: ${sample.test.flavorNotes} <br />
								<strong><spring:message code="acidity" /></strong>
								: ${sample.test.acidityNotes} <br />
								<strong><spring:message code="body" /></strong>
								: ${sample.test.bodyNotes} <br />
								<strong><spring:message code="observations" /></strong>
								: ${sample.test.notes} <br />
								
								<button id="test-edit" type="button" class="btn btn-success pull-right">							
								<spring:message code="edit" />						
					</button>
							</div>
							
							
					
							<div class="card-block" id="hidden-form-test-notes">
								<spring:url value="/or/update-test-notes" var="testUrlAction" />
								<form:form method="POST" modelAttribute="test" class="form-horizontal" action="${testUrlAction}">
									<form:hidden path="id" value="${test.id}" />
									<div class="form-group row ${status.error ? 'has-danger' : ''}">
						<label class="col-sm-5 col-md-4 col-lg-3 col-form-label"> <spring:message code="fragrance" />/<spring:message code="aroma" />
						</label>
						<div class="col-sm-7 col-md-8 col-lg-9">
							
							<form:textarea path="fragranceNotes" rows="1" maxlength="500" type="text" class="form-control form-control-feedback"  required="required"/>
							<form:errors path="fragranceNotes" class="form-control-feedback" />
						</div>
					</div>
					<div class="form-group row ${status.error ? 'has-danger' : ''}">
						<label class="col-sm-5 col-md-4 col-lg-3 col-form-label"> <spring:message code="flavor" />
						</label>
						<div class="col-sm-7 col-md-8 col-lg-9">
							
							<form:textarea path="flavorNotes" rows="1" maxlength="500" type="text" class="form-control form-control-feedback"  required="required"/>
							<form:errors path="flavorNotes" class="form-control-feedback" />
						</div>
					</div>
					<div class="form-group row ${status.error ? 'has-danger' : ''}">
						<label class="col-sm-5 col-md-4 col-lg-3 col-form-label"> <spring:message code="acidity" />
						</label>
						<div class="col-sm-7 col-md-8 col-lg-9">
							
							<form:textarea path="acidityNotes" rows="1" maxlength="500" type="text" class="form-control form-control-feedback"  required="required"/>
							<form:errors path="acidityNotes" class="form-control-feedback" />
						</div>
					</div>
					<div class="form-group row ${status.error ? 'has-danger' : ''}">
						<label class="col-sm-5 col-md-4 col-lg-3 col-form-label"> <spring:message code="body" /> 
						</label>
						<div class="col-sm-7 col-md-8 col-lg-9">
							
							<form:textarea path="bodyNotes" rows="1" maxlength="500" type="text" class="form-control form-control-feedback"  required="required"/>
							<form:errors path="bodyNotes" class="form-control-feedback" />
						</div>
					</div>
					<div class="form-group row ${status.error ? 'has-danger' : ''}">
						<label class="col-sm-5 col-md-4 col-lg-3 col-form-label"> <spring:message code="observations" /> 
						</label>
						<div class="col-sm-7 col-md-8 col-lg-9">
							
							<form:textarea path="notes" rows="2" maxlength="500" type="text" class="form-control form-control-feedback"  required="required"/>
							<form:errors path="notes" class="form-control-feedback" />
						</div>
					</div>
					<button id="form-test-cancel" type="button" class="btn btn-danger pull-left">							
								<spring:message code="cancel" />						
					</button>
					<button type="submit" class="btn btn-success pull-right">							
								<spring:message code="form.user.button.value.add" />						
					</button>
								</form:form>
							</div>
						</div>
						<br />
						<div class="card">
									<div class="card-header">
										<spring:message code="radar-chart" />
									</div>
									<div class="card-block">
										<div class="card-text">
											<spring:message code="radar-chart.notes" />
										</div>
										<i class="fa fa-hand-o-down" aria-hidden="true"></i>
										<div class="row">
											<div class="col">
												<table class="table table-responsive text-center">
													<tbody>
														<tr>
															<td class="text-center"><canvas id="marksChartSample${sample.test.id}" width="700" height="500"></canvas></td>
														</tr>
													</tbody>
												</table>
											</div>
										</div>
									</div>
								</div>
								<jsp:include page="../fragments/js/chartRadarMultiple.jsp">
									<jsp:param name="id" value="marksChartSample${sample.test.id}" />
								</jsp:include>
					</div>
				</div>
						
					</c:when>
					<c:otherwise>
						<strong><spring:message code="sample.test-not-finished" /></strong>
					</c:otherwise>
				</c:choose>
				
				
				
			</div>
		</div>
	
		<br />
		<c:if test="${not empty sample.testses}">
			<div class="alert alert-info" role="alert">
				<i class="fa fa-long-arrow-down fa-fw" aria-hidden="true"></i>
				<spring:message code="test.alert.pulse" />
			</div>
		</c:if>
		<div id="accordion" role="tablist" aria-multiselectable="true">
			<c:forEach items="${sample.testses}" var="testses">
				<div class="card">
					<div class="card-header" role="tab" id="heading-${testses.user.username}">
						<a class="btn btn-outline-${testses.test.disableScore == 0 ? 'primary' : 'danger'} btn-block text-left" data-toggle="collapse" data-parent="#accordion" href="#collapse-${testses.user.username}" aria-expanded="true" aria-controls="collapse-${testses.user.username}"> <spring:message
								code="view-test" />: ${testses.user.firstName} ${testses.user.lastName} . <i class="fa fa-chevron-down pull-right" aria-hidden="true"></i>
						</a>
					</div>
					<div id="collapse-${testses.user.username}" class="collapse" role="tabpanel" aria-labelledby="heading-${testses.user.username}">
						<c:if test="${sample.test.finished == 1 && fn:length(sample.testses) gt 1}">
							<div class="card-block">
								<div class="alert alert-success" role="alert">
									<strong><spring:message code="question-average" /></strong>
									<div class="btn-group" id="radio-selector" data-toggle="buttons">
										<label class="btn btn-success ${testses.test.disableScore == 0 ? 'active' : ''}"> <input class="conditional-post" type="radio" name="toogle-${testses.user.id}" id="yes-${testses.user.id}" data-sample="${testses.sample.id}" data-test="${testses.test.id}" value="false"
											autocomplete="off"> <spring:message code="yes" />
										</label> <label class="btn btn-warning ${testses.test.disableScore == 1 ? 'active' : ''}"> <input class="conditional-post" type="radio" name="toogle-${testses.user.id}" id="yes-${testses.user.id}" data-sample="${testses.sample.id}" data-test="${testses.test.id}" value="true"
											autocomplete="off"> <spring:message code="no" /></label>
									</div>
								</div>
							</div>
						</c:if>
						<div class="card-block">
							<c:choose>
								<c:when test="${testses.test.finished == 1}">
									<div class="row justify-content-center d-flex flex-row py-2">
										<div class="col-12 col-md-6 d-flex flex-column">
											<div class="card h-100 w-100">
												<div class="card-block ">
													<table class="table table-sm">
														<thead>
															<tr>
																<th>#</th>
																<th><spring:message code="attributes" /></th>
																<th><spring:message code="score" /></th>
															</tr>
														</thead>
														<tbody>
															<tr>
																<th scope="row">1</th>
																<td><spring:message code="fragrance" /></td>
																<td>+ <fmt:formatNumber value="${testses.test.fragrance}" />/2
																</td>
															</tr>
															<tr>
																<th scope="row">2</th>
																<td><spring:message code="aroma" /></td>
																<td>+ <fmt:formatNumber value="${testses.test.aroma}" />/2
																</td>
															</tr>
															<tr>
																<th scope="row">3</th>
																<td><spring:message code="flavor" /></td>
																<td>+ <fmt:formatNumber value="${testses.test.flavor}" /></td>
															</tr>
															<tr>
																<th scope="row">4</th>
																<td><spring:message code="residualFlavor" /></td>
																<td>+ <fmt:formatNumber value="${testses.test.residualFlavor}" /></td>
															</tr>
															<tr>
																<th scope="row">5</th>
																<td><spring:message code="acidity" /></td>
																<td>+ <fmt:formatNumber value="${testses.test.acidity}" /></td>
															</tr>
															<tr>
																<th scope="row">6</th>
																<td><spring:message code="body" /></td>
																<td>+ <fmt:formatNumber value="${testses.test.body}" /></td>
															</tr>
															<tr>
																<th scope="row">7</th>
																<td><spring:message code="uniformity" /></td>
																<td>+ <fmt:formatNumber value="${testses.test.uniformity}" /></td>
															</tr>
															<tr>
																<th scope="row">8</th>
																<td><spring:message code="balance" /></td>
																<td>+ <fmt:formatNumber value="${testses.test.balance}" /></td>
															</tr>
															<tr>
																<th scope="row">9</th>
																<td><spring:message code="cleanCup" /></td>
																<td>+ <fmt:formatNumber value="${testses.test.cleanCup}" /></td>
															</tr>
															<tr>
																<th scope="row">10</th>
																<td><spring:message code="sweetness" /></td>
																<td>+ <fmt:formatNumber value="${testses.test.sweetness}" /></td>
															</tr>
															<tr>
																<th scope="row">11</th>
																<td><spring:message code="defect" /></td>
																<td>- <fmt:formatNumber value="${testses.test.defect}" /></td>
															</tr>
															<tr>
																<th scope="row">12</th>
																<td><spring:message code="tasterScore" /></td>
																<td>+ <fmt:formatNumber value="${testses.test.tasterScore}" /></td>
															</tr>
															<tr>
																<th scope="row">#</th>
																<td><strong><spring:message code="totalScore" /></strong></td>
																<td><strong><fmt:formatNumber value="${testses.test.totalScore}" /></strong></td>
															</tr>
														</tbody>
													</table>
												</div>
											</div>
										</div>
										<div class="col-12 col-md-6 d-flex flex-column">
											<div class="card h-100 w-100">
												<div class="card-block">
													<strong><spring:message code="cups" />:</strong> &nbsp;&nbsp; ${testses.test.cups}
													<hr />
													<strong><spring:message code="notes" />:</strong>
													<p>${testses.test.notes}</p>
													<ul>
														<c:if test="${testses.test.fragranceNotes != ''}">
															<li><spring:message code="fragrance" />:&nbsp;${testses.test.fragranceNotes}</li>
														</c:if>
														<c:if test="${testses.test.aromaNotes != ''}">
															<li><spring:message code="aroma" />:&nbsp;${testses.test.aromaNotes}</li>
														</c:if>
														<c:if test="${testses.test.flavorNotes != ''}">
															<li><spring:message code="flavor" />:&nbsp;${testses.test.flavorNotes}</li>
														</c:if>
														<c:if test="${testses.test.residualFlavorNotes != ''}">
															<li><spring:message code="residualFlavor" />:&nbsp;${testses.test.residualFlavorNotes}</li>
														</c:if>
														<c:if test="${testses.test.acidityNotes != ''}">
															<li><spring:message code="acidity" />:&nbsp;${testses.test.acidityNotes}</li>
														</c:if>
														<c:if test="${testses.test.bodyNotes != ''}">
															<li><spring:message code="body" />:&nbsp;${testses.test.bodyNotes}</li>
														</c:if>
														<c:if test="${testses.test.uniformityNotes != ''}">
															<li><spring:message code="uniformity" />:&nbsp;${testses.test.uniformityNotes}</li>
														</c:if>
														<c:if test="${testses.test.balanceNotes != ''}">
															<li><spring:message code="balance" />:&nbsp;${testses.test.balanceNotes}</li>
														</c:if>
														<c:if test="${testses.test.cleanCupNotes != ''}">
															<li><spring:message code="cleanCup" />:&nbsp;${testses.test.cleanCupNotes}</li>
														</c:if>
														<c:if test="${testses.test.sweetnessNotes != ''}">
															<li><spring:message code="sweetness" />:&nbsp;${testses.test.sweetnessNotes}</li>
														</c:if>
														<c:if test="${testses.test.defectNotes != ''}">
															<li><spring:message code="defect" />:&nbsp;${testses.test.defectNotes}</li>
														</c:if>
													</ul>
												</div>
												<div class="card-block">
													<strong><spring:message code="attributes" />:</strong>
													<hr />
													<ul>
														<c:forEach items="${testses.test.attributes}" var="attribute">
															<c:if test="${attribute.type == 'a'}">
																<li><spring:message code="${attribute.name}" /></li>
															</c:if>
														</c:forEach>
													</ul>
												</div>
												<div class="card-block">
													<strong><spring:message code="defect" />:</strong> 
													<hr />
													<ul>
														<c:forEach items="${testses.test.attributes}" var="attribute">
															<c:if test="${attribute.type == 'd'}">
																<li><spring:message code="${attribute.name}" /></li>
															</c:if>
														</c:forEach>
													</ul>
												</div>
											</div>
										</div>
									</div>
									<div class="row  py-2">
										<div class="col-12">
											<div class="card h-100 w-100">
												<div class="card-block">
													<p>
														<spring:message code="cups-order" />
													</p>
													<hr />
													<div class="d-flex flex-wrap justify-content-between">
														<div class="p-2">
															<p>
																<spring:message code="uniformity" />
																:
															</p>
															<c:forEach var="i" begin="1" end="${fn:length(testses.test.uniformityOrder)}" step="1">
																<span class="badge badge-${fn:substring(testses.test.uniformityOrder, i-1, i) =='1' ? 'success' : 'danger'}"><i class="fa fa-coffee fa-2x "></i> ${i}</span>
															</c:forEach>
															<hr />
														</div>														
														<div class="p-2">
															<p>
																<spring:message code="cleanCup" />
																:
															</p>
															<c:forEach var="i" begin="1" end="${fn:length(testses.test.cleanCupOrder)}" step="1">
																<span class="badge badge-${fn:substring(testses.test.cleanCupOrder, i-1, i) =='1' ? 'success' : 'danger'}"><i class="fa fa-coffee fa-2x "></i> ${i}</span>
															</c:forEach>
															<hr />
														</div>
														<div class="p-2">
															<p>
																<spring:message code="sweetness" />
																:
															</p>
															<c:forEach var="i" begin="1" end="${fn:length(testses.test.sweetnessOrder)}" step="1">
																<span class="badge badge-${fn:substring(testses.test.sweetnessOrder, i-1, i) =='1' ? 'success' : 'danger'}"><i class="fa fa-coffee fa-2x "></i> ${i}</span>
															</c:forEach>
															<hr />
														</div>
														<div class="p-2">
															<p>
																<spring:message code="defect" />
																:
															</p>
															<c:forEach var="i" begin="1" end="${fn:length(testses.test.defectOrder)}" step="1">
																<c:choose>
																	<c:when test="${fn:substring(testses.test.defectOrder, i-1, i) == '2'}">
																		<c:set var="defectCups" value="warning" />
																	</c:when>
																	<c:when test="${fn:substring(testses.test.defectOrder, i-1, i) == '4'}">
																		<c:set var="defectCups" value="danger" />
																	</c:when>
																	<c:otherwise>
																		<c:set var="defectCups" value="success" />
																	</c:otherwise>
																</c:choose>
																<span class="badge badge-${defectCups}"><i class="fa fa-coffee fa-2x "></i> ${i}</span>
															</c:forEach>
															<hr />
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="row d-flex flex-row">
										<div class="col-12">
											<div class="card">
												<div class="card-block">
													<table class="table table-responsive">
														<tbody>
															<tr>
																<td><canvas id="marksChart${testses.test.id}" width="600" height="400"></canvas></td>
															</tr>
														</tbody>
													</table>
												</div>
											</div>
										</div>
										<jsp:include page="../fragments/js/chartRadar.jsp">
											<jsp:param name="taster" value="${testses.user.firstName} ${testses.user.lastName}" />
											<jsp:param name="id" value="marksChart${testses.test.id}" />
											<jsp:param name="fragrance" value="${testses.test.fragrance}" />
											<jsp:param name="aroma" value="${testses.test.aroma}" />
											<jsp:param name="flavor" value="${testses.test.flavor}" />
											<jsp:param name="residualFlavor" value="${testses.test.residualFlavor}" />
											<jsp:param name="balance" value="${testses.test.balance}" />
											<jsp:param name="acidity" value="${testses.test.acidity}" />
											<jsp:param name="body" value="${testses.test.body}" />
											<jsp:param name="tasterScore" value="${testses.test.tasterScore}" />
										</jsp:include>
									</div>
								</c:when>
								<c:otherwise>
									<strong><spring:message code="sample.test-not-finished" /></strong>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	<input id="urlservename" type="hidden" value="http://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/" name="urlservename">
	<jsp:include page="../fragments/footer.jsp" />
	<jsp:include page="../fragments/js/bootstrap.jsp" />
	<c:if test="${not empty notifyMesage}">
		<jsp:include page="../fragments/js/notify.jsp">
			<jsp:param name="notifyMesage" value="${notifyMesage}" />
			<jsp:param name="notifyType" value="notifyType" />
		</jsp:include>
	</c:if>
	<script type="text/javascript">
		$(document).ready(
				function() {

					$('#hidden-form-test-notes').hide(); 

					$('#test-edit').click(function(e){
						e.preventDefault();		
						$('#hidden-form-test-notes').show(); 
						$('#hidden-test-notes').hide(); 			

					});

					$('#form-test-cancel').click(function(e){
						e.preventDefault();		
						$('#hidden-form-test-notes').hide(); 
						$('#hidden-test-notes').show(); 			

					});
					

					// input seleccionado y se hace post
					$('input.conditional-post:radio').change(
							function(e) {
								e.preventDefault();

								var name = $(this).attr('name'), option = $(
										this).val();
								var sample = $(this).data('sample');
								var test = $(this).data('test');

								/*if(ajaxPost(formData)){
									window.location.href = $('#urlservename').val() + 'ta/panel-test-'+ $('#panel_id').val();
								}else{
									alert('castatrofe mi señor');
								}
								
								 */
								setTimeout(function() {

									window.location.href = $('#urlservename')
											.val()
											+ 'or/disable-test-'
											+ test
											+ '-'
											+ sample + '-' + option;
								}, 1000);

							});

				});
	</script>
</body>
</html>
<%--



		<div class="row py-3">
				
			<div class="col-sm-12  p-2 h-100">
				
				
				
			
					
						<ul class="list-group">
							<li class="list-group-item justify-content-between active"> <strong><spring:message code="sample" /></strong></li>
							<li class="list-group-item justify-content-between"><spring:message code="number-sample" />: <span>${sample.id}</span></li>
							<li class="list-group-item justify-content-between"><spring:message code="code" />: <span> ${sample.code}</span></li>
							<li class="list-group-item justify-content-between"><spring:message code="height" /> : <span> <fmt:formatNumber value="${sample.height}" /> ( <spring:message code="msl" /> )</span></li>
							<li class="list-group-item justify-content-between"><spring:message code="form.sample.label.variety" />: <span> ${sample.variety}</span></li>							
						</ul>					
			
			</div>
			</div>
			
			
			<div class="col-sm-12 col-md-6 p-2 h-100">
				<ul class="list-group">
					<li class="list-group-item justify-content-between active"><strong><spring:message code="form.sample.label.grower" /></strong></li>
					<li class="list-group-item justify-content-between"><spring:message code="form.sample.label.growerId" />: <span>${sample.growerId}</span></li>
					<li class="list-group-item justify-content-between"><spring:message code="form.sample.label.phone" />: <span> ${sample.phone}</span></li>
					<li class="list-group-item justify-content-between"><spring:message code="form.sample.label.location" /> : <span> ${sample.location}</span></li>
					<li class="list-group-item justify-content-between"><spring:message code="form.sample.label.departament" />: <span> ${sample.departament}</span></li>
					<li class="list-group-item justify-content-between"><spring:message code="form.sample.label.municipalityGrower" />: <span> ${sample.municipalityGrower}</span></li>
					<li class="list-group-item justify-content-between"><spring:message code="form.sample.label.veredaGrower" />: <span> ${sample.veredaGrower}</span></li>
				</ul>
			</div>
			
			<div class="row py-3">
			<div class="col-sm-12 col-md-6 p-2 h-100">
				<ul class="list-group">
					<li class="list-group-item justify-content-between active"><strong><spring:message code="physical-analysis" /></strong></li>
					<li class="list-group-item justify-content-between"><spring:message code="form.sample.label.fr" /> : <span> ${sample.fr} Kg</span></li>
					<li class="list-group-item justify-content-between"><spring:message code='form.sample.label.almondTotal' /> : <span> ${sample.almondTotal} %</span></li>
					<li class="list-group-item justify-content-between"><spring:message code='form.sample.label.almondHealthy' /> : <span> ${sample.almondHealthy} %</span></li>
					<li class="list-group-item justify-content-between"><spring:message code="form.sample.label.broca" /> (g) : <span>${sample.brocaGrams} g</span></li>
					<li class="list-group-item justify-content-between"><spring:message code="form.sample.label.broca" /> (%) : <span>${sample.brocaPercentage} %</span></li>
					<li class="list-group-item justify-content-between"><spring:message code="form.sample.label.pasilla" /> (g) : <span> ${sample.pasillaGrams} g</span></li>
					<li class="list-group-item justify-content-between"><spring:message code="form.sample.label.pasilla" /> (%) : <span> ${sample.pasillaPercentage} %</span></li>
					<li class="list-group-item justify-content-between"><spring:message code="form.sample.label.humidity" /> : <span> ${sample.humidity} %</span></li>
					<li class="list-group-item justify-content-between"><spring:message code="form.sample.label.merma" /> : <span> ${sample.merma} %</span></li>
				</ul>
			</div>
		</div>

 --%>