<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


	<script type="text/javascript">
		$(document).ready(function() {


			var marksCanvas = document.getElementById('${param.id}');

			var marksData = {
			  labels: ["<spring:message code='fragrance' />", 
				  	   "<spring:message code='aroma' />", 
				  	   "<spring:message code='flavor' />", 
				  	   "<spring:message code='residualFlavor' />", 
				  	   "<spring:message code='balance' />",   
				  	   "<spring:message code='acidity' />", 
				  	   "<spring:message code='body' />", 
				  	   "<spring:message code='tasterScore' />"],
			  datasets: [{
			    label: " ${param.taster}",
			    backgroundColor: "rgba(200,0,0,0.2)",
			    data: [

				    ${param.fragrance}, 
				    ${param.aroma}, 
				    ${param.flavor}, 
				    ${param.residualFlavor}, 
				    ${param.balance}, 
				    ${param.acidity}, 
				    ${param.body}, 
				    ${param.tasterScore} 	]
			  }]
			};

			var chartOptions = {
					  scale: {
					    ticks: {
					      beginAtZero: true,
					      min: 5,
					      max: 10,
					      stepSize: 0.5
					    },
					    pointLabels: {
					      fontSize: 14
					    }
					  },
					  legend: {
					    position: 'top'
					  }
					};

			var radarChart = new Chart(marksCanvas, {
			  type: 'radar',
			  data: marksData,
			  options : chartOptions
			});

			 
		
			
		});
	</script>
	
	