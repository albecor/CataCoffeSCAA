<%@page import="java.text.SimpleDateFormat"%>
<%@ page session="true"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../fragments/title.jsp" />
<jsp:include page="../fragments/css/datatable.jsp" />
<jsp:include page="../fragments/css/bootstrap.jsp" />
<jsp:include page="../fragments/css/footer.jsp" />
<jsp:include page="../fragments/css/fontAwesome.jsp" />
<jsp:include page="../fragments/css/animate.jsp" />
<link
	href="https://cdn.datatables.net/1.10.15/css/dataTables.bootstrap4.min.css"
	rel="stylesheet" />
<script>window.jQuery || document.write(unescape('%3Clink rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/datatable/dataTables.bootstrap4.min.css"/>" /%3E'));</script>
<link
	href="https://cdn.datatables.net/responsive/2.1.1/css/responsive.bootstrap4.min.css"
	rel="stylesheet" />
<script>window.jQuery || document.write(unescape('%3Clink rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/datatable/responsive.bootstrap4.min.css"/>" /%3E'));</script>
<style>
.btn[disabled] {
	/* don't let button block mouse events from reaching wrapper */
	pointer-events: none;
}
</style>
</head>
<body>
	<jsp:include page="../navbar.jsp" />
	<div class="container-fluid">
		<br />
		<div class="row">
			<div class="col">
				<div class="card">
					<div class="card-header">
						<strong><spring:message code="samples" /></strong>
					</div>
					<div class="card-block">
						<c:choose>
							<c:when test="${not empty samples}">
								<table
									class="table table-striped table-bordered dt-responsive nowrap"
									cellspacing="0" width="100%" id="table">
									<thead>
										<tr>
											<th class="text-center">#</th>
											<th class="text-center"><spring:message code="sample" /></th>
											<th class="text-center"><spring:message
													code="form.sample.label.grower" /></th>
											<th class="text-center"><spring:message code="state" /></th>
											<th class="text-center"><spring:message code="score" /></th>
											<th class="text-center"><spring:message
													code="date.tasted" /></th>
											<th class="text-center"><spring:message code="show" /></th>
											<th class="text-center"><spring:message code="edit" /></th>
											<th class="text-center"><spring:message code="delete" /></th>
											<th class="text-center"><spring:message code="report" /></th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${samples}" var="sample">
											<tr>
												<td class="text-center">${sample.id}</td>
												<td>${sample.code}</td>
												<td>${sample.grower}</td>
												<td><c:choose>
														<c:when test="${sample.test == null}">
															<i class="fa fa-ban fa-fw" style="color: red;"
																aria-hidden="true"></i>
															<spring:message code="sample.without-taste" />
														</c:when>
														<c:when test="${sample.test.finished == 1}">
															<i class="fa fa-check fa-fw" style="color: green;"
																aria-hidden="true"></i>
															<spring:message code="sample.tasted" />
														</c:when>
														<c:otherwise>
															<i class="fa fa-coffee fa-fw" style="color: #7F3300;"
																aria-hidden="true"></i>
															<spring:message code="sample.tasting" />
														</c:otherwise>
													</c:choose></td>
												<td class="text-center">${sample.test.totalScore}</td>
												<td class="text-center"><fmt:formatDate type="date"
														value="${sample.date}" /></td>
												<td class="text-center"><a
													href="<spring:url value="/or/sample-${sample.id}"/>"
													rel="tooltip" data-placement="bottom"
													title="<spring:message code="show" />"
													class="btn btn-sm btn-success"><i
														class="fa fa-eye fa-2x fa-fw" aria-hidden="true"></i></a></td>
												<td class="text-center"><a
													href="<spring:url value="/or/update-sample-${sample.id}"/>"
													rel="tooltip" data-placement="bottom"
													title="<spring:message code="edit" />"
													class="btn btn-sm btn-primary"><i
														class="fa fa-edit fa-2x fa-fw" aria-hidden="true"></i></a></td>
												<td class="text-center"><c:choose>
														<c:when test="${sample.test == null}">
															<a data-toggle="modal" data-placement="bottom"
																rel="tooltip" title="<spring:message code="delete" />"
																data-href="<spring:url value="/or/delete-sample-${sample.id}"/>"
																data-target="#myModal" href="#"
																class="btn btn-sm btn-danger "><i
																class="fa fa-trash fa-2x fa-fw" aria-hidden="true"></i></a>
														</c:when>


														<c:when test="${sample.test.finished == 1}">
															<button class="btn btn-sm btn-danger disabled"
																data-placement="bottom" rel="tooltip"
																title="<spring:message code="sample.tooltip.finished" />">
																<i class="fa fa-trash fa-2x fa-fw" aria-hidden="true"></i>
															</button>
														</c:when>
														<c:otherwise>
															<button class="btn btn-sm btn-danger disabled"
																data-placement="bottom" rel="tooltip"
																title="<spring:message code="sample.tooltip.into-panel" />">
																<i class="fa fa-trash fa-2x fa-fw" aria-hidden="true"></i>
															</button>
														</c:otherwise>


													</c:choose></td>
												<td class="text-center"><c:choose>
														<c:when test="${sample.test.finished == 1}">
															<div class="btn-group" role="group"
																aria-label="Basic example">
																<a data-placement="bottom" rel="tooltip" title="EXCEL"
																	href="<spring:url value="/or/sampleReport-${sample.id}?format=xlsx"/>"
																	target="_blank" class="btn btn-sm btn-outline-success "><i
																	class="fa fa-file-excel-o fa-2x fa-fw"
																	aria-hidden="true"></i></a> 
																<a data-placement="bottom"
																	rel="tooltip" title="PDF"
																	href="<spring:url value="/or/sampleReport-${sample.id}"/>"
																	target="_blank" class="btn btn-sm btn-outline-danger "><i
																	class="fa fa-file-pdf-o fa-2x fa-fw" aria-hidden="true"></i></a>
															</div>





														</c:when>

													</c:choose></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</c:when>
							<c:otherwise>
								<span class="lead text-danger"><spring:message
										code="samples.not-exist" /></span>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">
						<spring:message code="sample.delete.modal.title" />
					</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<p class="text-justify">
						<spring:message code="sample.delete.modal.body" />
					</p>
				</div>
				<div class="modal-footer">
					<a class="btn btn-danger btn-ok "> <spring:message
							code="sample.delete.modal.title" />
					</a>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../fragments/footer.jsp" />
	<jsp:include page="../fragments/js/jquery.jsp" />
	<jsp:include page="../fragments/js/bootstrap.jsp" />
	<script
		src="https://cdn.datatables.net/1.10.15/js/jquery.dataTables.min.js"></script>
	<script>window.jQuery || document.write(unescape('%3Cscript src="<spring:url value="/resources/js/datatable/jquery.dataTables.min.js"/>"%3E%3C/script%3E'))</script>
	<script
		src="https://cdn.datatables.net/1.10.15/js/dataTables.bootstrap4.min.js"></script>
	<script>window.jQuery || document.write(unescape('%3Cscript src="<spring:url value="/resources/js/datatable/dataTables.bootstrap4.min.js"/>"%3E%3C/script%3E'))</script>
	<script
		src="https://cdn.datatables.net/responsive/2.1.1/js/dataTables.responsive.min.js"></script>
	<script>window.jQuery || document.write(unescape('%3Cscript src="<spring:url value="/resources/js/datatable/dataTables.responsive.min.js" />"%3E%3C/script%3E'))</script>
	<script
		src="https://cdn.datatables.net/responsive/2.1.1/js/responsive.bootstrap4.min.js"></script>
	<script>window.jQuery || document.write(unescape('%3Cscript src="<spring:url value="/resources/js/datatable/responsive.bootstrap4.min.js" />"%3E%3C/script%3E'))</script>
	<script>
$('[data-toggle="modal"]').click(function(e) {
	e.preventDefault();
	
	 $($(this).data('target')).find('.btn-ok').attr('href', $(this).data('href'));  
	 $($(this).data('target')).modal('show'); 
	});




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

	
	  var order = [[0, 'desc']];

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