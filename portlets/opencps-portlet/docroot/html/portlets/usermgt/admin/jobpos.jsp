<%
/**
 * OpenCPS is the open source Core Public Services software
 * Copyright (C) 2016-present OpenCPS community
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Affero General Public License for more details.
 * You should have received a copy of the GNU Affero General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
%>
<%@ include file="../init.jsp"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.opencps.usermgt.model.JobPos"%>
<%@page import="java.util.List"%>
<%@page import="javax.portlet.PortletURL"%>
<%@page import="org.opencps.util.PortletPropsValues"%>
<%@page import="com.liferay.portal.kernel.dao.search.SearchContainer"%>
<%@page import="com.liferay.portal.kernel.dao.search.SearchEntry"%>
<%@page import="org.opencps.usermgt.service.JobPosLocalServiceUtil"%>
<%@page import="org.opencps.usermgt.search.JobPosSearchTerms"%>
<%@page import="org.opencps.usermgt.search.JobPosSearch"%>
<%
	long workingUnitId = ParamUtil.getLong(request, "workingUnitId");
	PortletURL iteratorURL = renderResponse.createRenderURL();
	iteratorURL.setParameter("mvcPath", templatePath + "jobpos.jsp");
	List<JobPos> jobPos = new ArrayList<JobPos>();
	int totalCount = 0;
%>

<liferay-ui:error key="DELETE_JOBPOS_ERROR" message="DELETE JOBPOS ERROR" />
<portlet:renderURL var="updateJobPosURL">
	<portlet:param name="mvcPath" value='<%=templatePath + "edit_jobpos.jsp" %>'/>
	<portlet:param name="workingUnitId" value="<%=String.valueOf(workingUnitId) %>"/>
</portlet:renderURL>

<liferay-ui:icon iconCssClass="icon-plus-sign" label="update-jobpos" 
	url="<%=updateJobPosURL.toString() %>"/>

<liferay-ui:search-container searchContainer="<%= 
	new JobPosSearch(renderRequest ,SearchContainer.DEFAULT_DELTA, iteratorURL) %>">
	<%
		
	%>
		
	<liferay-ui:search-container-results>
		<%@include file="/html/portlets/usermgt/admin/result_search_jobpos.jspf"%>
	</liferay-ui:search-container-results>
	<liferay-ui:search-container-row 
		className="org.opencps.usermgt.model.JobPos" 
		modelVar="jobPosSearch" 
		keyProperty="jobPosId"
	>
		<%
			String leaderName = "";
			if(jobPosSearch.getLeader() == 0) {
				leaderName = PortletPropsValues.USERMGT_JOBPOS_NOMAL;;
			} else if (jobPosSearch.getLeader() == 1) {
				leaderName = PortletPropsValues.USERMGT_JOBPOS_BOSS ;
			} else if (jobPosSearch.getLeader() == 2) {
				leaderName =  PortletPropsValues.USERMGT_JOBPOS_DEPUTY;
			}
			row.addText(jobPosSearch.getTitle());
			row.addText(leaderName);
			row.addJSP("center", SearchEntry.DEFAULT_VALIGN,  templatePath +
				"jobpos-action.jsp", config.getServletContext(),
				request, response);
		%>
	</liferay-ui:search-container-row>
	<liferay-ui:search-iterator/>
</liferay-ui:search-container>
