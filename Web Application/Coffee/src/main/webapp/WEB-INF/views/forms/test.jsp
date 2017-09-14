<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="com.spring.coffee.model.Attribute"%>
<%@ page import="com.google.gson.Gson" %>
<%@ page session="true"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />

<jsp:include page="../fragments/title.jsp" />
<jsp:include page="../fragments/css/bootstrap.jsp" />
<jsp:include page="../fragments/css/footer.jsp" />
<jsp:include page="../fragments/css/fontAwesome.jsp" />
<jsp:include page="../fragments/css/animate.jsp" />
<jsp:include page="../fragments/js/jquery.jsp" />
 
<style>
.disabled{
  pointer-events:none;
}
.hidden {
	display: none;
}

@media ( max-width : 575px) {
	.btn-group-lg>.btn, .btn-lg {
		padding: .5rem .75rem;
	}
}

#radio-selector .btn.active, #radio-selector .btn:active {
	box-shadow: 0 0 0 3px black;
}

#radio-defects .btn.active, #radio-defects .btn:active {
	box-shadow: 0 0 0 3px black;
}
.button-checkbox {
	margin-top: 10px;
}
.stepwizard-step button[disabled] {
	opacity: 1 !important;
	filter: alpha(opacity = 100) !important;
}

.hidden {
	display: none;
}

.btn-default {
	background-color: #fff;
	border-color: #0275d8;
}

@media ( max-width : 575px) {
	.btn-group-lg>.btn, .btn-lg {
		padding: .5rem .75rem;
	}
}

#radio-selector .btn.active, #radio-selector .btn:active {
	box-shadow: 0 0 0 3px black;
}

#radio-defects .btn.active, #radio-defects .btn:active {
	box-shadow: 0 0 0 3px black;
}
.calendar-text { margin-top: .1em; }
.colora{
color: white;
}

</style>
</head>
<body>
	<jsp:include page="../navbar.jsp" />
	<div class="container py-2">	
		<div class="row">
			<div class="col col-auto hidden-md-down">
				<div  class="btn-group-vertical setup-panel" role="group" >					
					<a id="href-content-fragrance" href="#content-fragrance" class="btn btn-primary"><i class="fa pull-right" aria-hidden="true"></i><spring:message code="fragrance" /></a>
					<a id="href-content-aroma" href="#content-aroma" class="btn btn-default "><i class="fa pull-right" aria-hidden="true"></i><spring:message code="aroma" /></a>
					<a id="href-content-flavor" href="#content-flavor" class="btn btn-default "><i class="fa pull-right" aria-hidden="true"></i><spring:message code="flavor" /></a>					
					<a id="href-content-residualFlavor" href="#content-residualFlavor" class="btn btn-default "><i class="fa pull-right" aria-hidden="true"></i><spring:message code="residualFlavor" /></a>					
					<a id="href-content-acidity" href="#content-acidity" class="btn btn-default "><i class="fa pull-right" aria-hidden="true"></i><spring:message code="acidity" /></a>					
					<a id="href-content-body" href="#content-body" class="btn btn-default "><i class="fa pull-right" aria-hidden="true"></i><spring:message code="body" /></a>					
					<a id="href-content-uniformity" href="#content-uniformity" class="btn btn-default "><i class="fa pull-right" aria-hidden="true"></i><spring:message code="uniformity" /></a>					
					<a id="href-content-balance"  href="#content-balance" class="btn btn-default "><i class="fa pull-right" aria-hidden="true"></i><spring:message code="balance" /></a>			
					<a id="href-content-cleanCup" href="#content-cleanCup" class="btn btn-default "><i class="fa pull-right" aria-hidden="true"></i><spring:message code="cleanCup" /></a>					
					<a id="href-content-sweetness" href="#content-sweetness" class="btn btn-default "><i class="fa pull-right" aria-hidden="true"></i><spring:message code="sweetness" /></a>					
					<a id="href-content-defect" href="#content-defect" class="btn btn-default "><i class="fa pull-right" aria-hidden="true"></i><spring:message code="defect" /></a>				
					<a id="href-content-attributes_lexic" href="#content-attributes_lexic" class="btn btn-default "><i class="fa pull-right" aria-hidden="true"></i><spring:message code="attributes_lexic" /></a>				
					<a id="href-content-defects_lexic" href="#content-defects_lexic" class="btn btn-default "><i class="fa pull-right" aria-hidden="true"></i><spring:message code="defects_lexic" /></a>				
					<a id="href-content-tasterScore" href="#content-tasterScore" class="btn btn-default "><i class="fa pull-right" aria-hidden="true"></i><spring:message code="tasterScore" /></a>					
					<a id="href-content-notes" href="#content-notes" class="btn btn-default "><i class="fa pull-right" aria-hidden="true"></i><spring:message code="notes" /></a>					
					<a id="href-content-summary" href="#content-summary" class="btn btn-default "><i class="fa pull-right" aria-hidden="true"></i><spring:message code="summary" /></a>
					<hr />							
					<button type="button" id="reject" class="btn btn-danger"><spring:message code="sample.reject" /></button>
				</div>				
			</div>
			<div class="col">
				<div class="card h-100">
					<div class="card-header">					
					<div class="row">
					<div class="col col-auto py-2"> 	<strong> <i class="fa fa-bell" aria-hidden="true"></i>
						<spring:message code="notify.sample.to-taste" /> : </strong></div>
					<div class="col col-auto">
					<c:forEach var="tests" items="${testses}">
							<a   id="url_test_${tests.test.id}" href="<spring:url value="/ta/paneli-${tests.panel.id}-test-${tests.test.id}"/>" class="btn btn-secondary samplesLink">${tests.sample.code}</a>
						</c:forEach>
					</div>
					</div>					
					</div>
					<div class="card-header  ">
					<div class="d-flex justify-content-between">					
						<strong><spring:message code="sample" />: ${sample.code} </strong>
						<div id="badge-total-score"></div>
					<%--<div id="loading" class="hidden"> <i class="fa fa-spinner fa-pulse fa-fw"></i></div> --%>
					</div>					
					</div>
					<div class="card-block">				
						<div class="row hidden-lg-up">
							<div class="col py-2">
							    <select class="form-control" id="select_menu" >
								    <option disabled><spring:message code="attributes" /></option>
								    <option  data-fragrance="<spring:message code="fragrance" />" style="background-color:gray;"  value="#content-fragrance"> <spring:message code="fragrance" /></option>
								    <option data-aroma="<spring:message code="aroma" />" value="#content-aroma"><spring:message code="aroma" /></option>
								    <option data-flavor="<spring:message code="flavor" />" value="#content-flavor"><spring:message code="flavor" /></option>
								    <option data-residualflavor="<spring:message code="residualFlavor" />" value="#content-residualFlavor"><spring:message code="residualFlavor" /></option>
								    <option data-acidity="<spring:message code="acidity" />" value="#content-acidity"><spring:message code="acidity" /></option>  
								    <option data-body="<spring:message code="body" />" value="#content-body"><spring:message code="body" /></option>  
								    <option data-uniformity="<spring:message code="uniformity" />" value="#content-uniformity"><spring:message code="uniformity" /></option>  
								    <option data-balance="<spring:message code="balance" />" value="#content-balance"><spring:message code="balance" /></option>  
								    <option data-cleancup="<spring:message code="cleanCup" />" value="#content-cleanCup"><spring:message code="cleanCup" /></option>  
								    <option data-sweetness="<spring:message code="sweetness" />" value="#content-sweetness"><spring:message code="sweetness" /></option>  
								    <option data-defect="<spring:message code="defect" />" value="#content-defect"><spring:message code="defect" /></option>  
								    <option data-attributes_lexic="<spring:message code="attributes_lexic" />" value="#content-attributes_lexic"><spring:message code="attributes_lexic" /></option>  
								    <option data-defects_lexic="<spring:message code="defects_lexic" />" value="#content-defects_lexic"><spring:message code="defects_lexic" /></option>  
								    <option data-tasterscore="<spring:message code="tasterScore" />" value="#content-tasterScore"><spring:message code="tasterScore" /></option>  
								    <option data-notes="<spring:message code="notes" />" value="#content-notes"><spring:message code="notes" /></option>  
								    <option data-summary="<spring:message code="summary" />" value="#content-summary"><spring:message code="summary" /></option>  
								    <option data-reject="<spring:message code="reject" />" value="#content-reject"><spring:message code="sample.reject" /></option>  
							    </select>
							</div>
						</div>
						
						<spring:url value="/test" var="userActionUrl" />						
						<form:form method="POST" modelAttribute="test" class="form-horizontal" action="${userActionUrl}">
							<form:hidden path="id" />
							<form:hidden path="cups" />	
							<input type="hidden" id="panel_id" value="${panelId}" />	
							<input type="hidden" id="attr" value="${attr}" />	
							<form:hidden path="finished" value="0" />
							<form:hidden path="defectOrder" value="${test.defectOrder}" />
							
							<form:hidden path="uniformityOrder" value="${test.uniformityOrder}" />							
						
							<form:hidden path="sweetnessOrder" value="${test.sweetnessOrder}" />
							<form:hidden path="cleanCupOrder" value="${test.cleanCupOrder}" />
		
							<input id="urlservename" type="hidden"  value="http://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/" name="urlservename">	
							<input id="locale" name="locale" type="hidden" value="${pageContext.response.locale.language}"/>
							<div class="row hidden" id="content-finished">
								<div class="col">
									<div class="alert alert-success" role="alert">
										<div class="row">
											<div class="col col-auto">
												<span class="text-justify"><spring:message code="alert.finished-test" /></span>
											</div>
											<div class="col">
												<button type="button" id="button-finish-test2" data-toggle="modal" data-target="#modalFinishTest" class="btn btn-success pull-right">
													<spring:message code="finish-test" />
												</button>												
									
											</div>
										</div>
									</div>
								</div>
							</div>
							<jsp:include page="../fragments/containerTest.jsp">
								<jsp:param name="path" value="fragrance" />
								<jsp:param name="value" value="${test.fragrance}" />
							</jsp:include>
							
							<jsp:include page="../fragments/containerTest.jsp">
								<jsp:param name="path" value="aroma" />
								<jsp:param name="value" value="${test.aroma}" />			
							</jsp:include>
							<div id="hidden-content-aroma">
							<div class="alert alert-warning" role="alert">
										<div class="row">
											<div class="col col-auto">
												<span class="text-justify"><spring:message code="fragrance-first" /></span>
											</div>
											
										</div>
									</div>
							</div>
							<div id="hidden-content-residualFlavor">
							<div class="alert alert-warning" role="alert">
										<div class="row">
											<div class="col col-auto">
												<span class="text-justify"><spring:message code="flavor-first" /></span>
											</div>
											
										</div>
									</div>
							</div>							
							<jsp:include page="../fragments/containerTest.jsp">
								<jsp:param name="path" value="flavor" />
								<jsp:param name="value" value="${test.flavor}" />
							</jsp:include>
							
							<jsp:include page="../fragments/containerTest.jsp">
								<jsp:param name="path" value="residualFlavor" />
								<jsp:param name="value" value="${test.residualFlavor}" />		
							</jsp:include>
							
							<jsp:include page="../fragments/containerTest.jsp">
								<jsp:param name="path" value="acidity" />
								<jsp:param name="value" value="${test.acidity}" />
							</jsp:include>
						
							<jsp:include page="../fragments/containerTest.jsp">
								<jsp:param name="path" value="body" />
								<jsp:param name="value" value="${test.body}" />
							</jsp:include>
							
							<input type="hidden" name="cup" value="${test.cups}">
							
							<jsp:include page="../fragments/containerTest.jsp">
								<jsp:param name="path" value="uniformity" />
								<jsp:param name="value" value="${test.uniformity}" />
								<jsp:param name="cups" value="${test.cups}" />
							</jsp:include>
							
							<jsp:include page="../fragments/containerTest.jsp">
								<jsp:param name="path" value="balance" />
								<jsp:param name="value" value="${test.balance}" />
								<jsp:param name="cups" value="${test.cups}" /> 
							</jsp:include>
							
							<jsp:include page="../fragments/containerTest.jsp">
								<jsp:param name="path" value="cleanCup" />
								<jsp:param name="value" value="${test.cleanCup}" />
								<jsp:param name="cups" value="${test.cups}" />			
							</jsp:include>
							
							<jsp:include page="../fragments/containerTest.jsp">
								<jsp:param name="path" value="sweetness" />
								<jsp:param name="value" value="${test.sweetness}" />
								<jsp:param name="cups" value="${test.cups}" />
							</jsp:include>
							
							<jsp:include page="../fragments/containerTest.jsp">
								<jsp:param name="path" value="defect" />
								<jsp:param name="value" value="${test.defect}" />
								<jsp:param name="cups" value="${test.cups}" />			
							</jsp:include>
							
							<jsp:include page="../fragments/containerTest.jsp">
								<jsp:param name="path" value="tasterScore" />
								<jsp:param name="value" value="${test.tasterScore}" />			
							</jsp:include>					
							
							<jsp:include page="../fragments/containerTest.jsp">
								<jsp:param name="path" value="attributes_lexic" />
							</jsp:include>
							
							<jsp:include page="../fragments/containerTest.jsp">
								<jsp:param name="path" value="defects_lexic" />
							</jsp:include>
					
							<c:set var="listraributos" value="${test.attributes}" />																	
							<%	
							Set<Attribute> attributes = (Set<Attribute>) pageContext.getAttribute("listraributos");					
							String json = new Gson().toJson(attributes);	
							%>					
							<script>
								var attributes =<%=json%>;
								 $.each(attributes, function(index, value) {					         
							            $('select[name="attributes"] option[value="' + value.id + '"]').prop('selected', true);	             
							            $('select[name="attributes1"] option[value="' + value.id + '"]').prop('selected', true);				       	            
							     });
							</script>					
							<jsp:include page="../fragments/containerTest.jsp">
								<jsp:param name="path" value="notes" />		
							</jsp:include>
							
							<jsp:include page="../fragments/containerTest.jsp">
								<jsp:param name="path" value="summary" />
								<jsp:param name="cups" value="${test.cups}" />
							</jsp:include>
							
							<jsp:include page="../fragments/containerTest.jsp">
								<jsp:param name="path" value="reject" />
							</jsp:include>				
						</form:form>
					</div>
				</div>
			</div>
		</div>
		
		<%--		<div class="container">
			<div class="row">
				<div class="col">
					<div id="postResultDiv"></div>
				</div>
			</div>
		</div>
		 --%>
		
<!-- Modal -->
<div class="modal fade" id="exampleModalLong" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle"><spring:message code="sample.reject" /></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
       <spring:message code="reject-body" arguments="${sample.code}" />
      </div>
      <div class="modal-body">
      
        <hr />
        <div class="d-flex justify-content-between">
      <button type="button" class="btn btn-secondary" data-dismiss="modal"><spring:message code="close" /></button>
        <button type="button" id="reject_sample" class="btn btn-danger"><spring:message code="sample.reject" /></button>
      </div>
       
      </div>
    </div>
  </div>
</div>
<!-- Modal -->
<div class="modal fade" id="modalFinishTest" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle"><spring:message code="finish-test" /></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
       <spring:message code="finish-test-body" arguments="${sample.code}" />
      </div>
      <div class="modal-body">
      
        <hr />
        <div class="d-flex justify-content-between">
      <button type="button" class="btn btn-secondary" data-dismiss="modal"><spring:message code="close" /></button>
        <button type="button" id="button-finish-test" class="btn btn-danger"><spring:message code="finish-test" /></button>
      </div>
       
      </div>
    </div>
  </div>
</div>
	</div>
	<jsp:include page="../fragments/footer.jsp" />
	<script src="<spring:url value="/resources/js/jquery.quicksearch.js"/>"></script>
	<script src="<spring:url value="/resources/js/postrequest2.js" />"></script>
	<script src="<spring:url value="/resources/js/getrequest.js" />"></script>
	<jsp:include page="../fragments/js/bootstrap.jsp" />
	<script src="<spring:url value="/resources/js/bootstrap-notify.min.js"/>"></script>
	<c:if test="${not empty notifyMesage}">
		<jsp:include page="../fragments/js/notify.jsp">
			<jsp:param name="notifyMesage" value="${notifyMesage}" />
			<jsp:param name="notifyType" value="notifyType" />
		</jsp:include>
	</c:if>
 
	<script>
		$(function() {
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$(document).ajaxSend(function(e, xhr, options) {
				xhr.setRequestHeader(header, token);
			});
		});
	</script>
</body>
</html>

<%-- <div class="row">
	<div class="dropdown">
  <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    <spring:message code="attributes" />
  </button>
  
  <div class="dropdown-menu setup-panel" aria-labelledby="dropdownMenuButton">
    <a href="#content-fragrance" class="dropdown-item"><spring:message code="fragrance" /></a>
							<a href="#content-aroma" class="dropdown-item"><spring:message code="aroma" /></a>
							<a href="#content-flavor" class="dropdown-item"><spring:message code="flavor" /></a>					
							<a href="#content-residualFlavor" class="dropdown-item"><spring:message code="residualFlavor" /></a>					
							<a href="#content-acidity" class="dropdown-item"><spring:message code="acidity" /></a>					
							<a href="#content-body" class="dropdown-item"><spring:message code="body" /></a>					
							<a href="#content-uniformity" class="dropdown-item"><spring:message code="uniformity" /></a>					
							<a href="#content-balance" class="dropdown-item"><spring:message code="balance" /></a>			
							<a href="#content-cleanCup" class="dropdown-item"><spring:message code="cleanCup" /></a>					
							<a href="#content-sweetness" class="dropdown-item"><spring:message code="sweetness" /></a>					
							<a href="#content-defect" class="dropdown-item"><spring:message code="defect" /></a>				
							<a href="#content-attributes_lexic" class="dropdown-item"><spring:message code="attributes_lexic" /></a>				
							<a href="#content-defects_lexic" class="dropdown-item"><spring:message code="defects_lexic" /></a>				
							<a href="#content-tasterScore" class="dropdown-item"><spring:message code="tasterScore" /></a>					
							<a href="#content-notes" class="dropdown-item"><spring:message code="notes" /></a>					
							<a href="#content-summary" class="dropdown-item"><spring:message code="summary" /></a>
  </div>
</div>
	</div>--%>