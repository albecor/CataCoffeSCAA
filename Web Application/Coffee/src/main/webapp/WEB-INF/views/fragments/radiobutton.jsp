<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="radio-selector" data-toggle="buttons">
	<div class="row justify-content-center">
		<div class="col col-auto">
			<div class="btn-group" role="group">
						 <label class="btn btn-warning btn-lg" data-color="warning"> <input disabled class="hidden direct-post" id="${param.path}-1" required="required" type="radio" autocomplete="off" value="6" name="${param.path}"> 6
				</label> <label class="btn btn-warning btn-lg" data-color="warning"> <input class="hidden direct-post" id="${param.path}-2" required="required" type="radio" autocomplete="off" value="6.25" name="${param.path}">6,25
				</label> <label class="btn btn-warning btn-lg" data-color="warning"> <input class="hidden direct-post" id="${param.path}-3" required="required" type="radio" autocomplete="off" value="6.5" name="${param.path}">6,50
				</label> <label class="btn btn-warning btn-lg" data-color="warning"> <input class="hidden direct-post" id="${param.path}-4" required="required" type="radio" autocomplete="off" value="6.75" name="${param.path}">6,75
				</label>
			</div>
		</div>
		</div>
		<div class="row justify-content-center">
		<div class="col col-auto">
			<div class="btn-group" role="group">
				<label class="btn btn-info btn-lg" data-color="info"> <input class="hidden direct-post" id="${param.path}-5" type="radio" required="required" autocomplete="off" value="7" name="${param.path}">7
				</label> <label class="btn btn-info btn-lg" data-color="info"> <input class="hidden direct-post" id="${param.path}-6" required="required" type="radio" autocomplete="off" value="7.25" name="${param.path}">7,25
				</label> <label class="btn btn-info btn-lg" data-color="info"> <input class="hidden direct-post" id="${param.path}-7" required="required" type="radio" autocomplete="off" value="7.5" name="${param.path}">7,50
				</label> <label class="btn btn-info btn-lg" data-color="info"> <input class="hidden direct-post" id="${param.path}-8" required="required" type="radio" autocomplete="off" value="7.75" name="${param.path}">7,75
				</label>
			</div>
		</div>
		</div>
		<div class="row justify-content-center">

		<div class="col col-auto">
			<div class="btn-group" role="group">
				<label class="btn btn-success btn-lg" data-color="success"> <input class="hidden direct-post" id="${param.path}-9" required="required" type="radio" autocomplete="off" value="8" name="${param.path}">8
				</label> <label class="btn btn-success btn-lg" data-color="success"> <input class="hidden direct-post" id="${param.path}-10" required="required" type="radio" autocomplete="off" value="8.25" name="${param.path}">8,25
				</label> <label class="btn btn-success btn-lg" data-color="success"> <input class="hidden direct-post" id="${param.path}-11" required="required" type="radio" autocomplete="off" value="8.5" name="${param.path}">8,50
				</label> <label class="btn btn-success btn-lg" data-color="success"> <input class="hidden direct-post" id="${param.path}-12" required="required" type="radio" autocomplete="off" value="8.75" name="${param.path}">8,75
				</label>
			</div>
		</div>
		</div>
		<div class="row justify-content-center">
		<div class="col col-auto">
			<div class="btn-group" role="group">
				<label class="btn btn-primary btn-lg" data-color="primary"> <input class="hidden direct-post" id="${param.path}-13" required="required" type="radio" autocomplete="off" value="9" name="${param.path}">9
				</label> <label class="btn btn-primary btn-lg"  data-color="primary"> <input class="hidden direct-post" id="${param.path}-14" required="required" type="radio" autocomplete="off" value="9.25" name="${param.path}">9,25
				</label> <label class="btn btn-primary btn-lg"  data-color="primary"> <input class="hidden direct-post" id="${param.path}-15" required="required" type="radio" autocomplete="off" value="9.5" name="${param.path}">9,50
				</label> <label class="btn btn-primary btn-lg"  data-color="primary"> <input class="hidden direct-post" id="${param.path}-16" required="required" type="radio" autocomplete="off" value="9.75" name="${param.path}">9,75
				</label>
			</div>
		</div>
	</div>
	
	<c:if test="${param.path == 'balance'}"><br />
				<div class="row justify-content-center">

		<div class="col col-auto">
			<label class="btn btn-success btn-lg btn-block" data-color="success"> <input class="hidden direct-post" id="${param.path}-17" required="required" type="radio" autocomplete="off" value="10" name="${param.path}">10
				</label>
		</div>
		</div>				
	</c:if>
</div>