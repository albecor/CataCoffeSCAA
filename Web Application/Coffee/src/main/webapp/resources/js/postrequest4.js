// carga los datos almacenados de la prueba al iniciar
function init_attributes(cups) {
// Carga los datos como > [ 'fragrance', 'aroma',  'flavor', 'residualFlavor',  'acidity', 'body', 'balance', 'tasterScore']; -----------
	var arr = [ 'fragrance', 'aroma',  'flavor', 'residualFlavor',  'acidity', 'body', 'balance', 'tasterScore'];
	$.each( arr, function( index, value ){
		$('input[name="'+value+'"][value="'+Number($('input[id="'+value+'"]').val())+'"]').prop('checked',true);
		$('input[name="'+value+'"][value="'+Number($('input[id="'+value+'"]').val())+'"]').parent().addClass('active').attr('aria-pressed', 'true');
	});

	
// Carga los datos como >  ['uniformity','cleanCup','sweetness'];	 ----------------------------------
	var arr_checkbox = ['uniformity','cleanCup','sweetness'];
	$.each( arr_checkbox, function( index, attribute ){		
		set_checkboxes(attribute, cups, true);		
	});
	
	
// carga los defectos de tazas  -----------------------------------------------------------------------
	var defectOrder = $('#defectOrder').val();
	
	if(defectOrder != ''){		
		for (var i = 0; i < cups; i++) {
			 var ss = $('input[id="defect-'+(i+1)+'-0"]');
			 ss.prop('checked',false);
			 ss.parent().removeClass('active').attr('aria-pressed', 'false');
		}
	
		for (var i = 0, len = defectOrder.length; i < len; i++) {
			 var ss = $('input[id="defect-'+(i+1)+'-'+defectOrder[i]+'"]');
			 ss.prop('checked',true);
			 ss.parent().addClass('active').attr('aria-pressed', 'true');
			}		
	} else{
	/*	for (var i = 0; i < cups; i++) {
			 var ss = $('input[id="defect-'+(i+1)+'-0"]');
			 ss.prop('checked',false);
			 ss.parent().addClass('active').attr('aria-pressed', 'true');
		}*/
	}
	
	  if(defectOrder.length == cups){	    	
	    	 $('#defect_warning').html('');
	    	 
	     }
	
}

// carga los attributos como > ['uniformity','cleanCup','sweetness'] -----------------------------------------
// en tiempo real y al iniciar la prueba
function set_checkboxes(attribute, cups, init ){
	
	var option_select = $('input[name="'+attribute+'"]:checked').val();

	
	var value = $('#'+attribute).val();
	var selected_cups, mi_select = '';

	if($.isNumeric(value)){
		value = Number(value);		
		if(value == 10){
			selected_cups = 0;			
			mi_select = 'yes';
			$('#hidden-'+attribute).hide();
		}else {
			mi_select = 'no';
			selected_cups = cups - Math.ceil(value*cups/10);
			$('#hidden-'+attribute).show();
			$('#hidden-'+attribute).addClass('animated fadeIn');			
		}		
	}else {
		if(option_select == 'no'){
			mi_select = 'no';
			$('#hidden-'+attribute).show();
			$('#hidden-'+attribute).addClass('animated fadeIn');
		} else{			
			$('#hidden-'+attribute).hide();
		}		
	}
	
	if(init){	
	$('#'+ mi_select+'-'+ attribute).prop('checked',true);
	$('#'+ mi_select+'-'+ attribute).parent().addClass('active').attr('aria-pressed', 'true');
	}
	 
	if(selected_cups == 0){		
		for (var i = 0; i < cups; i++) {
			 var checkbox = $('input[id="'+attribute+'-'+(i+1)+'"]');
			 checkbox.prop('checked',true);
			 var widget = checkbox.closest('.button-checkbox');
			 var button = widget.find('button');
			
			 encaje(widget, checkbox, button);
		}
		
	} else{
		for (var i = 0; i < selected_cups; i++) {
			 var checkbox = $('input[id="'+attribute+'-'+(i+1)+'"]');
			 var widget = checkbox.closest('.button-checkbox');
			 var button = widget.find('button');			
			encaje(widget, checkbox, button);
		}
	}
	 //$('#data-'+attribute).html(value);
	
}



// vector de datos con traduccion para español e inglés
function i18nData(){
	var arrLang = new Array();
	arrLang['en'] = new Array();
	arrLang['es'] = new Array();	
	
	arrLang['es']['alert_below_specialty_quality'] ='<div class="alert alert-danger" role="alert"><strong>No especial!</strong> Caf\u00e9 por debajo de la calidad de especial.</div>';
	arrLang['en']['alert_below_specialty_quality'] ='<div class="alert alert-danger" role="alert"><strong>Not Specialty!</strong> Below specialty quality.</div>';
	arrLang['es']['alert_very_good_quality'] ='<div class="alert alert-warning" role="alert"><strong>Especial!</strong> Muy buen caf\u00e9.</div>';
	arrLang['en']['alert_very_good_quality'] ='<div class="alert alert-warning" role="alert"><strong>Specialty!</strong> Very Good coffee.</div>';
	arrLang['es']['alert_excellent_quality'] ='<div class="alert alert-info" role="alert"><strong>Especial!</strong> Caf\u00e9 excelente.</div>';
	arrLang['en']['alert_excellent_quality'] ='<div class="alert alert-info" role="alert"><strong>Specialty!</strong> Excellent coffee.</div>';
	arrLang['es']['alert_outstanding_quality'] ='<div class="alert alert-success" role="alert"><strong>Especial!</strong> Caf\u00e9 excepcional</div>';
	arrLang['en']['alert_outstanding_quality'] ='<div class="alert alert-success" role="alert"><strong>Specialty!</strong> Outstanding coffee.</div>';

	return arrLang;
}

// formatea el dato si es numero 
function formatNumber(number){	
	
	if($.isNumeric(number)){
		number = Number(number);
	}	
	return number;
}

// establece las opciones almacenadas al cargar los datos como >  ['uniformity','cleanCup','sweetness'];	 ----------------------------------
function encaje (widgets, checkboxs, buttons){


	// Settings
	var $widget = widgets,
	    $button = buttons,
	    $checkbox = checkboxs,
	    color = $button.data('color'),
	    settings = {
	        on: {
	            icon: 'fa fa-times fa-2x'
	        },
	        off: {
	            icon: 'fa fa-coffee fa-2x'
	        }
	    };
	

    // Actions
    function updateDisplay() {
        var isChecked = $checkbox.is(':checked');

        // Set the button's state
        $button.data('state', (isChecked) ? "on" : "off");


        // Set the button's icon
        $button.find('.state-icon').removeClass().addClass('state-icon ' + settings[$button.data('state')].icon);

        // Update the button's color
        if (isChecked) {
            $button.removeClass('btn-success').addClass('btn-' + color + ' active');
        }
        else {
            $button.removeClass('btn-' + color + ' active').addClass('btn-success');
        }
    }
    
    // Initialization
    function init() {	        	
        updateDisplay();
        // Inject the icon if applicable
        if ($button.find('.state-icon').length == 0) {
            $button.prepend('<i class="state-icon ' + settings[$button.data('state')].icon + '"></i>');
        }	        	
    }
    
    $checkbox.prop('checked', !$checkbox.is(':checked'));	        	
    $checkbox.triggerHandler('change');
    init(); 
 
}

// crea el objecto de datos enviado al servidor --------------------------------------------
function data() {

	var test_id = $('input[id="id"]').val(); 		
 	var formData = { 
 			fragrance ,
 			aroma ,  
 			flavor ,
 			residualFlavor , 	
 			acidity ,
 			body,
 			uniformity, 
 			balance,
 			cleanCup, 	
 			sweetness, 
 			defect, 	
 			defectOrder,
 			attributes,
  			tasterScore,
 			totalScore : 0, 
 			notes , 	
 			cups,
 			finished : 0,
 			id : test_id
    	}
 	
 	formData['finished']= $('#finished').val();
 	var optionsAttribute = $('select[name="attributes"]').val(); 
 	var optionsDefects = $('select[name="attributes1"]').val();
 	

 
 	var summary_attributes = '<ul>';
 	jQuery.each( optionsAttribute, function( i, val ) {
 		summary_attributes += '<li>'+$('#attributes option[value="'+val+'"]').text()+'</li>';
 	});
 	summary_attributes += '</ul> ';
 	$('#summary-attributes_lexic').html(summary_attributes);
 	
 	var summary_defects = '<ul>';
 	jQuery.each( optionsDefects, function( i, val ) {
 		summary_defects += '<li>'+$('#attributes1 option[value="'+val+'"]').text()+'</li>';
 	});
 	summary_defects += '</ul>';
 	$('#summary-defects_lexic').html(summary_defects);
 	
 	

	jQuery.each( formData, function( i, val ) {
		
		var value = $('#'+i).val();
		
		if(i == 'notes' || i == 'defectOrder'){
			formData[i] = value;			
		} else if (i == 'attributes'){

			
		 	  
		 	var atributes = [];
		 	for (var k = 0; k < optionsAttribute.length; k++) {
		 		atributes.push({
		 	        id: optionsAttribute[k]
		 	    });
		 	}	 
		 		
		 	for (var k = 0; k < optionsDefects.length; k++) {
		 		atributes.push({
		 	        id: optionsDefects[k]
		 	    });
		 	}	
		 	
		 	formData[i] = atributes;		
			
		}else if( i == 'totalScore'){
			// no hace nada
		}else{
			formData[i] = formatNumber(value);
		}	 
	});
 //	alert(JSON.stringify(formData));
 	
 	/*
 	fragrance ,
		aroma ,  
		flavor ,
		residualFlavor , 	
		acidity ,
		body,
		uniformity, 
		balance,
		cleanCup, 	
		sweetness, 
		defect, 	
		defectOrder,
		attributes,
		tasterScore,
		totalScore, 
		notes , 	
		cups,
		finished,
		id : test_id*/
 	//alert(JSON.stringify(formData));

	
 	jQuery.each( formData, function( i, val ) {

 		
 		
 		$('#data-'+i).html(val);
 		if(i == 'id' || i == 'finished' || i == 'cups' || i == 'totalScore' || i == 'defectOrder'){
 			// no sumar
 		}else if(i ==  'notes'){
 			$('#summary-notes').html(val);			
 			
 		}else if($.isNumeric(val)){
 			
 		
 			 if (i == 'defect'){
 	 			
 				 formData['totalScore'] -= val;
 	 			$('#summary-'+i).html('- '+val);	
 	 		
 			 }else {	 		
 	 			
 	 			if(i == 'aroma' || i == 'fragrance'){
 	 				formData['totalScore'] += val/2; 	 			
 	 				$('#summary-'+i).html('+ '+val +'/2'); 	 				
 	 			}else{ 	 			
 	 				formData['totalScore'] += val; 	 	
 	 				$('#summary-'+i).html('+ '+val );
 	 			}
 	 			
 	 		}	
 		}
 		
 	});
 	
 	
 	
 	
 	
 	
	var totalScore = formData['totalScore'];
 	
	$("#summary-totalScore").html(totalScore);	
	
	// i18n
	var arrLang = i18nData();
	// locale de acuerdo a spring
	var locale = $('#locale').val();
	
	if(totalScore<80){	    		
		$('#final_score').html(arrLang[locale]['alert_below_specialty_quality']);
	}else if(totalScore>=80 && totalScore<=84.99){	    		
		$('#final_score').html(arrLang[locale]['alert_very_good_quality']);
	}else if(totalScore>=85 && totalScore<=89.99){	    		
		$('#final_score').html(arrLang[locale]['alert_excellent_quality']);
	}else if(totalScore>=90 && totalScore<=100){	    		
		$('#final_score').html(arrLang[locale]['alert_outstanding_quality']);
	}
	
 	// var totalScore = (fragrance/2 + aroma/2 + flavor + residualFlavor +
	// acidity + body + uniformity + balance + cleanCup + sweetness - defect +
	// tasterScore);
 /*	var finished = 0;
 	if(
 			( !isNaN(fragrance)) && 
 			( !isNaN(aroma) ) && 
 			( !isNaN(flavor) ) && 
 			( !isNaN(residualFlavor) ) && 
 			( !isNaN(acidity) ) && 
 			( !isNaN(body) ) && 
 			( !isNaN(uniformity) ) && 
 			( !isNaN(balance) ) && 
 			( !isNaN(cleanCup)) && 
 			( !isNaN(sweetness) ) && 
 			( !isNaN(defect) ) && 
 			( !isNaN(tasterScore) )
 	)
 	{
 		// finished = 1;
 	}
 	
 

 	$("#data-fragrance").html( fragrance );
	$("#data-aroma").html( aroma );
	$("#data-flavor").html( flavor );
	$("#data-residualFlavor").html( residualFlavor );
	$("#data-acidity").html( acidity );
	$("#data-body").html( body );
	$("#data-uniformity").html( uniformity );
	$("#data-balance").html( balance );
	$("#data-cleanCup").html( cleanCup );
	$("#data-sweetness").html( sweetness );
	$("#data-defect").html( defect );
	$("#data-tasterScore").html( tasterScore );
	$("#data-totalScore").html( totalScore );

	*/
	
    return formData;
}


// comprueba todos los valores para terminar la prueba
function done_button(){	
	
	
	var allright = true;

	var sdata = data();
	var arr = [ 'fragrance', 'aroma',  'flavor', 'residualFlavor',  'acidity', 'body', 'balance', 'tasterScore', 'uniformity','cleanCup','sweetness','defect'];
	$.each( arr, function( index, attribute ){
		condition($.isNumeric(sdata[attribute]) , attribute, true);
	});	
	
	condition((sdata['notes'] != '') , 'notes', true);
	
	//alert($('#select_menu option[value="#content-fragrance"]').text());
	condition(($('select[name="attributes"]').val() != '') , 'attributes_lexic', false);
	condition(($('select[name="attributes1"]').val() != '') , 'defects_lexic', false);

	
	if(allright){
		$('#content-finished').show();
	}else {
		$('#content-finished').hide();
	}
	
/* recibe la condicion para validar si todo es completado
*	state : si es true, checkea como dato validado
*	attribute : atributo a se validado
*	set_allright: define si se quiere validad la variable allright, true cuando se quiere vaidar y false si no se quiere validar, para los atributos
*	del lexico se coloca a false por que no se necesitan para terminar la prueba
*/	
	function condition (state, attribute,set_allright){
		
		if(state){	
			($('#href-content-'+ attribute).find('i')).addClass('fa-check-square-o');
		}else {
			($('#href-content-'+ attribute).find('i')).removeClass('fa-check-square-o');
			if(set_allright){
				allright = false;
			}
			
		}
		
		
		var content = $('#select_menu option[value="#content-'+attribute+'"]');
		var datar;
		if(attribute == 'residualFlavor'){
			datar = content.data('residualflavor');
		}else if (attribute == 'cleanCup'){
			datar = content.data('cleancup');
		}else if (attribute == 'tasterScore'){
			datar = content.data('tasterscore');
		}else{
			datar = content.data(attribute);
		}

		if(state){	
			content.html("&#x2713; "+datar );
		}else {
			content.html(datar );			
		}
		
		
	}


}



$( document ).ready(function() {
	// cambia el color del boton de la muestra que esta seleccionada para catar
	$('#url_test_'+$('input[name="id"]').val()).removeClass('btn-secondary').addClass('btn-success');
	
	// numero de tazas
	var cups = Number($('#cups').val());
	// inicializa todos los valores de la prueba
	init_attributes(cups);	
	done_button(data());
	//done_button();

	
    
	// cambia el tamaño de los botones de los defectos de acuerdo al tamaño de
	// pantalla
	var mediaquery = window.matchMedia("(max-width: 575px)");
	function handleOrientationChange(mediaquery) {
	  if (mediaquery.matches) {
	  	$('#radio_defects label').addClass('btn-sm');
	  } else {
		  $('#radio_defects label').removeClass('btn-sm');			    	
	  }
	}
	handleOrientationChange(mediaquery);
	mediaquery.addListener(handleOrientationChange);

	var navListItems = $('div.setup-panel a');
	var allWells = $('.setup-content');
	
	allWells.hide();
	$('#content-fragrance').show();
	 
	navListItems.click(function(e) {
		e.preventDefault();
		var $target = $($(this).attr('href')), $item = $(this);
		if (!$item.hasClass('disabled')) {
			navListItems.removeClass('btn-primary').addClass('btn-default');
			$item.addClass('btn-primary').removeClass('btn-default');
			allWells.hide();		
			$target.show();
			$target.addClass('animated pulse');
			
			//done_button();
			
			}
	});

	$('#reject').click(function(e) {
		allWells.hide();
		$('#content-reject').show();
		$('#content-reject').addClass('animated pulse');
	});

// scroll cuando e cambia el item
	$('#select_menu').change(function() {				
	    allWells.hide();
		$(this.value).show();	
		  $('html, body').animate({
		      scrollTop: $(this.value).offset().top
		    }, 500);			   
	});
			

	$('select[name="attributes"]').on('change', function(){
		var mi_data = data();		
		ajaxPost(mi_data);
		done_button(mi_data);
	  });
	
	$('select[name="attributes1"]').on('change', function(){
		var mi_data = data();		
		ajaxPost(mi_data);
		done_button(mi_data);
	  });
    	
	 
	
	/*
	$('#attributes').mousedown(function(e){
	    e.preventDefault();
	    
		var select = this;
	    var scroll = select.scrollTop;
	    alert($(this).attr('id'));
	    e.target.selected = !e.target.selected;
	    
	    setTimeout(function(){select.scrollTop = scroll;}, 0);
	    
	    $(select).focus();	    
	  	
	    var mi_data = data();		
		ajaxPost(mi_data);
		done_button(mi_data);
	}).mousemove(function(e){e.preventDefault()});
	
	*/
	    // opcion seleccionada con un click y se hace post
	$('option').mousedown(function(e) {
		    e.preventDefault();
		   
		    var nombre = $(this).parent().parent().attr('id');
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
		    var mi_data = data();		
			ajaxPost(mi_data);
			done_button(mi_data);
			return false;
		    
		}).mousemove(function(e){e.preventDefault()});
		
		// input seleccionado y se hace post
		$('.defect_pulse').change(function(e){
			e.preventDefault();	
	 	
		 	 var defect=0;
		 	 var defectOrder = '';
		     for (var i = 1; i <= cups; i++) {		    	
		     	var ka = $('input[name="defect-'+i+'"]:checked').val();
		     	if(ka != undefined ){
		     		defect+= Number(ka);
		     		defectOrder+= ka;
		     	}	
		 	}

		     if(defectOrder.length == cups){
		    	 $('#defect').val(defect);
		    	 $('#defect_warning').html('');
		    	 
		     }
				
				$('#data-defect').html(defect);
				$('#defectOrder').val(defectOrder);
				
				var mi_data = data();		
				ajaxPost(mi_data);
				done_button(mi_data);
		});
		
	
		
		
		 // permite rechazar la muestra y terminar la prueba
		$('#button-finish-test').click(function(e){
			e.preventDefault();	
			$('#finished').val(1);
			ajaxPost(data());

			setTimeout(function() {
				window.location.href = $('#urlservename').val() + 'ta/panel-test-'+ $('#panel_id').val();
			}, 1000);
			

		});
		
	    // input seleccionado y se hace post
		$('input.direct-post:radio').change(function(e){
			e.preventDefault();	
			var value = $(this).val(),	name = $(this).attr('name');			
			$('#'+name).val(value);			
			var mi_data = data();		
			ajaxPost(mi_data);
			done_button(mi_data);
		});
		
		 // input seleccionado y se hace post
		$('input.conditional-post:radio').change(function(e){
			e.preventDefault();	
			var	name = $(this).attr('name'), option = $(this).val();	
			if(option == 'yes'){
				$('#'+name).val(10);
			}else if (option == 'no'){
				$('#'+name).val('');
			}
			set_checkboxes(name, cups, false);	
			
			var mi_data = data();		
			ajaxPost(mi_data);
			done_button(mi_data);
		});
		
		 // permite rechazar la muestra y terminar la prueba
		$('#reject_sample').click(function(e){
			e.preventDefault();		
			// recoge los valores basicos para terminar la prueba
			var cups = Number($('input[name="cups"]').val());    	
		 	var test_id = $('input[name="id"]').val(); 		
		 	var notes = $('textarea[name="reject_notes"]').val(); 			
		 	var finished = 1;
		 	
		 	var formData = {	     			
		 			notes : notes,	     			
		 			cups : cups,
		 			finished : finished,
		 			id : test_id
		    	}
		 	
	
		 	
		 	ajaxPost(formData);
		 	setTimeout(function() {
				window.location.href = $('#urlservename').val() + 'ta/panel-test-'+ $('#panel_id').val();
			}, 1000);
			
		 	

		});
		
		 // recoge todos los input
		$('#add_notes').click(function(e){
			e.preventDefault();		
			var mi_data = data();		
			ajaxPost(mi_data);
			done_button(mi_data);
		});		
		
	
    function ajaxPost(form){  
    	
    	var url = $('#urlservename').val();
    	// DO POST
    	$.ajax({
			type : "POST",
			contentType : "application/json",
			url : url + "postcustomer2",
			data : JSON.stringify(form),
			dataType : 'json',
			success : function(result) {
				if(result.status == "Done"){
					$("#postResultDiv").html("<strong>" + "Post Successfully! Customer's Info: aroma = " 
							+JSON.stringify( result.data) + " ,flavor = " + result.data.flavor + " ,flavor = "+ result.data.fragrance+"</strong>");
				}else{
					$("#postResultDiv").html("<strong>Error</strong>");
				}
				console.log(result);
			},
			error : function(e) {
				alert("Error!")
				console.log("ERROR: ", e);
			}
		});
  
  }
    
    
    

    $('.button-checkbox').each(function () {

    	// Settings
    	var $widget = $(this),
    	    $button = $widget.find('button'),
    	    $checkbox = $widget.find('input:checkbox'),
    	    color = $button.data('color'),
    	    settings = {
    	        on: {
    	            icon: 'fa fa-times fa-2x'
    	        },
    	        off: {
    	            icon: 'fa fa-coffee fa-2x'
    	        }
    	    };
    	
    	
    	
        // Event Handlers
        $button.on('click', function () {
       
            $checkbox.prop('checked', !$checkbox.is(':checked'));	        	
            $checkbox.triggerHandler('change');
            updateDisplay();
            
         	var cups = Number($('input[name="cups"]').val());
         	var value = Number((cups -  $('input[type="checkbox"][name="'+$checkbox.attr('name')+'"]:checked').length)*10/cups);
         	//--------------------------
        // 	 $('#data-'+$checkbox.attr('name')).html(value);
        	$('#'+$checkbox.attr('name')).val(value);
        	var mi_data = data();		
    		ajaxPost(mi_data);
    		done_button(mi_data);

        });

        // Actions
        function updateDisplay() {
            var isChecked = $checkbox.is(':checked');

            // Set the button's state
            $button.data('state', (isChecked) ? "on" : "off");


            // Set the button's icon
            $button.find('.state-icon').removeClass().addClass('state-icon ' + settings[$button.data('state')].icon);

            // Update the button's color
            if (isChecked) {
                $button.removeClass('btn-success').addClass('btn-' + color + ' active');
            }
            else {
                $button.removeClass('btn-' + color + ' active').addClass('btn-success');
            }
        }
        
        // Initialization
        function init() {	        	
            updateDisplay();
            // Inject the icon if applicable
            if ($button.find('.state-icon').length == 0) {
                $button.prepend('<i class="state-icon ' + settings[$button.data('state')].icon + '"></i>');
            }	        	
        }
        init();   
    });	  
    

    /* 
    function data_reject() {
    	
    	var cups = Number($('input[name="cups"]').val());    	
     	var test_id = $('input[name="id"]').val(); 		
     	var notes = $('textarea[name="reject_notes"]').val(); 			
     	var finished = 1;
     	
     	var formData = {	     			
     			notes : notes,	     			
     			cups : cups,
     			finished : finished,
     			id : test_id
        	}
     	
        return formData;
    }
    */
    

	
	

	/*
	 * var total=0;
	 * 
	 * $("input[type='text']").each(function() { total += parseInt(this.value,
	 * 10); });
	 */
	// create defect
   /* var defect=0;
    for (var i = 1; i <= cups; i++) {		    	
    	var ka = $('input[name="defect-'+i+'"]:checked').val();
    	if(ka != undefined ){
    		defect+= Number(ka);
    	}	
	}*/
    
  /*
	 * // create json attribute list var optionsAttribute =
	 * $('select[name="attributes"]').val();
	 * 
	 * var atributes = []; for (var i = 0; i < optionsAttribute.length; i++) {
	 * atributes.push({ id: optionsAttribute[i] }); } var optionsDefects =
	 * $('select[name="attributes1"]').val(); for (var i = 0; i <
	 * optionsDefects.length; i++) { atributes.push({ id:
	 * optionsDefects[i] }); }
	 */
 	
 
/*
 * 
 * var formData = { fragrance : '', aroma : '', flavor : '', residualFlavor :
 * '', acidity : '', body : '', uniformity : '', balance : '', cleanCup : '',
 * sweetness : '', defect : '', aroma : '', tasterScore : '', totalScore : '',
 * notes : '', attributes : [], cups : '', finished : '', id : test_id }
 * 
 * 
 * 
 */
 	
/*
 * var formData = { fragrance : fragrance, aroma : aroma, flavor : flavor,
 * residualFlavor : residualFlavor, acidity : acidity, body : body, uniformity :
 * uniformity, balance : balance, cleanCup : cleanCup, sweetness : sweetness,
 * defect : defect, aroma : aroma, tasterScore : tasterScore, totalScore :
 * totalScore, notes : notes, attributes : atributes, cups : cups, finished :
 * finished, id : test_id }
 */
	
	/*
						 * var d = data(); var deco =
						 * $($item.attr('href')).find('input[type="hidden"]').val();
						 * if(deco == ''){ alert(deco); }
						 * 
						 */

	// alert(JSON.stringify(sdata));
	// var saca = $($item.attr('href')).find('input[type="hidden"]').attr('id');
	// $('#href-content-'+value).data('clickDado', true);
	// alert($('setup-panel a[hre="#content-'+value+'"]').attr('href'));
	// alert(d[value]);
	// $item.addClass('btn-primary').removeClass('btn-default');

	// alert($('#href-content-fragrance').data('clickDado'));
	
    
    
	/*
	 * // recoge todos los input $('select').change(function(e){
	 * e.preventDefault(); var formdata = data($(this).closest("form"));
	 * ajaxPost(formdata); });
	 */
	 // recoge todos los input
/*
 * $('select[name="attributes"]').change(function(e){ e.preventDefault(); var
 * formdata = data($(this).closest("form")); ajaxPost(formdata); }); // recoge
 * todos los input $('select[name="attributes1"]').change(function(e){
 * e.preventDefault(); var formdata = data($(this).closest("form"));
 * ajaxPost(formdata); });
 */
// SUBMIT FORM
/*
 * $('form').on('submit', function (e) { // Prevent the form from submitting via
 * the browser. e.preventDefault(); ajaxPost($(this)); });
 */
    
	// var totalScore = (fragrance/2 + aroma/2 + flavor + residualFlavor +
	// acidity + body + uniformity + balance + cleanCup + sweetness - defect +
	// tasterScore);
 	
    
    /*
	 * var cups = Number($('input[name="cups"]').val()); var uniformity =
	 * Number((cups -
	 * $('input[name="checkbox-uniformity"]:checked').length)*10/cups); var
	 * sweetness = Number((cups -
	 * $('input[name="checkbox-sweetness"]:checked').length)*10/cups); var
	 * cleanCup = Number((cups -
	 * $('input[name="checkbox-cleanCup"]:checked').length)*10/cups); var
	 * fragrance =Number( $('input[name="fragrance"]:checked').val()); var aroma =
	 * Number($('input[name="aroma"]:checked').val()); var flavor =
	 * Number($('input[name="flavor"]:checked').val()); var residualFlavor =
	 * Number($('input[name="residualFlavor"]:checked').val()); var acidity =
	 * Number($('input[name="acidity"]:checked').val()); var body =
	 * Number($('input[name="body"]:checked').val()); var balance =
	 * Number($('input[name="balance"]:checked').val()); var tasterScore =
	 * Number($('input[name="tasterScore"]:checked').val()); var test_id =
	 * $('input[name="id"]').val(); var notes =
	 * $('textarea[name="notes"]').val(); //var test_id =
	 * (form.closest("form").attr('id').split('-'))[1];
	 * 
	 * 
	 *  // create defect var defect=0; for (var i = 1; i <= cups; i++) { var ka =
	 * $('input[name="defect-'+i+'"]:checked').val(); if(ka != undefined ){
	 * defect+= Number(ka); } }
	 *  // create json attribute list var optionsAttribute =
	 * $('select[name="attributes"]').val();
	 * 
	 * var atributes = []; for (var i = 0; i < optionsAttribute.length; i++) {
	 * atributes.push({ id: optionsAttribute[i] }); } var optionsDefects =
	 * $('select[name="attributes1"]').val(); for (var i = 0; i <
	 * optionsDefects.length; i++) { atributes.push({ id:
	 * optionsDefects[i] }); }
	 */
	
	
	
    /*
	 * 
	 * 
	 * var cups = $('input[id="cups"]').val(); var uniformity =
	 * $('input[id="uniformity"]').val(); var sweetness =
	 * $('input[id="sweetness"]').val(); var cleanCup =
	 * $('input[id="cleanCup"]').val(); var fragrance =
	 * $('input[id="fragrance"]').val(); var aroma =
	 * $('input[id="aroma"]').val(); var flavor = $('input[id="flavor"]').val();
	 * var residualFlavor = $('input[id="residualFlavor"]').val(); var acidity =
	 * $('input[id="acidity"]').val(); var body = $('input[id="body"]').val();
	 * var balance = $('input[id="balance"]').val(); var tasterScore =
	 * $('input[id="tasterScore"]').val(); var test_id =
	 * $('input[id="id"]').val(); var balance = $('input[id="balance"]').val();
	 * var totalScore = $('input[id="balance"]').val(); var attributes =
	 * $('input[id="balance"]').val(); var finished =
	 * $('input[id="balance"]').val(); var notes =
	 * $('textarea[id="notes"]').val();
	 * 
	 * var formData = { fragrance : fragrance, aroma : aroma, flavor : flavor,
	 * residualFlavor : residualFlavor, acidity : acidity, body : body,
	 * uniformity : uniformity, balance : balance, cleanCup : cleanCup,
	 * sweetness : sweetness, defect : defect, aroma : aroma, tasterScore :
	 * tasterScore, totalScore : totalScore, notes : notes, attributes :
	 * attributes, cups : cups, finished : finished, id : test_id }
	 * 
	 * $('#mirar').html(JSON.stringify(formData));
	 * 
	 * 
	 */
    
	
	/*
	 * var cups = Number($('input[name="cups"]').val()); var uniformity =
	 * Number((cups -
	 * $('input[name="checkbox-uniformity"]:checked').length)*10/cups); var
	 * sweetness = Number((cups -
	 * $('input[name="checkbox-sweetness"]:checked').length)*10/cups); var
	 * cleanCup = Number((cups -
	 * $('input[name="checkbox-cleanCup"]:checked').length)*10/cups); var
	 * fragrance =formatNumber( $('input[id="fragrance"]').val()); var aroma =
	 * formatNumber($('input[id="aroma"]').val()); var flavor =
	 * formatNumber($('input[id="flavor"]').val()); var residualFlavor =
	 * formatNumber($('[id="residualFlavor"]').val()); var acidity =
	 * formatNumber($('input[id="acidity"]').val()); var body =
	 * formatNumber($('input[id="body"]').val()); var balance =
	 * formatNumber($('input[id="balance"]').val()); var tasterScore =
	 * formatNumber($('input[id="tasterScore"]').val()); var test_id =
	 * $('input[id="id"]').val(); var notes = $('textarea[name="notes"]').val();
	 */
     
})