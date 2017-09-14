<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Users List</title>

<jsp:include page="fragments/title.jsp" />
<jsp:include page="fragments/css/bootstrap.jsp" />
<jsp:include page="fragments/css/footer.jsp" />
<jsp:include page="fragments/css/fontAwesome.jsp" />
<jsp:include page="fragments/css/animate.jsp" />
</head>

<body>
	<div class="container">
<br />
<br />
		<div class="card">
		<div class="card-header">
			<span class="lead">List of Users </span>
			</div>
			<div class="card-block">
			  <!-- Default panel contents -->
		  
			<table class="table table-hover">
	    		<thead>
		      		<tr>
				        <th>Firstname</th>
				        <th>Lastname</th>
				        <th>Email</th>
				        <th>SSO ID</th>
				     
				        <sec:authorize access="hasRole('ADMIN')">
				        	<th width="100"></th>
				        </sec:authorize>				        
					</tr>
		    	</thead>
	    		<tbody>
				<c:forEach items="${users}" var="user">
					<tr>
						<td>${user.firstName}</td>
						<td>${user.lastName}</td>
						<td>${user.email}</td>
						<td>${user.id}</td>
					   
				        <sec:authorize access="hasRole('ADMIN')">
							<td><a href="<c:url value='/ad/${user.username}' />" class="btn btn-success ">show</a></td>
        				</sec:authorize>
					</tr>
				</c:forEach>
	    		</tbody>
	    	</table>
			</div>
		</div>
		<sec:authorize access="hasRole('ADMIN')">
		 	<div class="well">
		 		soy ADMIN
		 	</div>
	 	</sec:authorize>
	 	
	 	<sec:authorize access="hasRole('ORGANIZER')">
		 	<div class="well">
		 		soy ORGANIZER
		 	</div>
	 	</sec:authorize>
	 	
	 	<sec:authorize access="hasRole('TASTER')">
		 	<div class="well">
		 		soy TASTER
		 	</div>
	 	</sec:authorize>
	 	
	 	
   	</div>
   	<jsp:include page="fragments/js/jquery.jsp" />
	<jsp:include page="fragments/js/bootstrap.jsp" />
</body>
</html>