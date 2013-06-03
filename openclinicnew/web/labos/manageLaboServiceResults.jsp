<%@include file="/includes/validateUser.jsp"%>
<%@ page import="be.openclinic.medical.RequestedLabAnalysis,java.util.*,be.openclinic.medical.LabRequest,java.util.Date" %>
<%=checkPermission("labos.servicelaboresults","select",activeUser)%>
<%!
    public class LabRow {
        int type;
        String tag;

        public LabRow(int type, String tag) {
            this.type = type;
            this.tag = tag;
        }
    }
%>
<%
    String serviceId=checkString(request.getParameter("serviceId"));
    String serviceText=checkString(request.getParameter("serviceText"));
    if(serviceId.length()==0){
        serviceId=activeUser.activeService.code;
        serviceText=activeUser.activeService.getLabel(sWebLanguage);
    }
%>
<form name="samplesForm" method="post">
    <%=writeTableHeader("Web","serviceLaboResults",sWebLanguage," doBack();")%>
    <table width="100%" cellspacing="0" cellpadding="1" class="menu">
        <tr>
            <td>
                <input class='text' TYPE="text" NAME="serviceText" readonly size="49" TITLE="<%=serviceText%>" VALUE="<%=serviceText%>" onkeydown="window.event.keyCode = '';return true;">
                <%
                    if(serviceId.length()>0){
                        %>
                            <img src="<c:url value='/_img/icon_info.gif'/>" class="link" alt="<%=getTran("Web","Information",sWebLanguage)%>" onclick='searchInfoService(samplesForm.serviceId)'/>
                        <%
                    }
                %>
                <%=ScreenHelper.writeServiceButton("buttonUnit", "serviceId", "serviceText", sWebLanguage, sCONTEXTPATH)%>
                &nbsp;
                <input TYPE="hidden" NAME="serviceId" VALUE="<%=serviceId%>">
                <%=getTran("web","stardate",sWebLanguage)%>
                <input type="text" class="text" size="12" maxLength="10" name="startdate" value="<%=checkString(request.getParameter("startdate")).length()>0?checkString(request.getParameter("startdate")):new SimpleDateFormat("dd/MM/yyyy").format(new Date())%>" id="trandate" OnBlur='checkDate(this)'>
                <script>writeMyDate("trandate","<c:url value="/_img/icon_agenda.gif"/>","<%=getTran("Web","PutToday",sWebLanguage)%>");</script>
                &nbsp;
                <input class="button" type="submit" name="submit" value="<%=getTran("web","find",sWebLanguage)%>"/>
            </td>
        </tr>
    </table>
</form>
<script type="text/javascript">
    function doBack(){
        window.location.href="<c:url value="/main.do"/>?Page=labos/index.jsp";
    }
</script>
<%
    if(request.getParameter("startdate")!=null && request.getParameter("serviceId")!=null){
        Date date=new SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("startdate"));
        SortedMap requestList = new TreeMap();
        Vector r = LabRequest.findServiceValidatedRequestsSince(serviceId,date,sWebLanguage,25);
        if(r.size()>20){
            out.print("<script>alert('"+getTran("web","onlylast20resultsareshown",sWebLanguage)+"');</script>");
        }
        for(int n=0;n<r.size();n++){
            if(n>r.size()-20){
                LabRequest labRequest = (LabRequest)r.elementAt(n);
                if(labRequest.getRequestdate()!=null){
                    requestList.put(new SimpleDateFormat("yyyyMMddHHmmss").format(labRequest.getRequestdate())+"."+labRequest.getServerid()+"."+labRequest.getTransactionid(),labRequest);
                }
            }
        }

        SortedMap groups = new TreeMap();
        Iterator iterator = requestList.keySet().iterator();
        while(iterator.hasNext()){
            LabRequest labRequest=(LabRequest)requestList.get(iterator.next());
            Enumeration enumeration = labRequest.getAnalyses().elements();
            while(enumeration.hasMoreElements()){
                RequestedLabAnalysis requestedLabAnalysis = (RequestedLabAnalysis)enumeration.nextElement();
                if(groups.get(requestedLabAnalysis.getLabgroup())==null){
                    groups.put(requestedLabAnalysis.getLabgroup(),new Hashtable());
                }
                ((Hashtable)groups.get(requestedLabAnalysis.getLabgroup())).put(requestedLabAnalysis.getAnalysisCode(),"1");
            }
        }

    %>
    <table class="list" width="100%">
        <tr>
            <td><%=getTran("web","analysis",sWebLanguage)%></td>
        <%
            Iterator requestsIterator = requestList.keySet().iterator();
            while (requestsIterator.hasNext()) {
                LabRequest labRequest = (LabRequest) requestList.get(requestsIterator.next());
                out.print("<td><b>"+labRequest.getPatientname()+"</b><br/>" + new SimpleDateFormat("dd/MM/yyyy HH:mm").format(labRequest.getRequestdate()) + "<br/><a href='javascript:showRequest("+labRequest.getServerid()+","+labRequest.getTransactionid()+")'><b>" + labRequest.getTransactionid() + "</b></a></td>");
            }
        %>
        </tr>
        <%
            String abnormal=MedwanQuery.getInstance().getConfigString("abnormalModifiers","*+*++*+++*-*--*---*h*hh*hhh*l*ll*lll*");
            Iterator groupsIterator = groups.keySet().iterator();
            while(groupsIterator.hasNext()){
                String groupname=(String)groupsIterator.next();
                out.print("<tr class='admin'><td colspan='"+(requestList.size()+1)+"'><b>"+MedwanQuery.getInstance().getLabel("labanalysis.groups",groupname,sWebLanguage)+"</b></td></tr>");
                Hashtable analysisList = (Hashtable)groups.get(groupname);
                Enumeration analysisEnumeration = analysisList.keys();
                while (analysisEnumeration.hasMoreElements()){
                    String analysisCode=(String)analysisEnumeration.nextElement();
                    out.print("<tr bgcolor='#FFFCD6'><td><b>"+MedwanQuery.getInstance().getLabel("labanalysis",analysisCode,sWebLanguage)+"</b></td>");
                    requestsIterator = requestList.keySet().iterator();
                    while(requestsIterator.hasNext()){
                        LabRequest labRequest = (LabRequest)requestList.get(requestsIterator.next());
                        RequestedLabAnalysis requestedLabAnalysis=(RequestedLabAnalysis)labRequest.getAnalyses().get(analysisCode);
                        String result=(requestedLabAnalysis!=null?(requestedLabAnalysis.getFinalvalidation()>0?requestedLabAnalysis.getResultValue():"?"):"");
                        boolean bAbnormal=(result.length()>0 && !result.equalsIgnoreCase("?") && abnormal.toLowerCase().indexOf("*"+checkString(requestedLabAnalysis.getResultModifier()).toLowerCase()+"*")>-1);
                        boolean newResult=(requestedLabAnalysis!=null && requestedLabAnalysis.getFinalvalidationdatetime()!=null && !requestedLabAnalysis.getFinalvalidationdatetime().before(date));
                        out.println("<td"+(bAbnormal?" bgcolor='#FF8C68'":"")+">"+(newResult?"<b><u>":"")+result+(bAbnormal?" "+checkString(requestedLabAnalysis.getResultModifier().toUpperCase()):"")+(newResult?"</u></b>":"")+"</td>");
                    }
                    out.print("</tr>");
                }
            }
        %>
    </table>
    </body>
    <script type="text/javascript">
        function showRequest(serverid,transactionid){
            window.open("<c:url value='/popup.jsp'/>?Page=labos/manageLabResult_view.jsp&ts=<%=getTs()%>&show."+serverid+"."+transactionid+"=1","Popup"+new Date().getTime(),"toolbar=no, status=yes, scrollbars=yes, resizable=yes, width=800, height=600, menubar=no");
        }
    </script>
<%
    }
%>