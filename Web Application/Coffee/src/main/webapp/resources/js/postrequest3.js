$( document ).ready(function() {
	
	
	// cambia el color del boton de la muestra que esta seleccionada
	var testId = $('input[name="id"]').val();	
	$('#url_test_'+testId).removeClass('btn-secondary').addClass('btn-success');
	
	
	// i18n 
	var arrLang = new Array();
	arrLang['en'] = new Array();
	arrLang['es'] = new Array();
	
	
	
	
	arrLang['es']['alert_below_specialty_quality'] ='<div class="alert alert-warning" role="alert"><strong>No especial!</strong> Café por debajo de la calidad de especial.</div>';
	arrLang['en']['alert_below_specialty_quality'] ='<div class="alert alert-warning" role="alert"><strong>Not Specialty!</strong> Below specialty quality.</div>';
	arrLang['es']['alert_very_good_quality'] ='<div class="alert alert-info" role="alert"><strong>Especial!</strong> Muy buen café.</div>';
	arrLang['en']['alert_very_good_quality'] ='<div class="alert alert-info" role="alert"><strong>Specialty!</strong> Very Good coffee.</div>';
	arrLang['es']['alert_excellent_quality'] ='<div class="alert alert-primary" role="alert"><strong>Especial!</strong> Café excelente.</div>';
	arrLang['en']['alert_excellent_quality'] ='<div class="alert alert-primary" role="alert"><strong>Specialty!</strong> Excellent coffee.</div>';
	arrLang['es']['alert_outstanding_quality'] ='<div class="alert alert-success" role="alert"><strong>Especial!</strong> Café excepcional</div>';
	arrLang['en']['alert_outstanding_quality'] ='<div class="alert alert-success" role="alert"><strong>Specialty!</strong> Outstanding coffee.</div>';
	// locale de acuerdo a spring
	var locale = $('#locale').val();
	
	
	
	
	
    
	
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
	        });
	        $checkbox.on('change', function () {
	            updateDisplay();
	        });

	        // Actions
	        function updateDisplay() {
	            var isChecked = $checkbox.is(':checked');

	            // Set the button's state
	            $button.data('state', (isChecked) ? "on" : "off");

	            // Set the button's icon
	            $button.find('.state-icon')
	                .removeClass()
	                .addClass('state-icon ' + settings[$button.data('state')].icon);

	            // Update the button's color
	            if (isChecked) {
	                $button
	                    .removeClass('btn-success')
	                    .addClass('btn-' + color + ' active');
	            }
	            else {
	                $button
	                    .removeClass('btn-' + color + ' active')
	                    .addClass('btn-success');
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
	    
	  
	    
	    var url =  "http://localhost:8080/coffee/postcustomer2"; //window.location
	    
	    function data(form) {
	    	
	    	var cups = Number(form.closest("form").find('input[name="cups"]').val());   
	    	var uniformity = Number((cups -  form.closest("form").find('input[name="checkbox-uniformity"]:checked').length)*10/cups);
	     	var sweetness = Number((cups -  form.closest("form").find('input[name="checkbox-sweetness"]:checked').length)*10/cups);
	     	var cleanCup = Number((cups -  form.closest("form").find('input[name="checkbox-cleanCup"]:checked').length)*10/cups);
	     	var fragrance =Number( form.closest("form").find('input[name="fragrance"]:checked').val());
	     	var aroma = Number(form.closest("form").find('input[name="aroma"]:checked').val());
	     	var flavor = Number(form.closest("form").find('input[name="flavor"]:checked').val());
	     	var residualFlavor = Number(form.closest("form").find('input[name="residualFlavor"]:checked').val());
	     	var acidity = Number(form.closest("form").find('input[name="acidity"]:checked').val());
	     	var body = Number(form.closest("form").find('input[name="body"]:checked').val());
	     	var balance = Number(form.closest("form").find('input[name="balance"]:checked').val());
	     	var tasterScore = Number(form.closest("form").find('input[name="tasterScore"]:checked').val());	     	
	     	var test_id = form.closest("form").find('input[name="id"]').val(); 		
	     	var notes = form.closest("form").find('textarea[name="notes"]').val(); 			
	     	//var test_id = (form.closest("form").attr('id').split('-'))[1];
	     	
	     	
	    	// create defect
		    var defect=0;
		    for (var i = 1; i <= cups; i++) {		    	
		    	var ka = form.closest("form").find('input[name="defect-'+i+'"]:checked').val();
		    	if(ka != undefined ){
		    		defect+= Number(ka);
		    	}	
			}
		    
		    // create json attribute list
	     	var optionsAttribute = form.closest("form").find('select[name="attributes"]').val();	      
	     	  
	     	var atributes = [];
	     	for (var i = 0; i < optionsAttribute.length; i++) {
	     		atributes.push({
	     	        id: optionsAttribute[i]
	     	    });
	     	}	     	
	     	var optionsAttribute1 = form.closest("form").find('select[name="attributes1"]').val();     	
	     	for (var i = 0; i < optionsAttribute1.length; i++) {
	     		atributes.push({
	     	        id: optionsAttribute1[i]
	     	    });
	     	}			
			
		
			 
	     	//var totalScore = (fragrance/2 + aroma/2 + flavor + residualFlavor + acidity + body + uniformity + balance + cleanCup + sweetness - defect +  tasterScore);
	     	var totalScore = 0;
	     	if(!isNaN(fragrance) ){
	     		totalScore+= fragrance/2;
	     		$("#summary-fragrance").html('+ '+fragrance+'/2');
	    	}	     	
	     	if( !isNaN(aroma)){
	     		totalScore+= aroma/2;
	     		$("#summary-aroma").html('+ '+aroma+'/2');
	    	}
	     	if( !isNaN(flavor)){
	     		totalScore+= flavor;
	     		$("#summary-flavor").html('+ '+ flavor);
	    	}
	     	if( !isNaN(residualFlavor) ){
	     		totalScore+= residualFlavor;
	     		$("#summary-residualFlavor").html('+ '+residualFlavor );
	    	}
	     	if( !isNaN(acidity)){
	     		totalScore+= acidity;
	     		$("#summary-acidity").html('+ '+ acidity);
	    	}
	     	if( !isNaN(body) ){
	     		totalScore+= body;
	     		$("#summary-body").html('+ '+ body);
	    	}
	     	if(!isNaN(uniformity)){
	     		totalScore+= uniformity;
	     		$("#summary-uniformity").html('+ '+uniformity );			
	    	}
	     	if( !isNaN(balance) ){
	     		totalScore+= balance;
	     		$("#summary-balance").html('+ '+ balance);
			
	    	}
	     	if( !isNaN(cleanCup) ){
	     		totalScore+= cleanCup;
	     		$("#summary-cleanCup").html('+ '+ cleanCup);
				
	    	}
	     	if( !isNaN(sweetness) ){
	     		totalScore+= sweetness;
	     		$("#summary-sweetness").html('+ '+ sweetness);
				
	    	}
	     	if( !isNaN(defect) ){
	     		totalScore-= defect;
	     		$("#summary-defect").html('- '+ defect);
				
	    	}
	     	if( !isNaN(tasterScore) ){
	     		totalScore+= tasterScore;
	     		$("#summary-tasterScore").html('+ '+tasterScore );					
	    	}
	     	
	    	$("#summary-totalScore").html(totalScore );		
	    	
	    	if(totalScore<80){	    		
	    		$('#final_score').html(arrLang[locale]['alert_below_specialty_quality']);
	    	}else if(totalScore>=80 && totalScore<=84.99){	    		
	    		$('#final_score').html(arrLang[locale]['alert_very_good_quality']);
	    	}else if(totalScore>=85 && totalScore<=89.99){	    		
	    		$('#final_score').html(arrLang[locale]['alert_excellent_quality']);
	    	}else if(totalScore>=90 && totalScore<=100){	    		
	    		$('#final_score').html(arrLang[locale]['alert_outstanding_quality']);
	    	}
	    	
	     	//var totalScore = (fragrance/2 + aroma/2 + flavor + residualFlavor + acidity + body + uniformity + balance + cleanCup + sweetness - defect +  tasterScore);
	     	var finished = 0;
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
	     		finished = 1;
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
			
		
	     	
	     	var formData = {
	     			fragrance : fragrance,
	     			aroma : aroma,
	     			flavor : flavor,
	     			residualFlavor : residualFlavor,
	     			acidity : acidity,
	     			body : body,
	     			uniformity : uniformity,
	     			balance : balance,
	     			cleanCup : cleanCup,
	     			sweetness : sweetness,
	     			defect : defect,
	     			aroma : aroma,
	     			tasterScore : tasterScore,
	     			totalScore : totalScore,
	     			notes : notes,
	     			attributes : atributes,
	     			cups : cups,
	     			finished : finished,
	     			id : test_id
	        	}	  
	     
	        return formData;
	    }
	    
	    
function data_reject(form) {
	    	
	    	var cups = Number(form.closest("form").find('input[name="cups"]').val());    	
	     	var test_id = form.closest("form").find('input[name="id"]').val(); 		
	     	var notes = form.closest("form").find('textarea[name="reject_notes"]').val(); 			
	     	var finished = 1;
	     	
	     	var formData = {	     			
	     			notes : notes,	     			
	     			cups : cups,
	     			finished : finished,
	     			id : test_id
	        	}	  
	     
	        return formData;
	    }
    	
	    
	    // recoge todos los input
		$('input').change(function(e){
			e.preventDefault();			
			 var formdata = data($(this).closest("form"));
			 ajaxPost(formdata);
		});
		
		 // recoge todos los input
		$('#reject_sample').click(function(e){
			e.preventDefault();			
			 var formdata = data_reject($(this).closest("form"));
			 ajaxPost(formdata);
		});
		
		 // recoge todos los input
		$('#add_notes').click(function(e){
			e.preventDefault();			
			 var formdata = data($(this).closest("form"));
			 ajaxPost(formdata);
		});		
		
		/* // recoge todos los input
		$('select').change(function(e){
			e.preventDefault();			
			 var formdata = data($(this).closest("form"));
			 ajaxPost(formdata);
		});	*/
		 // recoge todos los input
		$('select[name="attributes"]').change(function(e){
			e.preventDefault();			
			 var formdata = data($(this).closest("form"));
			 ajaxPost(formdata);
		});	
		 // recoge todos los input
		$('select[name="attributes1"]').change(function(e){
			e.preventDefault();			
			 var formdata = data($(this).closest("form"));
			 ajaxPost(formdata);
		});	
	
	// SUBMIT FORM
	/* $('form').on('submit', function (e) {
		// Prevent the form from submitting via the browser.
		e.preventDefault();
		ajaxPost($(this));
	});*/

    function ajaxPost(formdata){
    	
   
    	
    	// DO POST
    	$.ajax({
			type : "POST",
			contentType : "application/json",
			url : url,
			data : JSON.stringify(formdata),
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
    	
    	// Reset FormData after Posting
    	resetData();

    }
    
    function resetData(){
    
    }
})