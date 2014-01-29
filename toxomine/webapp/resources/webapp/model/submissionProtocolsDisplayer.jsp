<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="im"%>
<%@ taglib uri="http://flymine.org/imutil" prefix="imutil"%>
<%@ taglib uri="http://jakarta.apache.org/taglibs/string-1.1"
  prefix="str"%>

<!-- submissionProtocolsDisplayer.jsp -->

<tiles:importAttribute />

<html:xhtml />

<style type="text/css">
div#submissionProtocols h3 {
  color: black;
  margin-bottom: 20px;
}
</style>

<div class="body">

<%--========== --%>

<script type="text/javascript" charset="utf-8">
    jQuery(document).ready(function () {
        jQuery("#sis").click(function () {
           if(jQuery("#protocols").is(":hidden")) {
             jQuery("#co").attr("src", "images/disclosed.gif");
           } else {
             jQuery("#co").attr("src", "images/undisclosed.gif");
           }
           jQuery("#protocols").toggle("slow");
        });
    })
</script>

<html:link linkName="#" styleId="sis" style="cursor:pointer">
    <h3>
        Protocols used for this submission (click to toggle)
        <img src="images/undisclosed.gif" id="co">
    </h3>
</html:link>

<script type="text/javascript" charset="utf-8">

jQuery(document).ready(function () {
 jQuery(".tbox").children('doopen').show();
 jQuery(".tbox").children('doclose').hide();

  jQuery('.tbox').click(function () {
  var text = jQuery(this).children('doclose');

  if (text.is(':hidden')) {
       jQuery(this).children('doclose').show("slow");
     } else {
         jQuery(this).children('doopen').show("slow");
      }
   });

  jQuery("doopen").click(function(){
     jQuery(this).toggle("slow");
     return true;
    });

  jQuery("doclose").click(function(){
      jQuery(this).toggle("slow");
        return true;
    });


  });

</script>

<div id="protocols" style="display: block">

    <table width="100%" cellpadding="0" cellspacing="0" border="0" class="results">
        <tr>
            <th>Type</th>
            <th>Protocol</th>
            <th width="50%" >Description</th>
        </tr>
        <c:forEach items="${protocols}" var="prot" varStatus="p_status">
            <c:set var="pRowClass">
                <c:choose>
                    <c:when test="${p_status.count % 2 == 1}">
                        odd-alt
                    </c:when>
                    <c:otherwise>
                        even-alt
                    </c:otherwise>
                </c:choose>
            </c:set>

          <tr class="<c:out value="${pRowClass}"/>">
              <td>${prot.type}</td>
              <td>
                <html:link href="/${WEB_PROPERTIES['webapp.path']}/report.do?id=${prot.id}">
                    ${prot.name}
                </html:link>
              </td>
              <td class="description">
                  <div class="tbox">
                      <doopen>
                          <img src="images/undisclosed.gif">
                          <i>${fn:substring(prot.description,0,80)}... </i>
                      </doopen>
                      <doclose>
                          <img src="images/disclosed.gif">
                          <i>${prot.description}</i>
                      </doclose>
                  </div>
              </td>
          </tr>
        </c:forEach>
    </table>

</div>

<%---========= --%>

<script type="text/javascript" charset="utf-8">
    jQuery(document).ready(function () {
        jQuery("#bro").click(function () {
           if(jQuery("#submissionProtocols").is(":hidden")) {
             jQuery("#oc").attr("src", "images/disclosed.gif");
           } else {
             jQuery("#oc").attr("src", "images/undisclosed.gif");
           }
           jQuery("#submissionProtocols").toggle("slow");
        });
    })
</script>

   <table width="100%" cellpadding="0">
       <tr>
           <TD colspan=2 align="left" style="padding-bottom:10px">
               <c:set var="toxoCoreUrl" value="http://129.98.110.218/" />

               <html:link linkName="#" styleId="bro" style="cursor:pointer">
                   <h3>Browse metadata for this submission (click to toggle)<img src="images/undisclosed.gif" id="oc"></h3>
               </html:link>

               <div id="submissionProtocols" style="display: block">
                   <table width="100%" cellpadding="0" cellspacing="0" border="0" class="results">
                       <tr>
                         <th>Step</th>
                         <th colspan="2">Inputs</th>
                         <th>Applied Protocol</th>
                         <th colspan="2">Outputs</th>
                       </tr>
                       <c:set var="prevStep" value="0" />

                       <tbody>
                           <c:forEach var="row" items="${pagedResults.rows}" varStatus="status">
                               <c:set var="rowClass">
                                 <c:choose>
                                   <c:when test="${status.count % 2 == 1}">odd</c:when>
                                   <c:otherwise>even</c:otherwise>
                                 </c:choose>
                               </c:set>

                               <c:forEach var="subRow" items="${row}" varStatus="multiRowStatus">
                                   <im:instanceof instanceofObject="${subRow[0]}" instanceofClass="org.intermine.api.results.flatouterjoins.MultiRowFirstValue" instanceofVariable="isFirstValue"/>
                                   <c:if test="${isFirstValue == 'true'}">
                                       <c:set var="step" value="${subRow[0].value.field}" scope="request"/>
                                   </c:if>
                                   <c:set var="stepClass">
                                       <c:choose>
                                           <c:when test="${step % 2 == 1}">stepO</c:when>
                                           <c:otherwise>stepE</c:otherwise>
                                       </c:choose>
                                   </c:set>

                                   <tr class="<c:out value="${stepClass}${rowClass}"/>">
                                       <c:set var="output" value="true"/>
                                       <c:forEach var="column" items="${pagedResults.columns}" varStatus="status2">
                                           <im:instanceof instanceofObject="${subRow[column.index]}" instanceofClass="org.intermine.api.results.flatouterjoins.MultiRowFirstValue" instanceofVariable="isFirstValue"/>
                                           <c:if test="${isFirstValue == 'true'}">
                                               <c:set var="resultElement" value="${subRow[column.index].value}" scope="request"/>
                                               <c:choose>
                                                   <c:when test="${column.index == 0}">
                                                       <c:set var="output" value="true"/>
                                                       <td rowspan="${subRow[column.index].rowspan}" >${resultElement.field}</td>
                                                   </c:when>
                                                   <c:when test="${column.index == 1 || column.index == 5}">
                                                       <c:if test="${fn:startsWith(resultElement.field,'file')}">
                                                           <c:set var="output" value="true"/>
                                                           <c:set var="isFile" value="true" />
                                                       </c:if>
                                                   </c:when>
                                                   <c:otherwise>
                                                       <c:if test="${column.index == 4}">
                                                           <c:set var="output" value="true"/>
                                                       </c:if>
                                                       <c:if test="${output}">
                                                           <td id="cell,${status2.index},${status.index},${subRow[column.index].value.type}" rowspan="${subRow[column.index].rowspan}" class="<c:out value="${stepClass}${rowClass}"/>">
                                                               <c:choose>
                                                                   <c:when test="${isFile}">
                                                                       <c:set var="isFile" value="false" />
                                                                       <c:set var="doLink" value="true" />
                                                                       ${resultElement.field}
                                                                   </c:when>
                                                                   <c:when test="${doLink}">
                                                                       <a href="${toxoCoreUrl}${resultElement.field}" title="Download file ${resultElement.field}" class="value extlink">
                                                                           <c:out value="${resultElement.field}" />
                                                                       </a>
                                                                       <c:set var="doLink" value="false" />
                                                                   </c:when>
                                                                   <c:otherwise>
                                                                   		<c:choose>
                                                                   			<c:when test="${column.index == 2 || column.index == 6}">
                                                                   				<tiles:insert name="objectView.tile" />
                                                                   			</c:when>
                                                                   			<c:when test="${column.index == 7 || column.index == 8}">
                                                                   				<tiles:insert name="objectView.tile" />
                                                                   			</c:when>
                                                                   			<c:otherwise>
                                                                        		<tiles:insert name="objectView.tile" />
                                                                        	</c:otherwise>
                                                                        </c:choose>
                                                                   </c:otherwise>
                                                               </c:choose>
                                                           </td>
                                                       </c:if>
                                                   </c:otherwise>
                                               </c:choose>
                                           </c:if>
                                       </c:forEach>
                                   </tr>
                               </c:forEach>
                           </c:forEach>
                       </tbody>
                   </table>
                   <br/>
               </div>
           </TD>
       </tr>
   </table>

</div>

<!-- /submissionProtocolsDisplayer.jsp -->
