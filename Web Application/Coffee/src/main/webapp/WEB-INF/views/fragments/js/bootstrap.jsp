<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
 
<script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js" ></script>
<script>window.jQuery || document.write(unescape('%3Cscript src="<spring:url value="/resources/js/tether.min.js"/>"%3E%3C/script%3E'))</script>


<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js"></script>
<script>window.jQuery || document.write(unescape('%3Cscript src="<spring:url value="/resources/js/bootstrap.min.js"/>"%3E%3C/script%3E'))</script>
	    

<script> 
$('[rel="tooltip"]').tooltip({container: 'body'});    
$('[data-toggle="popover"]').popover();
<%--
	
var mediaquery = window.matchMedia("(max-width: 760px)");

		function handleOrientationChange(mediaquery) {
			if (mediaquery.matches) {
				$('.table').addClass('table-responsive');
			} else {
				$('.table').removeClass('table-responsive');
			}
		}
		handleOrientationChange(mediaquery);
		mediaquery.addListener(handleOrientationChange);
--%> 
</script>


