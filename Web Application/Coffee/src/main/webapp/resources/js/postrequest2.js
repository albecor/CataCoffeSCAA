// carga los datos almacenados de la prueba al iniciar
function init_attributes(cups) {
// Carga los datos como > [ 'fragrance', 'aroma',  'flavor', 'residualFlavor',  'acidity', 'body', 'balance', 'tasterScore']; -----------
	var arr = [ 'fragrance', 'aroma',  'flavor', 'residualFlavor',  'acidity', 'body',  'tasterScore', 'balance'];
	$.each( arr, function( index, value ){
		$('input[name="'+value+'"][value="'+Number($('input[id="'+value+'"]').val())+'"]').prop('checked',true);
		$('input[name="'+value+'"][value="'+Number($('input[id="'+value+'"]').val())+'"]').parent().addClass('active').attr('aria-pressed', 'true');
	});

	
// Carga los datos como >  ['uniformity','cleanCup','sweetness'];	 ----------------------------------
	var arr_checkbox = ['uniformity','cleanCup','sweetness' ];
	$.each( arr_checkbox, function( index, attribute ){		
		set_checkboxes(attribute, cups, true);		
	});
	
	
// carga los defectos de tazas  -----------------------------------------------------------------------
	var defectOrder = $('#defectOrder').val();
	
	if(defectOrder != ''){
	var m =	(/^(.)\1+$/.test(defectOrder) ? true : false);
		if(m){
$('#hidden-defect-one').hide();
			var ka = $('#yes-defect');
			 ka.prop('checked',true);
			 ka.parent().addClass('active').attr('aria-pressed', 'true');
	     	
			
			 var ss = $('input[id="defect-'+defectOrder.charAt(0)+'"]');
			 ss.prop('checked',true);
			 ss.parent().addClass('active').attr('aria-pressed', 'true');
	     	
		}else{		 
			$('#hidden-defect-all').hide();
			var ka = $('#no-defect');
			 ka.prop('checked',true);
			 ka.parent().addClass('active').attr('aria-pressed', 'true');
	     	 
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
		}
		
		
	} else{
		$('#hidden-defect-one').hide();
		var ka = $('#yes-defect');
		 ka.prop('checked',true);
		 ka.parent().addClass('active').attr('aria-pressed', 'true');
     	
	}
	

	  
	  bloquear_radios('fragrance','aroma');
	  bloquear_radios('flavor','residualFlavor');
	  
	  
	
}




function set_all_checkboxes(valor, orden, attributevigente, option){
	
	//Carga los datos como >  ['uniformity','cleanCup','sweetness'];	 ----------------------------------
	var arr_checkbox = ['uniformity','cleanCup'];

	$.each( arr_checkbox, function( index, attribute ){		
		
		if(attributevigente != attribute ){
			var cups = Number($('#cups').val()); 
			for (var i = 0; i < cups; i++) {

				 var checkbox = $('input[id="'+attribute+'-'+(i+1)+'"]');
				 checkbox.prop('checked',true);
				 var widget = checkbox.closest('.button-checkbox');
				 var button = widget.find('button');
				
				 encaje(widget, checkbox, button);
			} 
			
			if(option == 'yes'){
				$('#no-'+ attribute).prop('checked',false);
				$('#no-'+ attribute).parent().removeClass('active').attr('aria-pressed', 'false');
				$('#yes-'+ attribute).prop('checked',true);
				$('#yes-'+ attribute).parent().addClass('active').attr('aria-pressed', 'true');
			}else if(option == 'no'){				
				$('#no-'+ attribute).prop('checked',true);
				$('#no-'+ attribute).parent().addClass('active').attr('aria-pressed', 'true');
				$('#yes-'+ attribute).prop('checked',false);
				$('#yes-'+ attribute).parent().removeClass('active').attr('aria-pressed', 'false');				
			}
			
			$('#'+attribute).val(valor);			
			$('#'+attribute+'Order').val(orden); 
			set_checkboxes(attribute, cups, true);	
		
		}		
			
	});

}


// carga los attributos como > ['uniformity','cleanCup','sweetness'] -----------------------------------------
// en tiempo real y al iniciar la prueba
function set_checkboxes(attribute, cups, init ){
	
	var option_select = $('input[name="'+attribute+'"]:checked').val();

	
	var value = $('#'+attribute).val();
	var selected_cups = 0, mi_select = '';	
	

	if($.isNumeric(value)){
		value = Number(value);		
		if(value == 10){
			mi_select = 'yes';
			$('#hidden-'+attribute).hide();
		
			var order = '';
			for (var i = 0; i < cups; i++) {
				order+='1';

				 var checkbox = $('input[id="'+attribute+'-'+(i+1)+'"]');
				 checkbox.prop('checked',true);
				 var widget = checkbox.closest('.button-checkbox');
				 var button = widget.find('button');
				
				 encaje(widget, checkbox, button);
			}
			$('#'+attribute+'Order').val(order);	
			
		}else {
			mi_select = 'no';
			// se calcula el numero de tazas seleccionadas con el orden guardado en order.
			var order = $('#'+attribute+'Order').val();	
			for (var i = 0, len = order.length; i < len; i++) {		
			
				if(order.charAt(i) == '0'){
					 var checkbox = $('input[id="'+attribute+'-'+(i+1)+'"]');
					 var widget = checkbox.closest('.button-checkbox');
					 var button = widget.find('button');			
					encaje(widget, checkbox, button);
				}
				}	
		
			
			$('#hidden-'+attribute).show();
			$('#hidden-'+attribute).addClass('animated fadeIn');			
		}		
	}else {
		if(option_select == 'no'){
			mi_select = 'no';
			$('#'+attribute+'Order').val('');
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
	arrLang['es']['fragrance'] ='Fragancia';
	arrLang['en']['fragrance'] ='Fragrance';
	arrLang['es']['aroma'] ='Aroma';
	arrLang['en']['aroma'] ='Aroma';
	arrLang['es']['flavor'] ='Sabor';
	arrLang['en']['flavor'] ='Flavor';
	arrLang['es']['residualFlavor'] ='Sabor residual';
	arrLang['en']['residualFlavor'] ='Residual flavor';
	arrLang['es']['acidity'] ='Acidez';
	arrLang['en']['acidity'] ='Acidity';
	arrLang['es']['body'] ='Cuerpo';
	arrLang['en']['body'] ='Body';
	arrLang['es']['balance'] ='Balance';
	arrLang['en']['balance'] ='Balance';
	arrLang['es']['uniformity'] ='Uniformidad';
	arrLang['en']['uniformity'] ='Uniformity';
	arrLang['es']['cleanCup'] ='Taza limpia';
	arrLang['en']['cleanCup'] ='Clean cup';
	arrLang['es']['sweetness'] ='Dulzor';
	arrLang['en']['sweetness'] ='Sweetness';
	arrLang['es']['defect'] ='Defects';
	arrLang['en']['defect'] ='Defectos';
	arrLang['es']['total-score'] ='Puntaje total';
	arrLang['en']['total-score'] ='Total score';
	
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

	// i18n
	var arrLang = i18nData();
	// locale de acuerdo a spring
	var locale = $('#locale').val();
	
	var cups = $('#cups').val();
	
 	var formData = { 
 			fragrance ,
 			fragranceNotes,
 			aroma ,  
 			aromaNotes ,  
 			flavor ,
 			flavorNotes ,
 			residualFlavor , 	
 			residualFlavorNotes , 	
 			acidity ,
 			acidityNotes ,
 			body,
 			bodyNotes,
 			uniformity, 
 			uniformityOrder, 
 			uniformityNotes, 
 			balance,
 			balanceNotes,
 			cleanCup, 	
 			cleanCupOrder, 	
 			cleanCupNotes, 	
 			sweetness, 
 			sweetnessOrder, 
 			sweetnessNotes, 
 			defect, 	
 			defectNotes, 	
 			defectOrder,
 			attributes,
  			tasterScore,
 			totalScore : 0, 
 			notes , 	
 			cups : cups,
 			finished : $('#finished').val(),
 			id : $('input[id="id"]').val()
    	}
 	
 	
 	// seleccionamos los actributos del lexico
 	var optionsAttribute = $('select[name="attributes"]').val(); 
 	var optionsDefects = $('select[name="attributes1"]').val();
 	

 //agrega los atributos al resumen
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
 	//------------------------------------------------------------------
 	
 	
 	// vector con los todos los atributos y defectos de la muestra
 	var atributos = [];
 	for (var k = 0; k < optionsAttribute.length; k++) {
 		atributos.push({
 	        id: optionsAttribute[k]
 	    });
 	}
 		
 	for (var k = 0; k < optionsDefects.length; k++) {
 		atributos.push({
 	        id: optionsDefects[k]
 	    });
 	}	
 	//---------------------------------------------------
 	
 	// sumamos y agregamos los atributos al vector del post y al resumen
 	var arrNumber = [ 'fragrance', 'aroma',  'flavor', 'residualFlavor',  'acidity', 'body', 'balance','uniformity','cleanCup','sweetness','defect', 'tasterScore'];
 	$.each( arrNumber, function( index, v ){
 		var value = $('#'+v).val();
 		
if($.isNumeric(value)){
	$('#data-'+v).html(value);
		formData[v] = formatNumber(value);
		
		 if (v == 'defect'){	 			
			 formData['totalScore'] -= formData[v];
 			$('#summary-'+v).html('- '+formData[v]);	
 		
		 }else {	 		
 			
 			if(v == 'aroma' || v == 'fragrance'){
 				formData['totalScore'] += formData[v]/2; 	 			
 				$('#summary-'+v).html('+ '+formData[v] +'/2'); 	 				
 			}else{ 	 			
 				formData['totalScore'] += formData[v]; 	 	
 				$('#summary-'+v).html('+ '+formData[v] );
 			}
 			
 		}
}else{
	formData[v] = null;
	$('#data-'+v).html('');
	$('#summary-'+v).html('');
}
 		
 		 
 		 
	});
 	
 	
 	var summary_attributes_notes = '<ul>';
 	var arrString = [ 'fragranceNotes', 'aromaNotes',  'flavorNotes', 'residualFlavorNotes',  'acidityNotes', 'bodyNotes', 'balanceNotes', 'uniformityNotes','cleanCupNotes','sweetnessNotes','defectNotes'];
 	$.each( arrString, function( index, v ){
 		var value = $('#'+v).val();
 		formData[v] = value;
 		if(value != ''){
 			summary_attributes_notes += '<li>'+arrLang[locale][v.split("N")[0]]+': '+value+' </li>';
 		}
	});
 	summary_attributes_notes += '</ul>';
 	$('#summary-attributes-notes').html(summary_attributes_notes);
 	
 	var arrString = [ 'uniformityOrder','cleanCupOrder','sweetnessOrder','defectOrder'];
 	$.each( arrString, function( index, v ){
 		var value = $('#'+v).val();
 		formData[v] = value;	
 		
 		
 		
 		
 		var htmldata = '';
 		if(value == ''){
 			htmldata='--';
 		}
 		
 		for (var i = 0, len = value.length; i < len; i++) { 		
 			var color = 'success';
 			if(v != 'defectOrder'){
 				if(value.charAt(i) == '0'){
 	 				color = 'danger';
 	 			}
 			}else{
 				if(value.charAt(i) == '2'){
 	 				color = 'warning';
 	 			}else if(value.charAt(i) == '4'){
 	 				color = 'danger';
 	 			}
 			}		
 			htmldata+='<span class="badge badge-'+color+'"><i class="fa fa-coffee fa-2x "></i>'+(i+1)+'</span> ';
 			}
 		$('#order-cups-'+v.split("O")[0]).html(htmldata);
 		
 		
	});
 	
	formData['attributes'] = atributos;	
	formData['notes'] = $('#notes').val();	
	$('#summary-notes').html($('#notes').val());		
	
	
	
	
	

 	
 	/*
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
		 	
		 	formData[i] = atributos;		
			
		}else if( i == 'totalScore'){
			// no hace nada
		}else{
			formData[i] = formatNumber(value);
		}	 
	});
*/
	/*
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
 	
 	
 	
 	
 	*/

	var totalScore = formData['totalScore'];


$('#badge-total-score').hide();
if($.isNumeric(totalScore)){
	$('#badge-total-score').show();	
}
 	
	$("#summary-totalScore").html(totalScore);	
	
	
	if(totalScore<80){	    		
		$('#final_score').html(arrLang[locale]['alert_below_specialty_quality']);
		$('#badge-total-score').html(arrLang[locale]['total-score']+': <span class="badge badge-danger" >'+totalScore+'</span>');
	}else if(totalScore>=80 && totalScore<=84.99){	    		
		$('#final_score').html(arrLang[locale]['alert_very_good_quality']);
		$('#badge-total-score').html(arrLang[locale]['total-score']+': <span class="badge badge-warning" >'+totalScore+'</span>');
	}else if(totalScore>=85 && totalScore<=89.99){	    		
		$('#final_score').html(arrLang[locale]['alert_excellent_quality']);
		$('#badge-total-score').html(arrLang[locale]['total-score']+': <span class="badge badge-info" >'+totalScore+'</span>');
	}else if(totalScore>=90 && totalScore<=100){	    		
		$('#final_score').html(arrLang[locale]['alert_outstanding_quality']);
		$('#badge-total-score').html(arrLang[locale]['total-score']+': <span class="badge badge-success" >'+totalScore+'</span>');
	}
	

	
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
	
	condition(($('select[name="attributes"]').val() != '') , 'attributes_lexic', false);
	condition(($('select[name="attributes1"]').val() != '') , 'defects_lexic', false);

	
	if(allright){
		$('#content-finished').show();
		$('#content-finished').addClass('animated fadeIn');
	}else {	
		$('#content-finished').hide();
	}
	
/* recibe la condicion para validar si todo es completado
*	state : si es true, checkea como dato validado
*	attribute : atributo a se validado
*	set_allright: define si se quiere validar la variable allright, true cuando se quiere vaidar y false si no se quiere validar, para los atributos
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

function radio_colors(attribute){	
	for (var i = 1; i <= 16; i++) {	 
		 var label = $('#'+attribute+''+i).closest('label');
		label.removeClass('btn-outline-secondary');
		label.addClass('btn-'+label.data('color'));
		
	}
	
}

function bloquear_radios(atributo_libre, atributo_limitado){	
	var radio_libre = Number(($("input[name='"+atributo_libre+"'][value='"+$('#'+atributo_libre).val()+"']").attr('id')).split("-")[1]);
	var radio_limitado = Number(($("input[name='"+atributo_limitado+"'][value='"+$('#'+atributo_limitado).val()+"']").attr('id')).split("-")[1]);
	var min = radio_libre - 4;
	var max = radio_libre + 4;
	
	for (var i = 1; i <= 16; i++) {	
		var label = $('#'+atributo_limitado+'-'+i).closest("label");
		 if(i<min || i>max){
			 
			 label.addClass('disabled');
			 label.removeClass('btn-'+label.data('color'));
			 label.addClass('btn-outline-secondary');	
			 	if(radio_limitado == i){						 
				 $('#'+atributo_limitado+'-'+ i).prop('checked',false);
				 $('#'+atributo_limitado+'-'+ i).parent().removeClass('active').attr('aria-pressed', 'false');
				 $('#'+atributo_limitado).val('');
			 }
		 }else{
			 label.removeClass('disabled');	
			 label.removeClass('btn-outline-secondary');	
			 label.addClass('btn-'+label.data('color'));
		 } 
	}
	
}


// se deben bloquear los botones de acuerdo al rango de 1 punto por arriba o por debajo 
// para un valor de fragancia, el aroma solo puede estar maximo o minimo un punto de diferencia, y los demas botones son bloqueados
// a si mismo con el sabor y el sabor residual 
function limitar_atributos(atributo_libre, atributo_limitado, $target){	
	if($target.attr('id') == 'content-'+atributo_limitado){
		if($('#'+atributo_libre).val() == ''){
			$target.hide();
			$('#hidden-content-'+atributo_limitado).show();
		}else{
			$target.show();
			$('#hidden-content-'+atributo_limitado).hide();				
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
	$('#hidden-content-aroma').hide();
	$('#hidden-content-residualFlavor').hide();
	 
	navListItems.click(function(e) {

	
	$('#attr').val($(this).attr('id').split('-')[2]);
		e.preventDefault();
		var $target = $($(this).attr('href')), $item = $(this);
		if (!$item.hasClass('disabled')) {
			navListItems.removeClass('btn-primary').addClass('btn-default');
			$item.addClass('btn-primary').removeClass('btn-default');
			allWells.hide();		
			$target.show();
			$target.addClass('animated pulse');
			
			$('#hidden-content-aroma').hide();
			$('#hidden-content-residualFlavor').hide();		
			
			limitar_atributos('fragrance','aroma', $target);
			limitar_atributos('flavor','residualFlavor', $target);

			
			 var mi_data = data();		
				ajaxPost(mi_data);
				done_button(mi_data);			
			}
	});

	$('#reject').click(function(e) {
		allWells.hide();
		$('#content-reject').show();
		$('#content-reject').addClass('animated pulse');
	}); 

	
	
	function menu2(object){
		var $target = $($(object).attr('href')), $item = $(object);
		if (!$item.hasClass('disabled')) {
			navListItems.removeClass('btn-primary').addClass('btn-default');
			$item.addClass('btn-primary').removeClass('btn-default');
			allWells.hide();		
			$target.show();
			$target.addClass('animated pulse');
			
			$('#hidden-content-aroma').hide();
			$('#hidden-content-residualFlavor').hide();		
			
			limitar_atributos('fragrance','aroma', $target);
			limitar_atributos('flavor','residualFlavor', $target);

		}
	}
		
	
	if($('#attr').val() != ''){
		menu2($('#href-content-'+$('#attr').val())); 
		$('#select_menu').val('#content-'+$('#attr').val());
	 	
	}else{
		menu2($('#href-content-fragrance')); 
	}
		
	


//menu($('#content-'+$('#attr').val())); 


// scroll cuando e cambia el item
//$('#attr').val($(this).attr('id').split('-')[2]);
	
	
//	$('#select_menu').val('#content-'+$('#attr'));
 	
	$('#select_menu').change(function() {	 	
		  allWells.hide();
		  $('#attr').val($(this.value).attr('id').split('-')[1]);
		  
		  
			$(this.value).show();	
			$target =$(this.value);
			$('#hidden-content-aroma').hide();
			$('#hidden-content-residualFlavor').hide();
			
			if($target.attr('id') == 'content-aroma'){
				if($('#fragrance').val() == ''){
					$target.hide();
					$('#hidden-content-aroma').show();
				}else{
					$target.show();
					$('#hidden-content-aroma').hide();
				}
			}
			if($target.attr('id') == 'content-residualFlavor'){
				if($('#flavor').val() == ''){
					$target.hide();
					$('#hidden-content-residualFlavor').show();
				}else{
					$target.show();
					$('#hidden-content-residualFlavor').hide();
				}
			}
			
			 var mi_data = data();		
				ajaxPost(mi_data);
				done_button(mi_data);
				
				
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
	 	
			var state = $('input[name="defect-state"]:checked').val();
			
		 	 var defect=0;
		 	 var defectOrder = '';
		 	 
		 	 if(state == 'no'){
		     for (var i = 1; i <= cups; i++) {		    	
		     	var ka = $('input[name="defect-'+i+'"]:checked').val();
		     	if(ka != undefined ){
		     		defect+= Number(ka);
		     		defectOrder+= ka;
		     	}	
		 	}

		     if(defectOrder.length == cups){
		    	 $('#defect').val(defect);
		    	 $('#defect_warning').hide();
		    	 
		     }}else if(state == 'yes') {
		    	   		    	
				     	var ka = $('input[name="defect-a"]:checked').val();
				     	if(ka != undefined ){
				     		for (var i = 1; i <= cups; i++) {
				     		defect+= Number(ka);
				     		defectOrder+= ka;
				     	}	}
				     	 $('#defect').val(defect);
				 	
		    	 
		     }
		 	 
				
				$('#data-defect').html(defect);
				$('#defectOrder').val(defectOrder);
				
				var mi_data = data();		
				ajaxPost(mi_data);
				done_button(mi_data);
		});
		
	
	    // input seleccionado y se hace post
		$('input.check-defect:radio').change(function(e){
			e.preventDefault();	
	
		if($(this).val() == 'yes'){
			$('#hidden-defect-one').hide();
			$('#hidden-defect-all').show();		
			
		}else{
			$('#hidden-defect-all').hide();
			 $('#defect_warning').show();
			$('#hidden-defect-one').show();			
		}
		
	
		 
		 for (var k = 0; k <= 4; k+=2) {
				var aa = $('input[id="defect-'+(k)+'"]');
				 aa.prop('checked',false);
				 aa.parent().removeClass('active').attr('aria-pressed', 'false');				
			}
		 
		 
		for (var i = 0; i < cups; i++) {
			for (var k = 0; k <= 4; k+=2) {
				var ss = $('input[id="defect-'+(i+1)+'-'+k+'"]');
				 ss.prop('checked',false);
				 ss.parent().removeClass('active').attr('aria-pressed', 'false');
			}			 
		}	
		
		$('#data-defect').html('');
		$('#defectOrder').val('');
		$('#defect').val('');
		var mi_data = data();		
		ajaxPost(mi_data);
		done_button(mi_data);
		});
		
		
		
	    // input seleccionado y se hace post
		$('input.direct-post:radio').change(function(e){
			e.preventDefault();	
			var value = $(this).val(),	name = $(this).attr('name');			
			$('#'+name).val(value);		
			
			if(name == 'fragrance'){
				bloquear_radios('fragrance', 'aroma');
			}
			if(name == 'flavor'){
				bloquear_radios('flavor', 'residualFlavor');
			}
			
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
				var order=''; 
				for (var i = 0; i < cups; i++) {    	
					order+='1';
				} 
				$('#'+name+'Order').val(order);
			}else if (option == 'no'){
				$('#'+name).val('');
				$('#'+name+'Order').val('');
			}
			set_checkboxes(name, cups, false);	
			
			if(name == 'uniformity' || name == 'cleanCup'){
				set_all_checkboxes($('#'+name).val(), $('#'+name+'Order').val(), name, option);
			}
	
			
			
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
		 			fragrance : '0',
		 			fragranceNotes : '',
		 			aroma : '0',  
		 			aromaNotes : '',  
		 			flavor : '0' ,
		 			flavorNotes : '',
		 			residualFlavor : '0' , 	
		 			residualFlavorNotes : '', 	
		 			acidity : '0',
		 			acidityNotes : '' ,
		 			body : '0',
		 			bodyNotes: '',
		 			uniformity : '0', 
		 			uniformityOrder: '', 
		 			uniformityNotes: '', 
		 			balance : '0',
		 			balanceNotes: '',
		 			cleanCup : '0', 	
		 			cleanCupOrder : '', 	
		 			cleanCupNotes : '', 	
		 			sweetness : '0', 
		 			sweetnessOrder : '', 
		 			sweetnessNotes : '', 
		 			defect : '0', 	
		 			defectNotes : '', 	
		 			defectOrder : '',
		 			attributes,
		  			tasterScore : '0',
		 			totalScore : '0', 
		 			notes : notes , 	
		 			cups : cups,
		 			finished : finished,
		 			id : test_id
		    	}
		 	
		 
		 	if(ajaxPost(formData)){
		 		window.location.href = $('#urlservename').val() + 'ta/panel-test-'+ $('#panel_id').val();
		 	}else{
		 		alert('castatrofe mi señor');
		 	}
		 
		 	/*setTimeout(function() {
				window.location.href = $('#urlservename').val() + 'ta/panel-test-'+ $('#panel_id').val();
			}, 1000);		*/ 	

		});
		

		 // permite rechazar la muestra y terminar la prueba
		$('#button-finish-test').click(function(e){
			e.preventDefault();	
			$('#finished').val(1);
			

			
			if(ajaxPost(data())){
		 		window.location.href = $('#urlservename').val() + 'ta/panel-test-'+ $('#panel_id').val();
		 	}else{
		 		alert('castatrofe mi señor');
		 	}
			/*
			setTimeout(function() {
				window.location.href = $('#urlservename').val() + 'ta/panel-test-'+ $('#panel_id').val();
			}, 1000);	*/
			

		});
		
		 // permite rechazar la muestra y terminar la prueba
		$('a.samplesLink').click(function(e){
			e.preventDefault();	
			
			var url = this.href+'-attr-'+$('#attr').val();

			
			if(ajaxPost(data())){
				 window.location = url;
		 	}else{
		 		alert('castatrofe mi señor');
		 	}
			/*
			setTimeout(function() {
				window.location.href = $('#urlservename').val() + 'ta/panel-test-'+ $('#panel_id').val();
			}, 1000);	*/
			

		});
		
		 // recoge todos los input
		$('#add_notes').click(function(e){
			e.preventDefault();		
			var mi_data = data();		
			ajaxPost(mi_data);
			done_button(mi_data);
		});		
		
	
    function ajaxPost(form){  
    	
    	var resultado;
    	//$('#loading').removeClass('hidden');
    	
    	var url = $('#urlservename').val();
    	// DO POST
    	$.ajax({
			type : "POST",
			async: false,
			contentType : "application/json",
			url : url + "postcustomer2",
			data : JSON.stringify(form),
			dataType : 'json',
			success : function(result) {
				
				if(result.status == "Done"){					
					resultado = true;
					$("#postResultDiv").html("<strong>" + "Post Successfully! Customer's Info: aroma = " 
							+JSON.stringify( result.data) + " ,flavor = " + result.data.flavor + " ,flavor = "+ result.data.fragrance+"</strong>");
				}else{
					resultado = false;
					$("#postResultDiv").html("<strong>Error</strong>");
				}
				console.log(result);
			},
			error : function(e) {
				alert("Error!")
				console.log("ERROR: ", e);
			}
		});
    //	$('#loading').addClass('hidden');
    	return resultado;
  
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
         	value  = Number(value.toFixed(2));
         	//--------------------------
        // 	 $('#data-'+$checkbox.attr('name')).html(value);
 
         	
/*


if($('input[class="conditional-post"][name="'+$checkbox.attr('name')+'"]:checked').val() == 'no' && value == 10){
	$('#'+$checkbox.attr('name')).val('');
	$('#'+$checkbox.attr('name')+'Order').val('');
}else{
	$('#'+$checkbox.attr('name')).val(value);
	$('#'+$checkbox.attr('name')+'Order').val(order);
}
*/
        
checkyn = $('input[class="conditional-post"][name="'+$checkbox.attr('name')+'"]:checked').val() ;

if( checkyn == 'no' && value == 10){
	$('#'+$checkbox.attr('name')).val('');
	$('#'+$checkbox.attr('name')+'Order').val('');
}else if(checkyn == 'yes'){
	$('#'+$checkbox.attr('name')).val(10);
	var order=''; 
	for (var i = 0; i < cups; i++) {    	
		order+='1';
	} 
	$('#'+$checkbox.attr('name')+'Order').val(order);
}else{
	$('#'+$checkbox.attr('name')).val(value);
	var order=''; 
	for (var i = 1; i <= cups; i++) {		    	
		var checked = $('#'+$checkbox.attr('name')+'-'+i).is(':checked');
		
		if(checked){
			order+='0';
		}else{
			order+='1';
		}
	} 

	$('#'+$checkbox.attr('name')+'Order').val(order);
}

if($checkbox.attr('name') == 'uniformity' || $checkbox.attr('name') == 'cleanCup'){
	set_all_checkboxes($('#'+$checkbox.attr('name')).val(), $('#'+$checkbox.attr('name')+'Order').val(), $checkbox.attr('name'),'no');	
}


        //	alert($('#'+$checkbox.attr('name')+'Order').val()); 
        	
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