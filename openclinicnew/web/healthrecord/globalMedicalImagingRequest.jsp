<%@ page import="java.util.*" %>
<%@include file="/includes/validateUser.jsp"%>
<%@page errorPage="/includes/error.jsp"%>
<%=checkPermission("occup.medicalimagingrequest","select",activeUser)%>

<form name="transactionForm" id="transactionForm" method="POST" action="<c:url value="/healthrecord/updateTransaction.do"/>?ts=<%=getTs()%>" onclick="setSaveButton(event);" onkeyup="setSaveButton(event);">
    <bean:define id="transaction" name="be.mxs.webapp.wl.session.SessionContainerFactory.WO_SESSION_CONTAINER" property="currentTransactionVO"/>
    <input type="hidden" id="transactionId" name="currentTransactionVO.<TransactionVO[hashCode=<bean:write name="transaction" scope="page" property="transactionId"/>]>.transactionId" value="<bean:write name="transaction" scope="page" property="transactionId"/>"/>
    <input type="hidden" id="serverId" name="currentTransactionVO.<TransactionVO[hashCode=<bean:write name="transaction" scope="page" property="transactionId"/>]>.serverId" value="<bean:write name="transaction" scope="page" property="serverId"/>"/>
    <input type="hidden" id="transactionType" name="currentTransactionVO.<TransactionVO[hashCode=<bean:write name="transaction" scope="page" property="transactionId"/>]>.transactionType" value="<bean:write name="transaction" scope="page" property="transactionType"/>"/>
    <input type="hidden" readonly name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_SCREEN_MOBILE_UNIT" property="itemId"/>]>.value" value="medwan.common.true"/>
    <input type="hidden" readonly name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_CONTEXT_DEPARTMENT" property="itemId"/>]>.value" value="<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_CONTEXT_DEPARTMENT" translate="false" property="value"/>"/>
    <input type="hidden" readonly name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_CONTEXT_CONTEXT" translate="false" property="itemId"/>]>.value" value="<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_CONTEXT_CONTEXT" translate="false" property="value"/>"/>
    <input type="hidden" readonly name="be.mxs.healthrecord.updateTransaction.actionForwardKey" value="/main.do?Page=curative/index.jsp&ts=<%=getTs()%>"/>

    <%=writeHistoryFunctions(((TransactionVO)transaction).getTransactionType(),sWebLanguage)%>
    <%=contextHeader(request,sWebLanguage,"")%>

    <%
        SessionContainerWO sessionContainerWO = (SessionContainerWO) SessionContainerFactory.getInstance().getSessionContainerWO(request, SessionContainerWO.class.getName());
        String sIdentificationRX = "";
        if (sessionContainerWO.getCurrentTransactionVO().getTransactionId().intValue() > 0) {
            ItemVO item = sessionContainerWO.getCurrentTransactionVO().getItem(sPREFIX+"ITEM_TYPE_MIR2_IDENTIFICATION_RX");
            if (item != null) {
                sIdentificationRX = item.getValue();
            }
        }
        else {
            String sServerID = sessionContainerWO.getCurrentTransactionVO().getServerId() + "";
            sIdentificationRX = "4" + ScreenHelper.padLeft(sServerID,"0",3) + MedwanQuery.getInstance().getNewOccupCounterValue("IdentificationRXID");
        }
    %>

    <table class="list" width="100%" cellspacing="1">
        <%-- DATE --%>
        <tr>
            <td class="admin" width="<%=sTDAdminWidth%>">
                <a href="javascript:openHistoryPopup();" title="<%=getTran("Web.Occup","History",sWebLanguage)%>">...</a>&nbsp;
                <%=getTran("Web.Occup","medwan.common.date",sWebLanguage)%>
            </td>
            <td class="admin2">
                <input type="text" class="text" size="12" value="<mxs:propertyAccessorI18N name="transaction" scope="page" property="updateTime" formatType="date" format="dd-mm-yyyy"/>" name="currentTransactionVO.<TransactionVO[hashCode=<bean:write name="transaction" scope="page" property="transactionId"/>]>.updateTime" id="trandate" OnBlur="checkDate(this);">
                <script>writeMyDate("trandate","<c:url value="/_img/icon_agenda.gif"/>","<%=getTran("Web","PutToday",sWebLanguage)%>");</script>
            </td>

            <%-- IDENTIFICATIE NR RX --%>
            <td class="admin" width="<%=sTDAdminWidth%>"><%=getTran("Web.Occup",sPREFIX+"item_type_mir_identification_rx",sWebLanguage)%></td>
            <td class="admin2">
                <input type="text" id="rxid" class="text" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_IDENTIFICATION_RX" property="itemId"/>]>.value" value="<%=sIdentificationRX%>" READONLY>
            </td>
        </tr>

        <%-- DEMAND 1 ---------------------------------------------------------------------------%>
        <tr class="gray">
            <td colspan="4"><%=getTran("web.occup","demand",sWebLanguage)%> 1</td>
        </tr>

        <%-- TYPE --%>
        <tr>
            <td class="admin"><%=getTran("Web.Occup",sPREFIX+"item_type_mir_type",sWebLanguage)%></td>
            <td class="admin2">
                <select id="examination" class="text" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_TYPE" property="itemId"/>]>.value">
                    <option/>
                    <%
                        String sType = checkString(request.getParameter("type"));
                        if(sType.length() == 0){
                            ItemVO item = sessionContainerWO.getCurrentTransactionVO().getItem(sPREFIX+"ITEM_TYPE_MIR2_TYPE");
                            if (item!=null){
                                sType = checkString(item.getValue());
                            }
                        }
                    %>
                    <%=ScreenHelper.writeSelect("mir_type",sType,sWebLanguage,false,true)%>
                </select>
            </td>

            <%-- SPECIFICATION --%>
            <td class="admin"><%=getTran("web.occup","specification",sWebLanguage)%></td>
            <td class="admin2">
                <textarea id="SPECIFICATION" onKeyup="resizeTextarea(this,10);limitChars(this,255);" <%=setRightClick("ITEM_TYPE_MIR2_SPECIFICATION")%> class="text" cols="80" rows="2" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_SPECIFICATION" property="itemId"/>]>.value"><mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_SPECIFICATION" property="value"/></textarea>
            </td>
        </tr>

        <tr>
            <%-- URGENCY --%>
            <td class="admin"><%=getTran("Web.Occup","urgency",sWebLanguage)%></td>
            <td class="admin2">
                <input <%=setRightClick("ITEM_TYPE_OTHER_REQUESTS_URGENT")%> type="checkbox" id="urgency" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_URGENT" property="itemId"/>]>.value" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_URGENT;value=medwan.common.true" property="value" outputString="checked"/> value="medwan.common.true">
            </td>

            <%-- REASON --%>
            <td class="admin"><%=getTran("Web.Occup","examinationreason",sWebLanguage)%>&nbsp;</td>
            <td class="admin2">
                <textarea id="reason" onKeyup="resizeTextarea(this,10);limitChars(this,255);" <%=setRightClick("ITEM_TYPE_MIR2_EXAMINATIONREASON")%> class="text" cols="80" rows="2" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_EXAMINATIONREASON" property="itemId"/>]>.value"><mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_EXAMINATIONREASON" property="value"/></textarea>
            </td>
        </tr>

        <tr>
            <%-- ORIGINAL MODIFIED --%>
            <td class="admin"><%=getTran("Web.Occup","original_modified",sWebLanguage)%></td>
            <td class="admin2">
                <input type="checkbox" id="modified" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_ORIGINAL_MODIFIED" property="itemId"/>]>.value" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_ORIGINAL_MODIFIED;value=medwan.common.true" property="value" outputString="checked"/> value="medwan.common.true" onclick="doModified('modified','modifiedreason');">
            </td>

            <%-- REASON --%>
            <td class="admin"><%=getTran("Web.Occup","medwan.common.reason",sWebLanguage)%>&nbsp;</td>
            <td class="admin2">
                <textarea id="modifiedreason" onKeyup="resizeTextarea(this,10);limitChars(this,255);" <%=setRightClick("ITEM_TYPE_MIR2_ORIGINAL_MODIFIED_REASON")%> class="text" cols="80" rows="2" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_ORIGINAL_MODIFIED_REASON" property="itemId"/>]>.value"><mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_ORIGINAL_MODIFIED_REASON" property="value"/></textarea>
            </td>
        </tr>

        <%
            if(activeUser.getAccessRight("occup.medicalimagingrequest.execute.select")){
                %>
                    <tr>
                        <%-- EXECUTION BY --%>
                        <td class="admin"><%=getTran("Web.Occup","medwan.healthrecord.executionby",sWebLanguage)%></td>
                        <td class="admin2">
                            <input type="radio" onclick="doExecution('executionreason',true);" onDblClick="uncheckRadio(this);" id="rbexecutionyes" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_PRESTATION" property="itemId"/>]>.value" value="medwan.common.yes" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_PRESTATION;value=medwan.common.yes" property="value" outputString="checked"/>><%=getLabel("Web.Occup","medwan.common.yes",sWebLanguage,"rbexecutionyes")%>
                            <input type="radio" onclick="doExecution('executionreason',false);" onDblClick="uncheckRadio(this);" id="rbexecutionno" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_PRESTATION" property="itemId"/>]>.value" value="medwan.common.no" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_PRESTATION;value=medwan.common.no" property="value" outputString="checked"/>><%=getLabel("Web.Occup","medwan.common.no",sWebLanguage,"rbexecutionno")%>
                        </td>

                        <%-- REASON --%>
                        <td class="admin"><%=getTran("Web.Occup","medwan.common.reason",sWebLanguage)%></td>
                        <td class="admin2">
                            <textarea id="executionreason" onKeyup="resizeTextarea(this,10);limitChars(this,255);" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_PRESTATION_REASON" property="itemId"/>]>.value" class="text" rows="2" cols="80"><mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_PRESTATION_REASON" property="value"/></textarea>
                        </td>
                    </tr>

                    <tr>
                        <%-- VALIDATION BY --%>
                        <td class="admin"><%=getTran("Web.Occup","medwan.healthrecord.validationby",sWebLanguage)%></td>
                        <td class="admin2">
                            <input <%=setRightClick("ITEM_TYPE_OTHER_REQUESTS_VALIDATION")%> type="checkbox" id="validation" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_VALIDATION" property="itemId"/>]>.value" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_VALIDATION;value=medwan.common.true" property="value" outputString="checked"/> value="medwan.common.true">
                        </td>

                        <%-- PROTOCOL --%>
                        <td class="admin"><%=getTran("Web.Occup",sPREFIX+"item_type_mir_protocol",sWebLanguage)%></td>
                        <td class="admin2">
                            <textarea id="protocol" onKeyup="resizeTextarea(this,10);limitChars(this,255);" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_PROTOCOL" property="itemId"/>]>.value" class="text" rows="2" cols="80"><mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_PROTOCOL" property="value"/></textarea>
                        </td>
                    </tr>

                    <%-- NIETS TE MELDEN --%>
                    <tr>
                        <td class="admin"><%=getTran("Web.Occup",sPREFIX+"item_type_mir_nothing_to_mention",sWebLanguage)%></td>
                        <td class="admin2">
                            <input id="nothing_to_mention" type="checkbox" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_NOTHING_TO_MENTION" property="itemId"/>]>.value" value="medwan.common.true" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_NOTHING_TO_MENTION;value=medwan.common.true" property="value" outputString="checked"/>>
                        </td>
                        <td class="admin"/>
                        <td class="admin2"/>
                    </tr>
                <%
            }
        %>

        <%-- DEMAND 2 ---------------------------------------------------------------------------%>
        <tbody id="demande2" style="display:none;">
            <tr class="gray">
                <td colspan="4"><%=getTran("web.occup","demand",sWebLanguage)%> 2</td>
            </tr>

            <%-- TYPE --%>
            <tr>
                <td class="admin"><%=getTran("Web.Occup",sPREFIX+"item_type_mir_type",sWebLanguage)%></td>
                <td class="admin2">
                    <select id="examination2" class="text" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_TYPE2" property="itemId"/>]>.value">
                        <option/>
                        <%
                            ItemVO item = sessionContainerWO.getCurrentTransactionVO().getItem(sPREFIX+"ITEM_TYPE_MIR2_TYPE2");
                            if (item!=null){
                                sType = checkString(item.getValue());
                            }
                        %>
                        <%=ScreenHelper.writeSelect("mir_type",sType,sWebLanguage,false,true)%>
                    </select>
                </td>

                <td class="admin"><%=getTran("web.occup","SPECIFICATION",sWebLanguage)%></td>
                <td class="admin2">
                    <textarea id="SPECIFICATION2" onKeyup="resizeTextarea(this,10);limitChars(this,255);" <%=setRightClick("ITEM_TYPE_MIR2_SPECIFICATION2")%> class="text" cols="80" rows="2" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_SPECIFICATION2" property="itemId"/>]>.value"><mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_SPECIFICATION2" property="value"/></textarea>
                </td>
            </tr>

            <tr>
                <%-- URGENCY --%>
                <td class="admin"><%=getTran("Web.Occup","urgency",sWebLanguage)%></td>
                <td class="admin2">
                    <input <%=setRightClick("ITEM_TYPE_OTHER_REQUESTS_URGENT2")%> type="checkbox" id="urgency2" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_URGENT2" property="itemId"/>]>.value" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_URGENT2;value=medwan.common.true" property="value" outputString="checked"/> value="medwan.common.true">
                </td>

                <%-- EXAMINATION REASON --%>
                <td class="admin"><%=getTran("Web.Occup","examinationreason",sWebLanguage)%>&nbsp;</td>
                <td class="admin2">
                    <textarea id="reason2" onKeyup="resizeTextarea(this,10);limitChars(this,255);" <%=setRightClick("ITEM_TYPE_MIR2_EXAMINATIONREASON2")%> class="text" cols="80" rows="2" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_EXAMINATIONREASON2" property="itemId"/>]>.value"><mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_EXAMINATIONREASON2" property="value"/></textarea>
                </td>
            </tr>

            <tr>
                <%-- ORIGINAL MODIFIED --%>
                <td class="admin"><%=getTran("Web.Occup","original_modified",sWebLanguage)%></td>
                <td class="admin2">
                    <input type="checkbox" id="modified2" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_ORIGINAL_MODIFIED2" property="itemId"/>]>.value" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_ORIGINAL_MODIFIED2;value=medwan.common.true" property="value" outputString="checked"/> value="medwan.common.true" onclick="doModified('modified2','modifiedreason2');">
                </td>

                <%-- EXAMINATION REASON --%>
                <td class="admin"><%=getTran("Web.Occup","medwan.common.reason",sWebLanguage)%>&nbsp;</td>
                <td class="admin2">
                    <textarea id="modifiedreason2" onKeyup="resizeTextarea(this,10);limitChars(this,255);" <%=setRightClick("ITEM_TYPE_MIR2_ORIGINAL_MODIFIED_REASON2")%> class="text" cols="80" rows="2" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_ORIGINAL_MODIFIED_REASON2" property="itemId"/>]>.value"><mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_ORIGINAL_MODIFIED_REASON2" property="value"/></textarea>
                </td>
            </tr>

            <%
                if(activeUser.getAccessRight("occup.medicalimagingrequest.execute.select")){
                    %>
                        <tr>
                            <%-- EXECUTION BY --%>
                            <td class="admin"><%=getTran("Web.Occup","medwan.healthrecord.executionby",sWebLanguage)%></td>
                            <td class="admin2">
                                <input onclick="doExecution('executionreason2',true);" type="radio" onDblClick="uncheckRadio(this);" id="rbexecutionyes2" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_PRESTATION2" property="itemId"/>]>.value" value="medwan.common.yes" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_PRESTATION2;value=medwan.common.yes" property="value" outputString="checked"/>><%=getLabel("Web.Occup","medwan.common.yes",sWebLanguage,"rbexecutionyes2")%>
                                <input onclick="doExecution('executionreason2',false);" type="radio" onDblClick="uncheckRadio(this);" id="rbexecutionno2" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_PRESTATION2" property="itemId"/>]>.value" value="medwan.common.no" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_PRESTATION2;value=medwan.common.no" property="value" outputString="checked"/>><%=getLabel("Web.Occup","medwan.common.no",sWebLanguage,"rbexecutionno2")%>
                            </td>

                            <%-- REASON --%>
                            <td class="admin"><%=getTran("Web.Occup","medwan.common.reason",sWebLanguage)%></td>
                            <td class="admin2">
                                <textarea id="executionreason2" onKeyup="resizeTextarea(this,10);limitChars(this,255);" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_PRESTATION_REASON2" property="itemId"/>]>.value" class="text" rows="2" cols="80"><mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_PRESTATION_REASON2" property="value"/></textarea>
                            </td>
                        </tr>

                        <tr>
                            <%-- VALIDATION BY --%>
                            <td class="admin"><%=getTran("Web.Occup","medwan.healthrecord.validationby",sWebLanguage)%></td>
                            <td class="admin2">
                                <input <%=setRightClick("ITEM_TYPE_OTHER_REQUESTS_VALIDATION2")%> type="checkbox" id="validation2" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_VALIDATION2" property="itemId"/>]>.value" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_VALIDATION2;value=medwan.common.true" property="value" outputString="checked"/> value="medwan.common.true">
                            </td>

                            <%-- PROTOCOL --%>
                            <td class="admin"><%=getTran("Web.Occup",sPREFIX+"item_type_mir_protocol",sWebLanguage)%></td>
                            <td class="admin2">
                                <textarea id="protocol2" onKeyup="resizeTextarea(this,10);limitChars(this,255);" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_PROTOCOL2" property="itemId"/>]>.value" class="text" rows="2" cols="80"><mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_PROTOCOL2" property="value"/></textarea>
                            </td>
                        </tr>

                        <%-- NIETS TE MELDEN --%>
                        <tr>
                            <td class="admin"><%=getTran("Web.Occup",sPREFIX+"item_type_mir_nothing_to_mention",sWebLanguage)%></td>
                            <td class="admin2">
                                <input id="nothing_to_mention2" type="checkbox" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_NOTHING_TO_MENTION2" property="itemId"/>]>.value" value="medwan.common.true" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_NOTHING_TO_MENTION2;value=medwan.common.true" property="value" outputString="checked"/>>
                            </td>
                            <td class="admin"/>
                            <td class="admin2"/>
                        </tr>
                    <%
                }
            %>
        </tbody>

        <%-- DEMAND 3 ---------------------------------------------------------------------------%>
        <tbody id="demande3" style="display:none;">
            <tr class="gray">
                <td colspan="4"><%=getTran("web.occup","demand",sWebLanguage)%> 3</td>
            </tr>

            <%-- TYPE --%>
            <tr>
                <td class="admin"><%=getTran("Web.Occup",sPREFIX+"item_type_mir_type",sWebLanguage)%></td>
                <td class="admin2">
                    <select id="examination3" class="text" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_TYPE3" property="itemId"/>]>.value">
                        <option/>
                        <%
                            item = sessionContainerWO.getCurrentTransactionVO().getItem(sPREFIX+"ITEM_TYPE_MIR2_TYPE3");
                            if (item!=null){
                                sType = checkString(item.getValue());
                            }
                        %>
                        <%=ScreenHelper.writeSelect("mir_type",sType,sWebLanguage,false,false)%>
                    </select>
                </td>

                <td class="admin"><%=getTran("web.occup","SPECIFICATION",sWebLanguage)%></td>
                <td class="admin2">
                    <textarea id="SPECIFICATION3" onKeyup="resizeTextarea(this,10);limitChars(this,255);" <%=setRightClick("ITEM_TYPE_MIR2_SPECIFICATION3")%> class="text" cols="80" rows="2" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_SPECIFICATION3" property="itemId"/>]>.value"><mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_SPECIFICATION3" property="value"/></textarea>
                </td>
            </tr>

            <tr>
                <td class="admin"><%=getTran("Web.Occup","urgency",sWebLanguage)%></td>
                <td class="admin2">
                    <input <%=setRightClick("ITEM_TYPE_OTHER_REQUESTS_URGENT3")%> type="checkbox" id="urgency3" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_URGENT3" property="itemId"/>]>.value" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_URGENT3;value=medwan.common.true" property="value" outputString="checked"/> value="medwan.common.true">
                </td>

                <%-- EXAMINATION REASON --%>
                <td class="admin"><%=getTran("Web.Occup","examinationreason",sWebLanguage)%>&nbsp;</td>
                <td class="admin2">
                    <textarea id="reason3" onKeyup="resizeTextarea(this,10);limitChars(this,255);" <%=setRightClick("ITEM_TYPE_MIR2_EXAMINATIONREASON3")%> class="text" cols="80" rows="2" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_EXAMINATIONREASON3" property="itemId"/>]>.value"><mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_EXAMINATIONREASON3" property="value"/></textarea>
                </td>
            </tr>

            <tr>
                <td class="admin"><%=getTran("Web.Occup","original_modified",sWebLanguage)%></td>
                <td class="admin2">
                    <input type="checkbox" id="modified3" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_ORIGINAL_MODIFIED3" property="itemId"/>]>.value" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_ORIGINAL_MODIFIED3;value=medwan.common.true" property="value" outputString="checked"/> value="medwan.common.true" onclick="doModified('modified3','modifiedreason3');">
                </td>

                <%-- EXAMINATION REASON --%>
                <td class="admin"><%=getTran("Web.Occup","medwan.common.reason",sWebLanguage)%>&nbsp;</td>
                <td class="admin2">
                    <textarea id="modifiedreason3" onKeyup="resizeTextarea(this,10);limitChars(this,255);" <%=setRightClick("ITEM_TYPE_MIR2_ORIGINAL_MODIFIED_REASON3")%> class="text" cols="80" rows="2" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_ORIGINAL_MODIFIED_REASON3" property="itemId"/>]>.value"><mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_ORIGINAL_MODIFIED_REASON3" property="value"/></textarea>
                </td>
            </tr>

            <%
                if(activeUser.getAccessRight("occup.medicalimagingrequest.execute.select")){
                    %>
                        <tr>
                            <td class="admin"><%=getTran("Web.Occup","medwan.healthrecord.executionby",sWebLanguage)%></td>
                            <td class="admin2">
                                <input onclick="doExecution('executionreason3',true);" type="radio" onDblClick="uncheckRadio(this);" id="rbexecutionyes3" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_PRESTATION3" property="itemId"/>]>.value" value="medwan.common.yes" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_PRESTATION3;value=medwan.common.yes" property="value" outputString="checked"/>><%=getLabel("Web.Occup","medwan.common.yes",sWebLanguage,"rbexecutionyes3")%>
                                <input onclick="doExecution('executionreason3',false);" type="radio" onDblClick="uncheckRadio(this);" id="rbexecutionno3" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_PRESTATION3" property="itemId"/>]>.value" value="medwan.common.no" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_PRESTATION3;value=medwan.common.no" property="value" outputString="checked"/>><%=getLabel("Web.Occup","medwan.common.no",sWebLanguage,"rbexecutionno3")%>
                            </td>

                            <td class="admin"><%=getTran("Web.Occup","medwan.common.reason",sWebLanguage)%></td>
                            <td class="admin2">
                                <textarea id="executionreason3" onKeyup="resizeTextarea(this,10);limitChars(this,255);" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_PRESTATION_REASON3" property="itemId"/>]>.value" class="text" rows="2" cols="80"><mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_PRESTATION_REASON3" property="value"/></textarea>
                            </td>
                        </tr>

                        <tr>
                            <td class="admin"><%=getTran("Web.Occup","medwan.healthrecord.validationby",sWebLanguage)%></td>
                            <td class="admin2">
                                <input <%=setRightClick("ITEM_TYPE_OTHER_REQUESTS_VALIDATION3")%> type="checkbox" id="validation3" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_VALIDATION3" property="itemId"/>]>.value" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_VALIDATION3;value=medwan.common.true" property="value" outputString="checked"/> value="medwan.common.true">
                            </td>

                            <%-- PROTOCOL --%>
                            <td class="admin"><%=getTran("Web.Occup",sPREFIX+"item_type_mir_protocol",sWebLanguage)%></td>
                            <td class="admin2">
                                <textarea id="protocol3" onKeyup="resizeTextarea(this,10);limitChars(this,255);" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_PROTOCOL3" property="itemId"/>]>.value" class="text" rows="2" cols="80"><mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_PROTOCOL3" property="value"/></textarea>
                            </td>
                        </tr>

                        <%-- NIETS TE MELDEN --%>
                        <tr>
                            <td class="admin"><%=getTran("Web.Occup",sPREFIX+"item_type_mir_nothing_to_mention",sWebLanguage)%></td>
                            <td class="admin2">
                                <input id="nothing_to_mention3" type="checkbox" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_NOTHING_TO_MENTION3" property="itemId"/>]>.value" value="medwan.common.true" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_NOTHING_TO_MENTION3;value=medwan.common.true" property="value" outputString="checked"/>>
                            </td>
                            <td class="admin"/>
                            <td class="admin2"/>
                        </tr>
                    <%
                }
            %>
        </tbody>

        <%-- DEMAND 4 ---------------------------------------------------------------------------%>
        <tbody id="demande4" style="display:none;">
            <tr class="gray">
                <td colspan="4"><%=getTran("web.occup","demand",sWebLanguage)%> 4</td>
            </tr>

            <%-- TYPE --%>
            <tr>
                <td class="admin"><%=getTran("Web.Occup",sPREFIX+"item_type_mir_type",sWebLanguage)%></td>
                <td class="admin2">
                    <select id="examination4" class="text" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_TYPE4" property="itemId"/>]>.value">
                        <option/>
                        <%
                            item = sessionContainerWO.getCurrentTransactionVO().getItem(sPREFIX+"ITEM_TYPE_MIR2_TYPE4");
                            if (item!=null){
                                sType = checkString(item.getValue());
                            }
                        %>
                        <%=ScreenHelper.writeSelect("mir_type",sType,sWebLanguage,false,false)%>
                    </select>
                </td>

                <%-- SPECIFICATION --%>
                <td class="admin"><%=getTran("web.occup","specification",sWebLanguage)%></td>
                <td class="admin2">
                    <textarea id="SPECIFICATION4" onKeyup="resizeTextarea(this,10);limitChars(this,255);" <%=setRightClick("ITEM_TYPE_MIR2_SPECIFICATION4")%> class="text" cols="80" rows="2" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_SPECIFICATION4" property="itemId"/>]>.value"><mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_SPECIFICATION4" property="value"/></textarea>
                </td>
            </tr>

            <tr>
                <%-- URGENCY --%>
                <td class="admin"><%=getTran("Web.Occup","urgency",sWebLanguage)%></td>
                <td class="admin2">
                    <input <%=setRightClick("ITEM_TYPE_OTHER_REQUESTS_URGENT4")%> type="checkbox" id="urgency4" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_URGENT4" property="itemId"/>]>.value" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_URGENT4;value=medwan.common.true" property="value" outputString="checked"/> value="medwan.common.true">
                </td>

                <%-- EXAMINATION REASON --%>
                <td class="admin"><%=getTran("Web.Occup","examinationreason",sWebLanguage)%>&nbsp;</td>
                <td class="admin2">
                    <textarea id="reason4" onKeyup="resizeTextarea(this,10);limitChars(this,255);" <%=setRightClick("ITEM_TYPE_MIR2_EXAMINATIONREASON4")%> class="text" cols="80" rows="2" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_EXAMINATIONREASON4" property="itemId"/>]>.value"><mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_EXAMINATIONREASON4" property="value"/></textarea>
                </td>
            </tr>

            <tr>
                <%-- ORIGINAL MODIFIED --%>
                <td class="admin"><%=getTran("Web.Occup","original_modified",sWebLanguage)%></td>
                <td class="admin2">
                    <input type="checkbox" id="modified4" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_ORIGINAL_MODIFIED4" property="itemId"/>]>.value" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_ORIGINAL_MODIFIED4;value=medwan.common.true" property="value" outputString="checked"/> value="medwan.common.true" onclick="doModified('modified4','modifiedreason4');">
                </td>

                <%-- EXAMINATION REASON --%>
                <td class="admin"><%=getTran("Web.Occup","medwan.common.reason",sWebLanguage)%>&nbsp;</td>
                <td class="admin2">
                    <textarea id="modifiedreason4" onKeyup="resizeTextarea(this,10);limitChars(this,255);" <%=setRightClick("ITEM_TYPE_MIR2_ORIGINAL_MODIFIED_REASON4")%> class="text" cols="80" rows="2" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_ORIGINAL_MODIFIED_REASON4" property="itemId"/>]>.value"><mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_ORIGINAL_MODIFIED_REASON4" property="value"/></textarea>
                </td>
            </tr>

            <%
                if(activeUser.getAccessRight("occup.medicalimagingrequest.execute.select")){
                    %>
                        <tr>
                            <%-- EXECUTION BY --%>
                            <td class="admin"><%=getTran("Web.Occup","medwan.healthrecord.executionby",sWebLanguage)%></td>
                            <td class="admin2">
                                <input onclick="doExecution('executionreason4',true);" type="radio" onDblClick="uncheckRadio(this);" id="rbexecutionyes4" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_PRESTATION4" property="itemId"/>]>.value" value="medwan.common.yes" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_PRESTATION4;value=medwan.common.yes" property="value" outputString="checked"/>><%=getLabel("Web.Occup","medwan.common.yes",sWebLanguage,"rbexecutionyes4")%>
                                <input onclick="doExecution('executionreason4',false);" type="radio" onDblClick="uncheckRadio(this);" id="rbexecutionno4" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_PRESTATION4" property="itemId"/>]>.value" value="medwan.common.no" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_PRESTATION4;value=medwan.common.no" property="value" outputString="checked"/>><%=getLabel("Web.Occup","medwan.common.no",sWebLanguage,"rbexecutionno4")%>
                            </td>

                            <%-- REASON --%>
                            <td class="admin"><%=getTran("Web.Occup","medwan.common.reason",sWebLanguage)%></td>
                            <td class="admin2">
                                <textarea id="executionreason4" onKeyup="resizeTextarea(this,10);limitChars(this,255);" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_PRESTATION_REASON4" property="itemId"/>]>.value" class="text" rows="2" cols="80"><mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_PRESTATION_REASON4" property="value"/></textarea>
                            </td>
                        </tr>

                        <tr>
                            <%-- VALIDATION BY --%>
                            <td class="admin"><%=getTran("Web.Occup","medwan.healthrecord.validationby",sWebLanguage)%></td>
                            <td class="admin2">
                                <input <%=setRightClick("ITEM_TYPE_OTHER_REQUESTS_VALIDATION4")%> type="checkbox" id="validation4" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_VALIDATION4" property="itemId"/>]>.value" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_VALIDATION4;value=medwan.common.true" property="value" outputString="checked"/> value="medwan.common.true">
                            </td>

                            <%-- PROTOCOL --%>
                            <td class="admin"><%=getTran("Web.Occup",sPREFIX+"item_type_mir_protocol",sWebLanguage)%></td>
                            <td class="admin2">
                                <textarea id="protocol4" onKeyup="resizeTextarea(this,10);limitChars(this,255);" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_PROTOCOL4" property="itemId"/>]>.value" class="text" rows="2" cols="80"><mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_PROTOCOL4" property="value"/></textarea>
                            </td>
                        </tr>

                        <%-- NIETS TE MELDEN --%>
                        <tr>
                            <td class="admin"><%=getTran("Web.Occup",sPREFIX+"item_type_mir_nothing_to_mention",sWebLanguage)%></td>
                            <td class="admin2">
                                <input id="nothing_to_mention4" type="checkbox" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_NOTHING_TO_MENTION4" property="itemId"/>]>.value" value="medwan.common.true" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_NOTHING_TO_MENTION4;value=medwan.common.true" property="value" outputString="checked"/>>
                            </td>
                            <td class="admin"/>
                            <td class="admin2"/>
                        </tr>
                    <%
                }
            %>
        </tbody>

        <%-- DEMAND 5 ---------------------------------------------------------------------------%>
        <tbody id="demande5" style="display:none;">
            <tr class="gray">
                <td colspan="4"><%=getTran("web.occup","demand",sWebLanguage)%> 5</td>
            </tr>

            <%-- TYPE --%>
            <tr>
                <td class="admin"><%=getTran("Web.Occup",sPREFIX+"item_type_mir_type",sWebLanguage)%></td>
                <td class="admin2">
                    <select id="examination5" class="text" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_TYPE5" property="itemId"/>]>.value">
                        <option/>
                        <%
                            item = sessionContainerWO.getCurrentTransactionVO().getItem(sPREFIX+"ITEM_TYPE_MIR2_TYPE5");
                            if (item!=null){
                                sType = checkString(item.getValue());
                            }
                        %>
                        <%=ScreenHelper.writeSelect("mir_type",sType,sWebLanguage,false,false)%>
                    </select>
                </td>

                <%-- SPECIFICATION --%>
                <td class="admin"><%=getTran("web.occup","specification",sWebLanguage)%></td>
                <td class="admin2">
                    <textarea id="SPECIFICATION5" onKeyup="resizeTextarea(this,10);limitChars(this,255);" <%=setRightClick("ITEM_TYPE_MIR2_SPECIFICATION5")%> class="text" cols="80" rows="2" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_SPECIFICATION5" property="itemId"/>]>.value"><mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_SPECIFICATION5" property="value"/></textarea>
                </td>
            </tr>

            <tr>
                <%-- URGENCY --%>
                <td class="admin"><%=getTran("Web.Occup","urgency",sWebLanguage)%></td>
                <td class="admin2">
                    <input <%=setRightClick("ITEM_TYPE_OTHER_REQUESTS_URGENT5")%> type="checkbox" id="urgency5" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_URGENT5" property="itemId"/>]>.value" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_URGENT5;value=medwan.common.true" property="value" outputString="checked"/> value="medwan.common.true">
                </td>

                <%-- EXAMINATION REASON --%>
                <td class="admin"><%=getTran("Web.Occup","examinationreason",sWebLanguage)%>&nbsp;</td>
                <td class="admin2">
                    <textarea id="reason5" onKeyup="resizeTextarea(this,10);limitChars(this,255);" <%=setRightClick("ITEM_TYPE_MIR2_EXAMINATIONREASON5")%> class="text" cols="80" rows="2" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_EXAMINATIONREASON5" property="itemId"/>]>.value"><mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_EXAMINATIONREASON5" property="value"/></textarea>
                </td>
            </tr>

            <tr>
                <%-- ORIGINAL MODIFIED --%>
                <td class="admin"><%=getTran("Web.Occup","original_modified",sWebLanguage)%></td>
                <td class="admin2">
                    <input type="checkbox" id="modified5" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_ORIGINAL_MODIFIED5" property="itemId"/>]>.value" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_ORIGINAL_MODIFIED5;value=medwan.common.true" property="value" outputString="checked"/> value="medwan.common.true" onclick="doModified('modified5','modifiedreason5');">
                </td>

                <%-- EXAMINATION REASON --%>
                <td class="admin"><%=getTran("Web.Occup","medwan.common.reason",sWebLanguage)%>&nbsp;</td>
                <td class="admin2">
                    <textarea id="modifiedreason5" onKeyup="resizeTextarea(this,10);limitChars(this,255);" <%=setRightClick("ITEM_TYPE_MIR2_ORIGINAL_MODIFIED_REASON5")%> class="text" cols="80" rows="2" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_ORIGINAL_MODIFIED_REASON5" property="itemId"/>]>.value"><mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_ORIGINAL_MODIFIED_REASON5" property="value"/></textarea>
                </td>
            </tr>

            <%
                if(activeUser.getAccessRight("occup.medicalimagingrequest.execute.select")){
                    %>
                        <tr>
                            <%-- EXECUTION BY --%>
                            <td class="admin"><%=getTran("Web.Occup","medwan.healthrecord.executionby",sWebLanguage)%></td>
                            <td class="admin2">
                                <input onclick="doExecution('executionreason5',true);" type="radio" onDblClick="uncheckRadio(this);" id="rbexecutionyes5" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_PRESTATION5" property="itemId"/>]>.value" value="medwan.common.yes" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_PRESTATION5;value=medwan.common.yes" property="value" outputString="checked"/>><%=getLabel("Web.Occup","medwan.common.yes",sWebLanguage,"rbexecutionyes5")%>
                                <input onclick="doExecution('executionreason5',false);" type="radio" onDblClick="uncheckRadio(this);" id="rbexecutionno5" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_PRESTATION5" property="itemId"/>]>.value" value="medwan.common.no" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_PRESTATION5;value=medwan.common.no" property="value" outputString="checked"/>><%=getLabel("Web.Occup","medwan.common.no",sWebLanguage,"rbexecutionno5    ")%>
                            </td>

                            <%-- REASON --%>
                            <td class="admin"><%=getTran("Web.Occup","medwan.common.reason",sWebLanguage)%></td>
                            <td class="admin2">
                                <textarea id="executionreason5" onKeyup="resizeTextarea(this,10);limitChars(this,255);" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_PRESTATION_REASON5" property="itemId"/>]>.value" class="text" rows="2" cols="80"><mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_PRESTATION_REASON5" property="value"/></textarea>
                            </td>
                        </tr>

                        <tr>
                            <%-- VALIDATION BY --%>
                            <td class="admin"><%=getTran("Web.Occup","medwan.healthrecord.validationby",sWebLanguage)%></td>
                            <td class="admin2">
                                <input <%=setRightClick("ITEM_TYPE_OTHER_REQUESTS_VALIDATION5")%> type="checkbox" id="validation5" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_VALIDATION5" property="itemId"/>]>.value" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_VALIDATION5;value=medwan.common.true" property="value" outputString="checked"/> value="medwan.common.true">
                            </td>

                            <%-- PROTOCOL --%>
                            <td class="admin"><%=getTran("Web.Occup",sPREFIX+"item_type_mir_protocol",sWebLanguage)%></td>
                            <td class="admin2">
                                <textarea id="protocol5" onKeyup="resizeTextarea(this,10);limitChars(this,255);" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_PROTOCOL5" property="itemId"/>]>.value" class="text" rows="2" cols="80"><mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_PROTOCOL5" property="value"/></textarea>
                            </td>
                        </tr>

                        <%-- NIETS TE MELDEN --%>
                        <tr>
                            <td class="admin"><%=getTran("Web.Occup",
                                    sPREFIX+"item_type_mir_nothing_to_mention",sWebLanguage)%></td>
                            <td class="admin2">
                                <input id="nothing_to_mention5" type="checkbox" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_NOTHING_TO_MENTION5" property="itemId"/>]>.value" value="medwan.common.true" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_MIR2_NOTHING_TO_MENTION5;value=medwan.common.true" property="value" outputString="checked"/>>
                            </td>
                            <td class="admin"/>
                            <td class="admin2"/>
                        </tr>
                    <%
                }
            %>
        </tbody>

        <%-- PROVIDER (=802) --%>
        <input type="hidden" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_SUPPLIER" property="itemId"/>]>.value" value="802">

        <%-- VALUE (=0) --%>
        <input type="hidden" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_OTHER_REQUESTS_VALUE" property="itemId"/>]>.value" value="0">

        <%-- BUTTONS row 1 --%>
        <tr>
            <td class="admin"/>
            <td class="admin2" colspan="3">
                <input class="button" type="button" name="printLabelsButton" value="<%=getTran("Web","printlabels",sWebLanguage)%>" onclick="printLabels();"/>&nbsp;
                <button accesskey="<%=ScreenHelper.getAccessKey(getTranNoLink("accesskey","save",sWebLanguage))%>" class="buttoninvisible" onclick="doSave();"></button>

                <input type="button" class="button" value="<%=getTranNoLink("web.occup","add_new_demand",sWebLanguage)%>" name="buttonAddDemand" onclick="addDemand();"/>
            </td>
        </tr>

        <%-- BUTTONS row 2 --%>
        <tr>
            <td class="admin"/>
            <td class="admin2" colspan="3">
                <%=getButtonsHtml(request,activeUser,activePatient,"occup.medicalimagingrequest",sWebLanguage)%>
            </td>
        </tr>
    </table>

    <%=ScreenHelper.contextFooter(request)%>
</form>

<%=writeJSButtons("transactionForm", "saveButton")%>

<script>
  document.getElementById("trandate").focus();

  <%-- PRINT LABELS --%>
  function printLabels(){
    var url = "<c:url value="/healthrecord/createImagingLabelPdf.jsp"/>?imageid="+document.getElementsByName("rxid")[0].value+"&trandate="+document.getElementsByName("trandate")[0].value+"&examination="+document.getElementById("examination").options[document.getElementById("examination").selectedIndex].text+"&ts=<%=getTs()%>";
    window.open(url,"Popup"+new Date().getTime(),"toolbar=no, status=yes, scrollbars=yes, resizable=yes, width=400, height=300, menubar=no").moveTo((screen.width-400)/2,(screen.height-300)/2);
  }

  <%-- SUBMIT FORM --%>
  function submitForm(){

    var temp = Form.findFirstElement(transactionForm);//compatibility firefox
    document.transactionForm.saveButton.style.visibility = "hidden";
    document.transactionForm.submit();  
  }

  <%-- DO PRINT PDF --%>
  function doPrintPDF(){
    var url = "<c:url value="/healthrecord/loadPDF.jsp"/>?file=base/<%=sWebLanguage%>4M.pdf&module=N4M"+
              "&modulepar1="+document.getElementsByName("examination")[0].options[document.getElementsByName("examination")[0].selectedIndex].text+
              "&modulepar2="+document.getElementsByName("protocol")[0].value+
              "&modulepar3="+document.getElementsByName("rxid")[0].value+
              "&modulepar4=<%=checkString((String)session.getAttribute("activeMD"))+"$"+checkString((String)session.getAttribute("activePara"))+"$"+checkString((String)session.getAttribute("activeMedicalCenter"))%>"+
              "&ts=<%=ScreenHelper.getTs()%>";
    openpopup(url,700,500,"Print");
  }

  <%-- ADD DEMAND --%>
  var iDemand = 1;
  function addDemand(){
    iDemand++;
    document.getElementById("demande"+iDemand).style.display = "";

    if(iDemand==5){
      document.getElementById("ButtonAddDemand").disabled = true;
    }
  }

  <%-- DO MODIFIED --%>
  function doModified(sCB,sTextField){
    if (document.getElementById(sCB).checked){
      document.getElementById(sTextField).disabled = false;
      document.getElementById(sTextField).focus();
    }
    else {
      document.getElementById(sTextField).value = "";
      document.getElementById(sTextField).disabled = true;
    }
  }

  <%-- DO EXECUTION --%>
  function doExecution(sTextField, bDisabled){
    document.getElementById(sTextField).disabled = bDisabled;

    if (bDisabled){
      document.getElementById(sTextField).value = "";
    }
    else {
      document.getElementById(sTextField).focus();
    }
  }

  doModified("modified","modifiedreason");
  doExecution("executionreason",!document.getElementById("rbexecutionno").checked);

  <%
      // display saved demands on load
      ItemVO type2Item = sessionContainerWO.getCurrentTransactionVO().getItem(sPREFIX+"ITEM_TYPE_MIR2_TYPE2"),
             type3Item = sessionContainerWO.getCurrentTransactionVO().getItem(sPREFIX+"ITEM_TYPE_MIR2_TYPE3"),
             type4Item = sessionContainerWO.getCurrentTransactionVO().getItem(sPREFIX+"ITEM_TYPE_MIR2_TYPE4"),
             type5Item = sessionContainerWO.getCurrentTransactionVO().getItem(sPREFIX+"ITEM_TYPE_MIR2_TYPE5");

      if(type2Item!=null && type2Item.getValue().length() > 0){
          %>
              document.getElementById("demande2").style.display = "";
              doModified("modified2","modifiedreason2");
          <%

          if(activeUser.getAccessRight("occup.medicalimagingrequest.execute.select")){
              %>doExecution("executionreason2",!document.getElementById("rbexecutionno2").checked);<%
          }
      }

      if(type3Item!=null && type3Item.getValue().length() > 0){
          %>
              document.getElementById("demande2").style.display = "";
              doModified("modified2","modifiedreason2");
          <%

          if(activeUser.getAccessRight("occup.medicalimagingrequest.execute.select")){
              %>doExecution("executionreason3",!document.getElementById("rbexecutionno3").checked);<%
          }
      }

      if(type4Item!=null && type4Item.getValue().length() > 0){
          %>
              document.getElementById("demande3").style.display = "";
              doModified("modified3","modifiedreason3");
          <%

          if(activeUser.getAccessRight("occup.medicalimagingrequest.execute.select")){
              %>doExecution("executionreason4",!document.getElementById("rbexecutionno4").checked);<%
          }
      }

      if(type5Item!=null && type5Item.getValue().length() > 0){
          %>
              document.getElementById("demande5").style.display = "";
              doModified("modified5","modifiedreason5");
          <%

          if(activeUser.getAccessRight("occup.medicalimagingrequest.execute.select")){
              %>doExecution("executionreason5",!document.getElementById("rbexecutionno5").checked);<%
          }
      }
  %>
</script>
