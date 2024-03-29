<%@ page import="java.util.Vector,net.admin.Service,java.text.DecimalFormat,be.openclinic.adt.Bed,be.openclinic.adt.Encounter" %>
<%@include file="/includes/validateUser.jsp"%>
<%=sJSSORTTABLE%>
<%=writeTableHeader("Web","executive.bedoccupancy",sWebLanguage,"")%>
<%
    String sServiceId = checkString(request.getParameter("ServiceID"));
    if(sServiceId.length()==0){
%>
<table class="sortable" id="searchresults" width='100%' cellspacing="1" cellpadding="0">
    <tr class="gray">
        <th><%=getTran("web","service",sWebLanguage)%></th>
        <th width='150'><%=getTran("web","totalbeds",sWebLanguage)%></th>
        <th width='150'><%=getTran("web","occupiedbeds",sWebLanguage)%></th>
        <th width='150'><%=getTran("web","freebeds",sWebLanguage)%></th>
        <th width='150'><%=getTran("web","bedoccupancy",sWebLanguage)%></th>
    </tr>
<%
    Vector services = Service.getServicesWithBeds();
    double allbeds=0,alloccupiedbeds=0, totalBeds,occupiedBeds;
    Service service;
    for (int n = 0; n < services.size(); n++) {
        service = (Service) services.elementAt(n);
        totalBeds=service.getTotalBedCount();
        occupiedBeds= service.getOccupiedBedCount();
        allbeds+=totalBeds;
        alloccupiedbeds+=occupiedBeds;
        out.print("<tr class='list'><td>" + (service.code.indexOf(".") > -1 ? getTran("service", service.code.split("\\.")[0], sWebLanguage) + " &gt; " : "")
                + "<a href='javascript:selectMyService(\""+service.code+"\");'>"+getTran("service", service.code, sWebLanguage) + "</a></td>" +
                "<td>" + totalBeds + "</td>" +
                "<td>" + occupiedBeds + "</td>" +
                "<td><b>" + (totalBeds-occupiedBeds) + "</b></td>" +
                "<td>" + new DecimalFormat("##.#").format(100*occupiedBeds/totalBeds)+"%</td>"+
        "</tr>");
    }
    out.print("</table><table width='100%' cellspacing='1' cellpadding='0'><tr class='gray'>"
            +"<td>"+getTran("web", "total", sWebLanguage) + "</td>" +
            "<td width='150'>" + allbeds + "</td>" +
            "<td width='150'>" + alloccupiedbeds + "</td>" +
            "<td width='150'><b>" + (allbeds-alloccupiedbeds) + "</b></td>" +
            "<td width='150'>" + new DecimalFormat("##.#").format(100*alloccupiedbeds/allbeds)+"%</td>"+
    "</tr></table>");
    }
    else {
%>
<table class="list" width='100%' cellspacing="1" cellpadding="0">
    <tr class="admin">
        <td colspan='2'><%=(sServiceId.indexOf(".") > -1 ? getTran("service", sServiceId.split("\\.")[0], sWebLanguage) + " &gt; " : "") + getTran("service", sServiceId, sWebLanguage)%></td>
    </tr>
</table>
<table class="sortable" id="searchresults" width='100%' cellspacing="1" cellpadding="0">
    <tr class="gray">
        <td width='50'><%=getTran("web","bed",sWebLanguage)%></td>
        <td><%=getTran("web","patient",sWebLanguage)%></td>
    </tr>
<%
        Service service = Service.getService(request.getParameter("ServiceID"));
        Vector beds = service.getBeds();
        Bed bed;
        Encounter encounter;
        AdminPerson patient;
        for (int n = 0; n < beds.size(); n++) {
            bed = (Bed) beds.elementAt(n);
            encounter=Encounter.getActiveEncounterForBed(bed);
            patient=new AdminPerson();
            patient.firstname="-";
            if(encounter!=null){
                patient = encounter.getPatient();
            }
            out.print("<tr class='list'><td"+(patient.personid.length()>0 && !patient.personid.equalsIgnoreCase("-1")?" class='textred' ":"")
                +"><a href='javascript:selectMyBed(\""+bed.getUid()+"\",\""+bed.getName()+"\");'>"+bed.getName()+"</a></td>");

            if(patient.personid.length()>0 && !patient.personid.equalsIgnoreCase("-1")){
                out.print("<td class='textred'><a href='javascript:selectMyPatient(\""+patient.personid+"\");'>" + patient.firstname +" "+patient.lastname + "</a></td>");
            }
            else {
                out.print("<td/>");
            }
            out.print("</tr>");
        }
        out.print("</table>"
            +"<br/><center><input type='button' class='button' value='"+getTranNoLink("web","close",sWebLanguage)+"' onclick='window.close()'/></center>");
    }
%>
<script type="text/javascript">
    function selectMyService(sServiceId){
        window.open("<c:url value="/popup.jsp"/>?Page=statistics/bedoccupancyStatus.jsp&ServiceID="+sServiceId+"&ts=<%=getTs()%>","Popup"+new Date().getTime(),"toolbar=no, status=yes, scrollbars=yes, resizable=yes, width=300, height=400, menubar=no").moveTo((screen.width-800)/2,(screen.height-600)/2);
    }

    function selectMyPatient(sPatientId){
        window.open("<c:url value='/main.do'/>?Page=curative/index.jsp&ts=<%=ScreenHelper.getTs()%>&PersonID="+sPatientId,"Popup"+new Date().getTime(),"toolbar=no, status=yes, scrollbars=yes, resizable=yes, width=800, height=600, menubar=no").moveTo((screen.width-800)/2,(screen.height-600)/2);
    }

    function selectMyBed(sBedId, sBedName){
        window.open("<c:url value="/popup.jsp"/>?Page=statistics/bedoccupancyStatusDetail.jsp&BedID="+sBedId+"&BedName="+sBedName+"&ts=<%=getTs()%>","Popup"+new Date().getTime(),"toolbar=no, status=yes, scrollbars=yes, resizable=yes, width=700, height=400, menubar=no").moveTo((screen.width-800)/2,(screen.height-600)/2);
    }
</script>