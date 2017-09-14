<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


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
			  datasets: [


				  <c:forEach items="${requestScope.sample.testses}" var="testsesChart" varStatus="loop">
				  <c:if test="${testsesChart.test.disableScore != 1 }">
				  <c:set var="a"><%= java.lang.Math.round( java.lang.Math.floor(java.lang.Math.random() * 255) +0) %></c:set>
					<c:set var="b"><%= java.lang.Math.round( java.lang.Math.floor(java.lang.Math.random() * 255) +0) %></c:set>
					<c:set var="c"><%= java.lang.Math.round( java.lang.Math.floor(java.lang.Math.random() * 255) +0) %></c:set>
					
					
				  {
					    label: "${testsesChart.user.firstName} ${testsesChart.user.lastName}",
					    backgroundColor: "rgba(${a},${c},${b},0.2)",
					    borderColor: "rgba(${a},${c},${b},0.6)",
					    fill: true, 
					    radius: 6,
					    pointRadius: 4,
					    pointBorderWidth: 3,
					    pointBackgroundColor: "rgba(${a},${c},${b},0.6)",
					    pointBorderColor: "rgba(${a},${c},${b},0.6)",
					    pointHoverRadius: 10,
					    data: [
					    	${testsesChart.test.fragrance}, 
						    ${testsesChart.test.aroma}, 
						    ${testsesChart.test.flavor}, 
						    ${testsesChart.test.residualFlavor}, 
						    ${testsesChart.test.balance}, 
						    ${testsesChart.test.acidity}, 
						    ${testsesChart.test.body}, 
						    ${testsesChart.test.tasterScore} 
					    	]
					  }<c:if test="${!loop.last}">,</c:if>
				</c:if>
	 
					
				</c:forEach>
				<c:if test="${!requestScope.onlyOne}">
				,{
				    label: "<spring:message code='average' />",
				    backgroundColor: "rgba(0,38,255,0.2)",
				    borderColor: "rgba(0,38,255,0.6)",
				    fill: true, 
				    radius: 6,
				    pointRadius: 4,
				    pointBorderWidth: 3,
				    pointBackgroundColor: "rgba(0,38,255,0.6)",
				    pointBorderColor: "rgba(0,38,255,0.6)",
				    pointHoverRadius: 10,
				    data: [
				    	${requestScope.sample.test.fragrance}, 
					    ${requestScope.sample.test.aroma}, 
					    ${requestScope.sample.test.flavor}, 
					    ${requestScope.sample.test.residualFlavor}, 
					    ${requestScope.sample.test.balance}, 
					    ${requestScope.sample.test.acidity}, 
					    ${requestScope.sample.test.body}, 
					    ${requestScope.sample.test.tasterScore} 
				    	]
				  }
				</c:if>
				
				

				]
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
					    position: 'left'
					  }
					};


			var radarChart = new Chart(marksCanvas, {
			  type: 'radar',
			  data: marksData,
			  options: chartOptions
			});
			
		});
	</script>
	
	