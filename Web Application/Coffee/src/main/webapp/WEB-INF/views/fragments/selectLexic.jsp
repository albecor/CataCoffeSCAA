<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="row justify-content-center">
	<div class="col ">
		<select  id="${param.path}" name="${param.path}" multiple='multiple' size="15" class="form-control lexico"> 
			<optgroup label="<spring:message code="fruity" />">
				<option value="1"><spring:message code="fruity" /></option>
				<option value="2"><spring:message code="berry" /></option>
				<option value="3"><spring:message code="strawberry" /></option>
				<option value="4"><spring:message code="raspberry" /></option>
				<option value="5"><spring:message code="blueberry" /></option>
				<option value="6"><spring:message code="blackberry" /></option>
				<option value="7"><spring:message code="dried-fruit" /></option>
				<option value="8"><spring:message code="raisin" /></option>
				<option value="9"><spring:message code="prune" /></option>
				<option value="10"><spring:message code="other-fruit" /></option>
				<option value="11"><spring:message code="apple" /></option>
				<option value="12"><spring:message code="pear" /></option>
				<option value="13"><spring:message code="peach" /></option>
				<option value="14"><spring:message code="grape" /></option>
				<option value="15"><spring:message code="cherry" /></option>
				<option value="16"><spring:message code="pomegranate" /></option>
				<option value="17"><spring:message code="coconut" /></option>
				<option value="18"><spring:message code="pineapple" /></option>
				<option value="19"><spring:message code="citrus-fruit" /></option>
				<option value="20"><spring:message code="lemon" /></option>
				<option value="21"><spring:message code="grapefruit" /></option>
				<option value="22"><spring:message code="orange" /></option>
				<option value="23"><spring:message code="lime" /></option>
			</optgroup>
			<optgroup label="<spring:message code="alcohol/fermented" />">
				<option value="33"><spring:message code="winey" /></option>
			</optgroup>
			<optgroup label="<spring:message code="green/vegetative" />">				
				<option value="41"><spring:message code="fresh" /></option>				
				<option value="45"><spring:message code="herb-like" /></option>				
			</optgroup>
			<optgroup label="<spring:message code="spices" />">
				<option value="76"><spring:message code="nutmeg" /></option>
				<option value="77"><spring:message code="brown-spice" /></option>
				<option value="78"><spring:message code="cinnamon" /></option>
				<option value="79"><spring:message code="clove" /></option>
			</optgroup>
			<optgroup label="<spring:message code="nutty" />">
				<option value="80"><spring:message code="nutty" /></option>
				<option value="81"><spring:message code="almond" /></option>
				<option value="82"><spring:message code="hazelnut" /></option>
				<option value="83"><spring:message code="peanuts" /></option>
			</optgroup>
			<optgroup label="<spring:message code="cocoa" />">
				<option value="84"><spring:message code="cocoa" /></option>
				<option value="85"><spring:message code="chocolate" /></option>
				<option value="86"><spring:message code="dark-chocolate" /></option>
			</optgroup>
			<optgroup label="<spring:message code="sweet" />">
				<option value="87"><spring:message code="sweet" /></option>
				<option value="88"><spring:message code="molasses" /></option>
				<option value="89"><spring:message code="maple-syrup" /></option>
				<option value="90"><spring:message code="brown-sugar" /></option>
				<option value="91"><spring:message code="caramelized" /></option>
				<option value="92"><spring:message code="honey" /></option>
				<option value="93"><spring:message code="vanilla" /></option>
				<option value="94"><spring:message code="vanillin" /></option>
				<option value="95"><spring:message code="sweet-aromatics" /></option>
				<option value="96"><spring:message code="overall-sweet" /></option>
			</optgroup>
			<optgroup label="<spring:message code="floral" />">
				<option value="97"><spring:message code="floral" /></option>
				<option value="98"><spring:message code="rose" /></option>
				<option value="99"><spring:message code="jasmine" /></option>
				<option value="100"><spring:message code="chamomile" /></option>
				<option value="101"><spring:message code="black-tea" /></option>
			</optgroup>
		</select> <input type="hidden" name="attributes" id="attributes" />
	</div>
</div>
