<%@ page import="be.openclinic.adt.Encounter" %>
<%@ page import="java.awt.*" %>
<%@ page import="java.util.*" %>
<%@ page import="be.openclinic.medical.Diagnosis" %>
<%@ page import="be.mxs.webapp.wl.servlet.http.RequestParameterParser" %>
<%@ page import="be.mxs.common.util.system.HTMLEntities" %>
<%@ page import="be.openclinic.medical.ReasonForEncounter" %>
<%@ page errorPage="/includes/error.jsp" %>
<%@ include file="/_common/templateAddIns.jsp" %> 
<%!
    private void saveDiagnosesToTable(Hashtable ICPCCodes, Hashtable ICD10Codes, String sTransactionUID, SessionContainerWO sessionContainerWO, Encounter encounter) {
        //First remove existing diagnosis
        Diagnosis.deleteForEncounter(encounter.getUid());
        Enumeration enumeration;
        String code;
        enumeration = ICPCCodes.keys();
        while (enumeration.hasMoreElements()) {
            code = (String) enumeration.nextElement();
            if (code.indexOf("ICPCCode") == 0) {
                if (ScreenHelper.checkString((String) ICPCCodes.get("Gravity" + code)).length() > 0 && ScreenHelper.checkString((String) ICPCCodes.get("Certainty" + code)).length() > 0) {
                    Diagnosis.saveTransactionDiagnosisWithServiceAndFlags(code,
                            ScreenHelper.checkString((String) ICPCCodes.get(code)),
                            ScreenHelper.checkString((String) ICPCCodes.get("Gravity" + code)),
                            ScreenHelper.checkString((String) ICPCCodes.get("Certainty" + code)),
                            sessionContainerWO.getPersonVO().personId.toString(),
                            "ICPCCode",
                            "icpc",
                            ScreenHelper.getSQLTime(),
                            sTransactionUID,
                            sessionContainerWO.getUserVO().getUserId().intValue(),
                            encounter,
                            ScreenHelper.checkString((String) ICPCCodes.get("POA" + code)),
                            ScreenHelper.checkString((String) ICPCCodes.get("NC" + code)),
                            ScreenHelper.checkString((String) ICPCCodes.get("Service" + code)),
                            ScreenHelper.checkString((String) ICPCCodes.get("Flags" + code))
                    );
                }
            }
        }
        // ICD10Codes toevoegen
        enumeration = ICD10Codes.keys();

        while (enumeration.hasMoreElements()) {
            code = (String) enumeration.nextElement();
            if (code.indexOf("ICD10Code") == 0) {
                if (ScreenHelper.checkString((String) ICD10Codes.get("Gravity" + code)).length() > 0 && ScreenHelper.checkString((String) ICD10Codes.get("Certainty" + code)).length() > 0) {
                    Diagnosis.saveTransactionDiagnosisWithServiceAndFlags(code,
                            ScreenHelper.checkString((String) ICD10Codes.get(code)),
                            ScreenHelper.checkString((String) ICD10Codes.get("Gravity" + code)),
                            ScreenHelper.checkString((String) ICD10Codes.get("Certainty" + code)),
                            sessionContainerWO.getPersonVO().personId.toString(),
                            "ICD10Code",
                            "icd10",
                            ScreenHelper.getSQLTime(),
                            sTransactionUID,
                            sessionContainerWO.getUserVO().getUserId().intValue(),
                            encounter,
                            ScreenHelper.checkString((String) ICD10Codes.get("POA" + code)),
                            ScreenHelper.checkString((String) ICD10Codes.get("NC" + code)),
                            ScreenHelper.checkString((String) ICD10Codes.get("Service" + code)),
                            ScreenHelper.checkString((String) ICD10Codes.get("Flags" + code))
                    );
                }
            }
        }
    }
%>
<%
	
    boolean isFindPatient = checkString(request.getParameter("findPatient")).length() > 0;
    boolean isNewPatient = checkString(request.getParameter("newPatient")).length() > 0;
    boolean isNewEncounter = checkString(request.getParameter("newEncounter")).length() > 0;
    boolean isSaveEncounter = checkString(request.getParameter("saveEncounter")).length() > 0;
    boolean isFindEncounter = checkString(request.getParameter("findEncounter")).length() > 0;
    String sPatientLastname = checkString(request.getParameter("patientLastname"));
    String sPatientFirstname = checkString(request.getParameter("patientFirstname"));
    String sPatientDateOfBirth = checkString(request.getParameter("patientDateOfBirth"));
    String sPatientGender = checkString(request.getParameter("patientGender"));
    String sPatientUID = checkString(request.getParameter("PatientUID"));
    String sActivePatientUID = checkString(request.getParameter("activePatientUID"));

    String sEditEncounterUID = checkString(request.getParameter("EditEncounterUID"));
    String sEditEncounterType = checkString(request.getParameter("EditEncounterType"));
    String sEditEncounterBegin = checkString(request.getParameter("EditEncounterBegin"));
    String sEditEncounterEnd = checkString(request.getParameter("EditEncounterEnd"));
    String sEditEncounterService = checkString(request.getParameter("EditEncounterService"));
    String sEditEncounterServiceName = checkString(request.getParameter("EditEncounterServiceName"));
    String sEditEncounterOutcome = checkString(request.getParameter("EditEncounterOutcome"));
    String sEditEncounterOrigin = checkString(request.getParameter("EditEncounterOrigin"));
    String sICPCHtml = "";
%>
<form name='EditPatientForm' id='EditPatientForm' method='post'
      action="<c:url value='/'/>popup.jsp?Page=statistics/quickFile.jsp&PopupHeight=600&PopupWidth=800">
<table class='list' border='0' width='100%' cellspacing='1'>
    <tr>
        <td class="admin"><%=getTran("web", "name", sWebLanguage)%>
        </td>
        <td class="admin2"><input type="bold" class="text" name="patientLastname" id="pl" value="<%=sPatientLastname%>"
                                  size="25"/></td>
        <td class="admin"><%=HTMLEntities.htmlentities(getTran("web", "firstname", sWebLanguage))%>
        </td>
        <td class="admin2"><input type="text" class="text" name="patientFirstname" id="pf" value="<%=sPatientFirstname%>"
                                  size="15"/></td>
        <td class="admin"><%=getTran("web", "dateofbirth", sWebLanguage)%>
        </td>
        <td class="admin2"><input type="text" class="text" name="patientDateOfBirth" id="pd" value="<%=sPatientDateOfBirth%>"
                                  size="12" maxlength="10" OnBlur='checkDate(this)'/></td>
        <td class="admin"><%=getTran("web", "gender", sWebLanguage)%>
        </td>
        <td class="admin2">
            <select class="text" name="patientGender" id="pg">
                <option value="M" <%=sPatientGender.equalsIgnoreCase("M") ? "selected" : ""%>>M</option>
                <option value="F" <%=sPatientGender.equalsIgnoreCase("F") ? "selected" : ""%>>F</option>
            </select>
        </td>
        <td class="admin2"><input type="submit" class="button" class="text" name="findPatient"
                                  value="<%=getTran("web","find",sWebLanguage)%>" size="1"/></td>
        <td class="admin2"><input name="newPatient" class="button" type="hidden"/><input type="button" class="button" class="text"
                                                                          name="newPatientButton"
                                                                          value="<%=getTran("web","new",sWebLanguage)%>"
                                                                          size="1" onclick="newpat();"/></td>
        <td class="admin2"><input type="button" class="button" class="text" name="clear"
                                  value="<%=getTran("web","clear",sWebLanguage)%>" size="1"
                                  onclick="clearPatient();EditPatientForm.document.getElementById('patientLastname').focus();"/>
        </td>
    </tr>
</table>

<script type="text/javascript">
    function newpat() {
        window.open("<c:url value='/statistics/'/>verifyPatient.jsp?lastname=" + document.getElementsByName('patientLastname')[0].value + "&firstname=" + document.getElementsByName('patientFirstname')[0].value + "&dateofbirth=" + document.getElementsByName('patientDateOfBirth')[0].value, "verifypatient", "toolbar=no, status=no, scrollbars=no, resizable=no, width=1, height=1, menubar=no").moveTo(-1000, -1000);
    }
</script>
<%
    if (isSaveEncounter) {
        isFindPatient = true;
        sPatientUID = sActivePatientUID;
        Encounter encounter = null;
        if (sEditEncounterUID.length() == 0) {
            encounter = new Encounter();
        } else {
            encounter = Encounter.get(sEditEncounterUID);
        }
        encounter.setManagerUID("4");
        encounter.setPatientUID(sPatientUID);
        encounter.setType(sEditEncounterType);
        try {
            encounter.setBegin(new SimpleDateFormat("dd/MM/yyyy").parse(sEditEncounterBegin));
            if(sEditEncounterEnd.length()>0){
            	encounter.setEnd(new SimpleDateFormat("dd/MM/yyyy").parse(sEditEncounterEnd));
            }
            encounter.setServiceUID(sEditEncounterService);
            encounter.setOrigin(sEditEncounterOrigin);
            encounter.setOutcome(sEditEncounterOutcome);
            encounter.setCreateDateTime(new java.util.Date());
            encounter.setUpdateDateTime(new java.util.Date());
            encounter.setVersion(1);
            encounter.setUpdateUser(activeUser.userid);
            encounter.setTransferDate(encounter.getBegin());
            encounter.store();
            SessionContainerWO sessionContainerWO = (SessionContainerWO) SessionContainerFactory.getInstance().getSessionContainerWO(request, SessionContainerWO.class.getName());
            sessionContainerWO.setPersonVO(MedwanQuery.getInstance().getPerson(sPatientUID));
            if(sessionContainerWO.getUserVO()==null){
            	sessionContainerWO.setUserVO(MedwanQuery.getInstance().getUser(activeUser.userid));
            }
            saveDiagnosesToTable(RequestParameterParser.getInstance().parseRequestParameters(request, "ICPCCode"), RequestParameterParser.getInstance().parseRequestParameters(request, "ICD10Code"), "", sessionContainerWO, encounter);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
    if (isFindEncounter) {
        Encounter encounter = Encounter.get(sEditEncounterUID);
        sEditEncounterUID = encounter.getUid();
        sEditEncounterType = encounter.getType();
        if (encounter.getBegin() != null) {
            sEditEncounterBegin = new SimpleDateFormat("dd/MM/yyyy").format(encounter.getBegin());
        }
        if (encounter.getEnd() != null) {
            sEditEncounterEnd = new SimpleDateFormat("dd/MM/yyyy").format(encounter.getEnd());
        }
        sEditEncounterService = encounter.getServiceUID();
        if (sEditEncounterService != null && sEditEncounterService.length() > 0 && encounter.getService()!=null) {
            sEditEncounterServiceName = encounter.getService().getLabel(sWebLanguage);
        }
        sEditEncounterOutcome = encounter.getOutcome();
        sEditEncounterOrigin = encounter.getOrigin();
        Vector diagnoses = Diagnosis.selectDiagnoses("", "", sEditEncounterUID, "", "", "", "", "", "", "", "", "", "");
        for (int n = 0; n < diagnoses.size(); n++) {
            Diagnosis diagnosis = (Diagnosis) diagnoses.elementAt(n);
            sICPCHtml += "<span id='" + diagnosis.getCodeType() + diagnosis.getCode() + "'><img src='" + sCONTEXTPATH + "/_img/icon_delete.gif' onclick='document.getElementById(\"" + diagnosis.getCodeType() + diagnosis.getCode() + "\").innerHTML=\"\";'/> <input type='hidden' name='" + diagnosis.getCodeType().toUpperCase() + "Code" + diagnosis.getCode() + "' value='" + (diagnosis.getLateralisation().length() == 0 ? "-" : diagnosis.getLateralisation() + "") + "'/>" +
                    "<input type='hidden' name='Gravity" + diagnosis.getCodeType().toUpperCase() + "Code" + diagnosis.getCode() + "' value='" + diagnosis.getGravity() + "'/>" +
                    "<input type='hidden' name='Certainty" + diagnosis.getCodeType().toUpperCase() + "Code" + diagnosis.getCode() + "' value='" + diagnosis.getCertainty() + "'/>" +
                    "<input type='hidden' name='POA" + diagnosis.getCodeType().toUpperCase() + "Code" + diagnosis.getCode() + "' value='" + diagnosis.getPOA() + "'/>" +
                    "<input type='hidden' name='NC" + diagnosis.getCodeType().toUpperCase() + "Code" + diagnosis.getCode() + "' value='" + diagnosis.getNC() + "'/>" +
                    "<input type='hidden' name='Service" + diagnosis.getCodeType().toUpperCase() + "Code" + diagnosis.getCode() + "' value='" + diagnosis.getServiceUid() + "'/>" +
                    "<input type='hidden' name='Flags" + diagnosis.getCodeType().toUpperCase() + "Code" + diagnosis.getCode() + "' value='" + diagnosis.getFlags() + "'/>" +
                    "" + diagnosis.getCodeType().toUpperCase() + " " + diagnosis.getCode() + " " + MedwanQuery.getInstance().getDiagnosisLabel(diagnosis.getCodeType(), diagnosis.getCode(), sWebLanguage) + " [" + diagnosis.getLateralisation() + "] (" + getTranNoLink("medical.diagnosis.certainty", diagnosis.getCertainty() + "", sWebLanguage) + "," + getTranNoLink("medical.diagnosis.gravity", diagnosis.getGravity() + "", sWebLanguage) + ")"+(diagnosis.getPOA().length()>0?" POA":"")+(diagnosis.getNC().length()>0?" NC":"")+(diagnosis.getFlags().length()==0?"":" ("+diagnosis.getFlags()+")")+"<br/></span>";
        }

    }
    if (isNewEncounter) {
        isFindPatient = true;
        sPatientUID = sActivePatientUID;
    }
    if (isNewPatient && sPatientLastname.trim().length() > 0) {
        AdminPerson patient = new AdminPerson();
        patient.dateOfBirth = checkString(request.getParameter("patientDateOfBirth"));
        patient.lastname = checkString(request.getParameter("patientLastname"));
        patient.firstname = checkString(request.getParameter("patientFirstname"));
        patient.gender = checkString(request.getParameter("patientGender"));
        patient.language = MedwanQuery.getInstance().getConfigString("DefaultLanguage","fr");
        patient.nativeCountry = MedwanQuery.getInstance().getConfigString("DefaultCountry","RW");
        patient.sourceid = "4";
        patient.updateuserid = activeUser.userid;
      	Connection ad_conn = MedwanQuery.getInstance().getAdminConnection();
        patient.saveToDB(ad_conn);
        ad_conn.close();
        sPatientUID = patient.personid;
        isFindPatient = true;
        isNewPatient = false;
    }
    if (isFindPatient || isFindEncounter) {
        //Eerst kijken of de ingevoerde pati�nt wel bestaat
        java.util.List persons = new java.util.Vector();
        if (!isNewPatient && (sPatientLastname.trim().length() > 0 || sPatientFirstname.trim().length() > 0 || sPatientDateOfBirth.trim().length() > 0 || sPatientUID.trim().length() > 0)) {
            if (isFindEncounter) {
              	Connection ad_conn = MedwanQuery.getInstance().getAdminConnection();
                persons.add(AdminPerson.getAdminPerson(ad_conn, sPatientUID));
                ad_conn.close();
            } else {
                persons = AdminPerson.getAllPatients("", "", "", sPatientLastname, sPatientFirstname, sPatientDateOfBirth, sPatientUID,"");
            }
            if (persons.size() > 1) {
%>
<table width="100%" class="list" border="0">
    <%
        for (int n = 0; n < persons.size(); n++) {
            AdminPerson activePerson = (AdminPerson) persons.get(n);
    %>
    <tr>
        <td class="admin2"><b>
            <a href="<c:url value='/'/>popup.jsp?Page=statistics/quickFile.jsp&PopupHeight=600&PopupWidth=800&findPatient=1&PatientUID=<%=activePerson.personid%>"><%=
            activePerson.personid%>
        </a></b>
    </td>
    <td class="admin2"><b><%=
        HTMLEntities.htmlentities(activePerson.lastname + " " + activePerson.firstname + "  �" + activePerson.dateOfBirth + " " + activePerson.gender)%>
    </b></td>
</tr>
<%
    }
%>
</table>
<%
} else if (persons.size() == 1) {
    AdminPerson activePerson = (AdminPerson) persons.get(0);
    sPatientUID = activePerson.personid;
%>
<table width="100%" class="list" border="0">
    <tr>
        <td class="admin2"><b><%=activePerson.personid%>
        </b></td>
        <td class="admin2"><b><%=
            HTMLEntities.htmlentities(activePerson.lastname + " " + activePerson.firstname + "  �" + activePerson.dateOfBirth + " " + activePerson.gender)%>
        </b></td>
        <td class="admin2"><input type="submit" class="text button" name="newEncounter"
                                  value="<%=getTran("web","newencounter",sWebLanguage)%>" size="1"/></td>
    </tr>
</table>
<%
    if (isNewEncounter || isFindEncounter) {
%>
<hr/>
<table class='list' border='0' width='100%' cellspacing='1'>
    <%-- type --%>
    <tr>
        <td class="admin" width="<%=sTDAdminWidth%>"><%=getTran("Web", "type", sWebLanguage)%>
        </td>
        <td class='admin2'>
            <select class='text' name='EditEncounterType' onchange="checkEncounterType();">
                <%
                    String sOptions[] = {"admission", "visit"};

                    for (int i = 0; i < sOptions.length; i++) {
                        out.print("<option value='" + sOptions[i] + "' ");
                        if (sEditEncounterType.equalsIgnoreCase(sOptions[i])) {
                            out.print(" selected");
                        }
                        out.print(">" + getTran("web", sOptions[i], sWebLanguage) + "</option>");
                    }

                %>

            </select>
        </td>
    </tr>
    <%-- date begin --%>
    <tr>
        <td class="admin"><%=HTMLEntities.htmlentities(getTran("Web", "begindate", sWebLanguage))%>
        </td>
        <td class="admin2">
            <%=
                writeDateField("EditEncounterBegin", "EditPatientForm", sEditEncounterBegin + "' onblur='validatePeriod();", sWebLanguage)%>
        </td>
    </tr>

    <%-- date end --%>
    <tr>
        <td class="admin"><%=getTran("Web", "enddate", sWebLanguage)%>
        </td>
        <td class="admin2">
            <%=
                writeDateField("EditEncounterEnd", "EditPatientForm", sEditEncounterEnd + "' onblur='validatePeriod();", sWebLanguage)%>
        </td>
    </tr>
    <%-- origin --%>
    <tr>
        <td class="admin" width="<%=sTDAdminWidth%>"><%=getTran("openclinic.chuk","urgency.origin",sWebLanguage)%>
        </td>
        <td class="admin2">
                <select class="text" name="EditEncounterOrigin" style="vertical-align:-2px;">
                    <option/>
                    <%
                        out.print(ScreenHelper.writeSelect("urgency.origin",sEditEncounterOrigin,sWebLanguage));
                    %>
                </select>
        </td>
    </tr>
    <%-- service --%>
    <tr id="Service">
        <td class="admin"><%=getTran("Web", "service", sWebLanguage)%>
        </td>
        <td class='admin2'>
            <input type="hidden" name="EditEncounterService" value="<%=sEditEncounterService%>">
            <input class="text" type="text" name="EditEncounterServiceName" readonly size="<%=sTextWidth%>"
                   value="<%=sEditEncounterServiceName%>" onblur="">
            <img src="<c:url value="/_img/icon_search.gif"/>" class="link"
                 alt="<%=getTran("Web","select",sWebLanguage)%>"
                 onclick="searchService('EditEncounterService','EditEncounterServiceName');">
            <img src="<c:url value="/_img/icon_delete.gif"/>" class="link"
                 alt="<%=getTran("Web","clear",sWebLanguage)%>"
                 onclick="EditPatientForm.EditEncounterService.value='';EditPatientForm.EditEncounterServiceName.value='';">
        </td>
    </tr>
    <%-- outcome --%>
    <tr>
        <td class="admin" width="<%=sTDAdminWidth%>"><%=getTran("Web", "outcome", sWebLanguage)%>
        </td>
        <td class="admin2">
            <select class="text" name="EditEncounterOutcome" style="vertical-align:-2px;">
                <option value=""><%=getTran("web", "choose", sWebLanguage)%>
                </option>
                <%=HTMLEntities.htmlentities(ScreenHelper.writeSelectUnsorted("encounter.outcome", sEditEncounterOutcome, sWebLanguage))%>
            </select>
        </td>
    </tr>
	<%
	    String sRfe= ReasonForEncounter.getReasonsForEncounterAsHtml(sEditEncounterUID,sWebLanguage,"_img/icon_delete.gif","deleteRFE($serverid,$objectid)");
	%>
    <tr class="admin">
        <td align="left" colspan="2"><a href="javascript:openPopup('healthrecord/findRFE.jsp&field=rfe&patientuid=<%=sPatientUID%>&encounterUid=<%=sEditEncounterUID%>&ts=<%=getTs()%>',700,400)"><%=getTran("openclinic.chuk","rfe",sWebLanguage)%> <%=getTran("Web.Occup","ICPC-2",sWebLanguage)%>/<%=getTran("Web.Occup","ICD-10",sWebLanguage)%></a></td>
    </tr>
    <tr>
        <td id="rfe" colspan="2"><%=sRfe%></td>
    </tr>
    <tr class="admin">
        <td align="left" colspan="2"><a
                href="javascript:openPopup('healthrecord/findICPC.jsp&ts=<%=getTs()%>&patientuid=<%=sPatientUID%>&showpatientencounters=1',700,400)"><%=
            getTran("openclinic.chuk", "diagnostic", sWebLanguage)%> <%=getTran("Web.Occup", "ICPC-2", sWebLanguage)%>
            /<%=getTran("Web.Occup", "ICD-10", sWebLanguage)%>
        </a></td>
    </tr>
    <tr>
        <td id='icpccodes' colspan="2" align="left"><%=HTMLEntities.htmlentities(sICPCHtml)%></td>
    </tr>
</table>
<%=ScreenHelper.setFormButtonsStart()%>
<input class='button' type="button" name="saveMe" value='<%=getTranNoLink("Web","save",sWebLanguage)%>'
       onclick='doSubmit();'>&nbsp;
<input type="hidden" name="saveEncounter"/>
<input type="hidden" name="EditEncounterUID" value="<%=sEditEncounterUID%>"/>
<%=ScreenHelper.setFormButtonsStop()%>
<%
} else {
%>
<table width="100%" class="list" border="0">
    <%
        Vector encounters = Encounter.selectLastEncounters(activePerson.personid);
        for (int n = 0; n < encounters.size(); n++) {
            Encounter encounter = (Encounter) encounters.elementAt(n);
            if (encounter.getBegin() != null) {
    %>
    <tr>
        <td class="admin2"><b><a
                href="<c:url value='/'/>popup.jsp?Page=statistics/quickFile.jsp&PopupHeight=600&PopupWidth=800&EditEncounterUID=<%=encounter.getUid()%>&PatientUID=<%=activePerson.personid%>&findEncounter=1"/><%=
            new SimpleDateFormat("dd/MM/yyyy").format(encounter.getBegin()) + " -> " + (encounter.getEnd() == null ? "" : new SimpleDateFormat("dd/MM/yyyy").format(encounter.getEnd()))%>
        </b></td>
        <td class="admin2"><b><%=
            (encounter.getService() == null ? "" : encounter.getService().getLabel(sWebLanguage)) + (encounter.getOutcome() == null ? "" : " (" + getTran("encounter.outcome", encounter.getOutcome(), sWebLanguage) + ")")%>
        </b></td>
    </tr>
    <%
            }
        }
    %>
</table>
<%
                }
            }
        }
    }
%>
<input type="hidden" name="activePatientUID" value="<%=sPatientUID%>"/>
</form>

<script type="text/javascript">
    function doSubmit() {
        var begin = createDate(document.getElementsByName("EditEncounterBegin")[0].value);
        var end = createDate(document.getElementsByName("EditEncounterEnd")[0].value);
        if (document.getElementsByName("EditEncounterEnd")[0].value.length>0 && end < begin) {
            alert('<%=getTran("web","beginandendinverted",sWebLanguage)%>');
        }
        else if (end > new Date()) {
            alert('<%=getTran("web","endinfuture",sWebLanguage)%>');
        }
        else {
            document.getElementsByName("saveEncounter")[0].value = "true";
            document.getElementById("EditPatientForm").submit();
        }
    }

    function validatePeriod() {
        if (document.getElementsByName("EditEncounterBegin")[0].value.length > 0 && document.getElementsByName("EditEncounterEnd")[0].value.length > 0) {
            var begin = createDate(document.getElementsByName("EditEncounterBegin")[0].value);
            var end = createDate(document.getElementsByName("EditEncounterEnd")[0].value);
            if (end.getTime() - begin.getTime() > 180 * 24 * 60 * 60000) {
                alert('<%=getTran("web","longadmission",sWebLanguage)%>');
            }
        }
    }

    function createDate(sdate) {
        var d = new Date();
        d.setYear(sdate.substring(6, 10) * 1);
        d.setMonth(sdate.substring(3, 5) * 1 - 1);
        d.setDate(sdate.substring(0, 2) * 1);
        return d;
    }
    function clearPatient() {
        document.getElementById('pl').value = '';
        document.getElementById('pf').value = '';
        document.getElementById('pd').value = '';
        document.getElementById('pg').value = '';
    }

    function searchService(serviceUidField, serviceNameField) {
        openPopup("/_common/search/searchService.jsp&ts=<%=getTs()%>&VarCode=" + serviceUidField + "&VarText=" + serviceNameField);
        if (document.getElementsByName(serviceNameField)[0])document.getElementsByName(serviceNameField)[0].focus();
    }

    window.setTimeout("EditPatientForm.patientLastname.focus()",100);
</script>
