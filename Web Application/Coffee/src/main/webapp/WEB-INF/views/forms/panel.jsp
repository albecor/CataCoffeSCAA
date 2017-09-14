<%@ page session="true"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../fragments/title.jsp" />
<jsp:include page="../fragments/css/bootstrap.jsp" />
<jsp:include page="../fragments/css/footer.jsp" />
<jsp:include page="../fragments/css/fontAwesome.jsp" />
<jsp:include page="../fragments/css/animate.jsp" />
<link href="https://cdn.datatables.net/1.10.15/css/dataTables.bootstrap4.min.css" rel="stylesheet" />
<script>window.jQuery || document.write(unescape('%3Clink rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/datatable/dataTables.bootstrap4.min.css"/>" /%3E'));</script>
<link href="https://cdn.datatables.net/select/1.2.2/css/select.bootstrap4.min.css" rel="stylesheet" />
<script>window.jQuery || document.write(unescape('%3Clink rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/datatable/select.bootstrap4.min.css"/>" /%3E'));</script>
<link href="https://cdn.datatables.net/responsive/2.1.1/css/responsive.bootstrap4.min.css" rel="stylesheet" />
<script>window.jQuery || document.write(unescape('%3Clink rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/datatable/responsive.bootstrap4.min.css"/>" /%3E'));</script>
<link href="https://cdn.datatables.net/buttons/1.4.1/css/buttons.dataTables.min.css" rel="stylesheet" />
<script>window.jQuery || document.write(unescape('%3Clink rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/datatable/buttons.dataTables.min.css"/>" /%3E'));</script>
<link href="https://cdn.datatables.net/buttons/1.4.1/css/buttons.bootstrap4.min.css" rel="stylesheet" />
<script>window.jQuery || document.write(unescape('%3Clink rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/datatable/buttons.bootstrap4.min.css"/>" /%3E'));</script>
<style>
.hidden {
	display: none;
}
</style>
</head>
<body>
	<jsp:include page="../navbar.jsp" />
	<br />
	<c:choose>
		<c:when test="${empty panel.id}">
			<spring:url value="/or/new-panel" var="postActionUrl" />
		</c:when>
		<c:otherwise>
			<spring:url value="/or/update-panel-${panel.id}" var="postActionUrl" />
		</c:otherwise>
	</c:choose>
	<form:form method="POST" modelAttribute="event" class="form-horizontal" action="${postActionUrl}">
		<div class="container">
			<div class="card">
				<div class="card-header">
				
					<c:choose>
						<c:when test="${empty panel.id }">
							
								<strong><spring:message code="panel.title.create" /></strong>
							
							<a id="popover_info" tabindex="0" class="btn btn-lg btn-info btn-sm pull-right" data-html="true" role="button" data-toggle="popover" data-trigger="focus" title="<spring:message code="instructions" />" data-placement="left"
								data-content="<spring:message code="popover.panel.form"/>"><i class="fa fa-info" aria-hidden="true"></i></a>
						</c:when>
						<c:otherwise>
							<h5 class="card-title">
								<spring:message code="panel.title.update" />
							</h5>
						</c:otherwise>
					</c:choose>
				</div>
				<div id="step-1" class="card-block setup-content">
					<div class="alert alert-success" role="alert">
						<strong>1. </strong>
						<spring:message code="alert.panel.sample.add" />
					</div>
					<c:choose>
						<c:when test="${not empty samples}">
							<div class="col-12">
								<hr />
								<table id="tableSamples" class="table table-striped table-bordered dt-responsive nowrap" cellspacing="0" width="100%">
									<thead>
										<tr>
											<th><spring:message code="sample" /></th>
											<th><spring:message code="code" /></th>
											<th><spring:message code="form.sample.label.grower" /></th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${samples}" var="sample">
											<tr id="tr-sample-${sample.id}">
												<td>${sample.id}</td>
												<td>${sample.code}<input type="checkbox" autocomplete="off" value="${sample.id}" class="hidden" name="sampleId" id="sample-${sample.id}" /></td>
												<td>${sample.grower}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</c:when>
						<c:otherwise>
							<div class="col-12 text-center">
								<span class="lead text-danger"><spring:message code="samples.not-exist" /></span>
							</div>
						</c:otherwise>
					</c:choose>
					<hr />
					<button id="btnSamplesNext" class="btn btn-success nextBtn pull-right" type="button" disabled>
						<spring:message code="next" />
					</button>
				</div>
				<div class="card-block setup-content" id="step-2">
					<div class="alert alert-${cupsEmpty ? 'danger' : 'success'}" role="alert">
						<strong>2. </strong>
						<spring:message code="alert.panel.cups.add" />
					</div>
					<spring:bind path="cups">
						<div class="form-group  ${cupsEmpty ? 'has-danger' : ''}">
							<spring:message code="form.sample.placeholder.cups" var="placeholderCups" />
							<form:input autofocus="${cupsEmpty ? 'autofocus' : ''}" path="cups" id="cups" type="number" required="required" class="form-control form-control-feedback" placeholder="${placeholderCups}" />
							<form:errors path="cups" class="form-control-feedback" />
						</div>
					</spring:bind>
					<div class="row">
						<div class="col">
							<hr />
							<button class="btn btn-success prevBtn  float-left" type="button">
								<spring:message code="previous" />
							</button>
							<button id="btnCupsNext" class="btn btn-success nextBtn float-right" type="button" disabled>
								<spring:message code="next" />
							</button>
						</div>
					</div>
				</div>
				<div class="card-block setup-content" id="step-3">
					<div class="alert alert-success" id="emptyTaster" role="alert">
						<strong>3. </strong>
						<spring:message code="alert.panel.tasters.add" />
					</div>
					<c:choose>
						<c:when test="${not empty tasters}">
							<hr />
							<div class="text-center">
								<span class="lead "><spring:message code="tasters.list" /></span>
							</div>
							<table class="table table-striped table-bordered dt-responsive nowrap" cellspacing="0" width="100%" id="tasterTable">
								<thead>
									<tr>
										<th><spring:message code="user.id" /></th>
										<th><spring:message code="user.name" /></th>
										<th class="hidden-sm-down"><spring:message code="user.phone" /></th>
										 
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${tasters}" var="taster">
										<tr id="tr-taster-${taster.id}">
											<td>${taster.id}</td>
											<td>${taster.firstName}&nbsp;${taster.lastName}  <input type="checkbox" autocomplete="off" value="${taster.id}" class="hidden" name="tasterId" id="taster-${taster.id}" /></td>
											<td class="hidden-sm-down">${taster.phone}</td>
											
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</c:when>
						<c:otherwise>
							<div class="text-center">
								<span class="lead text-danger"><spring:message code="tasters.not-exist" /></span>
							</div>
						</c:otherwise>
					</c:choose>
					<hr />
					<button class="btn btn-success prevBtn  float-left" type="button">
						<spring:message code="previous" />
					</button>
					<button id="submit-panel" type="submit" class="btn float-right btn-success" disabled="disabled">
						<c:choose>
							<c:when test="${empty panel.id}">
								<spring:message code="panel.add" />
							</c:when>
							<c:otherwise>
								<spring:message code="panel.update" />
							</c:otherwise>
						</c:choose>
					</button>
					<hr />
				</div>
			</div>
		</div>
	</form:form>
	<jsp:include page="../fragments/footer.jsp" />
	<jsp:include page="../fragments/js/jquery.jsp" />
	<jsp:include page="../fragments/js/bootstrap.jsp" />
	<script src="https://cdn.datatables.net/1.10.15/js/jquery.dataTables.min.js"></script>
	<script>window.jQuery || document.write(unescape('%3Cscript src="<spring:url value="/resources/js/datatable/jquery.dataTables.min.js"/>"%3E%3C/script%3E'))</script>
	<script src="https://cdn.datatables.net/1.10.15/js/dataTables.bootstrap4.min.js"></script>
	<script>window.jQuery || document.write(unescape('%3Cscript src="<spring:url value="/resources/js/datatable/dataTables.bootstrap4.min.js"/>"%3E%3C/script%3E'))</script>
	<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
	<script>window.jQuery || document.write(unescape('%3Cscript src="<spring:url value="/resources/js/datatable/dataTables.select.min.js" />"%3E%3C/script%3E'))</script>
	<script src="https://cdn.datatables.net/responsive/2.1.1/js/dataTables.responsive.min.js"></script>
	<script>window.jQuery || document.write(unescape('%3Cscript src="<spring:url value="/resources/js/datatable/dataTables.responsive.min.js" />"%3E%3C/script%3E'))</script>
	<script src="https://cdn.datatables.net/responsive/2.1.1/js/responsive.bootstrap4.min.js"></script>
	<script>window.jQuery || document.write(unescape('%3Cscript src="<spring:url value="/resources/js/datatable/responsive.bootstrap4.min.js" />"%3E%3C/script%3E'))</script>
	<script src="https://cdn.datatables.net/buttons/1.4.1/js/dataTables.buttons.min.js"></script>
	<script>window.jQuery || document.write(unescape('%3Cscript src="<spring:url value="/resources/js/datatable/dataTables.buttons.min.js" />"%3E%3C/script%3E'))</script>
	<script src="https://cdn.datatables.net/buttons/1.4.1/js/buttons.bootstrap4.min.js"></script>
	<script>window.jQuery || document.write(unescape('%3Cscript src="<spring:url value="/resources/js/datatable/buttons.bootstrap4.min.js" />"%3E%3C/script%3E'))</script>
	<script>
$(document).ready(function() {


	
	// init popover and hidden when click in body
	$('#popover_info').popover('toggle');
	$(document).on('click', function(e) { 
	  $('[data-toggle="popover"]').each(function() {
	    //the 'is' for buttons that trigger popups
	    //the 'has' for icons within a button that triggers a popup
	    if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.popover').has(e.target).length === 0) {
	      $(this).popover('hide'); //.data('bs.popover').inState.click = false // fix for BS 3.3.6 
	    }

	  });
	});

// array de traducciones 
	var arrLang = new Array();
	arrLang['en'] = new Array();
	arrLang['es'] = new Array();	
	
	arrLang['es']['select_all'] ='Seleccionar todo';
	arrLang['en']['select_all'] ='Select all';
	arrLang['es']['select_none'] ='Nada';
	arrLang['en']['select_none'] ='None';

	var locale ='${pageContext.response.locale.language}';
	
// -- el boton siguiente se desactiva para cups cuando tenga un valor
	$('#cups').on('input', function(){		
		if($('#cups').val()==''){
			$('#btnCupsNext').prop("disabled", true);
			}else{
				$('#btnCupsNext').prop("disabled", false);
				}
	});

//612352605
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
	var columnDefs = [
	      {
	         'targets': 0,
	         'checkboxes': {
	            'selectRow': true
	         }
	      }
	   ];
	 var select = {
	      'style': 'multi'
	   }; 
	  var order = [[0, 'asc']];

//-------------------- TABLA PARA MUESTRAS --------------------------------
    var table1 = $('#tableSamples').DataTable( { 
    	 responsive: true, 
    	  dom: 'Bfrtip', 
    	
    	<c:if test="${pageContext.response.locale.language == 'es'}">
    	language: languageEs, 
    	</c:if>
    	'columnDefs': columnDefs,
    	   'select':select,
    	   'order': order,
    		    	  buttons: [ 
    		              {
    		                  text: arrLang[locale]['select_all'] ,
    		                  action: function () {
    		                      table1.rows().select();

    		                      table1.rows().every( function ( rowIdx, tableLoop, rowLoop ) {
    		                    	  var rows_selected =table1.row( rowIdx ).data()[0];
    		                    	  $('#sample-'+rows_selected).prop('checked', true);
    		                    	} );
    		                      
    		                  }
    		              },
    		              {
    		                  text: arrLang[locale]['select_none'] ,
    		                  action: function () {
    		                      table1.rows().deselect();
    		                      table1.rows().every( function ( rowIdx, tableLoop, rowLoop ) {
    		                    	  var rows_selected =table1.row( rowIdx ).data()[0];
    		                    	  $('#sample-'+rows_selected).prop('checked', false);
    		                    	} );
    		                  }
    		              }
    		          ]    	  
    } );
    table1
        .on( 'select', function ( e, dt, type, indexes ) {
        	var rows_selected =table1.row( indexes ).data()[0];
        	
        	$('#sample-'+rows_selected).prop('checked', true);
        	$('#btnSamplesNext').prop("disabled", false);
        	
        } )
        .on( 'deselect', function ( e, dt, type, indexes ) {
        	var rows_selected =table1.row( indexes ).data()[0];
        	
        	$('#sample-'+rows_selected).prop('checked', false);
        	if(table1.rows( '.selected' ).count() == 0){
        		$('#btnSamplesNext').prop("disabled", true);
            	}
        	
        } );


    var table2 = $('#tasterTable').DataTable( { 
    	 dom: 'Bfrtip',
    	<c:if test="${pageContext.response.locale.language == 'es'}">
    	    	 
    	language: languageEs, 
    	</c:if>
    	columnDefs: columnDefs,
    	select: select,
    	   order: order,    	   
	    	  buttons: [ 
	              {
	                  text: arrLang[locale]['select_all'] ,
	                  action: function () {
	                      table2.rows().select();
	                      table2.rows().every( function ( rowIdx, tableLoop, rowLoop ) {
	                    	  var rows_selected =table2.row( rowIdx ).data()[0];
	                    	  $('#taster-'+rows_selected).prop('checked', true);       
	                    	} );
	                      
	                  }
	              },
	              {
	                  text: arrLang[locale]['select_none'] ,
	                  action: function () {
	                      table2.rows().deselect();
	                      table2.rows().every( function ( rowIdx, tableLoop, rowLoop ) {
	                    	  var rows_selected =table2.row( rowIdx ).data()[0];
	                    	  $('#taster-'+rows_selected).prop('checked', false);  
	                    	} );
	                  }
	              }
	          ] 
    });

//----------------------- TABLA PARA CATADORES -------------------------
    table2
        .on( 'select', function ( e, dt, type, indexes ) {
        	var rows_selected =table2.row( indexes ).data()[0];

        	$('#taster-'+rows_selected).prop('checked', true);        	// checked el input para el catador seleccionada
				$('#submit-panel').prop("disabled", false);        	// activamos el boton de enviar panel
           
        } )
        .on( 'deselect', function ( e, dt, type, indexes ) {
        	var rows_selected =table2.row( indexes ).data()[0];
        	$('#taster-'+rows_selected).prop('checked', false);  // checked false el input para el catador deseleccionado

        	if(table2.rows( '.selected' ).count() == 0){
        		$('#submit-panel').prop("disabled", true); 	// desactivamos el boton de enviar el panel
            	}
        	
        	
           
        } );

//------------ PRECARGA DE DATOS ----------------------------
// se seleccionan los datos precargados cuando se actualiza el panel 
 
<c:if test="${not empty event.sampleId}">
$.each(${event.sampleId}, function( index, value ) {   
	$('#sample-'+value).prop('checked', true);  // checked el input 
	$('#btnSamplesNext').prop("disabled", false); // activamos el boton de siguiente para continuar

    for (var i = 0; i < table1.rows().count(); i++) {
        if(table1.row(i).data()[0] == value){
        	table1.row(i).select();            
            }    	 
	}	  
		
});
</c:if>


<c:if test="${not empty event.tasterId}">
$.each(${event.tasterId}, function( index, value ) {   
	$('#taster-'+value).prop('checked', true); // checked el input 
	$('#submit-panel').prop("disabled", false);  // activamos el boton de enviar el panel para continuar
	 for (var i = 0; i < table2.rows().count(); i++) {
	        if(table2.row(i).data()[0] == value){
	        	table2.row(i).select();            
	            }    	 
		}
});
</c:if>

<c:if test="${not empty event.cups}">
if($('#cups').val() != ''){ // cuando se definan las tazas
		$('#btnCupsNext').prop("disabled", false);  // activamos el boton de siguiente para continuar
	   }
</c:if>
 
//-------------------------- PRECARGA DE FORMULARIO PASO A PASO--------------------------
var navListItems = $('div.setup-panel div a'), allWells = $('.setup-content'), allNextBtn = $('.nextBtn'), allPrevBtn = $('.prevBtn');

allWells.hide();
$('#step-1').show();

allPrevBtn
		.click(function() {
			var curStep = $(this).closest(".setup-content"), 
				curStepBtn = curStep.attr("id"),
				prevStepWizard = $('#' + curStepBtn).prev();
			allWells.hide();
			prevStepWizard.show();
			prevStepWizard.addClass('animated fadeIn');
		});

allNextBtn.click(function() {

			var curStep = $(this).closest(".setup-content"), 
				curStepBtn = curStep.attr("id"), 
				nextStepWizard = $('#' + curStepBtn).next();		
				allWells.hide();
				nextStepWizard.show();
				nextStepWizard.addClass('animated fadeIn');
		});

} );
</script>
	<script>
$(document).ready(function() {
    $('a[data-toggle="tab"]').on( 'shown.bs.tab', function (e) {
        // var target = $(e.target).attr("href"); // activated tab
        // alert (target);
        $($.fn.dataTable.tables( true ) ).css('width', '100%');
        $($.fn.dataTable.tables( true ) ).DataTable().columns.adjust().draw();
    } ); 
});
</script>
	<%-- cargar de notificaciones si existen --%>
	<c:if test="${not empty notifyMesage}">
		<jsp:include page="../fragments/js/notify.jsp">
			<jsp:param name="notifyMesage" value="${notifyMesage}" />
			<jsp:param name="notifyType" value="${notifyType}" />
		</jsp:include>
	</c:if>
</body>
</html>