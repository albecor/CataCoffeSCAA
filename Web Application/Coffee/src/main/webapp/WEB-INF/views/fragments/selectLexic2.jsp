<%@ page session="true"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

					
					<form:select multiple="true" path="attributes">
    <form:options items="${attributes}" itemValue="id" itemLabel="name"/>
</form:select>			
								
		<c:if test="${not empty param.previous}">
			<button class="btn btn-primary prevBtn btn-lg pull-left" type="button">
				<spring:message code="previous" />
			</button>
		</c:if>
		<c:if test="${not empty param.next}">
			<button type="submit" class="btn btn-lg btn-primary pull-right">
						<spring:message code="form.user.button.value.add" />
			</button>
		</c:if>





