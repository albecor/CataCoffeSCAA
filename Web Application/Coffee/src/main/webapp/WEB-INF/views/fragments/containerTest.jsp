<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="setup-content" id="content-${param.path}">
	<div class="row justify-content-center">
		<div class="col ">
			<div class="card">
				<div class="card-block">
					<div class="d-flex justify-content-between">
						<strong> <spring:message code="${param.path}" /></strong>
						<c:if test="${param.path != 'notes' && param.path != 'summary' && param.path != 'attributes_lexic' && param.path != 'defects_lexic' && param.path != 'reject'}">
							<strong><spring:message code="score" />: <span id="data-${param.path}"><fmt:formatNumber value="${param.value}" /></span></strong>
						</c:if>
					</div>
					<hr />
					<c:if test="${param.path != 'summary'}">
						<p class="text-center">
							<strong> <spring:message code="question-${param.path}" /></strong>
						</p>
					</c:if>
					<c:choose>
						<c:when test="${param.path == 'notes'}">
							<div class="row justify-content-center">
								<form:textarea path="${param.path}" rows="5" class="form-control form-control-feedback" />
							</div>
							<br />
							<button id="add_notes" type="button" class="btn btn-primary">
								<spring:message code="add" />
							</button>
						</c:when>
						<c:when test="${param.path == 'reject'}">
							<div class="row justify-content-center">
								<textarea id="reject_notes" name="reject_notes" rows="5" class="form-control form-control-feedback"></textarea>
							</div>
							<br />
							<!-- Button trigger modal -->
							<button type="button" class="btn btn-warning" data-toggle="modal" data-target="#exampleModalLong">
								<spring:message code="sample.reject" />
							</button>
						</c:when>
						<c:when test="${param.path == 'attributes_lexic'}">
							<jsp:include page="../fragments/selectLexic.jsp">
								<jsp:param name="path" value="attributes" />
							</jsp:include>
						</c:when>
						<c:when test="${param.path == 'defects_lexic'}">
							<jsp:include page="../fragments/selectLexic3.jsp">
								<jsp:param name="path" value="attributes1" />
							</jsp:include>
						</c:when>
						<c:when test="${param.path == 'uniformity' || param.path == 'cleanCup' || param.path == 'sweetness'   }">
							<div class="btn-group" id="radio-selector" data-toggle="buttons">
							<label class="btn btn-success"> <input class="conditional-post" type="radio" name="${param.path}" id="yes-${param.path}" value="yes" autocomplete="off"> <spring:message code="yes" />
								</label> <label class="btn btn-warning"> <input class="conditional-post" type="radio" name="${param.path}" id="no-${param.path}" value="no" autocomplete="off"> <spring:message code="no" /></label>
							</div>
							<div id="hidden-${param.path}">
								<p>
									<strong><spring:message code="question-${param.path}-q" /></strong>
								</p>
								<div class="row justify-content-center">
									<c:forEach var="i" begin="1" end="${param.cups}">
										<div class="col col-auto">
											<div class="button-checkbox">
												<button type="button" class="btn" data-color="danger">	${i} </button>
												<input type="checkbox" class="hidden" name="${param.path}" id="${param.path}-${i}" />
											</div>
										</div>
									</c:forEach>
								</div>
							</div>
							<form:hidden path="${param.path}" value="${param.value}" />
							<hr />
							<strong><spring:message code="comments" />:</strong>
							<div class="row justify-content-center py-2">
								<form:textarea path="${param.path}Notes" rows="2" class="form-control form-control-feedback" />
							</div>
						</c:when>
						<c:when test="${param.path == 'defect'}">
						<br />
						<div class="row justify-content-center ">
						<div class="col">  <strong><spring:message code="question-defect-all" /> : </strong> </div>
						<div class="col"><div class="btn-group" id="radio-selector" data-toggle="buttons">
							<label class="btn btn-success"> <input  type="radio" class="check-defect" name="${param.path}-state" id="yes-${param.path}" value="yes" autocomplete="off"> <spring:message code="yes" />
								</label> 
								<label class="btn btn-warning"> <input type="radio" class="check-defect" name="${param.path}-state" id="no-${param.path}" value="no" autocomplete="off"> <spring:message code="no" /></label>
							</div></div>
						</div>
						
						
							
								<hr />
								
							<div id="radio-defects">
							
							<div id="hidden-defect-all">
							<div class="row mx-2 justify-content-center" style="margin-bottom: 1rem;">
										<span class="align-middle"> <i class="fa fa-coffee fa-3x fa-fw" aria-hidden="true"></i>
										</span>
										<div class="btn-group" data-toggle="buttons" id="radio_defects">
											<label class="btn btn-success"> <input type="radio" class="defect_pulse" name="${param.path}-a" id="${param.path}-0" value="0"><i class="fa fa-smile-o fa-2x fa-fw" aria-hidden="true"></i>
											</label> <label class="btn btn-warning"> <input type="radio" class="defect_pulse" name="${param.path}-a" id="${param.path}-2" value="2"><i class="fa fa-meh-o fa-2x fa-fw" aria-hidden="true"></i>
											</label> <label class="btn btn-danger"> <input type="radio" class="defect_pulse" name="${param.path}-a" id="${param.path}-4" value="4" style="margin-bottom: .2rem;"><i class="fa fa-frown-o fa-2x fa-fw" aria-hidden="true"></i>
											</label>
										</div>
							</div>
							</div>
							<div id="hidden-defect-one">							
								<c:forEach var="i" begin="1" end="${param.cups}">
									<div class="row mx-2 justify-content-center" style="margin-bottom: 1rem;">
										<span class="align-middle"> <i class="fa fa-coffee fa-3x fa-fw" aria-hidden="true"></i>
										</span>
										<div class="btn-group" data-toggle="buttons" id="radio_defects">
											<label class="btn btn-success"> <input type="radio" class="defect_pulse" name="${param.path}-${i}" id="${param.path}-${i}-0" value="0"><i class="fa fa-smile-o fa-2x fa-fw" aria-hidden="true"></i>
											</label> <label class="btn btn-warning"> <input type="radio" class="defect_pulse" name="${param.path}-${i}" id="${param.path}-${i}-2" value="2"><i class="fa fa-meh-o fa-2x fa-fw" aria-hidden="true"></i>
											</label> <label class="btn btn-danger"> <input type="radio" class="defect_pulse" name="${param.path}-${i}" id="${param.path}-${i}-4" value="4" style="margin-bottom: .2rem;"><i class="fa fa-frown-o fa-2x fa-fw" aria-hidden="true"></i>
											</label>
										</div>
									</div>
								</c:forEach>
								<p class="text-danger" id="defect_warning">
								<strong><spring:message code="defect.warning" /></strong>
							</p>
								</div>
							</div>
							
							<form:hidden path="${param.path}" value="${param.value}" />
							<hr />
							<div class="row">
								<div class="col col-auto">
									<div class="d-flex flex-column">
										<div class="p-2">
											<spring:message code="faultless" />
											(0) : &#160;<span class="badge badge-success float-right"><i class="fa fa-smile-o fa-2x fa-fw" aria-hidden="true"></i></span>
										</div>
										<div class="p-2">
											<spring:message code="taint" />
											(2) : &#160;<span class="badge badge-warning float-right"><i class="fa fa-meh-o fa-2x fa-fw" aria-hidden="true"></i></span>
										</div>
										<div class="p-2">
											<spring:message code="fault" />
											(4) : &#160;<span class="badge badge-danger float-right"><i class="fa fa-frown-o fa-2x fa-fw" aria-hidden="true"></i></span>
										</div>
									</div>
								</div>
								
							</div>						
							
							<hr />
							<strong><spring:message code="comments" />:</strong>
							<div class="row justify-content-center py-2">
								<form:textarea path="${param.path}Notes" rows="2" class="form-control form-control-feedback" />
							</div>
						</c:when>
						<c:when test="${param.path == 'summary'}">
							<div class="row justify-content-center d-flex flex-row py-2">
								<div class="col-12 d-flex flex-column" id="final_score"></div>
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
														<td><p id="summary-fragrance"></p></td>
													</tr>
													<tr>
														<th scope="row">2</th>
														<td><spring:message code="aroma" /></td>
														<td><p id="summary-aroma"></p></td>
													</tr>
													<tr>
														<th scope="row">3</th>
														<td><spring:message code="flavor" /></td>
														<td><p id="summary-flavor"></td>
													</tr>
													<tr>
														<th scope="row">4</th>
														<td><spring:message code="residualFlavor" /></td>
														<td><p id="summary-residualFlavor"></td>
													</tr>
													<tr>
														<th scope="row">5</th>
														<td><spring:message code="acidity" /></td>
														<td><p id="summary-acidity"></td>
													</tr>
													<tr>
														<th scope="row">6</th>
														<td><spring:message code="body" /></td>
														<td><p id="summary-body"></td>
													</tr>
													<tr>
														<th scope="row">7</th>
														<td><spring:message code="uniformity" /></td>
														<td><p id="summary-uniformity"></td>
													</tr>
													<tr>
														<th scope="row">8</th>
														<td><spring:message code="balance" /></td>
														<td><p id="summary-balance"></td>
													</tr>
													<tr>
														<th scope="row">9</th>
														<td><spring:message code="cleanCup" /></td>
														<td><p id="summary-cleanCup"></td>
													</tr>
													<tr>
														<th scope="row">10</th>
														<td><spring:message code="sweetness" /></td>
														<td><p id="summary-sweetness"></td>
													</tr>
													<tr>
														<th scope="row">11</th>
														<td><spring:message code="defect" /></td>
														<td><p id="summary-defect"></td>
													</tr>
													<tr>
														<th scope="row">12</th>
														<td><spring:message code="tasterScore" /></td>
														<td><p id="summary-tasterScore"></td>
													</tr>
													<tr>
														<th scope="row">#</th>
														<td><strong><spring:message code="totalScore" /></strong></td>
														<td><strong><span id="summary-totalScore"></span></strong></td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>
									<div class="float-right">
										<c:if test="${not empty param.submit}">
											<button type="submit" class="btn  btn-primary">
												<spring:message code="form.user.button.value.add" />
											</button>
										</c:if>
									</div>
								</div>
								<div class="col-12 col-md-6 d-flex flex-column">
									<div class="card h-100 w-100">									
										<div class="card-block">										
											<strong><spring:message code="cups" />:</strong> &nbsp;&nbsp; ${param.cups}
											<hr />
											<strong><spring:message code="notes" />:</strong>
											<p id="summary-notes">
											<p id="summary-attributes-notes">
										</div>
										<div class="card-block">
											<strong><spring:message code="attributes" />:</strong>
											<hr />
											<p id="summary-attributes_lexic">
										</div>
										<div class="card-block">
											<strong><spring:message code="defect" />:</strong>
											<hr />
											<p id="summary-defects_lexic">
										</div>
									</div>
								</div>
							</div>
							<div class="row  d-flex flex-row py-2">								
								<div class="col-12 col-md-6 d-flex flex-column">
									<div class="card h-100 w-100">
										<div class="card-block">
										<p><spring:message code="cups-order" /></p>										
										<p><spring:message code="uniformity" />:</p>
										<div id="order-cups-uniformity"></div><hr />										
										<p><spring:message code="cleanCup" />:</p>
										<div id="order-cups-cleanCup"></div><hr />
										<p><spring:message code="sweetness" />:</p>
										<div id="order-cups-sweetness"></div><hr />
										<p><spring:message code="defect" />:</p>
										<div id="order-cups-defect"></div>
										
										
										</div>
										</div>
										</div>
										</div>
						</c:when>
						<c:otherwise>
							<jsp:include page="../fragments/radiobutton.jsp">
								<jsp:param name="path" value="${param.path}" />
							</jsp:include>
							<form:hidden path="${param.path}" value="${param.value}" />
							<c:if test="${param.path == 'aroma' || param.path == 'residualFlavor'}"><br />
								<p class="text-danger text-center">
								<strong><spring:message code="only-active" /></strong>
							</p>
							</c:if>
							<c:if test="${param.path != 'tasterScore'}">
								<hr />
								<strong><spring:message code="comments" />:</strong>
								<div class="row justify-content-center py-2">
									<form:textarea path="${param.path}Notes" rows="2" class="form-control form-control-feedback" />
								</div>
							</c:if>
						</c:otherwise>
					</c:choose>
					<br />
				</div>
			</div>
		</div>
	</div>
</div>
