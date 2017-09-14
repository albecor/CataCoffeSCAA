<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:forEach var="i" begin="1" end="${param.cups}">
	<div class="col col-auto">
		<div class="button-checkbox">
			<button type="button" class="btn" data-color="danger"></button>
			<input type="checkbox" class="hidden" name="checkbox-${param.path}" id="${param.path}-${i}" />
		</div>
	</div>
</c:forEach>
<form:hidden path="${param.path}" />
