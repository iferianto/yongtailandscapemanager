<%@page import="be.mxs.common.util.system.*" %>
<%@include file="/includes/validateUser.jsp"%>
<%
	UpdateSystem.updateQueries(application);
	UpdateSystem.updateDb();
	UpdateSystem.updateLabels(sAPPFULLDIR);
	UpdateSystem.updateTransactionItems(sAPPFULLDIR);
	UpdateSystem.updateCounters();
	UpdateSystem.updateExaminations();
	if(request.getParameter("updateVersion")!=null){
		MedwanQuery.getInstance().setConfigString("updateVersion",request.getParameter("updateVersion"));
	}
%>
<script>window.location.href='<c:url value="/login.jsp"/>'</script>
