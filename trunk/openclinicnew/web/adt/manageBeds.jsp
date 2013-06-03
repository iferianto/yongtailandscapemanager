<%@ page import="be.openclinic.adt.Bed"%>
<%@ page import="java.util.Vector" %>
<%@include file="/includes/validateUser.jsp"%>

<%=checkPermission("adt.managebeds","all",activeUser)%>

<%=sJSSORTTABLE%>

<%
    String sAction = checkString(request.getParameter("Action"));

    // Find Params
    String sFindBedName        = checkString(request.getParameter("FindBedName"));
    String sFindBedService     = checkString(request.getParameter("FindBedService"));
    String sFindBedServiceName = checkString(request.getParameter("FindBedServiceName"));

    // Edit Params
    String sEditUID        = checkString(request.getParameter("EditUID"));
    String sEditName       = checkString(request.getParameter("EditName"));
    String sEditBedService = checkString(request.getParameter("EditBedService"));
    String sEditPriority   = checkString(request.getParameter("EditPriority"));
    String sEditLocation   = checkString(request.getParameter("EditLocation"));
    String sEditComment    = checkString(request.getParameter("EditComment"));

    String sEditBedServiceName = checkString(request.getParameter("EditBedServiceName"));
    if(Debug.enabled){
        Debug.println("\n ############ Find Params ############ " +
                      "\n FindBedName: " + sFindBedName +
                      "\n FindBedService: " + sFindBedService +
                      "\n FindBedServiceName: " + sFindBedServiceName +
                      "\n FindBedService: " + sFindBedService +
                      "\n #####################################" +
                      "\n ############ Edit Params ############ " +
                      "\n EditUID: " + sEditUID +
                      "\n EditName: " + sEditName +
                      "\n EditBedService: " + sEditBedService +
                      "\n EditPriority: " + sEditPriority +
                      "\n EditLocation: " + sEditLocation +
                      "\n EditComment: " + sEditComment +
                      "\n #####################################"
                     );
    }

    if(sAction.equals("SAVE")){
        Bed tmpBed = new Bed();
        if(sEditUID.length() > 0 ){//update
            tmpBed = Bed.get(sEditUID);
        }else{//insert
            tmpBed.setCreateDateTime(ScreenHelper.getSQLDate(getDate()));
        }
        tmpBed.setName(sEditName);
        Service sTMP = Service.getService(sEditBedService);
        if(sTMP == null){
            sTMP = new Service();
        }
        tmpBed.setService(sTMP);
        int priority=1;
        try{
            priority=Integer.parseInt(sEditPriority);
        }
        catch(Exception e){}
        tmpBed.setPriority(priority);
        tmpBed.setLocation(sEditLocation);
        tmpBed.setComment(sEditComment);
        tmpBed.setUpdateDateTime(ScreenHelper.getSQLDate(getDate()));
        tmpBed.setUpdateUser(activeUser.personid);
        tmpBed.store();
        sEditUID = tmpBed.getUid();
    }
    if(sEditUID.length() > 0){
        Bed tmpBed          = Bed.get(sEditUID);
        sEditUID            = tmpBed.getUid();
        sEditName           = tmpBed.getName();
        sEditPriority       = Integer.toString(tmpBed.getPriority());
        sEditLocation       = tmpBed.getLocation();
        sEditComment        = tmpBed.getComment();
        sEditBedService     = tmpBed.getService().code;
        sEditBedServiceName = getTran("Service",sEditBedService,sWebLanguage);
    }

    if(sAction.equals("SEARCH") || sAction.equals("")){
%>
<%-- BEGIN FIND BLOCK--%>
<form name='FindBedForm' method='POST' action='<c:url value="/main.do"/>?Page=adt/manageBeds.jsp&ts=<%=getTs()%>'>
    <%=writeTableHeader("Web","manageBeds",sWebLanguage," doBack();")%>
    <table class='list' width='100%' cellspacing='1' onKeyDown='if(event.keyCode==13){doFind();return false;}else{return true;}'>
        <%-- service --%>
        <tr>
            <td class="admin2"><%=getTran("Web","service",sWebLanguage)%></td>
            <td class="admin2">
                <input type="hidden" name="FindBedService" value="<%=sFindBedService%>">
                <input class="text" type="text" name="FindBedServiceName" readonly size="<%=sTextWidth%>" value="<%=sFindBedServiceName%>">
                <img src="<c:url value="/_img/icon_search.gif"/>" class="link" alt="<%=getTranNoLink("Web","select",sWebLanguage)%>" onclick="searchService('FindBedService','FindBedServiceName');">
                <img src="<c:url value="/_img/icon_delete.gif"/>" class="link" alt="<%=getTranNoLink("Web","clear",sWebLanguage)%>" onclick="FindBedForm.FindBedService.value='';FindBedForm.FindBedServiceName.value='';">
            </td>
        </tr>
        <%-- name --%>
        <tr>
            <td class="admin2" width="<%=sTDAdminWidth%>"><%=getTran("Web","name",sWebLanguage)%></td>
            <td class="admin2"><input class='text' name='FindBedName' value='<%=sFindBedName%>' size="<%=sTextWidth%>"></td>
        </tr>
        <%-- buttons --%>
        <tr>
            <td class="admin2"/>
            <td class="admin2">
                <input class='button' type='button' name='buttonfind' value='<%=getTran("Web","search",sWebLanguage)%>' onclick='doFind();'>&nbsp;
                <input class='button' type='button' name='buttonclear' value='<%=getTran("Web","Clear",sWebLanguage)%>' onclick='doClear();'>&nbsp;
                <input class='button' type='button' name='buttonnew' value='<%=getTran("Web","new",sWebLanguage)%>' onclick='doNew();'>&nbsp;
                <input class='button' type="button" name="Backbutton" value='<%=getTranNoLink("Web","Back",sWebLanguage)%>' onclick="doBack();">
            </td>
        </tr>
    </table>
    <input type='hidden' name='Action' value=''>
</form>

<%-- END FIND BLOCK --%>

<%-- BEGIN FINDRESULTS BLOCK --%>

<%
    }

    if (sAction.equals("SEARCH")) {
        StringBuffer sbResults = new StringBuffer();
        Vector vBeds = null;

        try {
            vBeds = Bed.selectBeds("","",sFindBedName,sFindBedService,"","","");

            Iterator iter = vBeds.iterator();
            Bed bTmp;
            String sClass = "";
            String sServiceUID = "";
            String sServiceName = "";

            while (iter.hasNext()) {
                if (sClass.equals("")) {
                    sClass = "1";
                } else {
                    sClass = "";
                }

                bTmp = (Bed) iter.next();
                sServiceUID = checkString(bTmp.getServiceUID());
                if (sServiceUID.length() > 0) {
                    sServiceName = getTran("Service", sServiceUID, sWebLanguage);
                } else {
                    sServiceName = "";
                }

                sbResults.append("<tr class='list" + sClass + "' " +
                        " onmouseover=\"this.style.cursor='hand';\" " +
                        " onmouseout=\"this.style.cursor='default';\" " +
                        " onclick=\"doSelect('" + checkString(bTmp.getUid()) + "');\">" +
                        "<td>" + checkString(bTmp.getName()) + "</td>" +
                        "<td>" + sServiceName + "</td>" +
                        "</tr>"
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (sbResults.length() == 0) {
            out.print(getTran("web", "norecordsfound", sWebLanguage));
        } else {
%>
            <table width='100%' cellspacing="0" cellpadding="0" class="sortable" id="searchresults">
                <tr class="admin">
                    <td width='30%'><%=getTran("Web","name",sWebLanguage)%></td>
                    <td width='*'><%=getTran("Web","service",sWebLanguage)%></td>
                </tr>
                <%=sbResults%>
            </table>

            <div><%=vBeds.size()%> <%=getTran("web","recordsfound",sWebLanguage)%></div>
        <%
        }
    }
%>

<%-- END FINDRESULTS BLOCK --%>

<%-- BEGIN EDIT BLOCK--%>

<%
    if(sAction.equals("NEW") || sAction.equals("SELECT") || sAction.equals("SAVE")){
%>
<form name='EditBedForm' method='POST' action='<c:url value="/main.do"/>?Page=adt/manageBeds.jsp&ts=<%=getTs()%>'>
    <%=writeTableHeader("Web","manageBeds",sWebLanguage," doBack();")%>
    <table class="list" width="100%" cellspacing="1">
        <%-- service --%>
        <tr>
            <td class="admin" width="<%=sTDAdminWidth%>"><%=getTran("Web","service",sWebLanguage)%> *</td>
            <td class="admin2">
                <input type="hidden" name="EditBedService" value="<%=sEditBedService%>">
                <input class="text" type="text" name="EditBedServiceName" readonly size="<%=sTextWidth%>" value="<%=sEditBedServiceName%>">
                <img src="<c:url value="/_img/icon_search.gif"/>" class="link" alt="<%=getTranNoLink("Web","select",sWebLanguage)%>" onclick="searchService('EditBedService','EditBedServiceName');">
                <img src="<c:url value="/_img/icon_delete.gif"/>" class="link" alt="<%=getTranNoLink("Web","clear",sWebLanguage)%>" onclick="EditBedForm.EditBedService.value='';EditBedForm.EditBedServiceName.value='';">
            </td>
        </tr>
        <%-- name --%>
        <tr>
            <td class="admin"><%=getTran("Web","name",sWebLanguage)%> *</td>
            <td class="admin2"><input class='text' type='text' name='EditName' value='<%=sEditName%>' size="<%=sTextWidth%>"></td>
        </tr>

        <%-- priority --%>
        <tr>
            <td class="admin"><%=getTran("Web","priority",sWebLanguage)%></td>
            <td class="admin2"><input class='text' type='text' name='EditPriority' value='<%=sEditPriority%>' size="2"></td>
        </tr>
        <%-- location --%>
        <tr>
            <td class="admin"><%=getTran("Web","location",sWebLanguage)%></td>
            <td class="admin2">
                <input class='text' type='text' name='EditLocation' value='<%=sEditLocation%>' size="<%=sTextWidth%>">
                <img src="<c:url value="/_img/icon_view.gif"/>" class="link" alt="<%=getTran("Web","view",sWebLanguage)%>" onclick="openFile()">
                <br>
                <%
                    if ((sEditLocation.length()>0)&&(sEditLocation.indexOf(".")>-1)){
                        String sExtension = sEditLocation.substring(sEditLocation.indexOf(".")+1).toLowerCase();

                        if (MedwanQuery.getInstance().getConfigString("image_extensions","gif,jpg,bmp").toLowerCase().indexOf(sExtension)>-1){
                          %>
                    <img id="myImg" src="<%=MedwanQuery.getInstance().getConfigString("documentsdir","adt/documents/")+"/"+sEditLocation%>" alt="" width="<%=MedwanQuery.getInstance().getConfigString("adt.bed.imagewidth","250")%>" border=1>
                        <%
                        }
                    }
                    %>
            </td>
        </tr>
        <%-- comment --%>
        <tr>
            <td class="admin"><%=getTran("Web","comment",sWebLanguage)%></td>
            <td class="admin2"><%=writeTextarea("EditComment","","","",sEditComment)%></td>
        </tr>
        <%-- Action,UID --%>
        <input type='hidden' name='Action' value=''>
        <input type='hidden' name='EditUID' value='<%=sEditUID%>'>
        <%-- button --%>
        <%=ScreenHelper.setFormButtonsStart()%>
            <input class='button' type="button" name="saveButton" value='<%=getTranNoLink("Web","save",sWebLanguage)%>' onclick="doSave();">&nbsp;
            <input class='button' type="button" name="Backbutton" value='<%=getTranNoLink("Web","Back",sWebLanguage)%>' onclick="doBackToSearch();">
            <input class='button' type="button" name="newButton" value='<%=getTranNoLink("Web","new",sWebLanguage)%>' onclick="doNewBed();">
        <%=ScreenHelper.setFormButtonsStop()%>
    </table>
</form>
<form target="_newForm" name="uploadForm" action="<c:url value='/adt/storeDocument.jsp'/>" method="post" enctype="multipart/form-data">
    <%=writeTableHeader("Web","upload_file",sWebLanguage," doBack();")%>
    <table class="list" width="100%" cellspacing="1">
        <input name="ReturnField" value="EditLocation" type="hidden"/>
        <tr>
            <td class="admin" width="<%=sTDAdminWidth%>">
                <%=getTran("web","doc_upload",sWebLanguage)%>
                <br>
            </td>
            <td class="admin2">
                <input class='text' name="filename" type="file" title="" size='<%=sTextWidth%>'/>
                &nbsp;&nbsp;<input class='button' name="sendimage" type="submit" value="<%=getTranNoLink("web","upload_file",sWebLanguage)%>">
            </td>
        </tr>
    </table>
    <%=getTran("Web","colored_fields_are_obligate",sWebLanguage)%>
</form>

<%
    }
%>
<%-- END EDIT BLOCK--%>

<script>

<%-- Find Block --%>

    function doClear(){
        FindBedForm.FindBedService.value = "";
        FindBedForm.FindBedServiceName.value = "";
        FindBedForm.FindBedName.value = "";

    }
    function doFind(){
        if(FindBedForm.FindBedService.value != "" || FindBedForm.FindBedName.value != ""){
            FindBedForm.Action.value = "SEARCH";
            FindBedForm.buttonfind.disabled = true;
            FindBedForm.submit();
        }else{
            var popupUrl = "<%=sCONTEXTPATH%>/_common/search/template.jsp?Page=okPopup.jsp&ts=<%=getTs()%>&labelType=web.manage&labelID=datamissing";
            var modalities = "dialogWidth:266px;dialogHeight:163px;center:yes;scrollbars:no;resizable:no;status:no;location:no;";
            window.showModalDialog(popupUrl,'',modalities);
        }
    }

    function doNew(){
        FindBedForm.Action.value = "NEW";
        FindBedForm.submit();
    }

<%-- End Find Block --%>

<%-- FindResults Block --%>

    function doSelect(id){
        window.location.href="<c:url value='/main.do'/>?Page=adt/manageBeds.jsp&Action=SELECT&EditUID=" + id + "&ts=<%=getTs()%>";
    }

<%-- End FindResults Block --%>

<%-- Edit Block --%>

    function doBack(){
        window.location.href="<c:url value='/main.do'/>?Page=system/menu.jsp&ts=<%=getTs()%>";
    }

    function doBackToSearch(){
        window.location.href="<c:url value='/main.do'/>?Page=adt/manageBeds.jsp&ts=<%=getTs()%>";
    }

    <%-- search service --%>
    function searchInfoService(sObject){
      if(sObject.value.length > 0){
        openPopup("/_common/search/serviceInformation.jsp&ServiceID="+sObject.value + "&ViewCode=on");
      }
    }

    function doNewBed(){
        EditBedForm.newButton.disabled = true;
        EditBedForm.Action.value = "NEW";
        EditBedForm.EditName.value = "";
        EditBedForm.EditPriority.value="";
        EditBedForm.EditLocation.value="";
        EditBedForm.EditComment.value="";
        EditBedForm.EditUID.value="";
        EditBedForm.submit();
    }

    function doSave(){
        if(EditBedForm.EditBedService.value == ""){
            var popupUrl = "<%=sCONTEXTPATH%>/_common/search/okPopup.jsp?ts=<%=getTs()%>&labelType=web&labelID=no_bed_service";
            var modalities = "dialogWidth:266px;dialogHeight:163px;center:yes;scrollbars:no;resizable:no;status:no;location:no;";
            window.showModalDialog(popupUrl,'',modalities);
        }else if(EditBedForm.EditName.value == ""){
            var popupUrl = "<%=sCONTEXTPATH%>/_common/search/okPopup.jsp?ts=<%=getTs()%>&labelType=web&labelID=no_bed_name";
            var modalities = "dialogWidth:266px;dialogHeight:163px;center:yes;scrollbars:no;resizable:no;status:no;location:no;";
            window.showModalDialog(popupUrl,'',modalities);
        }else if(!isNumber(EditBedForm.EditPriority.value)){
            var popupUrl = "<%=sCONTEXTPATH%>/_common/search/okPopup.jsp?ts=<%=getTs()%>&labelType=web&labelID=bed_invalid_priority";
            var modalities = "dialogWidth:266px;dialogHeight:163px;center:yes;scrollbars:no;resizable:no;status:no;location:no;";
            window.showModalDialog(popupUrl,'',modalities);
        }else{
            EditBedForm.saveButton.disabled = true;
            EditBedForm.Action.value = "SAVE";
            EditBedForm.submit();
        }
    }

    function isNumber(val){
        if (isNaN(val)){
            return false;
        }else{
            return true;
        }
    }

    function openFile(){
        if (EditBedForm.EditLocation.value.length>0){
            window.open("<%=MedwanQuery.getInstance().getConfigString("documentsdir","adt/documents/")+"/"+sEditLocation%>","","height=500, width=550, toolbar=no, status=no, scrollbars=no, resizable=no, menubar=no");
        }
    }

    function searchService(serviceUidField,serviceNameField){
        openPopup("/_common/search/searchService.jsp&ts=<%=getTs()%>&VarCode="+serviceUidField+"&VarText="+serviceNameField);
    }

<%-- End Edit Block --%>
</script>