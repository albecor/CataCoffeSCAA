<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="row justify-content-center">
	<div class="col ">
		<select  id="${param.path}" name="${param.path}" multiple='multiple' size="15" class="form-control lexico"> 	
		<optgroup label="<spring:message code="sour/acid" />">
				<option value="24"><spring:message code="sour" /></option>
				<option value="25"><spring:message code="sour-aromatics" /></option>			
			</optgroup>
			<optgroup label="<spring:message code="alcohol/fermented" />">
				<option value="31"><spring:message code="alcohol" /></option>				
				<option value="34"><spring:message code="fermented" /></option>
				<option value="35"><spring:message code="overripe/near-fermented" /></option>
			</optgroup>
			<optgroup label="<spring:message code="green/vegetative" />">
				<option value="36"><spring:message code="olive-oil" /></option>
				<option value="37"><spring:message code="raw" /></option>
				<option value="38"><spring:message code="under-ripe" /></option>
				<option value="39"><spring:message code="peapod" /></option>
				<option value="40"><spring:message code="green" /></option>				
				<option value="42"><spring:message code="dark-green" /></option>
				<option value="43"><spring:message code="vegetative" /></option>
				<option value="44"><spring:message code="hay-like" /></option>				
				<option value="46"><spring:message code="beany" /></option>
			</optgroup>			
			<optgroup label="<spring:message code="stale/papery" />">
				<option value="47"><spring:message code="stale" /></option>
				<option value="48"><spring:message code="papery" /></option>
				<option value="49"><spring:message code="cardboard" /></option>
			</optgroup>			
			<optgroup label="<spring:message code="earthy" />">
				<option value="50"><spring:message code="musty/earthy" /></option>
				<option value="51"><spring:message code="musty/dusty" /></option>
				<option value="52"><spring:message code="moldy/damp" /></option>
				<option value="53"><spring:message code="phenolic" /></option>
				<option value="54"><spring:message code="animalic" /></option>
				<option value="55"><spring:message code="meaty/brothy" /></option>
				<option value="56"><spring:message code="woody" /></option>
			</optgroup>
			
			<optgroup label="<spring:message code="chemical" />">
				<option value="57"><spring:message code="bitter" /></option>
				<option value="58"><spring:message code="salty" /></option>
				<option value="59"><spring:message code="medicinal" /></option>
				<option value="60"><spring:message code="rubber" /></option>
				<option value="61"><spring:message code="petroleum" /></option>
				<option value="62"><spring:message code="skunky" /></option>
			</optgroup>
			<optgroup label="<spring:message code="roasted" />">
				<option value="63"><spring:message code="tobacco" /></option>
				<option value="64"><spring:message code="pipe-tobacco" /></option>
				<option value="65"><spring:message code="acrid" /></option>
				<option value="66"><spring:message code="ashy" /></option>
				<option value="67"><spring:message code="burnt" /></option>
				<option value="68"><spring:message code="smoky" /></option>
				<option value="69"><spring:message code="roasted" /></option>
				<option value="70"><spring:message code="brown-roast" /></option>
			</optgroup>
			<optgroup label="<spring:message code="cereal" />">
				<option value="71"><spring:message code="grain" /></option>
				<option value="72"><spring:message code="malt" /></option>
			</optgroup>			
			<optgroup label="<spring:message code="spices" />">
				<option value="73"><spring:message code="pungent" /></option>
				<option value="74"><spring:message code="pepper" /></option>
				<option value="75"><spring:message code="anise" /></option>
			</optgroup>			
			<optgroup label="<spring:message code="mouthfeel" />">
				<option value="106"><spring:message code="mouth-drying" /></option>
				<option value="107"><spring:message code="thickness" /></option>
				<option value="108"><spring:message code="metallic" /></option>
				<option value="109"><spring:message code="oily" /></option>
			</optgroup>
		</select> <input type="hidden" name="${param.path}"/>
	</div>
</div>
