<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@page session="true"%>
<html>
<head>
<jsp:include page="fragments/title.jsp" />
<jsp:include page="fragments/css/bootstrap.jsp" />
<jsp:include page="fragments/css/signin.jsp" />
<jsp:include page="fragments/css/footer.jsp" />
<jsp:include page="fragments/css/fontAwesome.jsp" />
<jsp:include page="fragments/css/animate.jsp" />
<style>
html, body {
	height: 100%;
	margin: 0;
	background-color: #E9E9E9;
}

#logo-c {
	width: auto;
}

#section-1 {
	background: #292b2c;
	color: white;
}

#section-3 {
	background: linear-gradient(45deg, #A6C14B 20%, transparent 0%),
		linear-gradient(0deg, #292b2c 100%, transparent 0%);
	color: white;
}

#section-5 {
	background: linear-gradient(-45deg, #292b2c 70%, transparent 0%),
		linear-gradient(0deg, #A6C14B 100%, transparent 0%);
}

.divider-section {
	padding-top: 65px;
	background: #A6C14B;
}

#section-2 {
	background: linear-gradient(-45deg, #292b2c 70%, transparent 0%),
		linear-gradient(0deg, #A6C14B 100%, transparent 0%);
	color: white;
}

.fixed-top {
	position: relative;
}

.embed-container {
	position: relative;
	padding-bottom: 56.25%;
	height: 0;
	overflow: hidden;
}

.embed-container iframe {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
}

@media ( min-width : 768px) AND ( min-height: 400px ) {
	.fixed-top {
		position: fixed;
	}
	section {
		padding-top: 65px;
	}
	#section-1 {
		height: 100vh;
	}
	#section-5 {
		height: 100vh;
	}
	#logo-c {
		width: 600px;
	}
}

.bg-inverse {
	background-color: #292b2c !important;
	<!--
	rgba
	(41,
	43,
	44,
	0.66)
	!important;
	-->
}

.carousel-item>.card, .carousel-caption.card, .section-3.card {
	border: none;
	background-color: rgba(0, 0, 0, 0.24);
}
</style>
</head>
<body>
<nav class="navbar fixed-top navbar-toggleable-sm navbar-inverse bg-inverse " style="background-color: #e3f2fd;">
		<button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<a class="navbar-brand" href="#section-1"><img src="<c:url value="/resources/images/logo-cesurcafe.svg"/>" alt="Card image cap" class="img-fluid" width="100px"> </a>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false"> <c:if test="${pageContext.response.locale.language == 'es'}">
			         ES
			      </c:if> <c:if test="${pageContext.response.locale.language == 'en'}">
			         EN
			      </c:if> <i class="fa fa-language" aria-hidden="true"></i></a>
					<div class="dropdown-menu">
						<a class="dropdown-item" href="?lang=es"> <img src="<c:url value="/resources/images/spanish-icon.png"/>" class="img-fluid" alt="Responsive image" width="30" height="30"> <spring:message code="spanish" /></a> <a class="dropdown-item" href="?lang=en"><img src="<c:url value="/resources/images/english-icon.png"/>" class="img-fluid" alt="Responsive image" width="30" height="30"> <spring:message code="english" /></a>
					</div></li>
				<li class="nav-item"><a class="nav-link" href="#section-2"><spring:message code="know-us" /></a></li>
				<li class="nav-item"><a class="nav-link" href="#section-4"><spring:message code="contact-us" /></a></li>
			</ul>
			<a class="btn btn-outline-success my-2 my-sm-0 hidden-sm-down" href="#section-5"><i class="fa fa-sign-in fa-fw" aria-hidden="true"></i> <spring:message code="login" /></a>
		</div>
	</nav>

	<section id="section-1"
		class="d-flex align-items-center  justify-content-center ">
		<div class="container-fluid">
			<div class="row">
				<div class="col py-2 text-center d-flex flex-column">
					<br /> <img id="logo-c"
						src="<c:url value="/resources/images/logo-cesurcafe.svg"/>"
						alt="Card image cap"> <br />
					<p class="text-center">
						<spring:message code="slogan" />
					</p>
					<br />
					<p class="text-center">
						<a target="_blank"
							href="https://www.facebook.com/Centro-Surcolombiano-de-Investigaci%C3%B3n-en-Caf%C3%A9-Cesurcaf%C3%A9-486785554834086/"
							class="text-success"><i class="fa fa-facebook fa-fw fa-3x"></i></a>
						<a href="#" class="text-success"><i
							class="fa fa-twitter fa-fw fa-3x"></i></a> <a href="#"
							class="text-success"><i class="fa fa-youtube fa-fw fa-3x"></i></a>
					</p>
					<p class="hidden-md-up">
						<a class="btn btn-outline-success my-2 my-sm-0" href="#section-5"><i
							class="fa fa-sign-in fa-fw" aria-hidden="true"></i> <spring:message
								code="login" /></a>
					</p>
				</div>
			</div>
		</div>
	
	</section>
	<div class="divider-section"></div>
	<section id="section-2">
		<div class="container">
			<div class="row justify-content-center pb-5">
				<div class="col col-12 col-lg-8 ">
					<div id="carouselExampleIndicators" class="carousel slide"
						data-ride="carousel">
						<ol class="carousel-indicators">
							<li data-target="#carouselExampleIndicators" data-slide-to="0"
								class="active"></li>
							<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
							<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
							<li data-target="#carouselExampleIndicators" data-slide-to="3"></li>
							<li data-target="#carouselExampleIndicators" data-slide-to="4"></li>
						</ol>
						<div class="carousel-inner" role="listbox">
							<div class="carousel-item active">
								<div class="card">
									<img
										src="https://lh3.googleusercontent.com/tIgqMYzvqMg6Dj2GifA8Xqu1RvvpQakAcHwyw6CB0hD6T8xzIJSAB302WtMyEhATKKku7yXBAu1xuzjM2MhpJjLrzZ-y4GQL02GosBXZjNboE6B5G-9ZmxCKFiJW8wrIinBl=w900-h600-no"
										class="img-fluid" alt="Responsive image">
								</div>
							</div>
							<div class="carousel-item">
								<div class="card">
									<img
										src="https://lh3.googleusercontent.com/x-NRL3thLp3E-qxFMqE_N6bhCzpASb-9beniRHeuAwCnxCIKqqCJJwcSnPizn0y40IvsRsyuN_XjA6rqn-la5nxdGo9sosUduK9QewbEi43jeE7lBlAGNycVIZVWVFdTnPWz=w900-h600-no"
										class="img-fluid" alt="Responsive image">
								</div>
							</div>
							<div class="carousel-item">
								<div class="card">
									<img
										src="https://lh3.googleusercontent.com/b3j5xv7dIB5XQUQXzVV1yFm_YOMM-Zq4eDUgZ62beifRjIKAjbXYm4OGeQDlfnwb_nkm4jy4HCokYB-BAoWk1LydNK_MPbbQOFGjtSJwA_n_uExovWdo7OGVZpOWazIYzHSf=w900-h600-no"
										class="img-fluid" alt="Responsive image">
								</div>
							</div>
							<div class="carousel-item">
								<div class="card">
									<img
										src="https://lh3.googleusercontent.com/CrveOGOftyGMqeBT6umS3URV7xh8lgcbbz6G1PZYuOj9hhUPU0v0Vq8Dl97cxVMgK8yKKSOsfnBLF_2of4gRwE-NdEkzw8mcxtR83Nxk3OGGx7RnoWscC9ywodejyFnSSfmL=w900-h600-no"
										class="img-fluid" alt="Responsive image">
								</div>
							</div>
							<div class="carousel-item">
								<div class="card">
									<img
										src="https://lh3.googleusercontent.com/tep0eXnHnYQbmfmtGXhZHVuUrjNU7ltVc0HGx2juLPaUdvKIlmxCzlfuHyWGl9cziXMmJkWuZmkTD1dDqu7K7TuiyWHb5x_8p4Gdmj9xpjEXa9RPpxanh-oCTqMRVWZrC9yw=w900-h600-no"
										class="img-fluid" alt="Responsive image">
								</div>
							</div>
						</div>
						<a class="carousel-control-prev" href="#carouselExampleIndicators"
							role="button" data-slide="prev"> <span
							class="carousel-control-prev-icon" aria-hidden="true"></span> <span
							class="sr-only">Previous</span>
						</a> <a class="carousel-control-next"
							href="#carouselExampleIndicators" role="button" data-slide="next">
							<span class="carousel-control-next-icon" aria-hidden="true"></span>
							<span class="sr-only">Next</span>
						</a>
					</div>
				</div>
				<div class="col col-12 col-lg-4 pt-1">
					<div class="card"
						style="border: none; background-color: rgba(0, 0, 0, 0.1);">
						<div class="card-block">
							<h4 class="card-title">Cesurcafé</h4>
							<p class="text-justify"> <spring:message code="login.cesurcafe.message" /></p>
							
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<div class="divider-section"></div>
	<section id="section-3">
		<div class="container">
			<div class="row pb-5">
				<div class=" col-sm-12 col-md-6 d-flex">
					<div class="card section-3 ">
						<img
							src="https://lh3.googleusercontent.com/x-NRL3thLp3E-qxFMqE_N6bhCzpASb-9beniRHeuAwCnxCIKqqCJJwcSnPizn0y40IvsRsyuN_XjA6rqn-la5nxdGo9sosUduK9QewbEi43jeE7lBlAGNycVIZVWVFdTnPWz=w900-h600-no"
							class="card-img-top img-fluid" alt="Responsive image">
						<div class="card-block ">
							<h4 class="card-title">
								<spring:message code="mision.title" />
							</h4>
							<p class="card-text  text-justify">
								<spring:message code="mision" />
							</p>
						</div>
					</div>
				</div>
				<div class="col-sm-12 col-md-6  d-flex ">
					<div class="card section-3">
						<div class="card-block ">
							<h4 class="card-title">
								<spring:message code="vision.title" />
							</h4>
							<p class="card-text text-justify">
								<spring:message code="vision" />
							</p>
						</div>
						<img
							src="https://lh3.googleusercontent.com/yX7HLJSzysPyTvFb-6KwK12OlheDGGqgELx17smXcSKLYzOznygwLzeGJooGPeAuIA4iR-bkWBkUuoKSOjl6FSJxWREpCnrCUvUquTGGYBd7D4V8E_QB2DOf4cXp9Av72o3HBRvM1Owz_TTMc3f3twfRp5S7ka2n9hoZtmOLjfCjM5ERHsi02KXYYkuZslt1M8gX0wRHPiaNIUVtOM-M2J2THeWlr40uisiD1Um27anNakE_fdaL2A1_TcCipfdtcTNLf5L7hz2GWLXDuHq6wtHeynKk1KzWxJmlQ8_Z8qqGnzTiKhnhQW8e50qS0qUHyXRmhvxHD0emy2FEgItdFS5SfV0Xx75EpTjvqncUdGbooa_FZw9XPm3Cy8XwFJKA5qWBv5QT_zwGNVdh7pzmxBq4nE6UpEUSy_wPtXbKjIWxsBMY7L89RVfIMBNpA_JDiEbxxMY4ZGc7N5dI2YAEMaswtrDJ3exLPj9boPwXSOn7loX_WZWI44t2V4giNn8jqptMNwHn-yYgH3_NUGgrj1QGMXtwmXgCAAdRBKIGuM5mSzXjWmyYJLL7UKQu-LerU7ocriVCd8bDPhzHAb9Sfx0t3tQPu6METvl8LHrdPRjFqdCYVXYZNcEor9ZqvS8j_t-HePNs2n1TWWkkb_TYo8mkVzmCeNBTJjm8pWSV=w900-h600-no"
							class="card-img-bottom img-fluid" alt="Responsive image">
					</div>
				</div>
			</div>
		</div>
	</section>
	<div class="divider-section"></div>
	<section id="section-4">
		<div class="container">
			<div class="row">
				<div class="col text-center">
					<img src="<c:url value="/resources/images/logo-cesurcafe-2.svg"/>"
						alt="Card image cap" class="img-fluid" width="400px">
					<hr />
				</div>
			</div>
			<div class="row">
				<div class="col text-center pt-2">
					<p>
						Universidad Surcolombiana <br>Avenida Pastrana, Carrera 1.
					</p>
					<ul class="list-unstyled">
						<li><i class="fa fa-phone fa-fw"></i> (+57) 875 4753 Ext.
							1131</li>
						<li><i class="fa fa-envelope-o fa-fw"></i> <a
							href="mailto:cesurcafe@usco.edu.co">cesurcafe@usco.edu.co</a></li>
					</ul>
					<br> <a target="_blank"
						href="https://www.facebook.com/Centro-Surcolombiano-de-Investigaci%C3%B3n-en-Caf%C3%A9-Cesurcaf%C3%A9-486785554834086/"><i
						class="fa fa-facebook fa-fw fa-3x"></i></a> <a href="#"><i
						class="fa fa-twitter fa-fw fa-3x"></i></a> <a href="#"><i
						class="fa fa-youtube fa-fw fa-3x"></i></a>

				</div>
				<div class="col text-center">
					
						<iframe
							src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3984.558998903301!2d-75.30068588538121!3d2.9422098552107503!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x8e3b74f407574aff%3A0x962a48fd2f9423d7!2sUniversidad+Surcolombiana+Campus+Central!5e0!3m2!1ses-419!2sco!4v1497318705124"
							width="300" height="250" frameborder="1" style="border: 0"
							allowfullscreen></iframe>

				
				</div>

			</div>
			<hr />
			<div class="row align-items-center justify-content-center">
				<div class="col text-center">
					<img src="<c:url value="/resources/images/LGTST2.png"/>"
						class="img-fluid rounded" alt="Responsive image" width="100px">
				</div>
				<div class="col text-center">
					<img src="<c:url value="/resources/images/LU.png"/>"
						class="img-fluid rounded" alt="Responsive image" width="250px">
				</div>
			</div>
		</div>
	</section>
	<div class="divider-section"></div>
	<section id="section-5"
		class="d-flex align-items-center  justify-content-center ">
		<div class="row justify-content-center py-4 ">
			<div class="row card">
				<form class="form-signin ${param.error != null ? 'has-danger' : ''}"
					name='loginForm' action="<c:url value='/auth/login_check' />" method='POST'>
					<h2 class="form-signin-heading text-center">
						<spring:message code="login" />
					</h2>
					<label for="inputUsername" class="sr-only">Usuario:</label> <input
						type="number" id="inputUsername" name='username'
						class="form-control"
						placeholder="<spring:message code="login.username.placeholder" />"
						${param.error != null ? 'autofocus="autofocus"' : ''}> <label
						for="inputPassword" class="sr-only">Contraseña</label> <input
						type="password" id="inputPassword" name='password'
						class="form-control"
						placeholder="<spring:message code="login.password.placeholder" />"
						required>
					<button class="btn btn-lg btn-success btn-block" name="submit"
						type="submit" value="submit">
						<i class="fa fa-sign-in fa-fw" aria-hidden="true"></i>
						<spring:message code="login" />
					</button>
					<div class="checkbox">
						<label><input type="checkbox" id="rememberme"
							name="remember-me"> <spring:message
								code="login.remember-me" /></label>
					</div>
					<spring:url value="/re/resetPassword" var="RecoverPasswordUrl" /> 
					<a href="${RecoverPasswordUrl}"><span class="text-primary"><spring:message
								code="login.recovery-password" /></span></a>
					<c:if test="${param.error != null}">
						<div class="form-control-feedback text-center">
							<spring:message code="login.error" />
						</div>
					</c:if>
					<c:if test="${param.logout != null}">
						<div class="form-control-feedback text-center">
							<spring:message code="login.closed-sesion" />
						</div>
					</c:if>
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />
				</form>
			</div>
		</div>
		<c:if test="${temporal}">
			<div class="alert alert-success" role="alert">
				<spring:message code="login.msg.temporal" />
			</div>
		</c:if>
	</section>
	<%--
	<section>
		<div class="container  ">
			<div class="row  d-flex align-items-center">
				<div class="col-12 col-md-6 justify-content-center">
					<h3>Nuestra Misión</h3>
					<br />
					<hr />
					<p class="mb-0 text-justify">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Consectetur aliquid id sed eum maiores quae rem molestias dolores! Modi repellendus velit temporibus unde minus similique enim id autem laborum corporis!</p>
					<br />
				</div>
				<div class="col-12 col-md-6 justify-content-center">
					<img src="<c:url value="/resources/images/img.jpg"/>" class="img-fluid img-thumbnail" alt="Responsive image" width="450px">
				</div>
			</div>
			<br />
			<div class="row  d-flex align-items-center">
				<div class="col-12 col-md-6 justify-content-center">
					<h3>Nuestra Misión</h3>
					<br />
					<hr />
					<p class="mb-0 text-justify">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Consectetur aliquid id sed eum maiores quae rem molestias dolores! Modi repellendus velit temporibus unde minus similique enim id autem laborum corporis!</p>
					<br />
				</div>
				<div class="col-12 col-md-6 justify-content-center">
					<img src="<c:url value="/resources/images/img.jpg"/>" class="img-fluid img-thumbnail" alt="Responsive image" width="450px">
				</div>
			</div>
			<br />
		</div>
	</section> --%>
<footer class="text-center hidden-md-down">
	<hr>
	<p style="color: fff;">&copy; Universidad Surcolombiana 2017</p>
</footer>
	<jsp:include page="fragments/js/jquery.jsp" />
	<jsp:include page="fragments/js/bootstrap.jsp" />
	<c:if test="${not empty notifyMesage}">
		<jsp:include page="fragments/js/notify.jsp">
			<jsp:param name="notifyMesage" value="${notifyMesage}" />
			<jsp:param name="notifyType" value="${notifyType}" />
		</jsp:include>
	</c:if>
	<script src="<spring:url value="/resources/js/scrolling.js"/>"></script>
	
</body>
</html>