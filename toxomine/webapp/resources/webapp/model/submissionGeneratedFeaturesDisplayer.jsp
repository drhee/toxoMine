<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!-- submissionGeneratedFeaturesDisplayer.jsp -->

<style type="text/css">
.odd-alt-gf {
  background-color: #FBEFEF;
}
.even-alt-gf {
  background-color: #F6CECE;
}
</style>

<script type="text/javascript" charset="utf-8">
    jQuery(document).ready(function () {
        jQuery("#fea").click(function () {
           if(jQuery("#submission-generated-features").is(":hidden")) {
             jQuery("#co").attr("src", "images/disclosed.gif");
           } else {
             jQuery("#co").attr("src", "images/undisclosed.gif");
           }
           jQuery("#submission-generated-features").toggle("slow");
        });
    })
</script>

<html:link linkName="#" styleId="fea" style="cursor:pointer">
    <h3>
        Generated Features for this submission (click to toggle)
        <img src="images/undisclosed.gif" id="co">
    </h3>
</html:link>

<div id="submission-generated-features" style="display: block">
	<table width="100%" cellpadding="0" cellspacing="0" border="0" class="results">
		<tr>
        	<th>View data</th>
        	<th>Export</th>
        	<th>Action</th>
		</tr>
		<c:if test="${sequenceFeatureCount > 0}">
			<tbody>
				<tr class="odd-alt-gf">
					<td valign="top" style="width:30%;">
	                	<a href="/${WEB_PROPERTIES['webapp.path']}/features.do?type=submission&action=results&submission=${TCid}" style="text-decoration: none;" data-tc-id="${TCid}">
	                    	${sequenceFeatureCount}
	                	</a>
					</td>
					<td valign="top" style="width:50%;">
						<a href="/${WEB_PROPERTIES['webapp.path']}/features.do?type=submission&action=export&format=tab&submission=${TCid}" title="Tab-delimited values"
						style="text-decoration: none;">TAB</a>
						-----
						<a href="/${WEB_PROPERTIES['webapp.path']}/features.do?type=submission&action=export&format=csv&submission=${TCid}" title="Comma-separated values"
						style="text-decoration: none;">CSV</a>
					</td>
					<td valign="top" style="width:20%;">
						<a href="/${WEB_PROPERTIES['webapp.path']}/features.do?type=submission&action=list&submission=${TCid}" title="Create a list of ${TCid}"
						 style="text-decoration: none;">create LIST</a>
					</td>
				</tr>
			</tbody>
		</c:if>
	</table>
</div>

<!-- submissionGeneratedFeaturesDisplayer.jsp -->
