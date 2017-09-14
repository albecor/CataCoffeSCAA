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
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../fragments/title.jsp" />
<jsp:include page="../fragments/css/bootstrap.jsp" />
<jsp:include page="../fragments/css/footer.jsp" />
<jsp:include page="../fragments/css/fontAwesome.jsp" />
<jsp:include page="../fragments/css/animate.jsp" />
<link href="https://cdn.datatables.net/1.10.15/css/dataTables.bootstrap4.min.css" rel="stylesheet" /><script>window.jQuery || document.write(unescape('%3Clink rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/datatable/dataTables.bootstrap4.min.css"/>" /%3E'));</script>
<link href="https://cdn.datatables.net/responsive/2.1.1/css/responsive.bootstrap4.min.css" rel="stylesheet" /><script>window.jQuery || document.write(unescape('%3Clink rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/datatable/responsive.bootstrap4.min.css"/>" /%3E'));</script>
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
		<div class="row">
			<div class="col">
				<div class="card">
				<div class="card-header">
				<strong><spring:message code="panels" /></strong>
				</div>
					<div class="card-block">
						<c:choose>
							<c:when test="${not empty panels}">
							<table  class="table table-striped table-bordered dt-responsive nowrap" cellspacing="0" width="100%"  id="table">
									<thead>
										<tr>
											<th><spring:message code="panel"/></th>
											<th><spring:message code="samples" /></th>
											<th class="text-center"><spring:message code="authorize" /></th>											
											<th class="text-center"><spring:message code="edit" /></th>											
											<th class="text-center"><spring:message code="delete" /></th>											
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${panels}" var="panel">
											<tr>
												<td>${panel.id}</td>
												<td>
												
												
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
</c:forEach></td>		

												<td class="text-center">
												
												<a data-toggle="modal" rel="tooltip"  data-placement="bottom" title="<spring:message code="panel.enable" />" data-href="<spring:url value="/or/authorize-panel-${panel.id}"/>" data-target="#enablePanelModal" href="#" class="btn btn-sm btn-warning"><i class="fa fa-lock fa-2x fa-fw" aria-hidden="true"></i></a>
											
											
											
												</td>
												<td class="text-center">
												
												
												<a href="<spring:url value="/or/update-panel-${panel.id}"/>" rel="tooltip" data-placement="bottom" title="<spring:message code="edit" />" class="btn btn-sm btn-primary"><i class="fa fa-edit fa-2x fa-fw" aria-hidden="true"></i></a> 
												
												
												
												</td>
												<td class="text-center">
												
											
												<a data-toggle="modal" rel="tooltip"   data-placement="bottom" title="<spring:message code="delete" />" data-href="<spring:url value="/or/delete-panel-${panel.id}"/>" data-target="#deletePanelModal" href="#" class="btn btn-sm btn-danger"><i class="fa fa-trash fa-2x fa-fw" aria-hidden="true"></i></a>
											
												</td>
												 
											</tr>
										</c:forEach>
									</tbody>
								</table>
							
							</c:when>
							<c:otherwise>
								<span class="lead text-danger"><spring:message code="panels.not-exist" /></span>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
	</div> 
	<!-- Modal -->
	<div class="modal fade" id="deletePanelModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel"><spring:message code="panel.delete"/></h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<p class="text-justify"><spring:message code="panel.delete.modal.body"/></p>
				</div>
				<div class="modal-footer">
					<a class="btn btn-danger btn-ok "><spring:message code="panel.delete"/></a>
				</div>
			</div>
		</div>
	</div>
	
	<!-- Modal -->
	<div class="modal fade" id="enablePanelModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel"><spring:message code="panel.enable"/></h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<p class="text-justify"><spring:message code="panel.enable.modal.body"/></p>
				</div>
				<div class="modal-footer">
					<a class="btn btn-danger btn-ok "><spring:message code="panel.enable"/></a>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../fragments/footer.jsp" />
	<jsp:include page="../fragments/js/jquery.jsp" />	
	
	<jsp:include page="../fragments/js/bootstrap.jsp" />
	<script>
	
	</script>
	<script src="https://cdn.datatables.net/1.10.15/js/jquery.dataTables.min.js"></script><script>window.jQuery || document.write(unescape('%3Cscript src="<spring:url value="/resources/js/datatable/jquery.dataTables.min.js"/>"%3E%3C/script%3E'))</script>
	<script src="https://cdn.datatables.net/1.10.15/js/dataTables.bootstrap4.min.js"></script><script>window.jQuery || document.write(unescape('%3Cscript src="<spring:url value="/resources/js/datatable/dataTables.bootstrap4.min.js"/>"%3E%3C/script%3E'))</script>
<script src="https://cdn.datatables.net/responsive/2.1.1/js/dataTables.responsive.min.js"></script><script>window.jQuery || document.write(unescape('%3Cscript src="<spring:url value="/resources/js/datatable/dataTables.responsive.min.js" />"%3E%3C/script%3E'))</script>
	<script src="https://cdn.datatables.net/responsive/2.1.1/js/responsive.bootstrap4.min.js"></script><script>window.jQuery || document.write(unescape('%3Cscript src="<spring:url value="/resources/js/datatable/responsive.bootstrap4.min.js" />"%3E%3C/script%3E'))</script>



<script>


	
</script>    
 <script>
$(document).ready(function() { 




	$('.modal').on('shown.bs.modal', function (e) {
		 $(this).find('.btn-ok').attr('href', $(e.relatedTarget).data('href'));		 
		})
		
  

// array de traducciones 
	var arrLang = new Array();
	arrLang['en'] = new Array();
	arrLang['es'] = new Array();	
	
	arrLang['es']['select_all'] ='Seleccionar todo';
	arrLang['en']['select_all'] ='Select all';
	arrLang['es']['select_none'] ='Nada';
	arrLang['en']['select_none'] ='None';

	var locale ='${pageContext.response.locale.language}';
	

//-------------- PARAMETROS DE LAS TABLAS
	// traductor a español de la libreria datatable
	var languageEs = {
    		select: {
                rows: {
                    _: "%d filas seleccionadas",
                    0: "Click en una fila para seleccionarla",
                    1: "1 fila seleccionada"
                }
            },
    	    "sProcessing":     "Procesando...",
    	    "sLengthMenu":     "Mostrar _MENU_ registros",
    	    "sZeroRecords":    "No se encontraron resultados",
    	    "sEmptyTable":     "Ningún dato disponible en esta tabla",
    	    "sInfo":           "Mostrando del _START_ al _END_ de  _TOTAL_ registros",
    	    "sInfoEmpty":      "Mostrando del 0 al 0 de 0 registros",
    	    "sInfoFiltered":   "(filtrado de un total de _MAX_ registros)",
    	    "sInfoPostFix":    "",
    	    "sSearch":         "Buscar:",
    	    "sUrl":            "",
    	    "sInfoThousands":  ",",
    	    "sLoadingRecords": "Cargando...",
    	    "oPaginate": {
    	        "sFirst":    "Primero",
    	        "sLast":     "Último",
    	        "sNext":     "Siguiente",
    	        "sPrevious": "Anterior"
    	    },
    	    "oAria": {
    	        "sSortAscending":  ": Activar para ordenar la columna de manera ascendente",
    	        "sSortDescending": ": Activar para ordenar la columna de manera descendente"
    	    }
    	};

	
	  var order = [[0, 'asc']];

//-------------------- TABLA PARA MUESTRAS --------------------------------
    var table1 = $('#table').DataTable( { 
    
    	
    	<c:if test="${pageContext.response.locale.language == 'es'}">
    	language: languageEs, 
    	</c:if>
    	   'order': order   	  
    } );

	
   
} );
</script>




		
	<c:if test="${not empty notifyMesage}">
		<jsp:include page="../fragments/js/notify.jsp">
			<jsp:param name="notifyMesage" value="${notifyMesage}" />
			<jsp:param name="notifyType" value="${notifyType}" />
		</jsp:include>
	</c:if>
</body>
</html>